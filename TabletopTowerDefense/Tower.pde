public class Tower extends Tile {
  int shot_delay, damage;
  float lastShot, range;

  public Tower(int row, int col, float tilesize) {
    super(row, col, tilesize, 'T');
    this.damage = 10;
    this.shot_delay = 3;
    lastShot = second();
    range = 250;
  }

  public void shoot(Creep[] wave){
      Creep target = null;
      if(second() - lastShot >= shot_delay){
         lastShot = second();
         target = findTarget(wave);
      }if(target.health > 0){
         target.health -= damage; 
      }
  }
  
   public Creep findTarget(Creep[] wave){
      for(Creep possible : wave){
         if(sqrt(sq(possible.getX() - (col * tilesize)) + sq(possible.getY() - (row * tilesize))) <= range){
             return possible;
         }
      }return null;
   }
    
  public void display() {
    fill(0, 0, 255);
    rect(col*tilesize, row*tilesize, tilesize, tilesize);
  }
}