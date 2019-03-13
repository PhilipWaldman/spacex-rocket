class Hitbox {

  PVector pos, size;

  Hitbox(float x, float y, float w, float h) {
    size = new PVector(w, h);
    pos = new PVector(x, y);
  }

  boolean overlaps() {
    return false;
  }

  void show() {
    noFill();
    rectMode(CENTER);
    strokeWeight(2);
    stroke(0, 0, 255);
    rect(pos.x, pos.y, size.x, size.y);
    rectMode(CORNER);
  }
}
