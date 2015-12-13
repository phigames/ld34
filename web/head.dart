part of ld34;

class Head {
  ImageElement image;
  num width = 100, height = 150;
  num x, y;

  Head(this.image, this.x, this.y) {

  }

  void update() {
    x += 0.5;
  }

  void draw(num xCam, num yCam) {
    bufferContext.drawImage(image, xCam + x+width/2, yCam + y+height/2);
  }

}