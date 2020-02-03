import org.roboid.cheese.*;
import org.roboid.hamster.*;
import org.roboid.master.*;
import org.roboid.robot.*;
import org.roboid.runtime.*;

import g4p_controls.*;
Cheese cheese;
HAT_010 hat;

GCustomSlider sli_br;
int [][] color_check = new int[5][5];
int color_flag;
boolean elevator_flag = true;
boolean button_A, button_B;

public void setup()
{ 
  size(300, 300, JAVA2D);

  cheese = new Cheese(this);
  hat = new HAT_010(cheese);
  cheese.attachHAT(hat);

  sli_br = new GCustomSlider(this, 265, 240, 200, 10);
  sli_br.setValue(0.04);
  sli_br.setRotation(-PI/2);
}

public void draw() {
  stroke(0);
  background(115, 160, 220);

  for (int i = 40; i < 250; i+=40) {
    line(40, i, 240, i); 
    line(i, 40, i, 240);
  }

  for (int i = 0; i < 5; i++) {
    for (int j = 0; j < 5; j++) {              
      if (color_check[i][j] == cheese.BLACK) fill(115, 160, 220);
      else if (color_check[i][j] == cheese.BLUE) fill(0, 0, 255);
      else if (color_check[i][j] == cheese.GREEN) fill(0, 255, 0);
      else if (color_check[i][j] == cheese.CYAN) fill(180, 225, 255);
      else if (color_check[i][j] == cheese.RED) fill(255, 0, 0);
      else if (color_check[i][j] == cheese.MAGENTA) fill(255, 0, 255); 
      else if (color_check[i][j] == cheese.YELLOW) fill(255, 255, 0);
      else if (color_check[i][j] == cheese.WHITE) fill(255, 255, 255);
      rect((i+1)*40, (j+1)*40, 40, 40);
    }
  }

  ///////////////////button & slider gui///////////////////
  fill(255);
  textSize(20);
  textAlign(LEFT, CENTER);
  text("Button A", 40, 250);
  text("Button B", 160, 250);
  textAlign(CENTER, CENTER);
  text(int(sli_br.getValueF()*255),270,250);
  text("Br",270,275);
  if (button_A) noFill();
  else fill(255);
  rect(70, 270, 20, 20);//A
  if (button_B) noFill();
  else fill(255);
  rect(190, 270, 20, 20);//B
}

public void loop() {
  hat.bright = int(sli_br.getValueF()*255); // set brightness of LED
  Bling();
  LED_state_update();
  button_A = boolean(hat.buttonA);
  button_B = boolean(hat.buttonB);
} 

public void execute() {
  Init();
}

public void Init() {  // initiate
  for (int i = 0; i < 5; i++) {
    for (int j = 0; j < 5; j++) {
      hat.led[i][j] = cheese.BLACK;
      color_check[i][j] = 0;
    }
  }
}



public void LED_state_update() {
  for (int i = 0; i < 5; i++) {
    for (int j = 0; j < 5; j++) {            
      hat.led[j][i] = color_check[i][j];
    }
  }
}

public void Bling() {
  for (int i = 0; i < 5; i++) {
    for (int j = 0; j < 5; j++) {
      switch(color_flag) {
      case 0: 
        color_check[i][j] = cheese.BLACK;
        break;
      case 1:
        color_check[i][j] = cheese.RED;
        break;
      case 2:
        color_check[i][j] = cheese.MAGENTA;
        break;
      case 3:
        color_check[i][j] = cheese.BLUE;
        break;
      case 4:
        color_check[i][j] = cheese.CYAN;
        break;
      case 5:
        color_check[i][j] = cheese.GREEN;
        break;
      case 6:
        color_check[i][j] = cheese.YELLOW;
        break;
      case 7:
        color_check[i][j] = cheese.WHITE;
        break;
      default:
        println("hit bottom");
        break;
      }
    }
  }
  if (color_flag==7 || color_flag == -1) elevator_flag = !elevator_flag;

  if (elevator_flag) color_flag++;
  else color_flag--;
}
