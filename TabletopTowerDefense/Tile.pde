public class Tile {
  int row, col;
  float tilesize;
  char type;

  public Tile(int row, int col, float tilesize, char type) {
    this.row = row;
    this.col = col;
    this.tilesize = tilesize;
    this.type = type;
  }

  public void display() {
    stroke(0, 0, 0, 0);
    //fill(255);
    if (type == 'W') {
      fill(255);
    } else {
      fill(0);
    }
    rect(row*tilesize, col*tilesize, tilesize, tilesize);
  }
  public void display(float r, float g, float b) {
    if (type == 'B') {
      stroke(0, 0, 0, 0);
      fill(r, g, b);
      rect(row*tilesize, col*tilesize, tilesize, tilesize);
    }
  }
}