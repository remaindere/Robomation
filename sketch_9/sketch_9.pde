
Cheese cs;
PID_12 pid;

import controlP5.*;
ControlP5 cp5;
PImage logo;

PFont lcdFont;
PFont pf;

String title =  "Temperature Sensor Test";
 
float fahrenheit;

//temp sensor uses "La" port.
public void setup()
{
  size(490, 490, JAVA2D);
  
  // Place your setup code here
  cs = new Cheese(this);
  delay(100);  // attach NULL device for reset
  
  pid = new PID_12(cs);
  logo = loadImage("logo.png");
  lcdFont = createFont("Arial",65);
  pf = createFont("Gadugi bold", 20);
   
}

public void draw(){
  background(255);
  //title//
  textFont(pf,36);
  textAlign(CENTER);
  fill(0,255,0);
  text(title, width/2 , height*0.1);
  
  //**************************box GUI***************************//
  fill(255);
  stroke(0);
  rect(20,90,450,330,50);
  
  
  fill(220);
  rect(40,110,410,240,25);
  
  fill(0);
  strokeWeight(5);
  line(40,235,450,235);
  
  textFont(lcdFont);
  textAlign(CENTER);
  
  //println(pid.temperature);
  
  fahrenheit = pid.temperature*9/5+ 32;

  String temperature = String.format("%.2f", pid.temperature);
  text(temperature,220,200);
  textFont(lcdFont, 35);
  text("°C", 410,200);

  String fahrenheit_str = String.format("%.2f", fahrenheit);
  textFont(lcdFont,65);
  text(fahrenheit_str,220,320);
  textFont(lcdFont,35);
  text("°F",410,320);
  
  image(logo,width/2-70,360);
  
  textSize(25);
  text("Temperature sensor uses La port.",width/2,470);
//******************************end of box GUI****************//
}
