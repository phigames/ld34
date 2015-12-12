part of ld34;

class World {

  List<Bacterium> bacteria;

  void initializeBacteria() {
    Random random = new Random();
    bacteria = new List<Bacterium>();
    for (int i = 0; i < bacteria.length; i++) {
      bacteria.add(new Bacterium(random.nextInt(400) + 200, random.nextInt(200) + 125));
    }
  }

  void update(num delta) {
    for (int i = 0; i < bacteria.length; i++) {
      bacteria[i].update(delta);
    }
  }

  void draw() {
    initializeBacteria();
    for (int i = 0; i < bacteria.length; i++) {
      bacteria[i].draw();
    }
  }

}

