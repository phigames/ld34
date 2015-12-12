part of ld34;

class BacteriaGroup {

  List<Bacterium> bacteria;
  num x;
  num y;
  num radius;

  BacteriaGroup(num x, num y) {
    this.x = x;
    this.y = y;
    initializeBacteria();
  }

  void initializeBacteria() {
    bacteria = new List<Bacterium>();
    for (int i = 0; i < 500; i++) {
      num phi = random.nextDouble()*2*PI;
      num distance = random.nextInt(50);
      bacteria.add(new Bacterium(random.nextInt(400) + 200, random.nextInt(200) + 125));
    }
  }

  void update() {
    for (int i = 0; i < bacteria.length; i++) {
      bacteria[i].update();
    }
  }

  void draw() {
    for (int i = 0; i < bacteria.length; i++) {
      bacteria[i].draw();
    }
  }

}