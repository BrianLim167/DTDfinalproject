public class Creep {
  float x, y, vx, vy, tilesize, health, speed, maxHealth;
  int fill;

  public Creep(float tilesize, float health, float speed, int fill) {
    this.tilesize = tilesize;
    x = tilesize / 2;
    y = height / 2 + (((int) random(0,2) - 1) * tilesize);
    vx = 0;
    vy = 0;
    this.health = health;
    maxHealth = health;
    this.speed = speed;
    this.fill = fill;
  }


  public boolean display() {
    fill(fill);
    x += vx;
    y += vy;
    ellipse(x, y + tilesize / 2, tilesize, tilesize);
    fill(255, 0, 0);
    rect(x - tilesize / 2, y + tilesize, tilesize, tilesize / 5);
    fill(0, 255, 0);
    rect(x - tilesize / 2, y + tilesize, tilesize * (health / maxHealth), tilesize / 5);
    return setVel();
  }

  public boolean getShot(int damage) {
    health -= damage;
    if (health <= 0) return true;
    else return false;
  }

  public float getRow() {
    return (y + tilesize / 2) / tilesize;
  }

  public float getCol() {
    return (x + tilesize / 2) / tilesize;
  }

  public float getX() {
    return x;
  }

  public float getY() {
    return y;
  }

  public boolean setVel() {
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
      if (nCol == width / tilesize){
          return true;
      }
      if (nRow >= 0 && nRow < field.length && nCol >= 0 && nCol < field[0].length &&
        field[nRow][nCol].getDist() >= 0 &&
        field[nRow][nCol].getDist() < field[row][col].getDist()) {
        vx = speed * dx;
        vy = speed * dy;
      }
    } return false;
  } 
}