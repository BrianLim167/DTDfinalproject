Tile[][] field;

public void setup(){
  size(800,600);
  int tilesize = 20;
  field = new Tile[width/tilesize][height/tilesize];
  for (int row=0 ; row<field.length ; row++){
    for (int col=0 ; col<field[0].length ; col++){
      field[row][col] = new Tile(row,col,tilesize);
    }
  }
}
public void draw(){
  for (int row=0 ; row<field.length ; row++){
    for (int col=0 ; col<field[0].length ; col++){
      field[row][col].display();
    }
  }
}