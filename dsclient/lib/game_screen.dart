import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flame/events.dart';
import 'game_over.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GameWidget(
        game: RacingGame(onGameOver: (score) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => GameOverScreen(score: score),
            ),
          );
        }),
      ),
    );
  }
}

class RacingGame extends FlameGame with TapCallbacks, HasCollisionDetection {
  late Player player;
  late TextComponent timerText;
  double nextSpawnSeconds = 0;
  Vector2? targetPosition;
  double gameTime = 15.0; // 게임 시간 30초
  final void Function(int) onGameOver;

  RacingGame({required this.onGameOver});

  @override
  Future<void> onLoad() async {
    player = Player(
      position: Vector2(size.x / 2, size.y - 20),
    );
    add(player);
    print('Player added at position: ${player.position}');

    // 타이머 텍스트 컴포넌트 추가
    timerText = TextComponent(
      text: 'Time: $gameTime',
      textRenderer: TextPaint(
        style: const TextStyle(color: Colors.white, fontSize: 40),
      ),
      anchor: Anchor.topCenter,
      position: Vector2(size.x / 2, 10),
    );
    add(timerText);
  }

  @override
  void onTapDown(TapDownEvent event) {
    super.onTapDown(event);
    if (!event.handled) {
      final touchPoint = event.canvasPosition;
      targetPosition = Vector2(touchPoint.x, player.position.y);
      print('Player tapped at ${event.localPosition}, and player pos:${player.position}, and touchPoint: $touchPoint');
    }
  }

  @override
  void update(double dt) {
    super.update(dt);

    // 게임 시간 업데이트
    gameTime -= dt;
    if (gameTime <= 0) {
      gameTime = 0;
      // 게임 종료 로직 추가
      pauseEngine();
      onGameOver(player.totalCount);
      print('Game Over');
    }
    timerText.text = 'Time: ${gameTime.toStringAsFixed(1)}';

    // 플레이어의 위치를 부드럽게 업데이트
    if (targetPosition != null) {
      final direction = (targetPosition! - player.position).normalized();
      final speed = 500.0; // 이동 속도
      player.position += direction * speed * dt;

      // 목표 위치에 도달하면 targetPosition을 null로 설정
      if ((targetPosition! - player.position).length < 1.0) {
        player.position = targetPosition!;
        targetPosition = null;
      }
    }

    nextSpawnSeconds -= dt;
    if (nextSpawnSeconds < 0) {
      var starPos = Random().nextInt(size.x.toInt()).toDouble();
      if (starPos < Star.starSize) {
        starPos = Star.starSize;
      } else if (starPos > size.x - Star.starSize) {
        starPos = size.x - Star.starSize;
      }

      add(Star(Vector2(starPos, 0)));
      nextSpawnSeconds = 0.3 + Random().nextDouble() * 2;
    }
  }
}

class Player extends RectangleComponent with CollisionCallbacks {
  static const playerSize = 96.0;
  int totalCount = 0;
  late TextComponent textComponent;

  Player({required position}) 
    : super(
        position: position,
        size: Vector2.all(playerSize),
        anchor: Anchor.bottomCenter,
      ); 

  @override
  Future<void> onLoad() async {
    super.onLoad();
    paint.color = Colors.blue;
    add(RectangleHitbox());

    textComponent = TextComponent(
      text:'',
      textRenderer: TextPaint(
        style: const TextStyle(color: Colors.white, fontSize: 40),
      ),
      anchor: Anchor.center,
      position: Vector2(playerSize/2, playerSize/2),
    );
    add(textComponent);
  }

  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Star) {
      totalCount++;
      textComponent.text = '$totalCount';
      print('onCollisionStart - totalCount: $totalCount');
    }
    else {
      super.onCollisionStart(intersectionPoints, other);
    }
  }
}

class Star extends RectangleComponent with HasGameRef, CollisionCallbacks {
  static const starSize = 64.0;

  Star(Vector2 position)
    : super(
        position: position,
        size: Vector2.all(starSize),
        anchor: Anchor.center,
    );

  @override
  Future<void> onLoad() async {
    super.onLoad();
    paint.color = Colors.yellow;
    add(RectangleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.y += 5;
    if (position.y > gameRef.size.y) {
      removeFromParent();
      print('update - removeFromParent 호출됨');
    }
  }

  @override
  bool onComponentTypeCheck(PositionComponent other) {
    if (other is Star) {
      return false;
    }
    else {
      return super.onComponentTypeCheck(other);
    }
  }

  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Player) {
      removeFromParent(); // Star만 제거
      print('onCollisionStart - removeFromParent 호출됨');
    }
    else {
      super.onCollisionStart(intersectionPoints, other);
    }
  }
}

