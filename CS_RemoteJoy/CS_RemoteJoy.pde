import java.awt.Robot;
import java.awt.event.KeyEvent;
import java.awt.AWTException;
import java.io.IOException;
 
PImage joy, SelStart, btn_a, btn_b;
PFont Gulim; 
Robot robot;
Cheese cs;
PID_13 pid13;
HAT_010 hat;

boolean SelStartInput; 
boolean gameMode;
int SelStartFlag;

void setup() {
  frameRate(120);
  size(600, 650, JAVA2D);
  
  cs = new Cheese(this);
  pid13 = new PID_13(cs);
  hat = new HAT_010(cs);
  cs.configSc(ANALOG_IN, ADC_BGV);
  cs.configSa(DIGITAL_IN, PULL_UP_50K);
  try {
    robot = new Robot();
  }
  catch (AWTException e) {
    exit();
  }
  textSize(25);
  Gulim = createFont("Gulimche",25);
  textFont(Gulim);
  textAlign(LEFT, CENTER);
  joy = loadImage("joystick.png");
  btn_a = loadImage("A.png");
  btn_b = loadImage("B.png");
  SelStart = loadImage("SelStart.png");
  pid13.x = 120;
  pid13.y = 120;
  cs.inputSa = 1;
  robot.setAutoDelay(1);
}

void draw() {
  joy();
  try{
    switch(status_flag){
    case JOY_FORWARD: 
      robot.keyPress(KeyEvent.VK_W);
      robot.keyRelease(KeyEvent.VK_A);
      robot.keyRelease(KeyEvent.VK_S);
      robot.keyRelease(KeyEvent.VK_D);
      break;
    case JOY_UPPERRIGHT:
      robot.keyPress(KeyEvent.VK_D);
      robot.keyPress(KeyEvent.VK_W);
      robot.keyRelease(KeyEvent.VK_S);
      robot.keyRelease(KeyEvent.VK_A);
      break;
    case JOY_RIGHT:
      robot.keyPress(KeyEvent.VK_D);
      robot.keyRelease(KeyEvent.VK_W);
      robot.keyRelease(KeyEvent.VK_S);
      robot.keyRelease(KeyEvent.VK_A);
      break;
    case JOY_LOWERRIGHT:
      robot.keyPress(KeyEvent.VK_D);
      robot.keyPress(KeyEvent.VK_S);
      robot.keyRelease(KeyEvent.VK_W);
      robot.keyRelease(KeyEvent.VK_A);
      break;
    case JOY_BACKWARD:
      robot.keyPress(KeyEvent.VK_S);
      robot.keyRelease(KeyEvent.VK_W);
      robot.keyRelease(KeyEvent.VK_A);
      robot.keyRelease(KeyEvent.VK_D);
     break;
    case JOY_LOWERLEFT:
      robot.keyPress(KeyEvent.VK_A);
      robot.keyPress(KeyEvent.VK_S);
      robot.keyRelease(KeyEvent.VK_W);
      robot.keyRelease(KeyEvent.VK_D);
      break;
    case JOY_LEFT:
      robot.keyPress(KeyEvent.VK_A);
      robot.keyRelease(KeyEvent.VK_W);
      robot.keyRelease(KeyEvent.VK_S);
      robot.keyRelease(KeyEvent.VK_D);
      break;
    case JOY_UPPERLEFT:
      robot.keyPress(KeyEvent.VK_A);
      robot.keyPress(KeyEvent.VK_W);
      robot.keyRelease(KeyEvent.VK_S);
      robot.keyRelease(KeyEvent.VK_D);
      break;
    default :
      robot.keyRelease(KeyEvent.VK_W);
      robot.keyRelease(KeyEvent.VK_A);
      robot.keyRelease(KeyEvent.VK_S);
      robot.keyRelease(KeyEvent.VK_D);
      break;
    }
    
    if(pid13.A){
      robot.keyPress(KeyEvent.VK_G);
    }
    else if(!pid13.A){
      robot.keyRelease(KeyEvent.VK_G);
    }

    if(cs.inputSa == 0) robot.keyPress(KeyEvent.VK_F);
    else if(cs.inputSa == 1) robot.keyRelease(KeyEvent.VK_F);
    
    if(50 <= cs.inputSc && cs.inputSc <= 205){
      SelStartInput = true;
      SelStartFlag = 0;
    }
    else if(SelStartInput && cs.inputSc < 50){
      SelStartInput = false;
      SelStartFlag = 1;
      robot.keyPress(KeyEvent.VK_J);
      robot.delay(10);
      robot.keyRelease(KeyEvent.VK_J);      
    }
    else if(SelStartInput && 205 < cs.inputSc){
      SelStartInput = false;
      SelStartFlag = 2;
      robot.keyPress(KeyEvent.VK_H);
      robot.delay(10);
      robot.keyRelease(KeyEvent.VK_H);      
    }
  }
  catch (Exception e){
    println("IO_EXCEPTION");
    e.printStackTrace();
    exit();
  }
  if(gameMode) return;
  else if(!gameMode) joyUI();
}
 
public void mouseClicked(){
  background(255);
  textAlign(CENTER, CENTER);
  fill(5);
  text("게임 모드 작동 중..\n\n마우스를 다시 클릭하면 돌아갑니다.",width/2,height/2);
  if(gameMode) gameMode = false;
  else gameMode = true;
}
