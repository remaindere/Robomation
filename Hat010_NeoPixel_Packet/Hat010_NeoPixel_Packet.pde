
Cheese cs;
HAT_010 hat1;
HAT_011 hat2;

PID_03 pid;
int angle = 0;
int tick = 0;
int state_B = 0;
int count = 0;
int csLoopCount=2;
//clear(); //all clear
//pattern(int pattern);
//pattern(int pattern, int block, int skip, int clear)
//setRange(from, to); (from,to,inc); //cmd 없음
//setBlock(int block);
//setBrightness(int bright);cmd0
//fill(W,R,G,B) cmd1
//fill(R,G,B) //cmd0
//change(W,R,G,B) 
//change(R,G,B)
//bright(int br)
// bright(int brW, int brR, int brG, int brB)
// bright(int brR, int brG, int brB)
//shift(int shift, int rot, int dir) cmd4
//rotate(int shift) cmd4
//shift(int shift) cmd4
//show() 명령들 갱신 처리
int [][] color_check = new int[5][5];





public void setup()
{
  size(280, 280, JAVA2D);

  // Place your setup code here
  cs = new Cheese(this);
  delay(100);  // attach NULL device for reset
  hat1 = new HAT_010(cs);
  hat2 = new HAT_011(cs);

  //pid = new PID_15(cs, 0);  // Rx Only
}

public void draw() {
  background(255);
  fill(0);
  stroke(0);
  textSize(20);
  background(115, 160, 220);
  textAlign(CENTER, CENTER);
  //text("tick: "+tick, width/2, height/2);
  text("Implemented by CMD Mode", width/2, 20);
  for (int i = 40; i < 250; i+=40) {
    line(40, i, 240, i); 
    line(i, 40, i, 240);
  }
  for (int i = 0; i < 5; i++) {
    for (int j = 0; j < 5; j++) {              
      if (color_check[i][j] == BLACK) fill(115, 160, 220);
      else if (color_check[i][j] == BLUE) fill(0, 0, 255);
      else if (color_check[i][j] == GREEN) fill(0, 255, 0);
      else if (color_check[i][j] == CYAN) fill(180, 225, 255);
      else if (color_check[i][j] == RED) fill(255, 0, 0);
      else if (color_check[i][j] == MAGENTA) fill(255, 0, 255); 
      else if (color_check[i][j] == YELLOW) fill(255, 255, 0);
      else if (color_check[i][j] == WHITE) fill(255, 255, 255);
      rect((i+1)*40, (j+1)*40, 40, 40);
    }
  }
}

public void loop()
{ 
  hat2.setMode(NEO_MODE_5);
  //hat2.setColor(7);
  hat2.setBrightness(7);
  //hat2.setMotoringPacket(i, 127);
  //cs.outSa++;
  //println(cs.outSa);
  //println(cs.configNeo);
  //csLoopCount++;
  switch(tick) {
  case 1:
    hat2.setRange(0, 4);
    for(int i = 0; i < 5; i++) color_check[i][0] = WHITE;
    hat2.fill(255, 255, 255); //cmd=0
    break;
  case 2:
    hat2.setRange(5, 9);
    for(int i = 0; i < 5; i++) color_check[i][1] = RED;
    hat2.fill(255, 0, 0);
    break;
  case 3:
    hat2.setRange(10, 14);
    for(int i = 0; i < 5; i++) color_check[i][2] = GREEN;
   hat2.fill(0, 255, 0); 
    break;
  case 4:
    hat2.setRange(15, 19);
    for(int i = 0; i < 5; i++) color_check[i][3] = BLUE;
    hat2.fill(0, 0, 255); 
    break;
  case 5:
    hat2.setRange(20, 24);
    for(int i = 0; i < 5; i++) color_check[i][4] = WHITE;
    hat2.fill(255, 255, 255);  
    break;
  case 6:
    hat2.setRange(0,4);
    for(int i = 0; i < 5; i++) color_check[i][0] = BLACK;
    hat2.fill(0,0,0);
    break;
  case 7:
    hat2.setRange(5,9);
    for(int i = 0; i < 5; i++) color_check[i][1] = BLACK;
    hat2.fill(0,0,0);
    break;
  case 8:
    hat2.setRange(10,14);
    for(int i = 0; i < 5; i++) color_check[i][2] = BLACK;
    hat2.fill(0,0,0);
    break;
  case 9:
    hat2.setRange(15,19);
    for(int i = 0; i < 5; i++) color_check[i][3] = BLACK;
    hat2.fill(0,0,0);
    break;
  case 10:
    hat2.setRange(20,24);
    for(int i = 0; i < 5; i++) color_check[i][4] = BLACK;
    hat2.fill(0,0,0);
    break;
  }

  hat2.show();
  tick++;
  tick%=11;
}



public void test()
{
  if (tick == 1) {
    hat2.clear();
  } else if (tick == 2) { 
    hat2.pattern(0X00);    //background color
    //hat.fill(100, 0, 0);
  } else if (tick == 3) {
    hat2.setRange(1, 1);  
    //hat.pattern(0x03);  
    hat2.fill(255, 255, 0);  //led color
  } else if (tick == 4) {
    hat2.setRange(0, 4);
    hat2.rotate(1);
  } else if (tick == 5) {
    hat2.setRange(5, 5); 
    hat2.fill(255, 255, 0);
  } else if (tick == 6 ) {
    hat2.setRange(5, 9);
    hat2.rotate(1);
  } else if (tick == 7) {
    hat2.setRange(8, 9);
    hat2.fill(255, 255, 0);
  } else if (tick == 8) {
    hat2.setRange(8, 9);
    hat2.fill(255, 255, 0);
  } else if (tick == 9) {
    hat2.setRange(10, 11);
    hat2.fill(255, 255, 0);
  } else if (tick == 10) {
    hat2.setRange(10, 14);
    hat2.rotate(-1);
  } else if (tick == 11) {
    hat2.setRange(15, 15);
    hat2.fill(255, 255, 0);
  } else if (tick == 12) {
    hat2.setRange(15, 19);
    hat2.rotate(1);
  } else if (tick == 13) {
    hat2.setRange(17, 18);
    hat2.fill(0, 255, 0);
  } else if (tick == 14) {
    hat2.setRange(17, 19);
    hat2.rotate(1);
  } else if (tick == 15) {
    hat2.setRange(21, 21);
    hat2.fill(255, 255, 0);
  } else if (tick > 16) {
    for (int i = 0; i < 5; i++)
    {
      hat2.setRange(20, 24);
      hat2.rotate(1);
      count++;
    }
    if (count > 25) tick = 0;
  } else {   
    //hat2.setRange(0,63);
  }
  hat2.show();

  tick++;  
  //  if(tick > 255) tick = 0;
}
