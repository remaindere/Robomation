//public static final int BLACK = 0x0;
//public static final int RED = 0x4; 
//public static final int GREEN = 0x2; 
//public static final int BLUE = 0x1;
//public static final int YELLOW = RED + GREEN; 
//public static final int CYAN = GREEN + BLUE; 
//public static final int MAGENTA = BLUE + RED;
//public static final int WHITE = RED + GREEN + BLUE;
public void SnakeDeadLeds(){
  int[][] TT= { {2,2,2,2,0},
                {2,1,1,1,2},
                {7,2,1,2,2},
                {7,2,2,2,0},
                {7,7,7,4,0}  };
  for(int i = 0; i < 5; i++){
    for(int j = 0; j < 5; j++){
      hat.led[i][j] = TT[i][j];
    }
  }
}

public void ReLeds(){
  int[][] Re= { {0,7,7,7,0},
                {0,0,0,7,0},
                {0,0,7,7,0},
                {0,0,0,0,0},
                {0,0,7,0,0}  };
  for(int i = 0; i < 5; i++){
    for(int j = 0; j < 5; j++){
      hat.led[i][j] = Re[i][j];
    }
  }
}

public void StartLeds(){
  int[][] Start= { {0,4,4,4,0},
                   {4,0,0,0,4},
                   {4,4,4,4,4},
                   {4,0,0,0,4},
                   {4,0,0,0,4}  };
  for(int i = 0; i < 5; i++){
    for(int j = 0; j < 5; j++){
      hat.led[i][j] = Start[i][j];
    }
  }
}


              //{ {0,0,0,0,0},
              //  {0,0,0,0,0},
              //  {0,0,0,0,0},
              //  {0,0,0,0,0},
              //  {0,0,0,0,0}};
