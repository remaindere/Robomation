

import g4p_controls.*;

Cheese cheese;
NEO_LED neo;

GCustomSlider br, col_r, col_g, col_b;

boolean[] led_state = new boolean[8];
int[][] led_color = new int[8][3];
int index = 0;  
  
public void setup(){
  size(750,400,JAVA2D);
  cheese = new Cheese(this);
  neo = new NEO_LED(cheese, NEO_MODE_5, NEO_CHIP_RGB); // mode:3[max-9 led], chip:0[RGB] 
  
  br = new GCustomSlider(this, 75, 350, 300, 10);
  br.setRotation(-PI/2);
  br.setValue(0.1);
  br.setEasing(5);
  col_r = new GCustomSlider(this, 525, 350, 300, 10);
  col_r.setRotation(-PI/2);
  col_r.setValue(0);
  col_r.setEasing(5);
  col_g = new GCustomSlider(this, 600, 350, 300, 10);
  col_g.setRotation(-PI/2);
  col_g.setValue(0);
  col_g.setEasing(5);
  col_b = new GCustomSlider(this, 675, 350, 300, 10);
  col_b.setRotation(-PI/2);
  col_b.setValue(0);
  col_b.setEasing(5);
}

public void draw(){
  background(230);
  
  /////////////////////////ellipse(neopixel device outline)/////////////
  noFill();
  stroke(0);
  strokeWeight(5);
  ellipse(300,200, 300, 300); //out circle
  ellipse(300,200, 150, 150); //inner circle
  
  /////////////////////////leds////////////////////
  noFill();
  stroke(0);
  strokeWeight(2);
  
  quadColor(0);
  quad(275,290, 325,290, 325,340, 275,340); // 0 led
  
  quadColor(1);
  quad(220,245, 255,280, 220,315, 185,280); // 1 led
  
  quadColor(2);
  quad(165,175, 215,175, 215,225, 165,225); // 2 led
  
  quadColor(3);
  quad(220,85, 255,120, 220,155, 185,120); // 3 led (1 led +=ypos(220])
  
  quadColor(4);
  quad(275,65, 325,65, 325,115, 275,115); // 4 led (0 led -=ypos[225])
  
  quadColor(5);
  quad(380,85, 415,120, 380,155, 345,120); // 5 led (3 led +=xpos[160])
  
  quadColor(6);
  quad(385,175, 435,175, 435,225, 385,225); // 6 led (2 led +=xpos[220])
  
  quadColor(7);
  quad(380,245, 415,280, 380,315, 345,280); // 7 led (1 led +=xpos[160])
  
  /////////////////////////clear rect///////////////////////////
  noFill();
  stroke(0);
  strokeWeight(2);
  rect(270,170,60,60);
  
  /////////////////////////text////////////////// ypos 25, 375
  fill(0);
  textAlign(CENTER, CENTER);
  textSize(20);
  text("NEOPixel_Rainbow-8", 300,25);
  
  text("Clear", 300,200);
  
  text("Brightness",80,25);
  text(int(br.getValueF()*255),80,375);
  
  text("R",530,25);
  text(int(col_r.getValueF()*255),530,375);
  
  text("G",605,25);
  text(int(col_g.getValueF()*255),605,375);
  
  text("B",680,25);
  text(int(col_b.getValueF()*255),680,375);
}


public void loop(){ // syncronized loop
  neo.setRange(index,index);
  if(led_state[index] == true){
    neo.fill(led_color[index][0],led_color[index][1],led_color[index][2]);
  }
  else{
    neo.fill(0,0,0);
  }
  neo.setBrightness(int(br.getValueF()*255));
  neo.show(cheese);
  
  index++;
  if(index==8) index=0; // we can't use for statement in (roboid timed)loop, because it's unsyncronous.
}


public void quadColor(int i){
  if(led_state[i] == true) fill(led_color[i][0],led_color[i][1],led_color[i][2]);
  else noFill();
}


public void led_Matrix_Handler(int i){
  if(col_r.getValueF() == 0 && col_g.getValueF() == 0 && col_b.getValueF() == 0) return;
  
  if(led_state[i] == true) led_state[i] = false;
  else{
    led_color[i][0] = int(col_r.getValueF()*255);
    led_color[i][1] = int(col_g.getValueF()*255);
    led_color[i][2] = int(col_b.getValueF()*255);
    led_state[i] = true;
  }    
}


public void mousePressed(){
  if(275 < mouseX && mouseX < 325 && 290 < mouseY && mouseY < 340){ // 0 led
    led_Matrix_Handler(0);
  }
  else if(185 < mouseX && mouseX < 255 && 245 < mouseY && mouseY < 315){ // 1 led
    led_Matrix_Handler(1);
  }
  else if(165 < mouseX && mouseX < 215 && 175 < mouseY && mouseY < 225){ // 2 led
    led_Matrix_Handler(2);
  }
  else if(185 < mouseX && mouseX < 255 && 85 < mouseY && mouseY < 155){ // 3 led
    led_Matrix_Handler(3);
  }
  else if(275 < mouseX && mouseX < 325 && 65 < mouseY && mouseY < 115){ // 4 led
    led_Matrix_Handler(4);
  }
  else if(345 < mouseX && mouseX < 415 && 85 < mouseY && mouseY < 155){ // 5 led
    led_Matrix_Handler(5);
  }
  else if(385 < mouseX && mouseX < 435 && 175 < mouseY && mouseY < 225){ // 6 led
    led_Matrix_Handler(6);
  }
  else if(345 < mouseX && mouseX < 415 && 245 < mouseY && mouseY < 315){ // 7 led
    led_Matrix_Handler(7);
  }
  else if(270 < mouseX && mouseX < 330 && 170 < mouseY && mouseY < 230){ // clear
    clear();
  }
}


public void clear(){
  for(int i = 0; i < 8; i++){
    led_state[i] = false;
    for(int j = 0; j < 3; j++){
      led_color[i][j] = 0;
    }
  }
  br.setValue(0.1);
  col_r.setValue(0);
  col_g.setValue(0);
  col_b.setValue(0);
}
