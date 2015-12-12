// Copyright (c) 2015, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:html';
import 'dart:math';

CanvasElement canvas;
CanvasRenderingContext2D canvasContext;
Random random;
List<Bacterium> bacteria;

void main() {
  canvas = querySelector('#canvas');
  canvasContext = canvas.context2D;
  random = new Random();
  bacteria = new List<Bacterium>();
  for (int i = 0; i < 100; i++) {
    bacteria.add(new Bacterium(random.nextInt(400) + 200, random.nextInt(200) + 125));
  }
  requestFrame();
}

void frame(num time) {
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
    x += random.nextInt(3) - 1;
    y += random.nextInt(3) - 1;
  }

  void draw() {
    canvasContext.fillStyle = '#F00';
    canvasContext.fillRect(x, y, 2, 2);
  }

}