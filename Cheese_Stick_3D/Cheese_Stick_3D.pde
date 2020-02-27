
import shapes3d.*;
import shapes3d.animation.*;
import shapes3d.utils.*;

Cheese cheese;
Box box;

int sv_fall = 0; // fell T/F
/* Since Cheese Stick's free-fall ID memory is consisted of quaternaries, it overflows(3->0).
 so these two values were needed to detect falling state when its 4th fall.*/

boolean tap = false; // tap T/F
boolean cheese_fall = false; // falling T/F

FloatList rolllist = new FloatList();
FloatList pitchlist = new FloatList();
float rollsum = 0;
float pitchsum = 0;
float fallR = 0.0; // free-fall speed

//cheese stick - to use internal values on draw
int cheese_tap;
int cheese_gravity_X;
int cheese_gravity_Y;
int cheese_gravity_Z;
int cheese_freeFallId;


public class Rain { // tap effect
  float xpos;
  float ypos;

  float r=0;
  float r_random;

  float fo_value = 200; // raining existance value(255->white(vanishing)
  final float fo_speed; // fade-out speed
  final float max_r;

  boolean del = false;

  Rain() {
    xpos = 625;
    ypos = 175;
    max_r = 200;
    fo_speed = 2;
  }

  public void display() {
    noFill();
    stroke(0, fo_value);

    ellipse(xpos, ypos, r, r);
  }

  public void move() {
    r += fo_speed;
    fo_value = map(r, 0,max_r ,255,0);

    if (max_r < r) del = true;
  }
}

ArrayList<Rain> rains = new ArrayList<Rain>();

public void setup() {
  size(800, 600, P3D);

  cheese = new Cheese(this);  
  
  cheese.setGravity(0,0);
  //default value(0,0) //cheese.setGravity(0~7[bandwidth], 0~3[G_range])
  
  ///////////////////////////////box//////////////////////////
  box = new Box(this);
  String[] faces = new String[] { // texture set
    "xf.jpg", "xr.jpg", "yf.jpg", 
    "yr.jpg", "zf.jpg", "zr.jpg"
  };
  box.setTextures(faces);
  box.fill(color(255));
  box.stroke(color(255));
  box.strokeWeight(0.5);
  box.setSize(100, 50, 250);
  box.drawMode(S3D.TEXTURE | S3D.WIRE | S3D.SOLID);
  ///////////////////////////////////////////////////////////
  
  if (sv_fall != cheese.freeFallId) sv_fall = cheese.freeFallId;
}

public void draw() {
  background(255);

  textSize(30);
  fill(0);
  textAlign(CENTER);
  text("Cheese Stick 3D", width/2, 40);
  textAlign(LEFT);
  
  textSize(25);
  fill(0, 0, 255);
  text("TAP!", 600, 180);
  
  fill(0);
  line(0, 50, 800, 50);
  line(450, 50, 450, 600);
  line(450, 300, 800, 300);

  textSize(20);
  text("G_X: "+cheese_gravity_X, 500, 350);
  text("G_Y: "+cheese_gravity_Y, 500, 390);
  text("G_Z: "+cheese_gravity_Z, 500, 430);
  text("TapSign: "+tap, 500, 470);
  text("Fall: "+cheese_fall, 500, 510);
  text("FallId: "+cheese_freeFallId, 500, 550);
  
  pushStyle();
  tap();
  fall();
  popStyle();
  //box draw//
  box.moveTo(250,320+fallR,0);
  
  float pitch = atan(-cheese.gravity_Y/(sqrt(pow(cheese.gravity_X,2)+pow(cheese.gravity_Z,2))));
  float roll = atan(cheese.gravity_X/(sqrt(pow(cheese.gravity_Y,2)+pow(cheese.gravity_Z,2)))); //pitch & roll calc
  rollsum = calcSum(rollsum, rolllist, roll, 10);
  pitchsum = calcSum(pitchsum, pitchlist, pitch, 10); // for easing
  
  box.rotateToX(-pitchsum/rolllist.size()); // -pitch
  box.rotateToZ(rollsum/pitchlist.size()); // roll 
  //box.rotateBy(-pitchsum/rolllist.size()/10,0,rollsum/pitchlist.size()/10); rotateBy, its not real-time modeling
  box.draw();
  /////////
}

public void loop() {
  cheese_tap = cheese.tap;
  cheese_gravity_X = cheese.gravity_X;
  cheese_gravity_Y = cheese.gravity_Y;
  cheese_gravity_Z = cheese.gravity_Z;
  cheese_freeFallId = cheese.freeFallId;
}

public void tap() {
  if (cheese_tap>=1) {
    rains.add(new Rain());
    tap = true;
  }
  else {
    tap = false;
  }
  for (int i=0; i<rains.size(); i++) {
    Rain myRain = rains.get(i);

    myRain.display();
    myRain.move();

    if (myRain.del == true) rains.remove(i);
  }
}

public void fall() {
  if (cheese_freeFallId != sv_fall) { // fall occur
    fallR = 200.0; // set fall timer
    sv_fall = cheese_freeFallId;
  }
  
  if (fallR > 0) { //in state ~ fall
    cheese_fall = true;
    fallR -= 5;
  }
  else {
    cheese_fall = false;
  }
}

public float calcSum(float sum, FloatList list, float value, int num) { // for easing effect
    list.append(value);
    sum += value;
    if(list.size() > num) {
        sum -= list.remove(0);
    }
    return sum;
}
