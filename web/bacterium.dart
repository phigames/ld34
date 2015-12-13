part of ld34;

class Bacterium {

  num x, y;
  num nutrition = 10;
  bool dead = false;
  num temporaryX, temporaryY;

  Bacterium(num x, num y) {
    this.x = x;
    this.y = y;
  }

  Bacterium clone() {
    Bacterium result = new Bacterium(x, y);
    nutrition /= 2;
    return new Bacterium(x, y)..nutrition = nutrition;
  }

  void update(num radius) {
    temporaryX = x+(random.nextInt(3) - 1) / 10;
    temporaryY = y+(random.nextInt(3) - 1) / 10;
    if (temporaryX*temporaryX+temporaryY*temporaryY < radius * radius) {
      x += (random.nextInt(3) - 1) / 10;
      y += (random.nextInt(3) - 1) / 10;
    }
    nutrition -= 0.01;
  }

  void draw(num xCam, num yCam, num groupX, num groupY) {
    bufferContext.fillStyle = '#F00';
    bufferContext.fillRect(x + groupX - 3 - xCam, y + groupY - 3 - yCam, 6, 6);
  }

}