Cheese cs;
HAT_043 hat;
PID_13 pid;

Snake snake, Resetsnake;
int tic;
int TT_Timer;
boolean bgm_flag;
boolean start_bgm;
boolean game_started_yet=true;
public void setup(){
  size(500,500, JAVA2D);
  
  cs = new Cheese(this);
  hat = new HAT_043(cs);
  pid = new PID_13(cs);
  cs.attachHAT(hat);
  cs.attachPID(pid);
  
  TT_Timer = 50;
  snake = new Snake();
  snake.Start();
}

public void draw(){
  background(255);
  textAlign(CENTER,CENTER);
  fill(5);
  textSize(25);
  text("X: "+pid.x,200,200);
  text("Y: "+pid.y,200,250);
  text("Button: "+pid.A,200,300);
  
}

public void loop(){
  if(snake.sState==0){
    if(start_bgm==false){
      cs.setSoundClip(HAPPY_SONG);
      start_bgm=true;
    }
    StartLeds();
  }
  //game start flag, init sState = 0, so if u want to start game, press button and lets get started.
  if(pid.A == true && game_started_yet){
    snake.sState=1;
    game_started_yet=false; // game can be started only once!
  }
  ////////////////////////////////////////////////////////////////////////
  
  ////////////////////////////////////////////////////////////////////////
  ///////////game is started!/////////////////////////////////////////////
  ////////////////////////////////////////////////////////////////////////
  if(snake.sState==1){
    int ledX, ledY;
    ///////snake direction control////////
    if(tic%2 == 0) getDirection();
    /////////////////////////////////////
    
    ////////////led clear(erase previous screen)//////////////////////////
    for(int i=0; i<16; i++){
      for(int j=0; j<8; j++){
        hat.led[i][j] = false;
      }
    }
    //////////////////////////////////////////////////////////////////////
    
    //////////////feed blinking & bgm tick & move/////////////////////////
    if(tic%3 == 0){    
        //it moves
        cs.setSoundClip(19);
        snake.Move();
        hat.led[snake.feedx-1][snake.feedy-1] = false;
    }
    if(tic%3 == 2){
      hat.led[snake.feedx-1][snake.feedy-1] = true;
    }
    /////////////////////////////////////////////////////////////////////
    
    /////////////////////snake body draw/////////////////////////////////
    Node tmp = new Node();
    tmp = snake.head;
    while(tmp!=null){
      ledX = tmp.x-1;
      ledY = tmp.y-1;
      hat.led[ledX][ledY] = true;
      tmp = tmp.nextL;
    }
    ////////////////////////////////////////////////////////////////////
    
    tic++;
  }
  ////////////////////////snake has been dead T T///////////////////////////
  if(snake.sState==2 || snake.sState==3){//dead state(state =2 hit wall // state =3 bite its own body)
    
    if(bgm_flag==false){
      cs.setSoundClip(SAD_SONG);
      bgm_flag = true;
    }
    if(TT_Timer>0){
      SnakeDeadLeds();
      TT_Timer--;
    }
    else if(TT_Timer==0){
      ReLeds();
      if(pid.A ==true){
        Reset();
      }
    }
  }
  //////////////////////////////////////////////////////////////////////
}

public void getDirection(){
  int current_dir = snake.head.direction;
  
  if(pid.y>146 && current_dir != 2){ // up
    snake.head.direction=0;
  }
  else if(pid.y<106 && current_dir != 0){ // down
    snake.head.direction=2;
  }
  else if(pid.x<101 && current_dir != 3){ // left
    snake.head.direction=1;
  }
  else if(pid.x>141 && current_dir!= 1){ // right
    snake.head.direction=3;
  }
}

public void Reset(){
  Resetsnake = new Snake();
  Resetsnake.Start();
  snake = Resetsnake;
  game_started_yet = true;
  TT_Timer = 50;
  snake.sState=1;
  bgm_flag=false;
}
