part of ld34;

abstract class Bacterium {

  num x, y;
  num nutrition = 10;
  bool dead = false;
  String color;

  Bacterium(this.x, this.y);

  Bacterium clone(bool mutate);

  void update(num radius);

  void draw(num xCam, num yCam, num groupX, num groupY) {
    num size = sqrt(nutrition / 10 * 36);
    bufferContext.fillStyle = color;
    bufferContext.fillRect(x + groupX - size / 2 - xCam, y + groupY - size / 2 - yCam, size, size);
    //bufferContext.font = 'bold 10px "Open Sans"';
    //bufferContext.fillText(nutrition.round().toString(), x + groupX - 3 - xCam, y + groupY - 3 - yCam);
  }

}

class BacteriumHealthy extends Bacterium {

  num pMutation = 0.02;

  BacteriumHealthy(num x, num y) : super(x, y) {
    nutrition = 10;
    color = '#1D9F12';
  }

  Bacterium clone(bool mutate) {
    nutrition /= 2;
    if (mutate && random.nextDouble() < pMutation) {
      print('mutant');
      return new BacteriumMutant(x, y)
        ..nutrition = nutrition;
    } else {
      return new BacteriumHealthy(x, y)
        ..nutrition = nutrition;
    }
  }

  void update(BacteriaGroup group) {
    num temporaryX = x+(random.nextInt(3) - 1) / 2;
    num temporaryY = y+(random.nextInt(3) - 1) / 2;
    if (temporaryX*temporaryX+temporaryY*temporaryY < group.radius * group.radius) {
      x = temporaryX;
      y = temporaryY;
    }
    nutrition -= 0.0001;
    if (nutrition <= 0) {
      dead = true;
    }
  }

}

class BacteriumMutant extends Bacterium {

  BacteriumMutant(num x, num y) : super(x, y) {
    nutrition = 10;
    color = '#13D1CB';
  }

  Bacterium clone(bool mutate) {
    nutrition /= 2;
    return new BacteriumMutant(x, y)..nutrition = nutrition;
  }

  void update(BacteriaGroup group) {
    num temporaryX = x+(random.nextInt(3) - 1) / 2;
    num temporaryY = y+(random.nextInt(3) - 1) / 2;
    if (temporaryX*temporaryX+temporaryY*temporaryY < group.radius * group.radius) {
      x = temporaryX;
      y = temporaryY;
    }
    for (int i = 0; i < group.bacteria.length; i++) {
      if (group.bacteria[i] != this && !dead && !group.bacteria[i].dead) {
        num dX = group.bacteria[i].x - x;
        num dY = group.bacteria[i].y - y;
        if (dX * dX + dY * dY <= nutrition / 10 * 3) {
          nutrition += group.bacteria[i].nutrition;
          group.bacteria[i].nutrition = 0;
          group.bacteria[i].dead = true;
        }
      }
    }
    /*nutrition -= 0.0001;
    if (nutrition <= 0) {
      dead = true;
    }*/
  }

}