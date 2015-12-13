part of ld34;

class BacteriaGroup {

  List<Bacterium> bacteria;
  num x, y;
  num radius = 50;
  num targetX, targetY;
  num targetPhi, targetCounter = 0, step = 0.5;
  num pMitosis = 0.003, nutritionMitosis = 10;

  BacteriaGroup(num x, num y) {
    this.x = x;
    this.y = y;
    initializeBacteria();
  }

  void initializeBacteria() {
    bacteria = new List<Bacterium>();
    bacteria.add(new BacteriumHealthy(0, 0));
    /*for (int i = 0; i < 100; i++) {
      num phi = random.nextDouble()*2*PI;
      num distance = random.nextInt(radius+1);
      bacteria.add(new BacteriumHealthy(cos(phi)*distance, sin(phi)*distance));
    }*/
  }

  void update(num xCam, num yCam) {
    if (Input.leftMouse) {
      targetX = Input.mouseX + xCam;
      targetY = Input.mouseY + yCam;
      num dX = targetX -x;
      num dY = targetY -y;
      targetPhi = atan((dY)/(dX));
      if (dX < 0){
        targetPhi += PI;
      }
      targetCounter = sqrt(dX*dX+dY*dY)/step;
    }
    if (targetCounter > 0) {
      targetCounter --;
      x += cos(targetPhi)*step;
      y += sin(targetPhi)*step;
    }
    for (int i = 0; i < bacteria.length; i++) {
      bacteria[i].update(this);
    }
    for (int i = 0; i < bacteria.length; i++) {
      if (bacteria[i].dead) {
        bacteria.removeAt(i);
        i--;
      } else if (bacteria[i].nutrition >= nutritionMitosis) {
        if (random.nextDouble() < pMitosis) {
          bacteria.add(bacteria[i].clone(bacteria.length > 10));
        }
      }
    }
    radius = sqrt(bacteria.length) * 4;
  }

  void draw(num xCam, num yCam) {
    for (int i = 0; i < bacteria.length; i++) {
      bacteria[i].draw(xCam, yCam, x, y);
    }
    bufferContext.strokeStyle = '#000';
    bufferContext.beginPath();
    bufferContext.arc(x - xCam, y - yCam, radius, 0, 2 * PI);
    bufferContext.stroke();
  }

}