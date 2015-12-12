library ld34;

import 'dart:html';
import 'dart:math';

part 'gamestate.dart';
part 'world.dart';
part 'bacterium.dart';
part 'nutrient.dart';
part 'input.dart';
part 'resources.dart';

CanvasElement canvas;
CanvasRenderingContext2D canvasContext;
Random random;
Gamestate gamestate;
World world;
num lastUpdate = -1;

void main() {
  random = new Random();
  canvas = querySelector('#canvas');
  canvasContext = canvas.context2D;
  requestFrame();
  gamestate = new GamestatePlaying();
}

void frame(num time) {
  if (lastUpdate == -1) {
    lastUpdate = time;
  } else {
    canvasContext.fillStyle = '#FFF';
    canvasContext.globalAlpha = 1;
    canvasContext.fillRect(0, 0, 800, 450);
    canvasContext.globalAlpha = 1;
    while (time - lastUpdate >= 20) {
      gamestate.update();
      lastUpdate += 20;
    }
    gamestate.draw();
  }
  requestFrame();
}

void requestFrame() {
  window.animationFrame.then(frame);
}