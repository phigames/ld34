part of ld34;

class Input {

  bool leftMouse, rightMouse;
  int mouseX, mouseY;

  void init() {
    leftMouse = false;
    rightMouse = false;
    mouseX = 0;
    mouseY = 0;
  }

  void onMouseDown(MouseEvent event) {
    if (event.button == 0) {
      leftMouse = true;
    } else if (event.button = 2) {
      rightMouse = true;
    }
  }

  void onMouseUp(MouseEvent event) {
    if (event.button == 0) {
      leftMouse = false;
    } else if (event.button = 2) {
      rightMouse = false;
    }
  }

  void onMouseMove(MouseEvent event) {
    mouseX = event.layer.x;
    mouseY = event.layer.y;
  }

}