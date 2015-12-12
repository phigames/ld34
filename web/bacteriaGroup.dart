part of ld34;

class BacteriaGroup {

  List<Bacterium> bacteria;
  num x;
  num y;
  num radius = 50;

  BacteriaGroup(num x, num y) {
    this.x = x;
    this.y = y;
    initializeBacteria();
  }

  void initializeBacteria() {
    bacteria = new List<Bacterium>();
    for (int i = 0; i < 500; i++) {
      num phi = random.nextDouble()*2*PI;
      num distance = random.nextInt(radius+1);
      bacteria.add(new Bacterium(cos(phi)*distance, sin(phi)*distance));
    }
  }

  void update() {
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