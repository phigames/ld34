part of ld34;

abstract class Nutrient {

  num x, y;
  num radius;
  List<Point<num>> points;
  num value;
  String color;
  bool dead = false;

  void update(BacteriaGroup bacteriaGroup) {
    num groupX = bacteriaGroup.x;
    num groupY = bacteriaGroup.y;
    for (int i = 0; i < bacteriaGroup.bacteria.length; i++) {
      num bacteriumX = groupX + bacteriaGroup.bacteria[i].x;
      num bacteriumY = groupY + bacteriaGroup.bacteria[i].y;
      // bacteria group get coord?
      num dX = bacteriumX - x;
      num dY = bacteriumY - y;
      if (dX * dX + dY * dY <= radius * radius) {
        value -= 1;
        bacteriaGroup.bacteria[i].nutrition += 1;
        if (value < 0) {
          dead = true;
        }
      }
    }
  }

  void draw() {
    bufferContext.beginPath();
    bufferContext.moveTo(x + points[0].x, y + points[0].y);
    for (int i = 1; i < points.length; i++) {
      bufferContext.lineTo(x + points[i].x, y + points[i].y);
    }
    bufferContext.closePath();
    bufferContext.fillStyle = color;
    bufferContext.fill();
  }

}

class Crumb extends Nutrient {

  Crumb(num x, num y) {
    this.x = x;
    this.y = y;
    radius = 20;
    points = new List<Point<num>>();
    for (int i = 0; i < 7; i++) {
      num angle = i / 7 * 2 * PI;
      num randomRadius = (random.nextDouble() / 2 + 3 / 4) * radius;
      points.add(new Point(cos(angle) * randomRadius, sin(angle) * randomRadius));
    }
    value = 50;
    color = '#DF3A01';
  }

}