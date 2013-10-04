NodeMatrix nodeMatrix;

void setup() {
  //size(1024, 768, P3D);
  //size(1280, 720, P3D);
  size(displayWidth, displayHeight, P3D);
  nodeMatrix = new NodeMatrix(20);
}

void draw() {
  nodeMatrix.update();
  nodeMatrix.display();
  //saveFrame("/Users/sam/Desktop/movieframes/seq-####.tif");
}

void mouseReleased() {

  nodeMatrix.nextItem();
}
