void setup() {
  size(1280, 960);
  background(255);
}

void draw() {
fill(255, 25);
rect(0, 0, width, height);
  translate(width/2, height/2); 
  fill(0, 255, 0);
  noStroke();
  ellipse(cos(frameCount*.010)*width*0.4, cos(frameCount*.008)*height*0.4, 50, 50);
}
