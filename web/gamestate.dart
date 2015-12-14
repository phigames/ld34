part of ld34;

abstract class Gamestate {

  bool tutorial = false;
  List<String> tutorialMessage;
  num tutorialX, tutorialY;
  num okX, okY, okW, okH;

  void update();

  void draw();

  void showTutorialMessage(String message, num x, num y) {
    tutorial = true;
    tutorialMessage = message.split('|');
    tutorialX = x;
    tutorialY = y;
    print(message);
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
    bufferContext.font = '30px bold "Open Sans"';
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
      Input.leftMouse = false;
      if (Input.mouseX >= okX && Input.mouseX < okX + okW && Input.mouseY >= okY && Input.mouseY < okY + okH) {
        tutorial = false;
      }
    }
  }

  void draw() {
    world.draw();
    if (tutorial) {
      bufferContext.fillStyle = '#BBB';
      bufferContext.strokeStyle = '#000';
      bufferContext.lineWidth = 2;
      bufferContext.beginPath();
      if (tutorialX - 200 > 0) {
        bufferContext.moveTo(tutorialX - 200, tutorialY);
        bufferContext.lineTo(tutorialX, tutorialY);
        if (tutorialY + tutorialMessage.length * 20 + 20 < height) {
          bufferContext.lineTo(tutorialX - 50, tutorialY + tutorialMessage.length * 20 + 20);
          bufferContext.lineTo(tutorialX - 200, tutorialY + tutorialMessage.length * 20 + 20);
        } else {
          bufferContext.lineTo(tutorialX - 50, tutorialY - tutorialMessage.length * 20 - 20);
          bufferContext.lineTo(tutorialX - 200, tutorialY - tutorialMessage.length * 20 - 20);
        }
      } else {
        bufferContext.moveTo(tutorialX, tutorialY);
        bufferContext.lineTo(tutorialX + 200, tutorialY);
        if (tutorialY + tutorialMessage.length * 20 + 20 < height) {
          bufferContext.lineTo(tutorialX + 200, tutorialY + tutorialMessage.length * 20 + 20);
          bufferContext.lineTo(tutorialX + 50, tutorialY + tutorialMessage.length * 20 + 20);
        } else {
          bufferContext.lineTo(tutorialX + 200, tutorialY - tutorialMessage.length * 20 - 20);
          bufferContext.lineTo(tutorialX + 50, tutorialY - tutorialMessage.length * 20 - 20);
        }
      }
      bufferContext.closePath();
      bufferContext.fill();
      bufferContext.stroke();
      bufferContext.font = '16px "Open Sans"';
      bufferContext.fillStyle = '#000';
      if (tutorialX - 200 > 0) {
        if (tutorialY + tutorialMessage.length * 20 + 20 < height) {
          for (int i = 0; i < tutorialMessage.length; i++) {
            bufferContext.fillText(tutorialMessage[i], tutorialX - 190, tutorialY + i * 20 + 25);
          }
        } else {
          for (int i = 0; i < tutorialMessage.length; i++) {
            bufferContext.fillText(tutorialMessage[i], tutorialX - 190, tutorialY - (tutorialMessage.length - i) * 20 + 5);
          }
        }
      } else {
        if (tutorialY + tutorialMessage.length * 20 + 20 < height) {
          for (int i = 0; i < tutorialMessage.length; i++) {
            bufferContext.fillText(tutorialMessage[i], tutorialX + 60, tutorialY + i * 20 + 25);
          }
        } else {
          for (int i = 0; i < tutorialMessage.length; i++) {
            bufferContext.fillText(tutorialMessage[i], tutorialX + 60, tutorialY - (tutorialMessage.length - i) * 20 + 5);
          }
        }
      }
      if (tutorialX - 200 > 0) {
        okX = tutorialX - 35;
      } else {
        okX = tutorialX;
      }
      if (tutorialY + tutorialMessage.length * 20 + 20 < height) {
        okY = tutorialY + tutorialMessage.length * 20;
      } else {
        okY = tutorialY - tutorialMessage.length * 20 - 20;
      }
      okW = 35;
      okH = 20;
      if (Input.mouseX >= okX && Input.mouseX < okX + okW && Input.mouseY >= okY && Input.mouseY < okY + okH) {
        bufferContext.fillStyle = '#888';
      } else {
        bufferContext.fillStyle = '#444';
      }
      bufferContext.fillRect(okX, okY, okW, okH);
      bufferContext.fillStyle = '#FFF';
      bufferContext.font = '20px "Open Sans"';
      bufferContext.fillText('ok', okX + 5, okY + 17);
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