import 'dart:async';
import 'package:flutter/services.dart' show rootBundle;
import 'package:yaml/yaml.dart';
import '../models/script_nodes.dart';

class ScriptRepository {
  Future<Map<String, Scene>> loadScenesFromAsset(String assetPath) async {
    try {
      final text = await rootBundle.loadString(assetPath);
      final docs = loadYamlDocuments(text);
      final scenes = <String, Scene>{};

      for (final doc in docs) {
        final map = doc.contents;
        if (map is! YamlMap) continue;

        final label = map['label']?.toString();
        final nodesYaml = map['nodes'];
        if (label == null || nodesYaml == null) continue;

        final nodes = <Node>[];
        for (final item in (nodesYaml as YamlList)) {
          if (item is YamlMap) {
            if (item.containsKey('bg')) {
              nodes.add(BgNode(item['bg'] as String));
              continue;
            }
            if (item.containsKey('music')) {
              nodes.add(MusicNode(item['music'] as String));
              continue;
            }
            if (item.containsKey('say')) {
              final inner = item['say'] as YamlMap;
              nodes.add(SayNode(inner['who']?.toString() ?? '',
                  inner['text']?.toString() ?? ''));
              continue;
            }
            if (item.containsKey('choice')) {
              final inner = item['choice'] as YamlMap;
              final prompt = inner['text']?.toString() ?? '';
              final optionsYaml = inner['options'] as YamlList;
              final opts = <ChoiceOption>[];
              for (final o in optionsYaml) {
                final om = o as YamlMap;
                opts.add(ChoiceOption(
                    text: om['text']?.toString() ?? '',
                    jump: om['jump']?.toString() ?? ''));
              }
              nodes.add(ChoiceNode(prompt, opts));
              continue;
            }
            if (item.containsKey('jump')) {
              nodes.add(JumpNode(item['jump'] as String));
              continue;
            }
            if (item.containsKey('end')) {
              nodes.add(EndNode());
              continue;
            }
            // В методе loadScenesFromAsset(), внутри цикла по item, добавьте:

            if (item.containsKey('add_score')) {
              nodes.add(AddScoreNode(item['add_score'] as int));
              continue;
            }
            if (item.containsKey('cond')) {
              final inner = item['cond'] as YamlMap;
              nodes.add(CondNode(
                inner['condition'] as String,
                inner['jump'] as String,
                inner['jump_if_false'] as String?,
              ));
              continue;
            }
          }
        }

        if (nodes.isNotEmpty) {
          scenes[label] = Scene(label, nodes);
        }
      }

      if (scenes.isEmpty) {
        throw Exception('Не найдено ни одной сцены в файле $assetPath');
      }

      return scenes;
    } catch (e) {
      throw Exception('Ошибка загрузки скрипта: $e');
    }
  }
}
