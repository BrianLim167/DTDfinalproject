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
        if (col < field[0].length/2 + 3 && col >= field[0].length/2 - 3) {
          if (row == 0) {
            field[row][col] = new Tile(row, col, tilesize, 'S');
          } else {
            field[row][col] = new Tile(row, col, tilesize, 'E');
          }
        } else {
          field[row][col] = new Tile(row, col, tilesize, 'W');
        }
      } else {
        field[row][col] = new Tile(row, col, tilesize, 'B');
      }
    }
  }
  Creep test = new Creep(10, 10, tilesize);
  wave = new Creep[10];
  wave[0] = test;
}

public void draw() {
  for (int row=0; row<field.length; row++) {
    for (int col=0; col<field[0].length; col++) {
      field[row][col].display();
    }
  }
  updateDist();
  mouse();
  wave[0].display();
}

public void updateDist() {
  MyDeque front = new MyDeque();
  Tile loc;
  for (int row=0; row<field.length; row++) {
    for (int col=0; col<field[0].length; col++) {
      if (field[row][col].getType() == 'E') {
        front.addLast(field[row][col]);
        field[row][col].setDist(0);
      } else {
        field[row][col].setDist(-1);
      }
    }
  }
  loc = front.removeFirst();
  while (front.hasNext()) {
    for (int dir=0; dir<4; dir++) {
      int nRow, nCol;
      nRow = -1;
      nCol = -1;
      if (dir==0) {
        nRow = loc.getRow();
        nCol = loc.getCol()+1;
      } else if (dir==1) {
        nRow = loc.getRow()+1;
        nCol = loc.getCol();
      } else if (dir==2) {
        nRow = loc.getRow();
        nCol = loc.getCol()-1;
      } else if (dir==3) {
        nRow = loc.getRow()-1;
        nCol = loc.getCol();
      }
      if (nRow >= 0 && nRow < field.length && nCol >= 0 && nCol < field[0].length &&
        (field[nRow][nCol].getType() == 'B' || field[nRow][nCol].getType() == 'S') &&
        field[nRow][nCol].getDist() == -1) {
        field[nRow][nCol].setDist(loc.getDist()+1);
        front.addLast(field[nRow][nCol]);
      }
    }
    loc = front.removeFirst();
  }
}

public void mouse() {
  int row, col;
  row = mouseX/tilesize;
  col = mouseY/tilesize;
  field[row][col].display(255, 0, 0);
}