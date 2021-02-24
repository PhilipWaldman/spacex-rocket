class Rocket {
  PVector pos, vel, acc, size;
  float rotation = 0, rotRate = 0, rotAcc = 0, fuel, maxFuel = 3000;
  boolean exploded = false, boost = false, legs = false, boostRight = false, boostLeft = false;
  Hitbox hitbox;

  Rocket(float x, float y) {
    size = new PVector(44, 123);
    pos = new PVector(x, y);
    vel = new PVector(0, 0);
    acc = new PVector(0, planet.gravity);
    loadImages();
    fuel = maxFuel;
    hitbox = new Hitbox(pos.x, pos.y, 8, size.y);
  }

  //Images
  PImage flame, body, puffRight, puffLeft, explosion;
  int legPic = 0;
  PImage[] legPics;
  void loadImages() {
    flame = loadImage("resources/flame.png");
    body = loadImage("resources/body.png");
    puffRight = loadImage("resources/puff_right.png");
    puffLeft = loadImage("resources/puff_left.png");
    explosion = loadImage("resources/explosion/test.png");
    legPics = new PImage[18];
    for (int i = 0; i < legPics.length; i++) {
      legPics[i] = loadImage("resources/legs/legs_" + i + ".png");
    }
  }

  void update() {
    updateFuel();

    if (boost) {
      acc = PVector.fromAngle(rotation - PI / 2).setMag(0.5);
    } else {
      acc = new PVector();
    }
    acc.y += planet.gravity;

    if (boostRight) {
      rotAcc -= PI / 50000;
    } else if (boostLeft) {
      rotAcc += PI / 50000;
    } else {
      rotAcc = 0;
    }
    rotRate += rotAcc;
    rotation += rotRate;
    rotation %= 2 * PI;

    if (!legs) {
      int dist = (int) ((pos.y + size.y / 2 - 16 - height * 0.7) * ((float) legPics.length / (height * 0.2)));
      int num = dist < 0 ? 0 : dist;
      legPic = num >= legPics.length ? legPics.length - 1 : num;
    }

    move();

    hitbox.pos = pos;
  }

  void move() {
    if (pos.y + size.y / 2 - 16 > height) {
      acc = new PVector();
      vel = new PVector();
      pos.y = height - size.y / 2 + 16;
      rotRate = 0;
    }

    pos.add(vel);
    vel.add(acc);
  }

  void updateFuel() {
    if (fuel > 0) {
      if (boost) {
        fuel--;
      }
      if (boostLeft) {
        fuel -= 0.1;
      }
      if (boostRight) {
        fuel -= 0.1;
      }
    } else {
      boost = false;
      boostLeft = false;
      boostRight = false;
      acc.x = 0;
      fuel = 0;
    }
  }

  void show() {
    showRocket();
    showFuel();
  }

  void showRocket() {
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(rotation);

    imageMode(CENTER);
    image(body, 0, 0, size.x, size.y);
    image(legPics[legPic], 0, 0, size.x, size.y);
    if (!exploded) {
      if (boost) {
        image(flame, 0, 0, size.x, size.y);
      }
      if (boostLeft) {
        image(puffLeft, 0, 0, size.x, size.y);
      }
      if (boostRight) {
        image(puffRight, 0, 0, size.x, size.y);
      }
    } else {
      image(explosion, 0, -10, size.x * 2, size.y * 2);
    }

    popMatrix();
  }

  void showFuel() {
    fill(0, 200, 0);
    noStroke();
    rect(width / 50 + width / 20, height * 0.3 + height * 0.4, -width / 20, -height * 0.4 * (fuel / maxFuel));

    noFill();
    stroke(0);
    strokeWeight(3);
    rect(width / 50, height * 0.3, width / 20, height * 0.4);
    strokeWeight(1);
  }

  void showDebug() {
    strokeWeight(5);
    stroke(255, 0, 0); // vel
    line(pos.x - size.x / 2, pos.y - size.y / 2, pos.x - size.x / 2 + vel.x * 10, pos.y - size.y / 2 + vel.y * 10);
    stroke(0, 255, 0); // acc
    line(pos.x + size.x / 2, pos.y - size.y / 2, pos.x + size.x / 2 + acc.x * 100, pos.y - size.y / 2 + acc.y * 100);
    fill(0);
    text(this.toString(), 100, 50);
    //hitbox.show(rotation);
  }

  String toString() {
    String str = "pos:\t\t" + pos;
    str += "\nvel:\t\t" + vel;
    str += "\nacc:\t\t" + acc;
    str += "\nsize:\t\t" + size;
    str += "\nrotation:\t\t" + rotation;
    str += "\nrotRate\t\t" + rotRate;
    str += "\nrotAcc:\t\t" + rotAcc;
    str += "\nmaxFuel:\t\t" + maxFuel;
    str += "\nfuel:\t\t" + fuel;
    str += "\nlegPic:\t\t" + legPic;
    return str;
  }
}
