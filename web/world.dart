part of ld34;

class World {

  BacteriaGroup bacteriaGroup;
  List<Nutrient> nutrients;
  List<Antibiotic> antibiotics;

  World() {
    bacteriaGroup = new BacteriaGroup(400,225);
    nutrients = new List<Nutrient>();
    nutrients.add(new Crumb(100, 100));
    nutrients.add(new Crumb(500, 300));
    antibiotics = new List<Antibiotic>();
    antibiotics.add(new Antibiotic(200, 300));
    antibiotics.add(new Antibiotic(400, 100));
  }

  void update() {
    bacteriaGroup.update();
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
    bacteriaGroup.draw();
    for (int i = 0; i < nutrients.length; i++) {
      nutrients[i].draw();
    }
    for (int i = 0; i < antibiotics.length; i++) {
      antibiotics[i].draw();
    }
  }

}

