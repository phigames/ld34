part of ld34;

abstract class Gamestate {

  void update();
  void draw();

}

class GamestateMenu extends Gamestate {

  bool start = false;
  num red = 1;

  void update() {
    if (!start && Input.leftMouse) {
      start = true;
    }
    if (start) {
      red -= 0.015;
      if (red <= 0) {
        gamestate = new GamestatePlaying();
      }
    }
  }

  void draw() {
    bufferContext.fillStyle = '#F00';
    bufferContext.fillRect(width / 2 * (1 - red), height / 2 * (1 - red), width * red, height * red);
    bufferContext.font = '30px "Open Sans"';
    bufferContext.fillStyle = '#FFF';
    bufferContext.fillText('click to start', 315, 230);
  }

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

  void update() {

  }

  void draw() {

  }

}