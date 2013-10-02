class Node {
  int x, y, targetSize, finalTargetSize, upperZ, lowerZ;
  float zSpeed, speed, s;
  color c;
  float z = 0;

  Node(int _x, int _y, int _s) {
    x = _x;
    y = _y;
    s = 1.0;
    c = color(noise(x)*255, noise(y)*255, 255);
    //c = color(noise(float(x)/120)*255, noise(float(x)/120)*255, 255);
    speed = random(.6, 1);
    upperZ = 50;
    lowerZ = -50;
  }

  void setZSpeed(float _zs) {
    zSpeed = _zs;
  }

  void setSize(int _s) {
    targetSize = _s;
    s = targetSize;
  }

  void resetColor() {
    int r = (int) random(1, 3);
    if (r == 1) {
      c = color(noise(x)*255, noise(y)*255, 255);
    } else if (r == 2) {
      c = color(noise(x)*255, 255, noise(y)*255);
    } else if (r == 3) {
      c = color(255, noise(x)*255, noise(y)*255);
    }
  }

  void update() {
    //if (int(s) < targetSize) {
      //s += speed;
    //} else if (int(s) > targetSize) {
      //s -= speed;
    //}


    if (z > upperZ) {
      zSpeed = zSpeed * -1;
    }

    if (z < lowerZ) {
      zSpeed = zSpeed * -1;
    }

    z += zSpeed;
  }

  void display() {
    update();
    pushMatrix();
      translate(0, 0, z);
      fill(c);
      noStroke();
      ellipse(x, y, s, s);
    popMatrix();
  }
}


//class VideoNode extends Node {

  //VideoNode(int _x, int _y, int _s) {
    //super();

  //}
  //void display() {

  //}

//}
