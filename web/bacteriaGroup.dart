part of ld34;

class BacteriaGroup {

  List<Bacterium> bacteria;
  num x, y;
  num radius = 50;
  num targetX, targetY;
  num targetPhi, targetCounter = 0, step =0.5;

  BacteriaGroup(num x, num y) {
    this.x = x;
    this.y = y;
    initializeBacteria();
  }

  void initializeBacteria() {
    bacteria = new List<Bacterium>();
    for (int i = 0; i < 1; i++) {
      radius = 5;
      num phi = random.nextDouble()*2*PI;
      num distance = random.nextInt(radius+1);
      bacteria.add(new Bacterium(cos(phi)*distance, sin(phi)*distance));
    }
  }

  void update() {
    if (Input.leftMouse) {
      targetX = Input.mouseX;
      targetY = Input.mouseY;
      num dX = targetX -x;
      num dY = targetY -y;
      targetPhi = atan((dY)/(dX));
      if (dX < 0){
        targetPhi += PI;
      }
      print(targetPhi);
      targetCounter = sqrt(dX*dX+dY*dY)/step;

    }
    if (targetCounter > 0) {
      targetCounter --;
      x += cos(targetPhi)*step;
      y += sin(targetPhi)*step;
    }
    for (int i = 0; i < bacteria.length; i++) {
      bacteria[i].update();
    }
  }

  void draw() {
    for (int i = 0; i < bacteria.length; i++) {
      bacteria[i].draw(x, y);
    }
  }

}