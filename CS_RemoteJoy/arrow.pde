public static final int JOY_DEFAULT=0;
public static final int JOY_FORWARD=1; 
public static final int JOY_UPPERRIGHT=2;
public static final int JOY_RIGHT=3;
public static final int JOY_LOWERRIGHT=4;
public static final int JOY_BACKWARD=5;
public static final int JOY_LOWERLEFT=6;
public static final int JOY_LEFT=7;
public static final int JOY_UPPERLEFT=8;

public static final int defaultX=90;
public static final int defaultY=90;

int status_flag;

void joy()
{
  if (pid13.x>131 && pid13.y>136 ) {
    status_flag=JOY_UPPERRIGHT;
  } //UPPERRIGHT
  else if (pid13.x<111 && pid13.y>136) {
    status_flag=JOY_UPPERLEFT;
  } //UPPERLEFT 
  else if (pid13.y>136) {
    status_flag=JOY_FORWARD;
  } // FORWARD
  else if (pid13.x>131 && pid13.y<116) {
    status_flag=JOY_LOWERRIGHT;
  }//LOWERRIGHT
  else if (pid13.x>131) {
    status_flag=JOY_RIGHT;
  }//RIGHT
  else if (pid13.x<111 && pid13.y<116) {
    status_flag=JOY_LOWERLEFT;
  } //LOWERLEFT
  else if (pid13.x<111) {
    status_flag=JOY_LEFT;
  } //LEFT
  else if (pid13.y<116) {
    status_flag=JOY_BACKWARD;
  } //BACKWARD
  else {
    status_flag=JOY_DEFAULT;
  }//default
}

public void joyUI(){
  textSize(25);
  Gulim = createFont("Gulimche",25);
  textFont(Gulim);
  textAlign(LEFT, CENTER);
  joy = loadImage("joystick.png");
  btn_a = loadImage("A.png");
  btn_b = loadImage("B.png");
  SelStart = loadImage("SelStart.png");
  
  background(255);
  fill(5);
  stroke(5);
  strokeWeight(2);
  line(0,350,600,350);
  text("Q: 작동이 되지 않는다면?\n\nA: 1.동글을 뽑고 다시 끼운 뒤,\n   2.치즈스틱을 껐다 켜 주고,\n   3.프로그램을 다시 실행해 주세요!",80,450);
  line(0,550,600,550);
  text("마우스 왼쪽 클릭을 누르면 반응속도가\n좀 더 빨라지는 \"게임 모드\"로 들어갑니다!",60,600);
  
  fill(200);
  noStroke();
  image(joy, defaultX-27, defaultY+30, 220, 220);
  ellipse(defaultX+20+(pid13.x/2), defaultY+(200-pid13.y/2), 100, 100);

  /////
  image(btn_a, defaultX+300, defaultY+85, 100, 100);
  image(btn_b, defaultX+300, defaultY-60, 100, 100);
  fill(100, 100);
  if (pid13.A) ellipse(defaultX+350, defaultY+135, 85, 85);
  if (cs.inputSa==0) ellipse(defaultX+350, defaultY-10, 85, 85);
  
  image(SelStart, defaultX-40, defaultY-60, 250, 100);
  if (SelStartFlag==0) ellipse(defaultX+85, defaultY-10, 55, 55);
  else if (SelStartFlag==1) ellipse(defaultX+150, defaultY-10, 55, 55);
  else if (SelStartFlag==2) ellipse(defaultX+20, defaultY-10, 55, 55);
}
