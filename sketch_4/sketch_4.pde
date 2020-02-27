import controlP5.*;

ControlP5 cp5;
Cheese cheese;

float voltage = 0;
float tempdata = 0;

public void setup() {
  size(500, 360, JAVA2D);

  cheese = new Cheese(this);  
  cheese.configLa(ANALOG_IN, ADC_VCC);
  cheese.configLb(DIGITAL_IN, PULL_UP_50K);

  cp5 = new ControlP5(this);
  cp5.addKnob("Dial Knob", 0, 100, 0, 200, 50, 100)
     .setFont(createFont("arial", 20))
     ;
}

public void draw() {
  background(255);
  fill(0);

  stroke(128);
  strokeWeight(1.5);

  Knob_Percentage_Print(255-cheese.inputLa);  

  textSize(30);
  text("Voltage : "+voltage+"/4V", 100, 200);
  text("Digital : "+cheese.inputLb, 100, 250);

  textSize(20);
  if (cheese.powerState==0) text("Supply Voltage : Normal", 100, 300);
  else if (cheese.powerState==1) text("Supply Voltage : Low", 100, 350);
  else if (cheese.powerState==2) text("Supply Voltage : Very Low", 100, 350);
}

public void loop() 
{
  println("Supply Voltage : " + (cheese.battery / 10 - 200));
  tempdata = 255 - cheese.inputLa;
  voltage = (float) tempdata * 4 / 256;
}

void Knob_Percentage_Print(float num) {
  float Pnum = num/255*100;
  cp5.getController("Dial Knob").setValue(Pnum);
}
