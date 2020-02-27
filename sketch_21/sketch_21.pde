
Cheese cheese;
HAT_050 hat;

int old_id;
PImage CARD;
PImage RFID;
String RFID_data = null;

public void setup()
{
  size(600, 400, JAVA2D);
  
  cheese = new Cheese(this);
  hat = new HAT_050(cheese);
  cheese.attachHAT(hat);

  RFID = loadImage("RFID.png");
  RFID.resize(200,300); // original size 211, 316
  CARD = loadImage("CARD.png");
  CARD.resize(168,72); // original size 139, 62
}

public void draw(){
  background(211,193,193);
  
  strokeWeight(2);
  line(0,height*1/8, width,height*1/8);
  line(width*1/2,height*1/8, width*1/2,height);
  line(0,height*1/8+175, width*1/2,height*1/8+175);
  fill(25);
  
  textAlign(CENTER, CENTER);
  textSize(30);
  text("RFID Tester",300, 25);
  if(hat.uid == 0){
    image(RFID, 350,75);
  }
  if(hat.uid != 0){ // RFID tagged
    image(CARD, 365,185);
  }
  
  textAlign(LEFT, CENTER);
  /////////////////////////decimal data////////////////////////
  textSize(25);
  text("Data",20, 75);
  
  textSize(20);
  text("Decimal", 20,120);
  text("Hexa_Decimal", 20,170);
  
  textSize(16);
  if(hat.uid == 0){
    text("NULL", 21,141);
    text("NULL", 21,191);
  }
  else{
    text(RFID_data,21,141);  // decimal data
    text(String.format("%x", hat.uid), 21,191);  // hexa data 
    
  }
/////////////////////////////8-bit cut data////////////////////////////
  textSize(25);
  text("8-bit Cut Data", 20,250);
  
  textSize(20);
  text("Decimal", 20,300);
  text("Hexa_Decimal", 20,350);
  
  textSize(16);
  if(hat.uid ==0){
    text("NULL", 21,321);
    text("NULL", 21,371);
  }
  else{
    for(int i=0; i< 4;i++){
      text(hat.s[i],21+i*40,371);   
      text(hat.s2[i],21+i*40,321);      
    }
  }
}  

public void loop() 
{
  delay(100); // next line should be excuted after serial comm. connection is estabilished [hat and cheese] 
  RFID_data = "" + hat.s2[0]+ hat.s2[1] + hat.s2[2]+ hat.s2[3];
  
  if(hat.id != old_id && hat.uid != 0){ // new RFID tag
    cheese.setSoundClip(BEEP);
  }
  else{ // other cases
    cheese.setSoundNote(MUTE);
  }
  old_id = hat.id; // current id save, in next loop it turns previous one.
}
