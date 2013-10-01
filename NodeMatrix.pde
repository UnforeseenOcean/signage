class NodeMatrix {
  int rows, cols, cellSize, textSz;
  float speed, xPos, contentWidth;
  ArrayList<Node> nodes;
  PImage img;
  PGraphics buffer;
  boolean useText = false;
  String txt;
  int tweetIndex = 0;
  TwitterSearch tweets;
  String searchQuery;

  NodeMatrix(int _cellSize) {
    cellSize = _cellSize;

    speed = 0.32;
    //speed = 0.5;
    textSz = 25;
    xPos = 0;

    ellipseMode(CENTER);
    rectMode(CENTER);

    rows = height / cellSize;
    cols = width / cellSize;

    buffer = createGraphics(cols, rows);

    nodes = new ArrayList();
    for (int y = 0; y < rows; y++) {
      for (int x = 0; x < cols; x++) {
        Node n = new Node(x * cellSize + cellSize / 2, y * cellSize + cellSize / 2, cellSize);
        n.setZSpeed(map(x, 0, cols, 0, .15));
        nodes.add(n);
      }
    }

    searchQuery = "this sucks";
    tweets = new TwitterSearch();
    tweets.getSearchTweets(searchQuery, 10);
    nextItem();
  }

  void update() {
    resetZAxis();

    //textSz = (int) map(mouseY, 0, height, 10, 50);
    //speed = map(mouseX, 0, width, 0, 1);

    buffer.beginDraw();
      buffer.background(255);
      if (useText == true) {
        buffer.fill(0);
        buffer.textAlign(LEFT, TOP);
        buffer.textSize(textSz);
        buffer.text(txt, xPos, 0);
      } else {
        buffer.image(img, xPos, 0);
      }
    buffer.endDraw();
    buffer.loadPixels();
    xPos -= speed;

    for (int i = 0; i < buffer.pixels.length; i ++) {
      color c = buffer.pixels[i];
      float sz = map(brightness(c), 0, 255, cellSize - 1, 1);
      //float sz = map(brightness(c), 0, 255, 1, cellSize - 1);
      nodes.get(i).setSize((int) sz);
    }

    if (xPos < contentWidth * -1) {
      nextItem();
    }


  }

  void nextItem() {
    setText(tweets.messages.get(tweetIndex));
    tweetIndex ++;

    if (tweetIndex >= tweets.messages.size()) {
      tweetIndex = 0;
      if (searchQuery == "this sucks") {
        searchQuery = "I love you";
      } else {
        searchQuery = "this sucks";
      }
      tweets.getSearchTweets(searchQuery, 10);
    }
  }

  void randomGraphic() {
    setGraphic("test" + int(random(1, 6)) + ".gif");
    setZTarget(-1, 1);
  }

  void resetZAxis() {
    if (frameCount % 4000 == 0) {
      for (Node n : nodes) {
        //n.z = 0;
        //n.zSpeed = abs(n.zSpeed);
        //n.resetColor();
        n.zSpeed = n.zSpeed * -1;
      }
    }
  }

  void setZTarget(int l, int u) {
    for (Node n : nodes) {
      n.upperZ = u;
      n.lowerZ = l;
    }
  }

  void setGraphic(String filename) {
    useText = false;
    img = loadImage(filename);
    img.resize(0, rows);

    buffer = createGraphics(cols, rows);
    xPos = buffer.width;

    buffer.beginDraw();
      buffer.image(img, xPos, 0);
    buffer.endDraw();
    buffer.loadPixels();

    contentWidth = img.width;
  }

  void setText(String _txt) {
    useText = true;
    txt = _txt;

    textSize(textSz);
    contentWidth = textWidth(txt);

    buffer = createGraphics(cols, rows);
    xPos = buffer.width;
  }

  void display() {
    background(0, 0, 0);
    for (int i=0; i < nodes.size(); i++) {
      nodes.get(i).display();
    }
    //image(buffer, 20, 20);
  }

}
