public class Creep {
  float x, y, vx, vy, tilesize, health;
  int dir;

  public Creep(int row, int col, int tilesize) {
    this.tilesize = tilesize;
    x = col * tilesize - (tilesize / 2);
    y = row * tilesize - (tilesize / 2);
    vx = 0;
    vy = 0;
    dir = -1;//
  }

  public void display() {
    fill(0, 255, 0);
    x += vx;
    y += vy;
    ellipse(x, y, tilesize, tilesize);
  }
  
  public float getRow(){
     return (y + tilesize / 2) / tilesize;
  }
  
  public float getCol(){
     return (x + tilesize / 2) / tilesize;
  }
  
  public void setVel(){
    int row,col;
    row = (int)(y/tilesize);
    col = (int)(x/tilesize);
  }
}