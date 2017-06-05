Tile[][] field;
Creep[] wave;
int tilesize;

public void setup() {
  size(800, 600);
  tilesize = 20;
  field = new Tile[width/tilesize][height/tilesize];
  for (int row=0; row<field.length; row++) {
    for (int col=0; col<field[0].length; col++) {
      if (row == 0 || col == 0 || row == field.length-1 || col == field[0].length-1) {
        field[row][col] = new Tile(row, col, tilesize, 'W');
      }else{
        field[row][col] = new Tile(row, col, tilesize, 'B');
      }
    }
  }
  Creep test = new Creep(10,10,tilesize);
  wave = new Creep[10];
  wave[0] = test;
}

public void draw() {
  for (int row=0; row<field.length; row++) {
    for (int col=0; col<field[0].length; col++) {
      field[row][col].display();
    }
  }
  mouse();
  wave[0].display();
}

public void mouse(){
  int row,col;
  row = mouseX/tilesize;
  col = mouseY/tilesize;
  field[row][col].display(255,0,0);
}