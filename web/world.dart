part of ld34;

class World {

  BacteriaGroup bacteriaGroup;
  List<Nutrient> nutrients;
  List<Antibiotic> antibiotics;
  num widthWorld = width*3, heightWorld = height*3;
  num widthCamera = width, heightCamera = height, xCamera, yCamera;
  num xOrigin, yOrigin;

  World() {
    xCamera = widthWorld/2-widthCamera/2;
    yCamera = heightWorld/2-heightCamera/2;
    bacteriaGroup = new BacteriaGroup(widthWorld / 2, heightWorld / 2);
    nutrients = new List<Nutrient>();
    nutrients.add(new Crumb(900, 550));
    nutrients.add(new Crumb(1400, 750));
    antibiotics = new List<Antibiotic>();
    antibiotics.add(new Antibiotic(1000, 750));
    antibiotics.add(new Antibiotic(1200, 550));
  }

  void update() {
    if (Input.rightMouse) {
      if (xOrigin != null) {
        xCamera += xOrigin - Input.mouseX;
        yCamera += yOrigin - Input.mouseY;
        if (xCamera < 0) {
          xCamera = 0;
        } else if (xCamera > widthWorld) {
          xCamera = widthWorld;
        } else if (yCamera < 0) {
          yCamera = 0;
        } else if (yCamera > heightWorld) {
          yCamera = heightWorld;
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
  }

  void draw() {
    bacteriaGroup.draw(xCamera, yCamera);
    for (int i = 0; i < nutrients.length; i++) {
      nutrients[i].draw(xCamera, yCamera);
    }
    for (int i = 0; i < antibiotics.length; i++) {
      antibiotics[i].draw(xCamera, yCamera);
    }
  }

}

