import processing.video.*;

Capture cam;
int h = 10;
int y = 0;
PImage[] history;
int historyIndex = 0;
int offset = 0;

void setup() {
  size(640, 480);
  String[] cameras = Capture.list();
  if (cameras.length == 0) exit();
  cam = new Capture(this, cameras[0]);
  history = new PImage[height/h];
  for (int i=0; i<history.length; i++)  history[i] = createImage(width, height, RGB);
  cam.start();
  background(0);
}

void captureEvent(Capture cam) {
 cam.read(); 
 history[historyIndex].copy(cam,0,0,width,height,0,0,width,height);
 historyIndex = (historyIndex + 1) % history.length;
}

void draw() {
  frameRate(15);
  for (int i=0; i<history.length; i++) {
    int y = i*h;
    int currentIndex = (i + offset) % history.length;
    copy(history[currentIndex], 0,y,width,h, 0,y,width,h);
  }
  offset++;
}
