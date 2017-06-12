public class Tile {
  int row, col;
  int dist;
  float tilesize;
  char type;

  public Tile(int row, int col, float tilesize, char type) {
    this.row = row;
    this.col = col;
    this.tilesize = tilesize;
    this.type = type;
  }

  public void setDist(int dist) {
    this.dist = dist;
  }
  public int getDist() {
    return dist;
  }

  public char getType() {
    return type;
  }

  public int getRow() {
    return row;
  }

  public int getCol() {
    return col;
  }

  public void display() {
    stroke(0, 0, 0, 0);
    //fill(255);
    if (type == 'W') {
      fill(110, 110, 110);
    } else if (type == 'S') {
      fill(0, 200, 0);
    } else if (type == 'E') {
      fill(200, 0, 0);
    } else {
      fill(0, 0, 0);
    }
    rect(col*tilesize, row*tilesize, tilesize, tilesize);
    fill(0, 0, 255);
    //text(""+dist, (col+0)*tilesize, (row+0.5)*tilesize);
    //text(type,(row+0)*tilesize,(col+0.5)*tilesize);
    //text(""+dist,(col+0)*tilesize,(row+0.5)*tilesize);
    //text(type,(col+0)*tilesize,(row+0.5)*tilesize);
  }
  public void display(float r, float g, float b) {
    if (type == 'B') {
      stroke(0, 0, 0, 0);
      fill(r, g, b);
      rect(col*tilesize, row*tilesize, tilesize, tilesize);
    }
  }
}