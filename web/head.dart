part of ld34;

class Head {
  ImageElement image;
  num width, height;
  num x, y;

  Head(this.image, this.x, this.y) {

  }

  void update() {
    x += 1;
    y += 1;
  }

  void draw() {
    bufferContext.drawImage(image, x, y);
  }

}