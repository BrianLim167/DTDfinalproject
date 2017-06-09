public class Creep {
  float x, y, vx, vy, tilesize, health, speed;

  public Creep(int row, int col, int tilesize) {
    this.tilesize = tilesize;
    x = col * tilesize - (tilesize / 2);
    y = row * tilesize - (tilesize / 2);
    vx = 0;
    vy = 0;
    speed = 1;
  }

  public void display() {
    fill(0, 255, 0);
    x += vx;
    y += vy;
    setVel();
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
    int dx,dy;
    dx = 0;
    dy = 0;
    for (int dir=0; dir<4; dir++) {
      int nRow, nCol;
      nRow = -1;
      nCol = -1;
      if (dir==0) {
        dx = 1;
        dy = 0;
      } else if (dir==1) {
        dx = 0;
        dy = -1;
      } else if (dir==2) {
        dx = -1;
        dy = 0;
      } else if (dir==3) {
        dx = 0;
        dy = 1;
      }
      nRow = row + dy;
      nCol = col + dx;
      if (nRow >= 0 && nRow < field.length && nCol >= 0 && nCol < field[0].length &&
        field[nRow][nCol].getDist() >= 0 &&
        field[nRow][nCol].getDist() < field[row][col].getDist()) {
        vx = speed * dx;
        vy = speed * dy;
      }
    }
  }
}