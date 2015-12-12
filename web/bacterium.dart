part of ld34;

class Bacterium {

  num x, y;

  Bacterium(x, y) {
    this.x = x;
    this.y = y;
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

