part of ld34;

abstract class Gamestate {

  void update();
  void draw();

}

class GamestateMenu extends Gamestate {

  bool loaded = false;
  bool start = false;
  num red = 1;

  void update() {
    if (Resources.imagesLoaded >= Resources.images.values.length || Resources.soundsLoaded >= Resources.sounds.values.length) {
      loaded = true;
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
  }

  void draw() {
    bufferContext.fillStyle = '#1D9F12';
    bufferContext.fillRect(width / 2 * (1 - red), (height - width * red) / 2, width * red, width * red);
    bufferContext.font = '30px "Open Sans"';
    bufferContext.fillStyle = '#FFF';
    if (loaded) {
      bufferContext.fillText('click to start', 313, 233);
    } else {
      bufferContext.fillText('loading...', 338, 233);
    }
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

class GamestateEnding extends Gamestate {

  void update() {

  }

  void draw() {

  }

}