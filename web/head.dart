part of ld34;

class Head {
  ImageElement image;
  num width = 100, height = 150;
  num x, y;
  num xSpeed = 1, ySpeed = 2;
  int infection = 0;
  bool dead = false;

  Head(this.image, this.x, this.y) {

  }

  void update(BacteriaGroup bacteriaGroup) {
    x += xSpeed;
    y += ySpeed;
    if (x > 2400 || x < 0) {
      xSpeed = -xSpeed;
    }
    if (y > 1350 || y < 0) {
      ySpeed = -ySpeed;
    }
    num groupX = bacteriaGroup.x;
    num groupY = bacteriaGroup.y;
    num groupDX = groupX - x;
    num groupDY = groupY - y;
    num radiusSum = bacteriaGroup.radius + width / 2;
    if (groupDX * groupDX + groupDY * groupDY <= radiusSum * radiusSum) {
      for (int i = 0; i < bacteriaGroup.bacteria.length; i++) {
        num bacteriumX = groupX + bacteriaGroup.bacteria[i].x;
        num bacteriumY = groupY + bacteriaGroup.bacteria[i].y;
        num dX = bacteriumX - x;
        num dY = bacteriumY - y;
        if (dX * dX + dY * dY <= width * width / 4) {
          bacteriaGroup.bacteria[i].dead = true;
          infection++;
          if (infection >= 100) {
            dead = true;
          }
        }
      }
    }
  }

  void draw(num xCam, num yCam) {
    bufferContext.drawImage(image, x - xCam - width/2, y - yCam - height/2);
    bufferContext.fillStyle = '#F00';
    bufferContext.font = '20px "Open Sans"';
    bufferContext.fillText(infection.toString() + '%', x - xCam - 20, y - yCam - height / 2);
    bufferContext.font = '15px "Open Sans"';
    bufferContext.fillText('infected', x - xCam - 30, y - yCam - height / 2 + 10);
  }

}