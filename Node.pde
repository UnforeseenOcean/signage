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
    speed = random(0.45, 0.8);
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
    c = color(noise(x)*255, noise(y)*255, 255);
  }

  void update() {
    if (int(s) < targetSize) {
      s += speed;
    } else if (int(s) > targetSize) {
      s -= speed;
    }


    if (z > upperZ) {
      zSpeed = zSpeed * -1;
    }

    if (z < lowerZ) {
      zSpeed = zSpeed * -1;
    }

    z += zSpeed;
    //if (int(s) == targetSize && finalTargetSize != targetSize) {
      //targetSize = finalTargetSize;
    //}
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
