part of ld34;

class World {

  BacteriaGroup bacteriaGroup;
  List<Nutrient> nutrients;
  List<Antibiotic> antibiotics;
  num widthWorld = width*3, heightWorld = height*3;
  num widthCamera = width, heightCamera = height, xCamera, yCamera;
  num xOrigin, yOrigin;
  num pNutrientSpawn = 0;
  num pAntibioticSpawn = 0;
  num counter = 0;
  Head cage;
  Head labeouf;
  Head trump;
  int cageTime = 10000;
  int labeoufTime = 20000;
  int trumpTime = 30000;
  int tutBacterium = 100;
  int spwNutrient = 350;
  int tutNutrient = 400;
  int spwAntibiotic = 850;
  int tutAntibiotic = 900;
  int tutMap = 1400;
  int tutHead = -1;

  World() {
    xCamera = widthWorld/2-widthCamera/2;
    yCamera = heightWorld/2-heightCamera/2;
    bacteriaGroup = new BacteriaGroup(widthWorld / 2, heightWorld / 2);
    nutrients = new List<Nutrient>();
    antibiotics = new List<Antibiotic>();
    cage = new Head(Resources.images['cage']);
    labeouf = new Head(Resources.images['labeouf']);
    trump = new Head(Resources.images['trump']);
  }

  spawnNutrient() {
    num x, y;
    num dX, dY;
    do {
      x = random.nextDouble() * widthWorld;
      y = random.nextDouble() * heightWorld;
      dX = bacteriaGroup.x - x;
      dY = bacteriaGroup.y - y;
    } while (dX * dX + dY * dY < bacteriaGroup.radius * bacteriaGroup.radius + 250);
    nutrients.add(new Crumb(x, y));
  }

  spawnAntibiotic() {
    num x, y;
    num dX, dY;
    do {
      x = random.nextDouble() * widthWorld;
      y = random.nextDouble() * heightWorld;
      dX = bacteriaGroup.x - x;
      dY = bacteriaGroup.y - y;
    } while (dX * dX + dY * dY < bacteriaGroup.radius * bacteriaGroup.radius + 250);
    antibiotics.add(new Antibiotic(x, y));
  }

  void update() {
    if (Input.rightMouse) {
      if (xOrigin != null) {
        xCamera += xOrigin - Input.mouseX;
        yCamera += yOrigin - Input.mouseY;
        if (xCamera < 0) {
          xCamera = 0;
        } else if (xCamera + widthCamera > widthWorld) {
          xCamera = widthWorld - widthCamera;
        }
        if (yCamera < 0) {
          yCamera = 0;
        } else if (yCamera + heightCamera > heightWorld) {
          yCamera = heightWorld - heightCamera;
        }
      }
      xOrigin = Input.mouseX;
      yOrigin = Input.mouseY;
    } else {
      if (xOrigin != null) {
        xOrigin = null;
        yOrigin = null;
      }
    }
    bacteriaGroup.update(xCamera, yCamera);
    for (int i = 0; i < nutrients.length; i++) {
      nutrients[i].update(bacteriaGroup);
      if (nutrients[i].dead) {
        nutrients.removeAt(i);
        i--;
      }
    }
    for (int i = 0; i < antibiotics.length; i++) {
      antibiotics[i].update(bacteriaGroup);
      if (antibiotics[i].dead) {
        antibiotics.removeAt(i);
        i--;
      }
    }
    if (random.nextDouble() < pNutrientSpawn) {
      spawnNutrient();
    }
    if (random.nextDouble() < pAntibioticSpawn) {
      spawnAntibiotic();
    }
    if (counter >= cageTime && !cage.dead) {
      if (counter == cageTime) {
        print('cage');
        cage.x = xCamera + widthCamera - 200;
        cage.y = yCamera + 100;
        tutHead = 50;
      }
      cage.update(bacteriaGroup);
    }
    if (counter >= labeoufTime && !labeouf.dead) {
      labeouf.update(bacteriaGroup);
    }
    if (counter >= trumpTime && !trump.dead) {
      trump.update(bacteriaGroup);
    }
    if (bacteriaGroup.bacteria.length <= 0) {
      gamestate = new GamestateLosing();
    } else if (cage.dead && labeouf.dead && trump.dead) {
      gamestate = new GamestateWinning();
    }
    counter++;
    if (tutBacterium > 0) {
      tutBacterium--;
      if (tutBacterium == 0) {
        gamestate.showTutorialMessage('This is your|first bacterium.|Click to move|it around.', bacteriaGroup.x + bacteriaGroup.bacteria[0].x - xCamera, bacteriaGroup.y + bacteriaGroup.bacteria[0].y - yCamera);
      }
    }
    if (spwNutrient > 0) {
      spwNutrient--;
      if (spwNutrient == 0) {
        nutrients.add(new Crumb(1400, 750));
      }
      pNutrientSpawn = 0.015;
    }
    if (tutNutrient > 0) {
      tutNutrient--;
      if (tutNutrient == 0) {
        gamestate.showTutorialMessage('This is food|for your bacteria.|Go grab some!', 1400 - xCamera, 750 - yCamera);
      }
    }
    if (spwAntibiotic > 0) {
      spwAntibiotic--;
      if (spwAntibiotic == 0) {
        antibiotics.add(new Antibiotic(1100, 600));
      }
      pNutrientSpawn = 0.005;
    }
    if (tutAntibiotic > 0) {
      tutAntibiotic--;
      if (tutAntibiotic == 0) {
        gamestate.showTutorialMessage('This is an antibiotic.|Don\'t touch it unless|you want to kill|your bacteria...', 1100 - xCamera, 600 - yCamera);
      }
    }
    if (tutMap > 0) {
      tutMap--;
      if (tutMap == 0) {
        gamestate.showTutorialMessage('You can move the map|around by dragging|with your right|mouse button.', 600, 50);
      }
    }
    if (tutHead > 0) {
      print('head');
      tutHead--;
      if (tutHead == 0) {
        gamestate.showTutorialMessage('What?! Who\'s this?|This guy doesn\'t|belong here!|Infect him!', cage.x - xCamera - 20, cage.y - yCamera + 30);
      }
    }
  }

  void draw() {
    bacteriaGroup.draw(xCamera, yCamera);
    for (int i = 0; i < nutrients.length; i++) {
      nutrients[i].draw(xCamera, yCamera);
    }
    for (int i = 0; i < antibiotics.length; i++) {
      antibiotics[i].draw(xCamera, yCamera);
    }
    if (counter > cageTime && !cage.dead) {
      cage.draw(xCamera, yCamera);
    }
    if (counter > labeoufTime && !labeouf.dead) {
      labeouf.draw(xCamera, yCamera);
    }
    if (counter > trumpTime && !trump.dead) {
      trump.draw(xCamera, yCamera);
    }
  }

}

