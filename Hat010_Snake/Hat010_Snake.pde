Cheese cs;
HAT_010 hat;

Snake snake, Resetsnake;
int tic;
boolean itMoves;
int TT_Timer;
boolean bgm_flag;
boolean start_bgm;
boolean game_started_yet=true;
boolean move_once=false; // each tic(snake moves), you can move only once
boolean hitA, hitB; // conditions - decides get direction or not
int preA, preB; // save previous hat.buttonX value; it is used in detecting "rise clock"(moments of pressing)

public void setup(){
  size(500,500, JAVA2D);
  
  cs = new Cheese(this);
  hat = new HAT_010(cs);
  cs.attachHAT(hat);
  
  hat.buttonA = 1;
  hat.buttonB = 1; // init button value; if you erase this field, game starts with "button pressed value" for 1~2 seconds, which is could make bugs

  TT_Timer = 30; // game over screen timer
  
  snake = new Snake();
  snake.Start(); // additional(but essential) method(sort of constructor) of snake(makes tail node)
}

public void draw(){
  background(255);
  textAlign(CENTER,CENTER);
  fill(5);
  textSize(25);
  
  text("A: "+hat.buttonA,200,200);
  text("B: "+hat.buttonB,200,250);
  text("Tic: "+tic,200,300);
  text("Dir: "+snake.head.direction,200,350);
  text("MO: "+move_once,200,400); // for debug
  
  if(preA==1 && hat.buttonA == 0) hitA = true;
  if(preB==1 && hat.buttonB == 0) hitB = true;
  preA = hat.buttonA;
  preB = hat.buttonB; // get inputs in draw function, in order to get inputs in fastest way(avoid input lag)
}

public void loop(){
  tic++; // determines game speed
  
  //println(hat.buttonA);
  //println(hat.buttonB);
  //println(snake.sState);  //for debug
  
  ///////////////////////game has not been started yet////////////////////
  if(snake.sState==0){
    if(start_bgm==false){
      cs.setSoundClip(HAPPY_SONG); // bgm starts
      start_bgm=true; // setSoundClip must be excuted only once
    }
    StartLeds();
  }
  //game start flag, init sState = 0, so if u want to start game, press button and lets get started.
  if((hat.buttonA == 0 || hat.buttonB == 0) && game_started_yet && tic>10){
    snake.sState=1;
    game_started_yet=false; // game can be started only once! if you earse this field, player is able to resume game by pressing buttons(at "bites its own body" condition)
  }
  
  ////////////////////////////////////////////////////////////////////////
  
  ////////////////////////////////////////////////////////////////////////
  ///////////game is started!/////////////////////////////////////////////
  ////////////////////////////////////////////////////////////////////////
  if(snake.sState==1){    
    //////////////snake moves and draw graphic - each "tic"///////////////
    if(itMoves){
      /////////////////////////////it moves///////////////////////////////
      cs.setSoundClip(19);//sound fx
      snake.Move();
      /////////////////////////////////////////////////////////////////////
    
      ////////////led clear(erase previous screen)/////////////////////////
    
      for(int i=0; i<5; i++){
        for(int j=0; j<5; j++){
          hat.led[i][j] = BLACK;
        }
      }
    
      //////////////////////////////////////////////////////////////////////  
    
      /////////////////////snake body draw/////////////////////////////////
      Node tmp = new Node();
      tmp = snake.head;
      while(tmp!=null){
        hat.led[tmp.y-1][tmp.x-1] = snake.sColor;
        tmp = tmp.nextL;
      }
      hat.led[snake.feedy-1][snake.feedx-1] = WHITE;
      move_once = true;
      /////////////////////////////////////////////////////////////////////
      
    }//tic ends
    
    ///////////////////////////set Difficulty/////////////////////////////
    //difficulty = game speed
    if(snake.sSize==2){
      if(tic%7==0){
        itMoves = true;
      }
      else itMoves = false;
    }
    else if(snake.sSize==3){
      if(tic%6==0){
        itMoves = true;
      }
      else itMoves = false;
    }
    else if(snake.sSize>=4){
      if(tic%5==0){
        itMoves = true;
      }
      else itMoves = false;
    }
    //////////////////////////////////////////////////////////////////////
    
    /////////////////////snake direction control//////////////////////////
    if(move_once && (hitA == true || hitB == true)){
      getDirection();
      move_once = false;
    }
    hitA = false;
    hitB = false; // set to false for next input
    
    //////////////////////////////////////////////////////////////////////
  }
  ////////////////////////snake has been dead T T///////////////////////////
  if(snake.sState==2 || snake.sState==3){//dead state(state =2 hit wall // state =3 bite its own body)
    
    if(bgm_flag==false){
      cs.setSoundClip(SAD_SONG); // bgm starts
      bgm_flag = true; // setSoundClip must be excuted only once
    }
    if(TT_Timer>0){ // SnakeDeadLeds is presented till 2400ms elapsed
      SnakeDeadLeds();
      TT_Timer--; // time flows
    }
    else if(TT_Timer==0){ // SnakeDeadLeds ends -> present "?" on screen
      ReLeds();
      if(hat.buttonA == 0 || hat.buttonB == 0){ // if player hit any button;
        Reset(); // game restarts
      }
    }
  }
  //////////////////////////////////////////////////////////////////////
}

public void getDirection(){ // get direction from button
//0 - up, 1 - left, 2 - down, 3 - right
  int current_dir = snake.head.direction;
  
  if((current_dir == 1 && hat.buttonB == 0) || (current_dir == 3 && hat.buttonA == 0)){
    snake.head.direction=0;//up
  }
  else if((current_dir == 1 && hat.buttonA == 0) || (current_dir == 3 && hat.buttonB == 0)){ 
    snake.head.direction=2;//down
  }
  else if((current_dir == 0 && hat.buttonA == 0) || (current_dir == 2 && hat.buttonB == 0)){ 
    snake.head.direction=1;//left
  }
  else if((current_dir == 0 && hat.buttonB == 0) || (current_dir == 2 && hat.buttonA == 0)){ 
    snake.head.direction=3;//right
  }
}

public void Reset(){ // reset the game
  Resetsnake = new Snake();
  Resetsnake.Start();
  snake = Resetsnake;
  game_started_yet = true;
  TT_Timer = 30;
  snake.sState=1;
  bgm_flag=false;
}
