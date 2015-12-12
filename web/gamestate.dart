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
      red *= 0.92;
      if (red < 0.007) {
        gamestate = new GamestatePlaying();
      }
    }
  }

  void draw() {
    bufferContext.fillStyle = '#F00';
    bufferContext.fillRect(width / 2 * (1 - red), (height - width * red) / 2, width * red, width * red);
    bufferContext.font = '30px "Open Sans"';
    bufferContext.fillStyle = '#FFF';
    bufferContext.fillText('click to start', 313, 233);
  }

}

class GamestatePlaying extends Gamestate {

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