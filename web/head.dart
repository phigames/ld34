part of ld34;

class Head {
  ImageElement image;
  String name;
  num width = 100, height = 150;
  num x, y;
  num xSpeed = 1, ySpeed = 0.5;
  int infection = 0;
  bool dead = false;
  num spawnTime = 0;

  Head(this.image, this.name, [this.x = 0, this.y = 0]);

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
          bool allDead = true;
          for (int j = 0; j < bacteriaGroup.bacteria.length; j++) {
            if (!bacteriaGroup.bacteria[j].dead) {
              allDead = false;
              break;
            }
          }
          if (allDead) {
            gamestate = new GamestateLosing(name);
          }
          infection++;
          if (infection >= 50) {
            dead = true;
            Resources.sounds['kill'].currentTime = 0;
            Resources.sounds['kill'].play();
          }
        }
      }
    }
    if (spawnTime < 1) {
      spawnTime += 0.08;
      if (spawnTime > 1) {
        spawnTime = 1;
      }
    }
  }

  void draw(num xCam, num yCam) {
    bufferContext.save();
    bufferContext.translate(x - xCam, y - yCam);
    if (spawnTime < 1) {
      bufferContext.scale(spawnTime, spawnTime);
    }
    bufferContext.drawImage(image, -width / 2, -height / 2);
    bufferContext.fillStyle = '#F00';
    bufferContext.font = '20px "Open Sans"';
    bufferContext.fillText((infection * 2).toString() + '%', -20, -height / 2);
    bufferContext.font = '15px "Open Sans"';
    bufferContext.fillText('infected', -30, -height / 2 + 10);
    bufferContext.restore();
  }

}