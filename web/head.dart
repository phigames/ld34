part of ld34;

class Head {
  ImageElement image;
  num width = 100, height = 150;
  num x, y;
  num xSpeed = 1, ySpeed = 2;

  Head(this.image, this.x, this.y) {

  }

  void update() {
    x += xSpeed;
    y += ySpeed;
    if (x > 2400 || x < 0) {
      xSpeed = -xSpeed;
    }
    if (y > 1350 || y < 0) {
      ySpeed = -ySpeed;
    }
  }

  void draw(num xCam, num yCam) {
    bufferContext.drawImage(image, x - xCam - width/2, y - yCam - height/2);
  }

}