part of ld34;

class Bacterium {

  num x, y;
  num nutrition;
  bool dead = false;

  Bacterium(num x, num y) {
    this.x = x;
    this.y = y;
  }

  void update() {
    x += (random.nextInt(3) - 1) / 10;
    y += (random.nextInt(3) - 1) / 10;
  }

  void draw(num xTest, num yTest) {
    bufferContext.fillStyle = '#F00';
    bufferContext.fillRect(x+xTest,y+yTest, 6, 6);
  }

}

