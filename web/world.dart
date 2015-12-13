part of ld34;

class World {

  BacteriaGroup bacteriaGroup;
  List<Nutrient> nutrients;
  List<Antibiotic> antibiotics;
  num widthWorld = width*3, heightWorld = height*3;
  num widthCamera = width, heightCamera = height, xCamera, yCamera;
  num xOrigin, yOrigin;
  num pNutrientSpawn = 0.003;
  num pAntibioticSpawn = 0.001;
  num counter = 0;
  Head cage;

  World() {
    xCamera = widthWorld/2-widthCamera/2;
    yCamera = heightWorld/2-heightCamera/2;
    bacteriaGroup = new BacteriaGroup(widthWorld / 2, heightWorld / 2);
    nutrients = new List<Nutrient>();
    /*nutrients.add(new Crumb(900, 550));
    nutrients.add(new Crumb(1400, 750));
    nutrients.add(new Crumb(1300, 600));
    nutrients.add(new Crumb(1000, 700));*/
    antibiotics = new List<Antibiotic>();
    /*antibiotics.add(new Antibiotic(1000, 750));
    antibiotics.add(new Antibiotic(1200, 550));*/
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
    if (counter == 200) {
      cage = new Head(Resources.images['cage'], xCamera, yCamera);
    } else if (counter > 200) {
      cage.update();
    }

    counter++;
  }

  void draw() {
    bacteriaGroup.draw(xCamera, yCamera);
    for (int i = 0; i < nutrients.length; i++) {
      nutrients[i].draw(xCamera, yCamera);
    }
    for (int i = 0; i < antibiotics.length; i++) {
      antibiotics[i].draw(xCamera, yCamera);
    }
    if (counter > 200) {
      cage.draw(xCamera, yCamera);
    }
  }

}

