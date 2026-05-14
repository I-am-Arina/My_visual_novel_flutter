// lib/services/audio_manager.dart
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';

class AudioManager {
  static final AudioManager _instance = AudioManager._internal();
  factory AudioManager() => _instance;
  AudioManager._internal();

  AudioPlayer? _player;
  String? _currentMusic;
  bool _isInitialized = false;
  bool _isMuted = false;
  double _volume = 0.7;

  Future<void> initialize() async {
    if (_isInitialized) return;

    try {
      _player = AudioPlayer();
      _isInitialized = true;
    } catch (e) {
      debugPrint('Не удалось инициализировать аудио плеер: $e');
      _isInitialized = false;
    }
  }

  Future<void> playMusic(String assetPath) async {
    if (!_isInitialized || _player == null) {
      debugPrint('Аудио плеер не инициализирован');
      return;
    }

    try {
      if (_currentMusic == assetPath && _player!.state == PlayerState.playing) {
        return;
      }

      if (_isMuted) return;

      await _player!.stop();
      _currentMusic = assetPath;

      await _player!.setReleaseMode(ReleaseMode.loop);
      await _player!.setVolume(_volume);
      await _player!.play(AssetSource(assetPath));
    } catch (e) {
      debugPrint('Ошибка воспроизведения музыки $assetPath: $e');
      _currentMusic = null;
    }
  }

  Future<void> toggleMusic() async {
    _isMuted = !_isMuted;
    
    if (_isMuted) {
      await _player?.setVolume(0);
    } else {
      await _player?.setVolume(_volume);
      if (_currentMusic != null && _player?.state != PlayerState.playing) {
        await playMusic(_currentMusic!);
      }
    }
  }

  Future<void> stopMusic() async {
    if (!_isInitialized || _player == null) return;

    try {
      await _player!.stop();
      _currentMusic = null;
      _isMuted = false;
    } catch (e) {
      debugPrint('Ошибка остановки музыки: $e');
    }
  }

  Future<void> setVolume(double volume) async {
    _volume = volume.clamp(0.0, 1.0);
    if (!_isMuted) {
      await _player?.setVolume(_volume);
    }
  }

  void dispose() {
    _player?.dispose();
    _player = null;
    _currentMusic = null;
    _isInitialized = false;
    _isMuted = false;
  }

  bool get isPlaying => !_isMuted && _currentMusic != null;
  String? get currentMusic => _currentMusic;
  double get volume => _volume;
  bool get isMuted => _isMuted;
}