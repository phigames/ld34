part of ld34;

class Bacterium {

  num x, y;
  num nutrition = 10;
  bool dead = false;

  Bacterium(num x, num y) {
    this.x = x;
    this.y = y;
  }

  void update() {
    x += (random.nextInt(3) - 1) / 10;
    y += (random.nextInt(3) - 1) / 10;
    nutrition -= 0.01;
  }

  void draw(num groupX, num groupY) {
    bufferContext.fillStyle = '#F00';
    bufferContext.fillRect(x + groupX - 3, y + groupY - 3, 6, 6);
  }

}

