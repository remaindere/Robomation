import g4p_controls.*;

GCScheme GCScheme;
GButton csd1, csd2, csd3, servo, joystick, btm; // btm == back to menu
GCustomSlider sliderSa, sliderSb, sliderSc, sliderLa, sliderMab;
PImage csd1_img, csd2_img, csd3_img, servo_img, joystick_img;
PImage joy, btn_a, btn_b;
PImage guide_csd1_img, guide_csd2_img, guide_csd3_img, guide_joystick_img;


Cheese cs;

HAT_010 hat;
PID_13 pid13;

boolean[] menu_flag = new boolean[6]; // 0==main menu, 1==SW(CSD1), 2==RGB LED(CSD2), 3==Rotary POT(CSD3), 4==SERVO, 5==JoyStick //
// 0 - off, 1- on(on selected menu)
boolean csd1_sw;
int csd2_rgbwFlag;
int servo_flag, sound_flag=0, sound_flag_low=0;
PFont myFont;
public void setup() {
  size(600, 800, JAVA2D);
  myFont = createFont("맑은 고딕", 32);
  textFont(myFont);

  GCScheme.makeColorSchemes();
  GCScheme.changePaletteColor(8, 3, color(0, 0));
  GCScheme.savePalettes(this);
  G4P.setGlobalColorScheme(8);

  buttonInitSettings();
  imgInitSettings();
  sliderInitSettings(); 

  cs = new Cheese(this);

  menu_flag[0] = true; // Init state; main menu
}

public void draw() {
  background(255);

  stroke(5);
  strokeWeight(2);
  fill(5);
  textSize(25);
  textAlign(CENTER, CENTER);

  ///////////////////////lines & main texts/////////////////////  
  line(0, 50, width, 50);
  line(0, 350, width, 350);
  textSize(30);
  text("치즈스틱 테스터", width/2, 25);
  textSize(25);
  text("Status", width/2, 75);
  /////////////////////////////////////////////////////////////  

  if (menu_flag[0] == true) { // main menu
    menuVisible();
    drawMenu();
  } else { //sub menu
    menuInvisible();
    if (menu_flag[1] == true) drawCsd1();
    else if (menu_flag[2] == true) drawCsd2();
    else if (menu_flag[3] == true) drawCsd3();
    else if (menu_flag[4] == true) drawServo();
    else if (menu_flag[5] == true) drawJoystick();
  }
}


private void buttonInitSettings() {
  csd1 = new GButton(this, (width*1)/12, (height*4.5)/8, 150, 150);
  csd1.useRoundCorners(false);
  csd1.setLocalColor(4, color(255, 0));
  csd1.setLocalColor(6, color(192, 128)); 
  csd1.setLocalColor(14, color(128, 128));
  csd2 = new GButton(this, (width*4.5)/12, (height*4.5)/8, 150, 150);
  csd2.useRoundCorners(false);
  csd2.setLocalColor(4, color(255, 0));
  csd2.setLocalColor(6, color(192, 128)); 
  csd2.setLocalColor(14, color(128, 128));
  csd3 = new GButton(this, (width*8)/12, (height*4.5)/8, 150, 150);
  csd3.useRoundCorners(false);
  csd3.setLocalColor(4, color(255, 0));
  csd3.setLocalColor(6, color(192, 128)); 
  csd3.setLocalColor(14, color(128, 128));

  servo = new GButton(this, (width*2.5)/12, (height*12.5)/16, 150, 150);
  servo.useRoundCorners(false);
  servo.setLocalColor(4, color(255, 0));
  servo.setLocalColor(6, color(192, 128)); 
  servo.setLocalColor(14, color(128, 128));
  joystick = new GButton(this, (width*6.5)/12, (height*12.5)/16, 150, 150);
  joystick.useRoundCorners(false);
  joystick.setLocalColor(4, color(255, 0));
  joystick.setLocalColor(6, color(192, 128)); 
  joystick.setLocalColor(14, color(128, 128));

  //btm = new GButton(this, (width)/12, (height*38)/80, 100, 50);
  btm = new GButton(this, (width)*8/10, (height)*9/10, 100, 50);
  btm.useRoundCorners(false);
  btm.setLocalColor(4, color(255, 0));
  btm.setLocalColor(6, color(192, 128)); 
  btm.setLocalColor(14, color(128, 128));
  btm.setLocalColorScheme(6);
  btm.setText("GO TO MENU");
}

public void handleButtonEvents(GButton button, GEvent event) {
  if (menu_flag[5]==true) {
    allClear();
  }
  delay(80);
  for (int i = 0; i<6; i++) { // there is any event from button, initialize menu_flag and set proper flag to true;

    //
    menu_flag[i] = false;
  }

  if (button == csd1) {
    menu_flag[1] = true;
    cs.configSa(DIGITAL_IN, PULL_UP_50K);
    cs.configSb(DIGITAL_IN, PULL_UP_50K);
    cs.configSc(DIGITAL_IN, PULL_UP_50K);
    cs.configLa(PWM_OUT, 0);
    cs.configLb(PWM_OUT, 0);
    cs.configLc(PWM_OUT, 0);
    cs.outLb=0;
    cs.outLc=0;
  } else if (button == csd2) {
    menu_flag[2] = true;
    cs.configLa(PWM_OUT, 0);
    cs.configLb(PWM_OUT, 0);
    cs.configLc(PWM_OUT, 0);
  } else if (button == csd3) {
    menu_flag[3] = true;
    cs.configLa(PWM_OUT, 0);
    cs.configLb(PWM_OUT, 0);
    cs.configLc(PWM_OUT, 0);
    cs.configSa(ANALOG_IN, ADC_BGV);
    cs.configSb(ANALOG_IN, ADC_BGV);
    cs.configSc(ANALOG_IN, ADC_BGV);
  } else if (button == servo) {
    menu_flag[4] = true;
    cs.configSa(SERVO_OUT, 0);
    cs.configSb(SERVO_OUT, 0);
    cs.configSc(SERVO_OUT, 0);
    cs.configLa(SERVO_OUT, 0);
    cs.configM(MONO_SERVO_MODE, 0);
  } else if (button == joystick) {
    menu_flag[5] = true;
    //register setting
    pid13 = new PID_13(cs);
    hat = new HAT_010(cs);
  } else if (button == btm) {
    menu_flag[0] = true;
    clearCheeseSet();
  }
}

private void menuVisible() {
  btm.setVisible(false);
  csd1.setVisible(true);
  csd2.setVisible(true);
  csd3.setVisible(true);
  servo.setVisible(true);
  joystick.setVisible(true);
  ///////////////
  sliderSa.setVisible(false);
  sliderSb.setVisible(false);
  sliderSc.setVisible(false);
  sliderLa.setVisible(false); //in menuVisible function
  sliderMab.setVisible(false);
}

private void menuInvisible() {
  btm.setVisible(true);
  csd1.setVisible(false);
  csd2.setVisible(false);
  csd3.setVisible(false);
  servo.setVisible(false);
  joystick.setVisible(false);
  //////////
  if (menu_flag[4]) { // servo sliders
    sliderSa.setVisible(true);
    sliderSb.setVisible(true);
    sliderSc.setVisible(true);
    sliderLa.setVisible(true);
    sliderMab.setVisible(true);
  } //in menuInvisible function
}

private void drawMenu() {
  menuImg();
  text("테스트 제품", width/2, 400);
}

private void drawCsd1() {
  text("TACT SWITCH 검사", width/2, 400);

  image(guide_csd1_img, 10, 55, 960/2.5, 720/2.5);

  text("Status", width/2, 75);
  textAlign(LEFT);
  textSize(19);
  text("1.위 그림과 같이 연결해줍니다.   \n   (위 그림은 Sa에 연결한 상태)\n    (스위치를 Sa/Sb/Sc 중 아무 곳에 연결해줍니다.)\n2. 스위치를 눌렀을 때, 위 Status창에 OFF가 ON으로 바뀌고,\n    RGB LED에 적색 불이 들어오고,\n    비프음이 들리면 정상입니다. ", width/15, 460);
  textSize(25);
  noStroke();
  if (csd1_sw == true) {
    text("OFF(LED 점멸)", width*6/15, 275);
    noFill();
  } else {
    text("ON(LED 적색점등)", width*6/15, 275);
    fill(255, 0, 0, 150);
  }
  ellipse(98, 95, 15, 15);
  doCsd1();
  stroke(0);
  fill(5);
}
private void doCsd1() {


  if (cs.inputSa == 0 || cs.inputSb == 0 || cs.inputSc == 0) {
    csd1_sw = false; 
    cs.outLa=10;
    soundPlay();
  } else {
    csd1_sw = true;
    cs.setSoundNote(MUTE); 
    sound_flag=1;
    cs.outLa=0;
  }
  //println("Sa: "+cs.inputSa);
  //println("Sb: "+cs.inputSb);
  //println("Sc: "+cs.inputSc);
  //println("La: "+cs.inputLa);
}

private void drawCsd2() {
  text("RGB LED 검사", width/2, 400);

  image(guide_csd2_img, 0, 480, 960/2, 720/2);
  textAlign(LEFT);
  textSize(19);
  text("1. L포트에 아래 그림과 같이 RGB LED 장치를 연결해줍니다.\n2. 위 Status와 같은 색으로 빛이 나오면 정상입니다. ", width/15, 460);
  textSize(25);
  if (csd2_rgbwFlag<=50) {
    text("적색", width*18/40, 300);
    fill(255, 0, 0, 200);
  } else if (50 < csd2_rgbwFlag && csd2_rgbwFlag <= 100) {
    text("녹색", width*18/40, 300);
    fill(0, 255, 0, 200);
  } else if (100 < csd2_rgbwFlag && csd2_rgbwFlag <= 150) {
    text("청색", width*18/40, 300);
    fill(0, 0, 255, 200);
  } else if (150 < csd2_rgbwFlag && csd2_rgbwFlag <= 200) {
    text("백색", width*18/40, 300);
    fill(255, 255, 255, 150);
  }
  rect(250, 160, 100, 100);

  doCsd2();
}
private void doCsd2() {

  if (csd2_rgbwFlag<=50) {
    cs.outLa = 10;
    cs.outLb = 0;
    cs.outLc = 0;
  } else if (10 < csd2_rgbwFlag && csd2_rgbwFlag <= 100) {
    cs.outLa = 0;
    cs.outLb = 10;
    cs.outLc = 0;
  } else if (20 < csd2_rgbwFlag && csd2_rgbwFlag <= 150) {
    cs.outLa = 0;
    cs.outLb = 0;
    cs.outLc = 10;
  } else if (30 < csd2_rgbwFlag && csd2_rgbwFlag <= 200) {
    cs.outLa = 10;
    cs.outLb = 10;
    cs.outLc = 10;
  }
  csd2_rgbwFlag++;
  if (csd2_rgbwFlag==200) csd2_rgbwFlag=0;
  //println(cs.outLa);
  //println(cs.outLb);
  //println(cs.outLc);
  //println(csd2_rgbwFlag);
}


private void drawCsd3() {
  text("ROTARY_POT 검사", width/2, 400);
  image(guide_csd3_img, 0, 100, 960/3, 720/3);
  text(doCsd3() +"/255", width/1.5, 200);
  textAlign(LEFT);
  textSize(19);
  text("1. ROTARY POT의 노브를 가장 왼쪽으로 돌려 놓습니다. \n2. 위 그림과 같이 L 포트에 RGB LED 장치를 \n    S포트에 ROTARY POT를 연결해줍니다.\n3. 이후, 노브를 시계방향으로 돌릴 때 \n    위 그림처럼 백색>적색>녹색>청색으로 바뀐 뒤, \n    동시에 백색일 때 '삑', 청색일 때 '삑 삑' 소리가 나야합니다.\n (유의사항: 가끔 ROTARY POT을 꽂을 때 나는 비프음 무시) ", width/15, 460);
  textSize(25);



  //doCsd3();
}
private int doCsd3() {
  int brightdata=0;

  brightdata=(cs.inputSa+cs.inputSb+cs.inputSc)>255 ? 255 : (cs.inputSa+cs.inputSb+cs.inputSc);

  if (brightdata<6)
  {
    cs.outLa=10;
    cs.outLb=10;
    cs.outLc=10;
    text("백색", width/3, 130);
    fill(255, 150);
  } else if (brightdata<85) {
    cs.outLa=10;
    cs.outLb=0;
    cs.outLc=0;
    text("적색", width/3, 130);
    fill(255, 0, 0, 150);
  } else if (brightdata<190) {
    cs.outLa=0;
    cs.outLb=10;
    cs.outLc=0;
    text("녹색", width/3, 130);
    fill(0, 255, 0, 150);
  } else if (brightdata<256) {
    cs.outLa=0;
    cs.outLb=0;
    cs.outLc=10;
    text("청색", width/3, 130);
    fill(0, 0, 255, 150);
  } 

  if (brightdata>250) {
    soundPlay();
  } else if (brightdata<6){soundPlay_low();}
  else {
    cs.setSoundNote(MUTE); 
    sound_flag=1;
  }



  noStroke();
  ellipse(95, 135, 19, 19);
  stroke(0);
  fill(5);
  //else if (brightdata<255) {
  //  cs.outLa=10;
  //  cs.outLb=10;
  //  cs.outLc=10;
  //}

  //println(data);
  //  println(cs.inputSa);
  //println(cs.inputSb);
  //println(cs.inputSc);
  return brightdata;
}


void soundPlay()
{

  if (sound_flag==1)cs.setSoundClip(BEEP_2);
  sound_flag=0;
}

void soundPlay_low()
{

  if (sound_flag==1)cs.setSoundClip(BEEP);
  sound_flag=0;
}


void tactSoundPlay_A()
{
  if (sound_flag_A==1) {
    cs.setSoundClip(BEEP);
    sound_flag_A=0;
  } else { 
    cs.setSoundNote(MUTE);
  }
}
void tactSoundPlay_B()
{
  if (sound_flag_B==1) {
    cs.setSoundClip(BEEP);
    sound_flag_B=0;
  } else { 
    cs.setSoundNote(MUTE);
  }
}

private void drawServo() {
  text("Servo", width/2, 400);
  pushStyle();
  textSize(30);
  text("Sa: "+sliderSa.getValueI()+"°", 140, 150);
  text("Sb: "+sliderSb.getValueI()+"°", 440, 150);
  text("Sc: "+sliderSc.getValueI()+"°", 140, 200);
  text("La: "+sliderLa.getValueI()+"°", 440, 200);
  text("Mab: "+sliderMab.getValueI()+"°", 290, 250);
  textSize(20);
  text("Sa", 140, 550);
  text("Sb", 440, 550);
  text("Sc", 140, 650);
  text("La", 440, 650);
  text("Mab", 290, 750);
  popStyle(); // in drawServo function
  doServo();
}


private void doServo() { // new function

  if (servo_flag==0) {
    sliderSa.setValue(0);
    sliderSb.setValue(0);
    sliderSc.setValue(0);
    sliderLa.setValue(0);
    sliderMab.setValue(0);
  } else if (servo_flag==50) {
    sliderSa.setValue(90);
    sliderSb.setValue(90);
    sliderSc.setValue(90);
    sliderLa.setValue(90);
    sliderMab.setValue(90);
  } else if (servo_flag==100) {
    sliderSa.setValue(180);
    sliderSb.setValue(180);
    sliderSc.setValue(180);
    sliderLa.setValue(180);
    sliderMab.setValue(180);
  } else if (servo_flag==150) {
    sliderSa.setValue(90);
    sliderSb.setValue(90);
    sliderSc.setValue(90);
    sliderLa.setValue(90);
    sliderMab.setValue(90);
  }

  cs.outSa = sliderSa.getValueI();
  cs.outSb = sliderSb.getValueI();
  cs.outSc = sliderSc.getValueI();
  cs.outLa = sliderLa.getValueI();
  cs.outMab = sliderMab.getValueI();

  servo_flag++;
  if (servo_flag==200) servo_flag=0;
}


private void drawJoystick() {
  text("조이스틱&버튼 검사", width/2, 380);

  image(guide_joystick_img, 0, (height*4.5)/7, 960/2, 720/2);
  textAlign(LEFT);
  textSize(19);
  text("1. 아래 그림과 같이 JOY STICK 장치와 \n    5x5 MATRIX를 연결해줍니다.(방향 맞게 연결함에 유의) \n2. 조이스틱과 5x5 MATRIX 방향이 같으면 \n    정상입니다.\n 3. A버튼과 B버튼을 누를 때 마다 비프음이 나며, \n    5x5 MATRIX 색상(파>초>빨>백>흑)이 바뀌면 정상입니다.", width/15, 430);
  textSize(25); 
  joyUI();
}



private void sliderInitSettings() { // new function
  sliderSa = new GCustomSlider(this, 50, 500, 180, 50);
  sliderSa.setValue(0);
  sliderSa.setLimits(1, 180);
  sliderSb = new GCustomSlider(this, 350, 500, 180, 50);
  sliderSb.setValue(0);
  sliderSb.setLimits(1, 180);
  sliderSc = new GCustomSlider(this, 50, 600, 180, 50);
  sliderSc.setValue(0);
  sliderSc.setLimits(1, 180);
  sliderLa = new GCustomSlider(this, 350, 600, 180, 50);
  sliderLa.setValue(0);
  sliderLa.setLimits(1, 180);
  sliderMab = new GCustomSlider(this, 200, 700, 180, 50);
  sliderMab.setValue(0);
  sliderMab.setLimits(1, 180);
}


private void imgInitSettings() {
  csd1_img = loadImage("csd1_img.jpg");
  csd2_img = loadImage("csd2_img.jpg");
  csd3_img = loadImage("csd3_img.jpg");
  servo_img = loadImage("servo_img.png");
  joystick_img = loadImage("joystick_img.jpg");
  joy = loadImage("joystick.png");
  btn_a = loadImage("A.png");
  btn_b = loadImage("B.png");

  guide_csd1_img = loadImage("TACT_SW_img.jpg");
  guide_csd2_img = loadImage("RGB_LED_img.jpg");
  guide_csd3_img = loadImage("ROTARY_POT_img.jpg");
  guide_joystick_img = loadImage("JOY_STICK_img.jpg");
  //PImage guide_csd1_img, guide_cds2_img, guide_cds3_img, guide_joystick_img;
}

private void menuImg() {
  image(csd1_img, (width*1)/12, (height*4.5)/8);
  image(csd2_img, (width*4.5)/12, (height*4.5)/8);
  image(csd3_img, (width*8)/12, (height*4.5)/8);
  image(servo_img, (width*2.5)/12, (height*12.5)/16);
  image(joystick_img, (width*6.5)/12, (height*12.5)/16);
}

private void clearCheeseSet() {

  cs.configSa(0, 0);
  cs.configSb(0, 0);
  cs.configSc(0, 0);
  cs.configLa(0, 0);
  cs.configLb(0, 0);
  cs.configLc(0, 0);
  cs.configM(0, 0, 0);
  cs.outSa = 0;
  cs.outSb = 0;
  cs.outSc = 0;
  cs.outLa = 0;
  cs.outLb = 0;
  cs.outLc = 0;
  cs.outMab = 0;
  cs.outMcd = 0;
  cs.detachPID();

  cs.detachHAT();
}
