part of ld34;

class World {

  List<Bacterium> bacteria;

  World() {
    initializeBacteria();
  }

  void initializeBacteria() {
    bacteria = new List<Bacterium>();
    for (int i = 0; i < 100; i++) {
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

