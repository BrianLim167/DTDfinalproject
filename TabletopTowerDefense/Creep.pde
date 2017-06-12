public class Creep {
  float x, y, vx, vy, speed, health, maxHealth;
  int tilesize;

  public Creep(int row, int col, int tilesize) {
    this.tilesize = tilesize;
    x = tilesize / 2;
    y = height / 2;
    vx = 0;
    vy = 0;
    health = 100;
    maxHealth = 100;
    speed = .5;
  }

  public void display() {
    fill(0, 100, 200);
    x += vx;
    y += vy;
    setVel();
    ellipse(x, y + tilesize / 2, tilesize, tilesize);
    fill(255, 0, 0);
    rect(x - tilesize / 2, y + tilesize, tilesize, tilesize / 5);
    fill(0, 255, 0);
    rect(x - tilesize / 2, y + tilesize, tilesize * (health / maxHealth), tilesize / 5);
  }

  public boolean getShot(int damage) {
    health -= damage;
    if (health <= 0) return true;
    else return false;
  }

  public int getRow() {
    return ((int)y + tilesize / 2) / tilesize;
  }

  public int getCol() {
    return ((int)x + tilesize / 2) / tilesize;
  }

  public float getX() {
    return x;
  }

  public float getY() {
    return y;
  }

  public void setVel() {
    int row, col;
    row = (int)(y/tilesize);
    col = (int)(x/tilesize);
    int dx, dy;
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