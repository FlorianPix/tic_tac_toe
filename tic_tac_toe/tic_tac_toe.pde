String[][] board;
String[] players = {"X", "O"};
int w, h;
int currentPlayer;
ArrayList<int[]> available;
boolean cont;

class Show{
  String winner;
  int[][] co;
  
  Show(String winner, int[][] co){
    this.winner = winner;
    this.co = co;
  }
  
  String getWinner(){
    return this.winner;
  }
  
  int[][] getCo(){
    return this.co;
  }
}

void setup(){
  size(640, 640);
  w = int(width/3);
  h = int(height/3);
  cont = true;
  board = new String[3][3];
  available = new ArrayList<int[]>();
  currentPlayer = floor(random(players.length));
  for (int i = 0; i < 3; i++){
    for(int j = 0; j < 3; j++){
      int[] a = {i, j};
      available.add(a);
    }
  }
}

void reset(){
  board = new String[3][3];
  available = new ArrayList<int[]>();
  currentPlayer = floor(random(players.length));
  for (int i = 0; i < 3; i++){
    for(int j = 0; j < 3; j++){
      int[] a = {i, j};
      available.add(a);
    }
  }
}

void nextTurn(){
  int index = floor(random(available.size()));
  int[] spot = available.remove(floor(index));
  int i = spot[0];
  int j = spot[1];
  board[i][j] = players[currentPlayer];
  currentPlayer = (currentPlayer + 1) % players.length;
}

Show checkWinner(){
  for (int i = 0; i < 3; i++){
    try{
      if (board[i][0].equals(board[i][1]) && board[i][1].equals(board[i][2])){
        int[][] a = {{i,0},{i,2}};
        return new Show(board[i][0], a);
      }
    } catch (NullPointerException e){
    }
    try{  
      if (board[0][i].equals(board[1][i]) && board[1][i].equals(board[2][i])){
        int[][] a = {{0,i},{2,i}};
        return new Show(board[0][i], a);
      }
    } catch (NullPointerException e){
    }
  }
  try {
    if (board[0][0].equals(board[1][1]) && board[1][1].equals(board[2][2])){
      int[][] a = {{0,0},{2,2}};
      return new Show(board[0][0], a);
    }
  } catch (NullPointerException e){
  }
  try {
    if (board[0][2].equals(board[1][1]) && board[1][1].equals(board[2][0])){
      int[][] a = {{0,2},{2,0}};
      return new Show(board[0][2], a);
    }
  } catch (NullPointerException e){
  }
  int[][] a = {{}};
  return new Show("", a);
}

void mousePressed(){
  setup();
}

void draw(){
  noFill();
  stroke(255, 102, 102);
  strokeWeight(4);
  background(255, 255, 230);
  
  line(w,0,w,height);
  line(2*w,0,2*w,height);
  line(0,h,width,h);
  line(0,2*h,width,2*h);
  if (cont){
    nextTurn();
  }
  for (int i = 0; i < 3; i++){
    for (int j = 0; j < 3; j++){
      float x = w * i + w/2;
      float y = h * j + h/2;
      String spot = board[i][j];
      if (spot == players[0]){
        float xr = w/4;
        line(x-xr,y-xr,x+xr,y+xr);
        line(x+xr,y-xr,x-xr,y+xr);
      }
      else if (spot == players[1]){
        noFill();
        ellipse(x,y,w/2,h/2);
      }
    }
  }
  Show show = checkWinner();
  String winner = show.getWinner();
  int[][] line = show.getCo();
  
  if (!winner.equals("")){
    line(map(line[0][0], 0 , 2, w/2, 5*w/2), map(line[0][1], 0, 2, h/2, 5*h/2), map(line[1][0], 0, 2, w/2, 5*h/2), map(line[1][1], 0, 2, h/2, 5*h/2));
    textSize(39);
    fill(0, 102, 153, 255);
    text(winner + " has won!", w+2, h+39);
    cont = false;
  }else if (available.size() == 0){
    textSize(32);
    fill(0, 102, 153, 255);
    text("Tie!", w+80, h+39);
    cont = false;
  }
  delay(200);
  
  if (mousePressed){
    reset();
  }
}
