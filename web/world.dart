part of ld34;

class World {

  BacteriaGroup bacteriaGroup = new BacteriaGroup(400,250);

  World() {

  }

  void update() {
    bacteriaGroup.update;
  }

  void draw() {
    bacteriaGroup.draw;
  }

}

