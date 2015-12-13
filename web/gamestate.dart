part of ld34;

abstract class Gamestate {

  bool tutorial = false;
  List<String> tutorialMessage;
  num tutorialX, tutorialY;

  void update();

  void draw();

  void showTutorialMessage(String message, num x, num y) {
    tutorial = true;
    tutorialMessage = message.split('|');
    tutorialX = x;
    tutorialY = y;
  }

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
    if (!tutorial) {
      world.update();
    } else if (Input.leftMouse) {
      tutorial = false;
    }
  }

  void draw() {
    world.draw();
    if (tutorial) {
      bufferContext.fillStyle = '#BBB';
      bufferContext.strokeStyle = '#000';
      bufferContext.lineWidth = 2;
      bufferContext.beginPath();
      bufferContext.moveTo(tutorialX, tutorialY);
      bufferContext.lineTo(tutorialX + 200, tutorialY);
      bufferContext.lineTo(tutorialX + 150, tutorialY + tutorialMessage.length * 20 + 20);
      bufferContext.lineTo(tutorialX, tutorialY + tutorialMessage.length * 20 + 20);
      bufferContext.closePath();
      bufferContext.fill();
      bufferContext.stroke();
      bufferContext.font = '16px "Open Sans"';
      bufferContext.fillStyle = '#000';
      for (int i = 0; i < tutorialMessage.length; i++) {
        bufferContext.fillText(tutorialMessage[i], tutorialX + 10, tutorialY + i * 20 + 25);
      }
    }
  }

}

class GamestateLosing extends Gamestate {

  num x = 133;
  num y = 20;

  void update() {
    y++;
  }

  void draw() {
    bufferContext.fillStyle = '#000000';
    bufferContext.font = '64px "Open Sans"';
    bufferContext.fillText("You've lost", 400, 225);
    bufferContext.drawImage(Resources.images['cage'], x, y);
    bufferContext.drawImage(Resources.images['labeouf'], x+233, y);
    bufferContext.drawImage(Resources.images['trump'], x+466, y);
    if (y > 20) {
      y = 0;
    }
  }

}

class GamestateWinning extends Gamestate {

  void update() {

  }

  void draw() {

  }

}