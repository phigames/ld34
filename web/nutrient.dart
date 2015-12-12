part of ld34;

abstract class Nutrient {

  num x, y;
  num radius;
  num value;
  String color;

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

      }
    }
  }

}