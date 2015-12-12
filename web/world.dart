part of ld34;

class World {

  BacteriaGroup bacteriaGroup;

  World() {
    bacteriaGroup = new BacteriaGroup(400,225);
  }

  void update() {
    bacteriaGroup.update;
  }

  void draw() {
    bacteriaGroup.draw;
  }

}

