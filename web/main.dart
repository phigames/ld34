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
List<Bacterium> bacteria;

void main() {
  canvas = querySelector('#canvas');
  canvasContext = canvas.context2D;
  random = new Random();
  bacteria = new List<Bacterium>();
  for (int i = 0; i < 10000; i++) {
    bacteria.add(new Bacterium(random.nextInt(400) + 200, random.nextInt(200) + 125));
  }
  requestFrame();
}

void frame(num time) {
  canvasContext.fillStyle = '#FFF';
  canvasContext.globalAlpha = 1;
  canvasContext.fillRect(0, 0, 800, 450);
  canvasContext.globalAlpha = 1;
  for (int i = 0; i < bacteria.length; i++) {
    bacteria[i].update();
    bacteria[i].draw();
  }
  requestFrame();
}

void requestFrame() {
  window.animationFrame.then(frame);
}

class Bacterium {

  num x, y;

  Bacterium(this.x, this.y) {

  }

  void update() {
    x += (random.nextInt(3) - 1) / 10;
    y += (random.nextInt(3) - 1) / 10;
  }

  void draw() {
    canvasContext.fillStyle = '#F00';
    canvasContext.fillRect(x, y, 4, 4);
  }

}