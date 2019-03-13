Rocket rocket;
Landscape planet;

void setup() {
  size(1300, 650);
  frameRate(30);
  planet = new Landscape(0.2);
  rocket = new Rocket(width/2-22, 0);
}

void draw() {
  background(200, 200, 255);

  rocket.update();
  rocket.show();

  fill(0);
  text((int)frameRate+" FPS", 3, 12);
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP)
      rocket.boost = true;
    if (keyCode == RIGHT)
      rocket.boostRight = true;
    if (keyCode == LEFT)
      rocket.boostLeft = true;
  }
}

void keyReleased() {
  if (key == CODED) {
    if (keyCode == UP)
      rocket.boost = false;
    if (keyCode == RIGHT)
      rocket.boostRight = false;
    if (keyCode == LEFT)
      rocket.boostLeft = false;
  }
}
