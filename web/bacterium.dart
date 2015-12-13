part of ld34;

abstract class Bacterium {

  num x, y;
  num nutrition = 10;
  bool dead = false;
  String color;

  Bacterium(this.x, this.y);

  Bacterium clone();

  void update(num radius);

  void draw(num xCam, num yCam, num groupX, num groupY) {
    bufferContext.fillStyle = color;
    bufferContext.fillRect(x + groupX - 3 - xCam, y + groupY - 3 - yCam, 6, 6);
  }

}

class BacteriumHealthy extends Bacterium {

  num pMutation = 0.1;

  BacteriumHealthy(num x, num y) : super(x, y) {
    nutrition = 10;
    color = '#1D9F12';
  }

  Bacterium clone() {
    nutrition /= 2;
    if (random.nextDouble() < pMutation) {
      return new BacteriumMutant(x, y)
        ..nutrition = nutrition;
    } else {
      return new BacteriumHealthy(x, y)
        ..nutrition = nutrition;
    }
  }

  void update(num radius) {
    num temporaryX = x+(random.nextInt(3) - 1) / 1;
    num temporaryY = y+(random.nextInt(3) - 1) / 1;
    if (temporaryX*temporaryX+temporaryY*temporaryY < radius * radius) {
      x = temporaryX;
      y = temporaryY;
    }
    nutrition -= 0.01;
  }

}

class BacteriumMutant extends Bacterium {

  BacteriumMutant(num x, num y) : super(x, y) {
    nutrition = 10;
    color = '#13D1CB';
  }

  Bacterium clone() {
    nutrition /= 2;
    return new BacteriumMutant(x, y)..nutrition = nutrition;
  }

  void update(num radius) {
    num temporaryX = x+(random.nextInt(3) - 1) / 1;
    num temporaryY = y+(random.nextInt(3) - 1) / 1;
    if (temporaryX*temporaryX+temporaryY*temporaryY < radius * radius) {
      x = temporaryX;
      y = temporaryY;
    }
    nutrition -= 0.01;
  }

}