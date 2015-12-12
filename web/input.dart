part of ld34;

class Input {

  static bool leftMouse, rightMouse;
  static int mouseX, mouseY;

  static void init() {
    leftMouse = false;
    rightMouse = false;
    mouseX = 0;
    mouseY = 0;
  }

  static void onMouseDown(MouseEvent event) {
    if (event.button == 0) {
      leftMouse = true;
    } else if (event.button = 2) {
      rightMouse = true;
    }
  }

  static void onMouseUp(MouseEvent event) {
    if (event.button == 0) {
      leftMouse = false;
    } else if (event.button = 2) {
      rightMouse = false;
    }
  }

  static void onMouseMove(MouseEvent event) {
    mouseX = event.layer.x;
    mouseY = event.layer.y;
  }

}