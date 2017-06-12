public class Tower extends Tile {
  int shot_delay, damage;
  float lastShot, range;
  char type;

  public Tower(int row, int col, float tilesize, char type) {
    super(row, col, tilesize, 'T');
    this.type = type;
    if (type == 'H') {
      this.damage = 150;
      this.shot_delay = 5;
      lastShot = second();
      range = 200;
    } else {
      this.damage = 30;
      this.shot_delay = 1;
      lastShot = second();
      range = 100;
    }
  }

  public int shoot(ArrayList<Creep> wave) {
    int x = -1;
    if (lastShot >= 60) lastShot = second();
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
    if (type == 'F') fill(200, 50, 200);
    else fill(255, 50, 255);
    rect(col*tilesize, row*tilesize, tilesize, tilesize);
  }
}