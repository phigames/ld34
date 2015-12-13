part of ld34;

abstract class Nutrient {

  num x, y;
  num radius;
  List<Point<num>> points;
  num value;
  String color;
  bool dead = false;
  num animationTime = 0;

  void update(BacteriaGroup bacteriaGroup) {
    num groupX = bacteriaGroup.x;
    num groupY = bacteriaGroup.y;
    for (int i = 0; i < bacteriaGroup.bacteria.length; i++) {
      num bacteriumX = groupX + bacteriaGroup.bacteria[i].x;
      num bacteriumY = groupY + bacteriaGroup.bacteria[i].y;
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
    animationTime += 0.02;
  }

  void draw(num xCam,num yCam) {
    bufferContext.save();
    bufferContext.translate(x - xCam, y - yCam);
    //bufferContext.rotate(sin(animationTime * 5) / 6);
    bufferContext.rotate(animationTime / 3);
    bufferContext.scale(1 + sin(animationTime * 7) / 20, 1 + sin(animationTime * 7) / 20);
    bufferContext.beginPath();
    bufferContext.moveTo(points[0].x, points[0].y);
    for (int i = 1; i < points.length; i++) {
      bufferContext.lineTo(points[i].x, points[i].y);
    }
    bufferContext.closePath();
    bufferContext.fillStyle = color;
    bufferContext.fill();
    bufferContext.restore();
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
      num randomRadius = (random.nextDouble() + 1 / 2) * radius;
      points.add(new Point(cos(angle) * randomRadius, sin(angle) * randomRadius));
    }
    value = 50;
    color = '#99642B';
  }

}