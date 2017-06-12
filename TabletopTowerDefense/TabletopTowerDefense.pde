Tile[][] field;
ArrayList<Creep> wave, toBeSpawned;
ArrayList<Tower> Towers;
int tilesize, playerHealth, gold, waveSpawn, waveNumber, creepSpawned;


public void setup() {
  waveNumber = 1;
  gold = 500;
  waveSpawn = second();
  playerHealth = 100;
  size(800, 600);
  tilesize = 20;
  Towers = new ArrayList();
  field = new Tile[height/tilesize][width/tilesize];
  for (int row=0; row<field.length; row++) {
    for (int col=0; col<field[0].length; col++) {
      if (row <= 1 || col == 0 || row >= field.length-3 || col == field[0].length-1) {
        if (row < field.length/2 + 3 && row >= field.length/2 - 3) {
          if (col == 0) {
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
  wave = new ArrayList<Creep>();
  toBeSpawned = spawnNextWave();
  creepSpawned = millis();
  updateDist();
}

public void draw() {
  background(0, 0, 0);
  for (int row=0; row<field.length; row++) {
    for (int col=0; col<field[0].length; col++) {
      field[row][col].display();
    }
  }
  mouse();
  int dead = -1;
  for (Tower next : Towers) {
    dead = next.shoot(wave);
    if (dead >= 0) {
      wave.remove(dead);
      gold += 25;
    }
  }
  for (int i = 0; i < wave.size(); i++) {
    if (wave.get(i).display()) {
      wave.remove(i);
      i--;
      playerHealth -= 1;
    }
  }
  creepSpawned = spawnMore();
  textSize(18);
  fill(255, 50, 50);
  text(playerHealth, 100, height - 30);
  text("Health:", 35, height - 30);
  fill(255, 100, 0);
  text(gold, 240, height - 30);
  text("Gold:", 175, height - 30);
  fill(100, 255, 50);
  text(wave.size(), 520, height - 30);
  text("Remaining Enemies:", 315, height - 30);
  fill(100, 255, 50);
  text(wave.size(), 520, height - 30);
  text("Remaining Enemies:", 315, height - 30);
  fill(255, 255, 255);
  text(waveNumber - 1, 720, height - 30);
  text("Current Wave:", 580, height - 30);
  fill(39, 200, 161);
  rect(width - 150, 0, 150, 40);
  fill(200, 25, 125);
  text("Next Wave", width - 140, 24);
  fill(39, 200, 161);
  rect(40, 0, 400, 17);
  rect(40, 20, 400, 17);
  fill(200, 25, 125);
  textSize(16);
  text("Right clock to place heavy turret for 175 gold", 55, 12);
  text("Left click to place light turrent for 150 gold", 55, 33);
}

public void mousePressed() {
  int row = mouseY / tilesize;
  int col = mouseX / tilesize;
  if (mouseX > width - 150 && mouseY < 45 && wave.size() == 0) {
    toBeSpawned = spawnNextWave();
  } else if (field[row][col].getType() == 'T') {
    gold += 75;
    field[row][col] = new Tile(row, col, tilesize, 'B');
    updateDist();
    for (int ind=0 ; ind<Towers.size() ; ind++){
      if (Towers.get(ind).getRow() == row && Towers.get(ind).getCol() == col){
        Towers.remove(ind);
        return;
      }
    }
  } else if (mouseButton == RIGHT) {  
    if (field[row][col].getType() == 'B' && gold >= 175) {
      Tower toAdd = new Tower(row, col, tilesize, 'H');
      field[row][col] = toAdd;
      updateDist();
      for (Creep next : wave) {
        if (field[next.getRow()][next.getCol()].getDist() == -1) {
          field[row][col] = new Tile(row, col, tilesize, 'B');
          updateDist();
          return;
        }
      }
      for (int r=0; r<field.length; r++) {
        for (int c=0; c<field[0].length; c++) {
          if (field[r][c].getType() == 'S' && field[r][c].getDist() == -1) {
            field[row][col] = new Tile(row, col, tilesize, 'B');
            updateDist();
            return;
          }
        }
      }
      Towers.add(toAdd);
      gold -= 175;
      //if (field[row - 1][col].type == 'B') field[row - 1][col].type = 'R';
    }
  } else if (field[row][col].getType() == 'B' && gold >= 150) {
    if (field[row][col].getType() == 'B' || field[row][col].getType() == 'R') {
      Tower toAdd = new Tower(row, col, tilesize, 'F');
      field[row][col] = toAdd;
      updateDist();
      for (Creep next : wave) {
        if (field[next.getRow()][next.getCol()].getDist() == -1) {
          field[row][col] = new Tile(row, col, tilesize, 'B');
          updateDist();
          return;
        }
      }
      for (int r=0; r<field.length; r++) {
        for (int c=0; c<field[0].length; c++) {
          if (field[r][c].getType() == 'S' && field[r][c].getDist() == -1) {
            field[row][col] = new Tile(row, col, tilesize, 'B');
            updateDist();
            return;
          }
        }
      }
      Towers.add(toAdd);
      gold -= 150;
      //if (field[row - 1][col].type == 'B') field[row - 1][col].type = 'R';
    }
  }
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
  while (front.hasNext()) {
    loc = front.removeFirst();
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
  }
}

public void mouse() {
  int row, col;
  row = mouseY/tilesize;
  col = mouseX/tilesize;
  field[row][col].display(255, 0, 0);
}

public ArrayList<Creep> spawnNextWave() {
  ArrayList<Creep> toBeSpawned = new ArrayList<Creep>();
  for (int x = 0; x < waveNumber * (5 + (waveNumber - 4)); x++) {
    toBeSpawned.add(new Creep(tilesize, 70, .25, #0000FF));
  }
  if (waveNumber > 4) {
    for (int x = 0; x < (waveNumber - 4) * (3 + (waveNumber - 7)); x++) {
      toBeSpawned.add(new Creep(tilesize, 30, .55, #38B480));
    }
  }
  if (waveNumber > 7) {
    for (int x = 0; x < (2 * (waveNumber - 6)) * (pow(-1, waveNumber - 1)); x++) {
      toBeSpawned.add(new Creep(tilesize, 500, .1, #72273D));
    }
  }
  waveNumber++;
  return toBeSpawned;
}

public int spawnMore() {
  if (toBeSpawned.size() > 0) {
    if (millis() - creepSpawned > 10000 / ((waveNumber - 1) * 10)) {
      int index = (int)random(0, toBeSpawned.size() - 1);
      wave.add(toBeSpawned.remove(index));
      return millis();
    }
  }
  return creepSpawned;
}