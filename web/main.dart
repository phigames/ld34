library ld34;

import 'dart:html';
import 'dart:math';

part 'gamestate.dart';
part 'world.dart';
part 'bacteriaGroup.dart';
part 'bacterium.dart';
part 'nutrient.dart';
part 'antibiotic.dart';
part 'input.dart';
part 'resources.dart';
part 'head.dart';

CanvasElement canvas, buffer;
CanvasRenderingContext2D canvasContext, bufferContext;
int width, height;
Random random;
Gamestate gamestate;
World world;
num lastUpdate = -1;

void main() {
  random = new Random();
  canvas = querySelector('#canvas');
  width = canvas.width;
  height = canvas.height;
  buffer = new CanvasElement(width: width, height: height);
  canvasContext = canvas.context2D;
  bufferContext = buffer.context2D;
  Input.init();
  canvas.onMouseDown.listen(Input.onMouseDown);
  canvas.onMouseUp.listen(Input.onMouseUp);
  canvas.onMouseMove.listen(Input.onMouseMove);
  Resources.init();
  Resources.load();
  gamestate = new GamestateMenu();
  requestFrame();
}

void frame(num time) {
  if (lastUpdate == -1) {
    lastUpdate = time;
  } else {
    while (time - lastUpdate >= 20) {
      gamestate.update();
      lastUpdate += 20;
    }
    bufferContext.clearRect(0, 0, width, height);
    gamestate.draw();
    canvasContext.clearRect(0, 0, width, height);
    canvasContext.drawImage(buffer, 0, 0);
  }
  requestFrame();
}

void requestFrame() {
  window.animationFrame.then(frame);
}

String ranHexColor(int r, int g, int b) {
  double ran = random.nextDouble()*0.3+0.85;
  int hexR = (ran * r).round(), hexG = (ran * g).round(), hexB = (ran * b).round();
  hexR = min(hexR, 0xFF);
  hexG = min(hexG, 0xFF);
  hexB = min(hexB, 0xFF);
  int number = (hexR*0x100+hexG)*0x100+hexB;
  return '#'+ number.toRadixString(16);
}