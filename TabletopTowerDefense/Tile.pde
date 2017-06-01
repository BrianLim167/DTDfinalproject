public class Tile{
   int row,col;
   float tilesize;
   
   public Tile(int row,int col,float tilesize){
     this.row = row;
     this.col = col;
     this.tilesize = tilesize;
   }
   
   public void display(){
     stroke(0);
     fill(255);
     rect(row*tilesize,col*tilesize,tilesize,tilesize);
   }
}