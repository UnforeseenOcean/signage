class NodeMatrix {
  int rows, cols, cellSize, textSz;
  float speed, xPos, contentWidth;
  ArrayList<Node> nodes;
  PImage img;
  PGraphics buffer;
  boolean useText = false;
  String txt;
  boolean reverse = false;

  int tweetIndex = 0;
  TwitterSearch tweets;
  String searchQuery;

  StringList messages;
  int messageIndex = 0;

  String[] queries = {
    "\"I love you\"",
    "\"I hate the government\"",
    "\"I'm so proud of you\"",
    "\"I see a celebrity\"",
    "\"storm the castle\"",
    "\"This sucks\"",
    "\"I'm a people person\"",
    "\"What day is it\"",
    "\"The government killed\"",
    "\"I miss you\"",
    "\"can I borrow some money\"",
    "\"Follow your dreams\""
  };

  int queryIndex = 0;

  NodeMatrix(int _cellSize) {
    cellSize = _cellSize;

    speed = 0.42;
    //speed = 0.5;
    textSz = 20;
    xPos = 0;

    ellipseMode(CENTER);
    rectMode(CENTER);

    rows = height / cellSize;
    cols = width / cellSize;

    buffer = createGraphics(cols, rows);

    nodes = new ArrayList<Node>();
    for (int y = 0; y < rows; y++) {
      for (int x = 0; x < cols; x++) {
        Node n = new Node(x * cellSize + cellSize / 2, y * cellSize + cellSize / 2, cellSize);
        n.setZSpeed(map(x, 0, cols, 0, .15));
        nodes.add(n);
      }
    }

    messages = new StringList();
    
    queryIndex = (int) random(0, 10);
    searchQuery = queries[queryIndex];
    tweets = new TwitterSearch();
    tweets.getSearchTweets(searchQuery, 10);
    nextItem();
  }

  void populateMessages() {

  }

  void inverse() {
    reverse = !reverse;
  }

  void update() {
    resetZAxis();

    //textSz = (int) map(mouseY, 0, height, 10, 50);

    buffer.beginDraw();
      buffer.background(255);
      if (useText == true) {
        buffer.fill(0);
        buffer.textAlign(LEFT, TOP);
        buffer.textSize(textSz);
        buffer.text(txt, xPos, -2);
        buffer.text(txt, textWidth(txt)*-1 + buffer.width - xPos, buffer.height/2 - 5);
      } else {
        buffer.image(img, xPos, 0);
      }
    buffer.endDraw();
    buffer.loadPixels();
    xPos -= speed;

    for (int i = 0; i < buffer.pixels.length; i ++) {
      color c = buffer.pixels[i];
      float sz;
      if (reverse) {
        sz = map(brightness(c), 0, 255, 1, cellSize - 1);
      } else {
        sz = map(brightness(c), 0, 255, cellSize - 1, 1);
      }
      nodes.get(i).setSize((int) sz);
    }

    if (xPos < contentWidth * -1) {
      nextItem();
    }
  }

  void nextItem() {
    //to do: replace with a generic list of messages
    setText(clean(tweets.messages.get(tweetIndex)));
    tweetIndex ++;

    if (tweetIndex >= tweets.messages.size()) {
      tweetIndex = 0;
      queryIndex ++;
      if (queryIndex >= queries.length) {
        queryIndex = 0;
      }
      tweets.getSearchTweets(queries[queryIndex], 10);
    }
  }

  void randomGraphic() {
    setGraphic("test" + int(random(1, 6)) + ".gif");
    setZTarget(-1, 1);
  }

  void resetZAxis() {
    if (frameCount % 4000 == 0) {
      for (Node n : nodes) {
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

  String clean(String s) {
    //println(s);
    s = s.replaceAll("\n|\r", "");
    s = s.replaceAll("(@)((?:[A-Za-z0-9-_]*))", "");
    //s = s.replaceAll("@(\\w)+(\\s+)|(\\s+)+@(\\w)+", "");
    //s = s.replaceAll("( *)(http)(\\S+ *)", "");
    s = s.replaceAll("(http(s)?://)?([\\w-]+\\.)+[\\w-]+(/\\S\\w[\\w- ;,./?%&=]\\S*)?", "");
    s = s.replaceAll("RT:", "");
    s = s.replaceAll("RT", "");
    s = s.replaceAll(": ", "");
    s = s.replaceAll("faggot|nigger", "");
    s = s.replaceAll("(#)((?:[A-Za-z0-9-_]*))", "");
    s = trim(s);

    return s;
  }

  void display() {
    background(0, 0, 0);
    for (Node n : nodes) {
      n.display();
    }
    //image(buffer, 20, 20);
  }

}
