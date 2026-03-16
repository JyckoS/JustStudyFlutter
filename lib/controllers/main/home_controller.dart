import 'dart:async';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:juststudyflutterapp/models/leaderboard_entry.dart';
import 'package:juststudyflutterapp/services/study_service.dart';
import '../../util.dart';

enum StudyMode { short, long }

enum TimerPhase { study, breakTime }

class HomeController extends GetxController {
  final StudyService _studyService = StudyService();

  //* Observables
  final studyMode = StudyMode.short.obs;
  final timerPhase = TimerPhase.study.obs;
  final isRunning = false.obs;
  final secondsLeft = 0.obs;
  final username = ''.obs;
  final totalStudyMinutes = 0.obs;

  //* Internal
  Timer? _timer;
  int _secondsAccumulated = 0;

  // ── Getters ───────────────────────────────────────────────────────────────

  bool get isStudyPhase => timerPhase.value == TimerPhase.study;

  int get totalSeconds {
    if (isStudyPhase) {
      return studyMode.value == StudyMode.short ? 25 * 60 : 60 * 60;
    } else {
      return studyMode.value == StudyMode.short ? 5 * 60 : 15 * 60;
    }
  }

  double get progress {
    if (totalSeconds == 0) return 0;
    return 1 - (secondsLeft.value / totalSeconds);
  }

  String get formattedTime {
    final m = (secondsLeft.value ~/ 60).toString().padLeft(2, '0');
    final s = (secondsLeft.value % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  String get phaseLabel => isStudyPhase ? 'Study Time' : 'Break Time';

  // ── Lifecycle ─────────────────────────────────────────────────────────────

  @override
  void onInit() {
    super.onInit();
    _resetTimer();
    loadUserData();
    _loadLeaderboard();
    _loadHistory();

    Timer.periodic(const Duration(minutes: 1), (_) => _loadLeaderboard());
    
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }

  // ── Data Loading ──────────────────────────────────────────────────────────

  Future<void> loadUserData() async {
    try {
      final userData = await _studyService.getUserData();
      final studyData = await _studyService.getTotalStudyMinutes();
      username.value = userData['user']['display_name'];
      totalStudyMinutes.value =
          int.tryParse(studyData['total'].toString()) ?? 0;
    } catch (e) {
      Debug.log('Failed to load user data: $e');
    }
  }

  // ── Leaderboard ───────────────────────────────────────────────────────────

  final leaderboard = <LeaderboardEntry>[].obs;
  Future<void> _loadLeaderboard() async {
    try {
      final data = await _studyService.getTopToday();
      final top = data['top'] as List;
      leaderboard.clear();
      for (dynamic topuser in top) {
       LeaderboardEntry entry =
        LeaderboardEntry(name: topuser['display_name'],
        time: _formatMinutes( int.parse(topuser['total_minutes'])));
        leaderboard.add(entry);
        print("assigned: ${entry.name} = ${entry.time}");

      }
    } catch (e) {
      Debug.log('Failed to load leaderboard: $e');
    }
  }
// ── Chart History ───────────────────────────────────────────
 
  //* Chart
  final studyHistory = <Map<String, dynamic>>[].obs;
 
  // Converts raw history into cumulative FlSpots for the line chart
List<FlSpot> get chartSpots {
  return studyHistory.asMap().entries.map((entry) {
    return FlSpot(
      entry.key.toDouble(),
      (entry.value['minutes'] as int).toDouble(),
    );
  }).toList();
}
 
  Future<void> _loadHistory() async {
    try {
      final data    = await _studyService.getHistory();
      final results = data['results'] as List;
      studyHistory.assignAll(
        results.map((item) => {
          'minutes': item['minutes'] as int,
          'created_at': item['created_at'].toString(),
        }).toList(),
      );
    } catch (e) {
      Debug.log('Failed to load study history: $e');
    }
  }
  // ── Timer Controls ────────────────────────────────────────────────────────

  void onCircleTap() => isRunning.value ? _pause() : _start();

  void switchMode(StudyMode mode) {
    if (isRunning.value) return;
    studyMode.value = mode;
    timerPhase.value = TimerPhase.study;
    _resetTimer();
  }

  void _start() {
    if (secondsLeft.value == 0) _resetTimer();
    isRunning(true);
       if (isStudyPhase) {
      AppSounds.studyStart();
    }
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (secondsLeft.value > 0) {
        secondsLeft.value--;
        if (isStudyPhase) _secondsAccumulated++;
        AppPresence.studying(formattedTime);
      } else {
        _onPhaseComplete();
      }
    });
  }

  void _pause() {
    _timer?.cancel();
    isRunning(false);
    AppPresence.idle();
    _saveStudySession();
  }

  void _onPhaseComplete() {
    _timer?.cancel();
    isRunning(false);
    _saveStudySession();
  isStudyPhase ? AppSounds.breakStart() : AppSounds.studyStart();

    // Flip phase
    timerPhase.value = isStudyPhase ? TimerPhase.breakTime : TimerPhase.study;
    _resetTimer();
    _updatePresence();
    _showPhaseSnackbar();
  }

  // ── Helpers ───────────────────────────────────────────────────────────────

  void _resetTimer() => secondsLeft.value = totalSeconds;

  void _updatePresence() {
    isStudyPhase ? AppPresence.idle() : AppPresence.onBreak();
  }

  String _formatMinutes(int minutes) {
    if (minutes < 60) return '${minutes}m';
    final h = minutes ~/ 60;
    final m = minutes % 60;
    return m == 0 ? '${h}h' : '${h}h ${m}m';
  }

  Future<void> _saveStudySession() async {
    if (_secondsAccumulated < 60) return;
    final minutes = _secondsAccumulated ~/ 60;
    _secondsAccumulated = _secondsAccumulated % 60;
    final success = await _studyService.addStudySession(minutes);
    if (success) {
      totalStudyMinutes.value += minutes;
      Debug.log('Added $minutes minutes to database');
      _loadLeaderboard();
      _loadHistory();
    }
  }

  void _showPhaseSnackbar() {
    Get.snackbar(
      isStudyPhase ? '☀️ Break over!' : '✅ Study session done!',
      isStudyPhase
          ? 'Tap the circle to start studying.'
          : 'Tap the circle to start your break.',
      backgroundColor: const Color(0xFFFF6B35),
      colorText: Colors.white,
      borderRadius: 12,
      margin: const EdgeInsets.all(16),
    );
  }
}
