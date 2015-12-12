part of ld34;

abstract class Gamestate {

  void update();
  void draw();

}

class GamestatePlaying extends Gamestate {

  World world;

  GamestatePlaying() {
    world = new World();
  }

  void update() {
    world.update();
  }

  void draw() {
    world.draw();
  }

}

class GamestateEnded extends Gamestate {

  void update(num delta) {

  }

  void draw() {

  }

}