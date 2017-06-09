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
    int x = -1;
      if(second() - lastShot >= shot_delay){
         lastShot = second();
         x = findTarget(wave);
      }if(x > -1 && wave[x].health > 0){
         wave[x].health -= damage; 
      }
  }
  
   public int findTarget(Creep[] wave){
      for(int x = 0; x < wave.length; x++){
         if(sqrt(sq(wave[x].getX() - (col * tilesize)) + sq(wave[x].getY() - (row * tilesize))) <= range){
             return x;
         }
      }return -1;
   }
    
  public void display() {
    fill(0, 0, 255);
    rect(col*tilesize, row*tilesize, tilesize, tilesize);
  }
}