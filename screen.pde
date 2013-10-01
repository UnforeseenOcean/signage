NodeMatrix nodeMatrix;

void setup() {
  //size(1024, 768, P3D);
  size(1360, 765, P3D);
  nodeMatrix = new NodeMatrix(20);
  //nodeMatrix.setGraphic("test5.gif");
  //nodeMatrix.setText("hello!!");
}

void draw() {
  nodeMatrix.update();
  nodeMatrix.display();

  //saveFrame("/Users/sam/Desktop/movieframes/seq-####.tif");
}


