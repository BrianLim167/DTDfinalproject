public class Tower extends Tile {
  int shot_delay, damage;
  float lastShot, range;

  public Tower(int row, int col, float tilesize) {
    super(row, col, tilesize, 'T');
    this.damage = 25;
    this.shot_delay = 2;
    lastShot = second();
    range = 100;
  }

  public int shoot(ArrayList<Creep> wave) {
    int x = -1;
    if(lastShot >= 60) lastShot = second();
    if (second() - lastShot >= shot_delay) {
      x = findTarget(wave);
    }
    if (x > -1) {
      lastShot = second();
      if (wave.get(x).getShot(damage)) {
        return x;
      }
    }
    return -1;
  }

  public int findTarget(ArrayList<Creep> wave) {
    for (int x = 0; x < wave.size(); x++) {
      if (sqrt(sq(wave.get(x).getX() - (col * tilesize)) + sq(wave.get(x).getY() - (row * tilesize))) <= range) {
        return x;
      }
    }
    return -1;
  }

  public void display() {
    fill(200, 50, 200);
    rect(col*tilesize, row*tilesize, tilesize, tilesize);
  }
}