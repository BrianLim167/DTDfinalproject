public class Creep {
  float x, y, vx, vy, tilesize, health;

  public Creep(int row, int col, int tilesize) {
    this.tilesize = tilesize;
    x = row * tilesize - (tilesize / 2);
    y = col * tilesize - (tilesize / 2);
    vx = 0;
    vy = 0;
  }

  public void display() {
    fill(0, 255, 0);
    x += vx;
    y += vy;
    ellipse(x, y, tilesize, tilesize);
  }
  
  public float getRow(){
     return (x + tilesize / 2) / tilesize;
  }
  
  public float getCol(){
     return (y + tilesize / 2) / tilesize;
  }
  
  
  
}