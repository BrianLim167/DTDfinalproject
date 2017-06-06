public class Tower extends Tile {
  int shot_delay, damage;

  public Tower(int row, int col, float tilesize) {
    super(row, col, tilesize, 'T');
    this.damage = 10;
    this.shot_delay = 10;
  }


    
  public void display() {
    fill(0, 0, 255);
    rect(col*tilesize, row*tilesize, tilesize, tilesize);
  }
}