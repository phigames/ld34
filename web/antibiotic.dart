part of ld34;

class Antibiotic {

  num x, y;
  num radius;
  num value;
  bool dead = false;
  num animationTime = 0;

  Antibiotic(this.x, this.y) {
    radius = 20;
    value = 10;
  }

  void update(BacteriaGroup bacteriaGroup) {
    num groupX = bacteriaGroup.x;
    num groupY = bacteriaGroup.y;
    for (int i = 0; i < bacteriaGroup.bacteria.length; i++) {
      num bacteriumX = groupX + bacteriaGroup.bacteria[i].x;
      num bacteriumY = groupY + bacteriaGroup.bacteria[i].y;
      num dX = bacteriumX - x;
      num dY = bacteriumY - y;
      if (dX * dX + dY * dY <= radius * radius) {
        value -= 1;
        bacteriaGroup.bacteria[i].dead = true;
        if (value < 0) {
          dead = true;
        }
      }
    }
    animationTime += 0.02;
  }

  void draw(num xCam, num yCam) {
    bufferContext.save();
    bufferContext.translate(x - xCam, y - yCam);
    //bufferContext.rotate(sin(animationTime * 5) / 6);
    bufferContext.rotate(animationTime / 3);
    bufferContext.scale(1 + sin(animationTime * 7) / 20, 1 + sin(animationTime * 7) / 20);
    bufferContext.beginPath();
    bufferContext.moveTo(0, -10);
    bufferContext.lineTo(-20, -10);
    bufferContext.arcTo(-30, -10, -30, 0, 10);
    bufferContext.arcTo(-30, 10, -20, 10, 10);
    bufferContext.lineTo(0, 10);
    bufferContext.closePath();
    bufferContext.fillStyle = '#2E9AFE';
    bufferContext.fill();
    bufferContext.beginPath();
    bufferContext.moveTo(0, -10);
    bufferContext.lineTo(20, -10);
    bufferContext.arcTo(30, -10, 30, 0, 10);
    bufferContext.arcTo(30, 10, 20, 10, 10);
    bufferContext.lineTo(0, 10);
    bufferContext.closePath();
    bufferContext.fillStyle = '#FA5858';
    bufferContext.fill();
    bufferContext.restore();
  }

}