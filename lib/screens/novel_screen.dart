import 'package:flutter/material.dart';
import '../models/game_state.dart';
import '../models/script_nodes.dart';
import '../services/script_engine.dart';
import '../services/script_loader.dart';
import '../services/audio_manager.dart';
import '../constants/app_constants.dart';
import '../constants/app_colors.dart';
import '../ui/widgets/loading_screen.dart';
import '../ui/widgets/error_screen.dart';
import '../ui/widgets/background_widget.dart';
import '../ui/widgets/dialogue_box.dart';
import '../ui/widgets/choice_box.dart';
import '../ui/widgets/end_screen.dart';

class NovelScreen extends StatefulWidget {
  const NovelScreen({super.key});

  @override
  State<NovelScreen> createState() => _NovelScreenState();
}

class _NovelScreenState extends State<NovelScreen> {
  final game = GameState();
  ScriptEngine? engine;
  Map<String, Scene>? scenes;
  String? _errorMessage;
  bool _isLoading = true;
  final _audioManager = AudioManager();

  @override
  void initState() {
    super.initState();
    _initializeAudio();
    _load();
  }

  Future<void> _initializeAudio() async {
    await _audioManager.initialize();
  }

  Future<void> _load() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final repo = ScriptRepository();
      scenes = await repo.loadScenesFromAsset(AppConstants.defaultScriptPath);
      game.currentLabel = AppConstants.defaultSceneLabel;
      game.index = 0;
      game.bgPath = null;
      game.ended = false;
      game.score = 0;      // ← добавляем
      game.maxScore = 0;   // ← добавляем
      
      engine = ScriptEngine(scenes!, game, onMusic: _audioManager.playMusic);
      engine!.next();
      setState(() {});
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _audioManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const LoadingScreen();
    }

    if (_errorMessage != null) {
      return ErrorScreen(
        errorMessage: _errorMessage!,
        onRetry: _load,
      );
    }

    if (engine == null || scenes == null) {
      return const Scaffold(
        backgroundColor: AppColors.backgroundDark,
        body: Center(
          child: Text(
            'Ошибка инициализации',
            style: TextStyle(color: AppColors.textWhite),
          ),
        ),
      );
    }

    final node = engine!.currentNode;

    return Scaffold(
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          if (node is SayNode) {
            engine!.advanceDialogue();
            setState(() {});
          }
        },
        child: Stack(
          children: [
            Positioned.fill(
              child: BackgroundWidget(bgPath: game.bgPath),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(AppConstants.defaultPadding),
                child: _buildNode(node),
              ),
            ),
            Positioned(
              right: 12,
              top: 40,
              child: Column(
                children: [
                  FloatingActionButton.small(
                    onPressed: _load,
                    backgroundColor:
                        AppColors.backgroundDark.withValues(alpha: 0.7),
                    child:
                        const Icon(Icons.refresh, color: AppColors.textWhite),
                  ),
                  const SizedBox(height: 8),
                  FloatingActionButton.small(
                    onPressed: _audioManager.isPlaying
                        ? () {
                            _audioManager.stopMusic();
                            setState(() {});
                          }
                        : null,
                    backgroundColor:
                        AppColors.backgroundDark.withValues(alpha: 0.7),
                    child: Icon(
                      _audioManager.isPlaying
                          ? Icons.volume_off
                          : Icons.volume_up,
                      color: AppColors.textWhite,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNode(Node? node) {
    if (game.ended) {
      return const EndScreen();
    }

    if (node is ChoiceNode) {
      return ChoiceBox(
        node: node,
        onPick: (i) {
          engine!.choose(i);
          setState(() {});
        },
      );
    }

    if (node is SayNode) {
      return DialogueBox(who: node.who, text: node.text);
    }

    return const SizedBox.shrink();
  }
}
