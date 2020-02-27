import java.awt.Robot;
import java.awt.event.KeyEvent;
import java.awt.AWTException;
import java.io.IOException;
import g4p_controls.*;

Robot robot;
Cheese cs;
PImage logo;
PImage direction[] = new PImage [4];
boolean turboMode;

HAT_030 hat;
public static final int UP_=3, DOWN_=4,  LEFT_=1, RIGHT_=2;


public void setup() {
  size(1280, 720);
  logo = loadImage("logo.png");
  direction[0] = loadImage("HAT_030_DOWN.png");
  direction[1] = loadImage("HAT_030_LEFT.png");
  direction[2] = loadImage("HAT_030_RIGHT.png");
  direction[3] = loadImage("HAT_030_UP.png");
  G4P.setCursor(CROSS); 
  cs = new Cheese(this);
  hat = new HAT_030(cs);
  cs.attachHAT(hat);
  
  try {
    robot = new Robot();
  }
  catch (AWTException e) {
    exit();
  }
  robot.setAutoDelay(1);
}

public void draw() {
  if(!turboMode){
    background(255);
    PFont font;
    font = loadFont("textfont.vlw");
    textFont(font);
    fill(227, 230, 255);
  
    noStroke();
    rect(width - 190, 0, 200, height);
    image(logo,width-850,height-100,250,80);
    text_name();
    text_data();
    gestureUI();
    //clickEventUI();
    SWUI();
  }
  try{// robot codes
    switch(hat.gesture){ 
    case UP_:
      robot.keyPress(KeyEvent.VK_Q);
      robot.delay(10);
      robot.keyRelease(KeyEvent.VK_Q);
      break;
    case DOWN_:
      robot.keyPress(KeyEvent.VK_E);
      robot.delay(10);
      robot.keyRelease(KeyEvent.VK_E);
      break;
    case LEFT_:
      robot.keyPress(KeyEvent.VK_Z);
      robot.delay(10);
      robot.keyRelease(KeyEvent.VK_Z);
      break;
    case RIGHT_:
      robot.keyPress(KeyEvent.VK_C);
      robot.delay(10);
      robot.keyRelease(KeyEvent.VK_C);
      break;
    case 5:
      robot.keyPress(KeyEvent.VK_S);
      robot.delay(10);
      robot.keyRelease(KeyEvent.VK_S);
      break;
    case 6:
      robot.keyRelease(KeyEvent.VK_G);
      robot.delay(10);
      robot.keyRelease(KeyEvent.VK_G);
      break;
    default:
      break;
    }
  }
  catch(Exception e){
    println("IO_EXCEPTION");
    e.printStackTrace();
    exit();
  }
}

public void text_data()
{
  fill(0);
  text("gesture ID : " + hat.gestureId + " \ngesture : " + hat.gesture + "\nup : " + hat.up+ " \ndown : " + hat.down+ " \nleft : " + hat.left+ " \nright : " + hat.right,width-180,200);
  fill(227, 230, 255);
}
public void text_name()
{
  fill(0);
  textSize(30);
  text("Gesture Sensor\nTESTER",1100,50);
  fill(227, 230, 255);
}
public void gestureUI()
{
  fill(115,160,220); // Main color
  stroke(100);
  fill(50);
  rect(345,195,410,410);
  fill(115,160,220);
  
  //when device get, fill this code 
  switch(hat.gesture){ 
  case UP_: image(direction[3],width-855,height-445,250,250);
  break;
  case DOWN_: image(direction[0],width-855,height-445,250,250);
  break;
  case LEFT_: image(direction[1],width-855,height-445,250,250);
  break;
  case RIGHT_: image(direction[2],width-855,height-445,250,250);
  break;
  case 5:  textSize(100);text("NEAR",480,450);
  break;
  case 6:  textSize(100);text("FAR",480,450);
  break;
  default:
  break;
  }
  fill(115,160,220);
}
//public void loop()
//{
  
//}
void SWUI(){
  strokeWeight(8);
  rect(150, 350, 100, 100);
  rect(850, 350, 100, 100);
  
  IsPushUI();
  fill(115,160,220);
  strokeWeight(1);
}
void IsPushUI()
{
  if(hat.buttonA!=0) {strokeWeight(10); }
  else strokeWeight(2);
  circle(200,400,75);
  if(hat.buttonB!=0) {strokeWeight(10);}
  else strokeWeight(2);
  circle(900,400,75);
  strokeWeight(2);
}

public void mouseClicked(){
  turboMode =! turboMode;
  if(turboMode){
    turboModeText();
  }
}
public void turboModeText(){
  pushStyle();
  PFont font;
  font = createFont("Gulimche",25);
  textFont(font);
  background(255);
  fill(5);
  textAlign(CENTER, CENTER);
  textSize(30);
  text("터보 모드가 실행 되었습니다. \n\n 마우스를 다시 클릭하면 일반 모드로 돌아갑니다.",width/2, height/2);
  popStyle();
}
