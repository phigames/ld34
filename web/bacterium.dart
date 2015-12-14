part of ld34;

abstract class Bacterium {

  num x, y;
  num nutrition = 10;
  bool dead = false;
  String color;

  Bacterium(this.x, this.y);

  Bacterium clone(bool mutate, num offsetX, num offsetY);

  void update(BacteriaGroup group, World world);

  void draw(num xCam, num yCam, num groupX, num groupY) {
    num size = sqrt(nutrition / 10 * 36);
    bufferContext.fillStyle = color;
    bufferContext.fillRect(x + groupX - size / 2 - xCam, y + groupY - size / 2 - yCam, size, size);
    //bufferContext.font = 'bold 10px "Open Sans"';
    //bufferContext.fillText(nutrition.round().toString(), x + groupX - 3 - xCam, y + groupY - 3 - yCam);
  }

}

class BacteriumHealthy extends Bacterium {

  static bool firstMutation = true;
  num pMutation = 0.02;

  BacteriumHealthy(num x, num y) : super(x, y) {
    nutrition = 10;
    color = ranHexColor(0x1D, 0x9F, 0x12);
  }

  Bacterium clone(bool mutate, World world) {
    nutrition /= 2;
    if (mutate && random.nextDouble() < pMutation) {
      BacteriumMutant mutant = new BacteriumMutant(x, y).. nutrition = nutrition;
      if (firstMutation) {
        if (world.bacteriaGroup.x + mutant.x < world.xCamera) {
          world.xCamera = world.bacteriaGroup.x + mutant.x - 50;
        } else if (world.bacteriaGroup.x + mutant.x > world.xCamera + world.widthCamera) {
          world.xCamera = world.bacteriaGroup.x + mutant.x - world.widthCamera + 50;
        }
        if (world.bacteriaGroup.y + mutant.y < world.yCamera) {
          world.yCamera = world.bacteriaGroup.y + mutant.y - 50;
        } else if (world.bacteriaGroup.y + mutant.y > world.yCamera + world.heightCamera) {
          world.yCamera = world.bacteriaGroup.y + mutant.y - world.heightCamera + 50;
        }
        gamestate.showTutorialMessage('One of your|bacteria just|mutated!|Kill the mutant|before it kills you!|(Use antibiotics)', mutant.x + world.bacteriaGroup.x - world.xCamera, mutant.y  + world.bacteriaGroup.y - world.yCamera);
        firstMutation = false;
      }
      Resources.sounds['mutant'].currentTime = 0;
      Resources.sounds['mutant'].play();
      return mutant;
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
    //nutrition -= 0.0001;
    if (nutrition <= 0) {
      dead = true;
    }
  }

}

class BacteriumMutant extends Bacterium {

  num pEat = 0.05;

  BacteriumMutant(num x, num y) : super(x, y) {
    nutrition = 10;
    color = ranHexColor(0xF7, 0x78, 0x4F);
  }

  Bacterium clone(bool mutate, World world) {
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
        if (dX * dX + dY * dY <= 4 && random.nextDouble() < pEat) {
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