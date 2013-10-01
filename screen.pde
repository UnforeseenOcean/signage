NodeMatrix nodeMatrix;

void setup() {
  size(1024, 768, P3D);
  nodeMatrix = new NodeMatrix(20);
  //nodeMatrix.setGraphic("test5.gif");
  //nodeMatrix.setText("hello!!");
}

void draw() {
  //translate(mouseX, 0, map(mouseY, 0, height, -500, 60));
  //rotateY(map(mouseX, 0, width, -TWO_PI, TWO_PI));

  nodeMatrix.update();
  nodeMatrix.display();
}

void mousePressed() {
  nodeMatrix.randomGraphic();
}

