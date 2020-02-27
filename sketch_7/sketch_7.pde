
Cheese cheese;
PID_11 pid;

import controlP5.*;
import g4p_controls.*;

Knob Humidity;
Knob Temperature;
Slider Thermometer;
Slider Hygrometer;
ControlP5 cp5;
controlP5.Button b;

GCScheme GCScheme;
GButton DHT__11, DHT__21, DHT__22;

float cx, y;
int cnt;
int myColorBackground = color(0, 0, 0);
int knobValue = 100;
int DHT_flag; // 0 = DHT_11, 1 = DHT_21, 2 = DHT_22;
int select_x_loc=50, select_y_loc;
int status_x_loc=240, status_y_loc=200;

boolean isOpen;

PImage logo;
PImage IMG11;
PImage IMG21;
PImage IMG22;

PFont pf;
PFont fontBold;
PFont buttonFont;
PFont lcdFont;
PFont myFont;
String title_1 = "Temperature & Humidity";
String title_2 = "Sensor Test";
String title_3 = "ROBOMATION";

public void setup()
{
  size(700, 400, JAVA2D);

  cp5 = new ControlP5(this);
  cheese = new Cheese(this);

  delay(100);  // attach NULL device for reset

  pid = new PID_11(cheese, DHT_11, 1);// default sensor = DHT_11

  GCScheme.makeColorSchemes();
  GCScheme.changePaletteColor(8, 3, color(0, 0));
  GCScheme.savePalettes(this);

  logo = loadImage("logo.png");
  IMG11 = loadImage("DHT_11.png");
  IMG21 = loadImage("DHT_21.png");
  IMG22 = loadImage("DHT_22.png");
  IMG11.resize(79, 79);
  IMG21.resize(79, 79);
  IMG22.resize(79, 79);

  cx = width/2;
  y = height*0.9;

  lcdFont = createFont("Arial", 45);
  pf = createFont("Arial", 20);
  fontBold = createFont("Arial", 20);
  buttonFont = createFont("Arial", 17, true);
  myFont = createFont("맑은 고딕", 32);

  smooth();
  noStroke();

  //*******************button*******************//
  //cp5.addButton("toggle")
  //   .setValue(10)
  //   .setPosition(280,90)
  //   .setSize(60,30)
  //   .setId(1);

  //b = cp5.addButton("movingButton")
  //       .setValue(10)
  //       .setPosition(300,140)
  //       .setSize(25,25)
  //       .setId(2)
  //       .setColorForeground(color(255))
  //       .setColorBackground(color(255));

  // change the font and content of the captionlabels 
  // for both buttons create earlier.
  //cp5.getController("toggle")
  //   .getCaptionLabel()
  //   .setFont(buttonFont)
  //   .toUpperCase(false)
  //   .setSize(12)             // this is text size
  //   ;

  //b.getCaptionLabel()
  // .setFont(buttonFont)
  // .setSize(10)              // this is text size
  // .toUpperCase(false)
  // .setText("")
  // ;
  // adjust the location of a caption label using the 
  //// style property of a controller.
  //b.getCaptionLabel().getStyle().marginLeft = 0;
  //b.getCaptionLabel().getStyle().marginTop = 40;

  DHT__11 = new GButton(this, select_x_loc, 100, 80, 80);
  DHT__11.useRoundCorners(false);
  DHT__11.setLocalColor(4, color(255, 0)); // background color_mouse off(4), color 255/ completely-transparent(0)
  DHT__11.setLocalColor(6, color(192, 128)); // background color_mouse over
  DHT__11.setLocalColor(14, color(128, 128)); // background color_mouse click-on
  DHT__21 = new GButton(this, select_x_loc, 200, 80, 80);
  DHT__21.useRoundCorners(false);
  DHT__21.setLocalColor(4, color(255, 0)); // background color_mouse off(4), color 255/ completely-transparent(0)
  DHT__21.setLocalColor(6, color(192, 128)); // background color_mouse over
  DHT__21.setLocalColor(14, color(128, 128)); // background color_mouse click-on
  DHT__22 = new GButton(this, select_x_loc, 300, 80, 80);
  DHT__22.useRoundCorners(false);
  DHT__22.setLocalColor(4, color(255, 0)); // background color_mouse off(4), color 255/ completely-transparent(0)
  DHT__22.setLocalColor(6, color(192, 128)); // background color_mouse over
  DHT__22.setLocalColor(14, color(128, 128)); // background color_mouse click-on

  //*****************end of gui button******************//



  //******************setting of seneor data**************//
  //Humidity = cp5.addKnob("Humidity")
  //  .setFont(createFont("Calibri", 15))
  //  .setRange(0, 100)
  //  .setValue(0)
  //  .setPosition(20, 110)
  //  .setRadius(40)
  //  .setDragDirection(Knob.VERTICAL)
  //  .setColorCaptionLabel(color(255))
  //  .setColorForeground(color(0, 0, 255))
  //  .setColorBackground(color(0, 0, 70))
  //  ;

  //Temperature = cp5.addKnob("Temperature")
  //  .setFont(createFont("Calibri", 15))
  //  .setRange(-100, 100)
  //  .setValue(0)
  //  .setPosition(20, 230)
  //  //.setPosition(20, 240)
  //  .setRadius(40)
  //  .setDragDirection(Knob.VERTICAL)
  //  .setColorCaptionLabel(color(255))
  //  .setColorForeground(color(255, 0, 0))
  //  .setColorBackground(color(70, 0, 0))
  //  .setColorActive(color(255,100,100))
  //  ;

  //Hygrometer = cp5.addSlider("Hygrometer")
  //  .setPosition(50, 240)
  //  .setSize(20, 80)
  //  .setRange(0, 100)
  //  //.setNumberOfTickMarks(5)
  //  .setFont(createFont("Calibri", 15))
  //  .setColorCaptionLabel(color(255))
  //  .setColorForeground(color(0, 0, 255))
  //  .setColorBackground(color(0, 0, 70))
  //  //cp5.getController("Hygrometer").getValueLabel().align(ControlP5.LEFT, ControlP5.BOTTOM_OUTSIDE).setPaddingX(0);
  //  //cp5.getController("Hygrometer").getCaptionLabel().align(ControlP5.LEFT, ControlP5.BOTTOM_OUTSIDE).setPaddingX(0);
  //  ;

  //Thermometer = cp5.addSlider("Thermometer")
  //  .setPosition(210, 240)
  //  .setSize(20, 80)
  //  .setRange(-100, 100)
  //  .setFont(createFont("Calibri", 15))
  //  .setColorCaptionLabel(color(255))
  //  .setColorForeground(color(255, 0, 0))
  //  .setColorBackground(color(70, 0, 0))
  //  .setColorActive(color(255,100,100));
  //  cp5.getController("Thermometer").getCaptionLabel().align(ControlP5.CENTER, ControlP5.BOTTOM_OUTSIDE).setPaddingX(0);
}

public void draw() {
  background(ControlP5.BLACK);
  //*********************right box(indicator)********************//
  fill(ControlP5.WHITE);
  stroke(0);
  rect(350, 90, 320, 300, 50);

  fill(220);
  stroke(0);
  rect(370, 110, 280, 210, 25);

  fill(0);
  strokeWeight(5);
  line(370, 215, 650, 215);

  textFont(lcdFont);
  textAlign(CENTER);
  fill(ControlP5.BLACK);
  //System.out.println(Float.parseFloat(String.format("%.2f",pid.humidity)));
  //text(Float.parseFloat(String.format("%.2f",pid.humidity)),500,170);

  String num = String.format("%.1f", pid.temperature);
  text(num, 480, 180);
  textFont(lcdFont, 30);
  text("°C", 620, 180);

  String num2 = String.format("%.1f", pid.humidity);
  textFont(lcdFont);
  text(num2, 480, 280);
  textFont(lcdFont, 30);
  text("%", 620, 280);

  image(logo, 440, 330); // robomation logo
  //**********************end of right box*******************//

  ////////////////////////////////////////////text/////
  //float x = Button.x(b.getPosition());
  ////x += ((isOpen==true ? 0:-200) - x) * 0.2;;
  //float y = Button.y(b.getPosition());
  //y += ((isOpen==true ? 140:+270) - y)*0.15;   //0.15 is selecting speed, 140 to 270 is selecting range of moving
  //b.setPosition(x,y);

  textFont(pf, 24);
  textAlign(CENTER);
  fill(255, 255, 0);
  text(title_1, cx, height*0.1); // cx = width/2
  text(title_2, cx, height*0.2);

  /////////////DHT_ image / button //////////////////////////
  //textFont(pf,16);
  textFont(myFont, 16);
  text("Select", select_x_loc+40, height*0.13);
  text("Sensor", select_x_loc+40, height*0.18);
  
  //센서 연결이 떨어지면 값 자체가 안들어오기 때문에 값은 유지. isActive -> false 
  //설정이 바뀌어도 패킷 자체 값은 유지. isActive -> false
  if ((pid.temperature==0&&pid.humidity==0)||pid.isActive()!= true) {
    if (DHT_flag == 0) text("DHT_11 \n연결 시도 중", status_x_loc, status_y_loc+30);
    if (DHT_flag == 1) text("DHT_21 \n연결 시도 중", status_x_loc, status_y_loc+30);
    if (DHT_flag == 2) text("DHT_22 \n연결 시도 중", status_x_loc, status_y_loc+30);

  } else {//연결 중 관련 코드 넣을 것.
    if (DHT_flag == 0) text("현재 장치\n DHT_11", status_x_loc, status_y_loc+30);
    if (DHT_flag == 1) text("현재 장치\n DHT_21", status_x_loc, status_y_loc+30);
    if (DHT_flag == 2) text("현재 장치\n DHT_22", status_x_loc, status_y_loc+30);
  }

  image(IMG11, select_x_loc, 100);
  image(IMG21, select_x_loc, 200);
  image(IMG22, select_x_loc, 300);
  textSize(10);
  text("DHT11", select_x_loc+42,190);
  text("DHT21", select_x_loc+42,190+100);
  text("DHT22", select_x_loc+42,190+200);
}

public void toggle() {
  //isOpen = !isOpen;
  //cnt++;
  //cp5.getController("toggle").setCaptionLabel((isOpen==true)? "Use Slider":"Use Knob");
}

/**@control called every BLE connection */
public void loop() 
{
  // TEST PID_11 
  //if(pid.isActive()) System.out.println(pid.humidity + ": " + pid.temperature);
  //println("설정 : "+cheese.outLa);
  //if(cnt%2 != 0){
  //Humidity.setValue(pid.humidity);
  //Temperature.setValue(pid.temperature); 
  //Hygrometer.setValue(0);
  //Thermometer.setValue(0);
  //}
  //else{
  //  Humidity.setValue(0);
  //  Temperature.setValue(0);
  //  Hygrometer.setValue(pid.humidity);
  //  Thermometer.setValue(pid.temperature);
  //}
}

public void handleButtonEvents(GButton button, GEvent event) {
  if (button == DHT__11) {
    pid = new PID_11(cheese, DHT_11, 1);
    DHT_flag = 0;
    delay(1000);
    pid.temperature=0;
    pid.humidity=0;
  } else if (button == DHT__21) {
    pid = new PID_11(cheese, DHT_21);
    DHT_flag = 1;
    delay(1000);
    pid.temperature=0;
    pid.humidity=0;
  } else if (button == DHT__22) {
    pid = new PID_11(cheese, DHT_22, 2);
    DHT_flag = 2;
    delay(1000);
    pid.temperature=0;
    pid.humidity=0;
  }
}
