boolean mouseIsBeingDragged = false;
int widthColorWheel = 288;
int heightColorWheel = 266;
int wheelInset = 10;
int pxlColor;
int selectedColor = color(255);
int colorToReplace = color(255);
int BLACK = color(0);
PImage img;

void setup() {
  size(600, 600);
  background(255);
  img = loadImage("colorSpectrumSmall.png");
}

void draw() {
  if (mouseIsBeingDragged) {
    strokeWeight(5);
    stroke(0);
    line(pmouseX, pmouseY, mouseX, mouseY);
  }
  image(img, 0, 0);
  noStroke();
  fill(selectedColor);
  float radiusColorSwatch = 15;
  float diameterColorSwatch = radiusColorSwatch * 1.5;
  ellipse(radiusColorSwatch, radiusColorSwatch, diameterColorSwatch, diameterColorSwatch);
}

boolean mouseInColorWheel() {
  return (mouseX < widthColorWheel && mouseY < heightColorWheel);
}

void mouseClicked() {
  if (mouseInColorWheel() ) {
    loadPixels();
    selectedColor = pixels[width * mouseY + mouseX];
  }
  fillPixels(mouseX, mouseY);
}

void mouseDragged() {
  mouseIsBeingDragged = true;
}

void mouseMoved() {
  mouseIsBeingDragged = false;
}

class Point {
  int x, y;

  Point(int x_, int y_) {
    x = x_; 
    y = y_;
  }
}


void fillPixels(int x, int y) {
  loadPixels();
  ArrayList<Point> pixelsToFill = new ArrayList<Point>();
  pixelsToFill.add(new Point(x, y));

  while (pixelsToFill.size () > 0) {
    Point point = pixelsToFill.get( 0);//pixelsToFill.size() - 1);
    int pxlIndex = point.y * width + point.x;
    int pxl = pixels[pxlIndex];
    if (pxl == BLACK ||pxl == selectedColor) {
      pixelsToFill.remove(point);
    } else {
      pixels[pxlIndex] = selectedColor;
      for (int dx = -1; dx < 2; ++dx) {
        for (int dy = -1; dy < 2; ++dy) {
          int x_ =point.x + dx;
          int y_ =point.y + dy;
          if (x_ >= 0 && x_ < width && y_>=0 && y_ < height) {
            if (x_ != 0 || y_ != 0) {
              int pxlToAddIndex = y_ * width + x_;
              int pxl_ = pixels[pxlToAddIndex];
              if (pxl_ != selectedColor) {
                pixelsToFill.add(new Point(x_, y_));
              }
            }
          }
        }
      }
    }
  }
  updatePixels();
}
