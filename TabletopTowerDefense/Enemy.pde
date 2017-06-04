public class Enemy {
  int x, y, tilesize, health;

  public Enemy(int row, int col, int tilesize) {
    this.tilesize = tilesize;
    x = row * tilesize - (tilesize / 2);
    y = col * tilesize - (tilesize / 2);
  }

  public void display() {
    fill(0, 255, 0);
    ellipse(x, y, tilesize, tilesize);
  }
  
  public int getRow(){
     return (x + tilesize / 2) / tilesize;
  }
  
  public int getCol(){
     return (y + tilesize / 2) / tilesize;
  }
}