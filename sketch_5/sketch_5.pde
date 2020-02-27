import controlP5.*;

ControlP5 cp5;
PID_16 pid;
Cheese cheese;

void setup() {
  size(250, 280);

  cheese = new Cheese(this);
  pid = new PID_16(cheese);
  cheese.attachPID(pid);

  cp5 = new ControlP5(this);

  cp5.addSlider("Encoder Value")
     .setSize(20, 100)
     .setPosition(50, 100)
     .setRange(0, 255)
     .setSliderMode(Slider.FLEXIBLE)
     ;

  cp5.addSlider("State Of Switch")
     .setSize(20, 100)
     .setPosition(150, 100)
     .setRange(0, 1)
     .setNumberOfTickMarks(2)
     ;

  cp5.addTextlabel("label")
     .setText("ROBOMATION")
     .setPosition(160, 260)
     .setColorValue(0xffffff00)
     .setFont(createFont("Georgia", 10))
     ;
}

void draw() {
  background(0);

  textSize(20);
  text("Encoder_Tester", 40, 50);

  textSize(10);
  text("0.00 = Off   1.00 = On", 100, 230);

  cp5.getController("Encoder Value").setValue(pid.count);

  if (pid.button == 0) cp5.getController("State Of Switch").setValue(0);
  else cp5.getController("State Of Switch").setValue(1);
}
