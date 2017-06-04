public class Tower extends Tile {
  int shot_delay, damage;

  public Tower(int row, int col, float tilesize) {
    super(row, col, tilesize, 't');
    this.damage = 10;
    this.shot_delay = 10;
  }
}