
import g4p_controls.*;

Cheese cheese;
PID_03 pid, newpid;

GCScheme GCScheme;
GTextField tx_tf;
GButton submit, start;
GOption atx, arx, atxbrx, arxbtx;
GToggleGroup pin_layout;
GCustomSlider baud_rate;

int pin_opt, baud_opt;
String Tx_text;
String Rx_text;
byte[] Rx_byte;
boolean isStart = false;
int sbm_t;

public void setup(){
  /////////////////////UI Setup./////////////////////
  size(500,650,JAVA2D);
  
  GCScheme.makeColorSchemes();
  GCScheme.changePaletteColor(8,3,color(0,0));
  GCScheme.savePalettes(this);
  G4P.setGlobalColorScheme(8); // black
  G4P.setInputFont("Dialog.plain", G4P.PLAIN, 20);
  
  tx_tf = new GTextField(this, 50,100,300,30);
  tx_tf.setLocalColorScheme(6);
  tx_tf.setPromptText("Write bytes");
  tx_tf.tag = "tx_tf";
 
  submit = new GButton(this, 350,99, 102.5,33);
  submit.useRoundCorners(false);
  submit.setLocalColor(4,color(192,64));
  submit.setLocalColor(6,color(192, 128)); 
  submit.setLocalColor(14,color(128, 128));
  
  atx = new GOption(this, 94,300, 15,15);
  arx = new GOption(this, 194,300, 15,15);
  atxbrx = new GOption(this, 294,300, 15,15);
  arxbtx = new GOption(this, 394,300, 15,15);
  pin_layout = new GToggleGroup();
  pin_layout.addControls(atx,arx,atxbrx,arxbtx);
  atx.setSelected(true);
  
  baud_rate = new GCustomSlider(this, 50,460, 400,50);
  baud_rate.setShowDecor(false, true, false, false);
  baud_rate.setNumberFormat(GCustomSlider.DECIMAL, 1);
  baud_rate.setLimits(0,0,7);
  baud_rate.setNbrTicks(8);
  baud_rate.setStickToTicks(true);
  
  start = new GButton(this, 200,550, 100,30);
  start.useRoundCorners(false);
  start.setLocalColor(4,color(192,64));
  start.setLocalColor(6,color(192, 128)); 
  start.setLocalColor(14,color(128, 128));


  tx_tf.setVisible(false);
  submit.setVisible(false);
}

public void draw(){
  background(255);
  fill(15);
  textSize(30);
  textAlign(CENTER, CENTER);
  text("L Port TXRX Test",width/2,15);
  

  ///////////////////////////////////////////////////
  ///////////////////go state////////////////////////
  ///////////////////////////////////////////////////
  if(isStart){
  ////////////////////////please////////////////////////
  fill(15);
  textAlign(CENTER, CENTER);
  textSize(30);
  text("If you want to change\nPin and Baud rate options,\nPlease restart program\n&\nreboot cheese stick.",width/2, height/1.5);
    
  
  ///////////////tx_tf highlight effects/////////////////////
  fill(15);
  strokeWeight(1);
  rect(49,99,301,31);
  
  ////////////////Rx text highlight
  noFill();
  strokeWeight(1);
  rect(50,170,400,30);
  
  ///////////////////////main texts//////////////////////////////
  fill(15);
  textAlign(LEFT, CENTER);
  textSize(25);

  text("Tx_Payload",50,80);
  text("Rx_Payload",50,150);

 
  ///////////////////////rx_byte print//////////////////////////
  fill(15);
  textSize(15);
  textAlign(LEFT, CENTER);
  
  if(Rx_byte!=null){
    Rx_text = new String(Rx_byte); 
    text(Rx_text,55,180);
  }
  else text("NULL",55,180);

  ///////////////////////submit button text//////////////////////////
  fill(15);
  textSize(15);
  textAlign(CENTER, TOP);
  text("Submit",400,106.5);

  //////////////////submit notification/////////////////
  fill(191,61,61);
  textSize(20);
  textAlign(CENTER, CENTER);
  if(sbm_t>0){
    text("Submitted.",405,80);
    sbm_t--;
  }
  
  //////////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////////
  }//isStart
  
  ////////////////////////////////////////////////////////////////
  //////////////////////////get set state//////////////////////////
  /////////////////////////////////////////////////////////////////
  else if(!isStart){
  ////////////////////////please////////////////////////
  fill(15);
  textAlign(CENTER, CENTER);
  textSize(30);
  text("Select Options and Press Start",width/2, height/5);
    
    
  //////////////"get set" state main texts////////////////////////
  fill(15);
  textAlign(LEFT, CENTER);
  textSize(25);
  text("Pin Layout",50,250);
  text("Baud Rate[K]",50,450);
  
  ////////////////////////Start button text///////////////////////
  fill(15);
  textAlign(CENTER, CENTER);
  textSize(20);
  text("Start",250,560);
  
  ///////////////////////Pin Layout_detail////////////////////////
  fill(15);
  textSize(20);
  textAlign(CENTER, CENTER);
  text("La = TX",100,350);
  text("La = RX",200,350);
  text("La = TX",300,350);
  text("Lb = RX",300,380);
  text("La = RX",400,350);
  text("Lb = TX",400,380);
  ///radio buttons boxes
  noFill();
  stroke(0);
  strokeWeight(1);
  rect(50,280, 400,50);
  rect(50,330, 400,80);
  line(150,280, 150,410);
  line(250,280, 250,410);
  line(350,280, 350,410);
  /////////////////////////baud Layout_detail//////////
  fill(15);
  textSize(20);
  textAlign(CENTER, CENTER);
  text("9.6",60,510);
  text("14.4",110,510);
  text("19.2",164,510);
  text("28.8",218,510);
  text("38.4",272,510);
  text("57.6",326,510);
  text("76.8",380,510);
  text("115.2",440,510);
  
    ////////////////////////////option set////////////////////////////
  if(atx.isSelected()) pin_opt = 0;
  else if(arx.isSelected()) pin_opt = 1;
  else if(atxbrx.isSelected()) pin_opt = 2;
  else if(arxbtx.isSelected()) pin_opt = 3;
  baud_opt = baud_rate.getValueI();
  
  //////////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////////
  }//!isStart

}//draw end

public void loop(){
  if(isStart){
    pid.send(Tx_text.getBytes());
    if(pid.isNew()) Rx_byte = pid.getBytes();
  }
}

public void init(){
  /////////////////////HW setup///////////////////////
  cheese = new Cheese(this);
  pid = new PID_03(cheese, pin_opt, baud_opt);
  delay(80);
  //g4p for test
  tx_tf.setVisible(true);
  submit.setVisible(true);
  
  //g4p for opt
  atx.setVisible(false);
  arx.setVisible(false);
  atxbrx.setVisible(false);
  arxbtx.setVisible(false);
  baud_rate.setVisible(false);
  start.setVisible(false);
  isStart = true;
}

public void handleButtonEvents(GButton button, GEvent event){
  if(button == submit){
    Tx_text = tx_tf.getText();
    tx_tf.setText("");
    sbm_t = 24;
  }
  else if(button == start){
    init();
  }
}

  
  //////////debugcodes///////////////////
  //println("tx text : "+Tx_text);
  //println(Rx_byte);
  //println("udt flag : "+udt_flag);
  //println("pid get : "+pid.getSimulacrum());
