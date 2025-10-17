import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';

class AudioManager {
  static final AudioManager _instance = AudioManager._internal();
  factory AudioManager() => _instance;
  AudioManager._internal();

  AudioPlayer? _player;
  String? _currentMusic;
  bool _isInitialized = false;

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
      if (_currentMusic == assetPath) return;

      await _player!.stop();
      _currentMusic = assetPath;

      await _player!.setReleaseMode(ReleaseMode.loop);
      await _player!.setVolume(0.7);

      await _player!.play(AssetSource(assetPath));
    } catch (e) {
      debugPrint('Ошибка воспроизведения музыки $assetPath: $e');
      _currentMusic = null;
    }
  }

  Future<void> stopMusic() async {
    if (!_isInitialized || _player == null) return;

    try {
      await _player!.stop();
      _currentMusic = null;
    } catch (e) {
      debugPrint('Ошибка остановки музыки: $e');
    }
  }

  void dispose() {
    _player?.dispose();
    _player = null;
    _currentMusic = null;
    _isInitialized = false;
  }

  bool get isPlaying => _currentMusic != null;
  String? get currentMusic => _currentMusic;
}
