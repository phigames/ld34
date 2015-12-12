part of ld34;

abstract class Gamestate {

  void update(num delta);
  void draw();

}

class GamestatePlaying extends Gamestate {

  GamestatePlaying() {
    World world = new World();
  }

  void update(num delta) {
    world.update(delta);
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