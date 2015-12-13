part of ld34;

class World {

  BacteriaGroup bacteriaGroup;
  List<Nutrient> nutrients;
  List<Antibiotic> antibiotics;
  num widthWorld = width*3, heightWorld = height*3;
  num widthCamera = width, heightCamera = height, xCamera, yCamera;
  num xOrigin, yOrigin;
  num pNutrientSpawn = 0.005;
  num pAntibioticSpawn = 0.002;
  num counter = 0;
  Head cage;
  Head labeouf;
  Head trump;
  int cageTime = 1000;
  int labeoufTime = 2000;
  int trumpTime = 3000;
  int tutBacterium = 50;
  int spwNutrient = 250;
  int tutNutrient = 300;
  int spwAntibiotic = 750;
  int tutAntibiotic = 800;

  World() {
    xCamera = widthWorld/2-widthCamera/2;
    yCamera = heightWorld/2-heightCamera/2;
    bacteriaGroup = new BacteriaGroup(widthWorld / 2, heightWorld / 2);
    nutrients = new List<Nutrient>();
    antibiotics = new List<Antibiotic>();
    cage = new Head(Resources.images['cage'], xCamera, yCamera);
    labeouf = new Head(Resources.images['labeouf'], xCamera, yCamera);
    trump = new Head(Resources.images['trump'], xCamera, yCamera);
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
    if (counter > cageTime && !cage.dead) {
      cage.update(bacteriaGroup);
    }
    if (counter > labeoufTime && !labeouf.dead) {
      labeouf.update(bacteriaGroup);
    }
    if (counter > trumpTime && !trump.dead) {
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
    }
    if (tutAntibiotic > 0) {
      tutAntibiotic--;
      if (tutAntibiotic == 0) {
        gamestate.showTutorialMessage('This is an antibiotic.|Don\'t touch it unless|you want to kill|your bacteria...', 900 - xCamera, 500 - yCamera);
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

