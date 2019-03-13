class Hitbox {

  PVector pos, size;

  Hitbox(float x, float y, float w, float h) {
    size = new PVector(w, h);
    pos = new PVector(x, y);
  }

  boolean overlaps() {
    return false;
  }

  void show(float rotation) {
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(rotation);

    noFill();
    rectMode(CENTER);
    strokeWeight(2);
    stroke(0, 0, 255);
    rect(0, 0, size.x, size.y);
    rectMode(CORNER);

    popMatrix();
  }
}
