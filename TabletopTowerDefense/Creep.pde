public class Creep {
  float x, y, vx, vy, tilesize, health;
  int direction;

  public Creep(int row, int col, int tilesize) {
    this.tilesize = tilesize;
    x = col * tilesize - (tilesize / 2);
    y = row * tilesize - (tilesize / 2);
    vx = 0;
    vy = 0;
    direction = -1;
  }

  public void display() {
    fill(0, 255, 0);
    x += vx;
    y += vy;
    ellipse(x, y, tilesize, tilesize);
  }

  public float getRow() {
    return (y + tilesize / 2) / tilesize;
  }

  public float getCol() {
    return (x + tilesize / 2) / tilesize;
  }

  public void setVel() {
    int row, col;
    row = (int)(y/tilesize);
    col = (int)(x/tilesize);
    for (int dir=0; dir<4; dir++) {
      int nRow, nCol;
      nRow = -1;
      nCol = -1;
      if (dir==0) {
        nRow = row;
        nCol = col+1;
      } else if (dir==1) {
        nRow = row+1;
        nCol = col;
      } else if (dir==2) {
        nRow = row;
        nCol = col;
      } else if (dir==3) {
        nRow = row-1;
        nCol = col;
      }
      if (nRow >= 0 && nRow < field.length && nCol >= 0 && nCol < field[0].length &&
        field[nRow][nCol].getDist() < field[row][col].getDist()) {
      }
    }
  }
}