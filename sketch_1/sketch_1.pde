Cheese cheese;

public void setup() {
  size(500, 500, JAVA2D);
  cheese = new Cheese(this);  
  cheese.configSa(DIGITAL_IN, PULL_UP_50K);
  fill(0);
  textSize(30);
}

public void draw() {
  background(255);
  println(cheese.inputSa);
  if (cheese.inputSa==1) _OFF();
  else _ON();
}

public void _ON() {
  text("Pressed", 150, 250);
  text("inputData : "+cheese.inputSa, 150, 300);
}


public void _OFF() {
  text("Released", 150, 250);
  text("inputData : "+cheese.inputSa, 150, 300);
}
