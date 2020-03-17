import gifAnimation.*;

GifMaker gifExport;

int xspacing = 5;   // How far apart should each horizontal location be spaced
int w;              // Width of entire wave

int frames = 0;
int totalFrames = 120;
float pos = 0;
float wave1Theta = 0.0;  // Start angle at 0
float wave2Theta = 60.0;  // Start angle at 60 degrees
int color1 = 200;
int color2 = 100; 
float amplitude = 25;  // Height of wave
float period = 100.0;  // How many pixels before the wave repeats
float dx;  // Value for incrementing X, a function of period and xspacing
float[] yvalues;  // Using an array to store height values for the wave

void setup() {
  smooth();
  gifExport = new GifMaker(this, "export.gif", 100);
  gifExport.setRepeat(0);
  
  size(750, 200);
  w = width+5;
  dx = (TWO_PI / period) * xspacing;
  yvalues = new float[w/xspacing];
}

void draw() {
  background(0);
  calcWave(wave1Theta);
  renderWave(color1);
  calcWave(wave2Theta);
  renderWave(color2);
  export();
}

void calcWave(float theta) {
  pos += 0.5;
  // Increment theta (try different values for 'angular velocity' here
  //theta += 0.02;

  // For every x value, calculate a y value with sine function
  float x = theta;
  for (int i = 0; i < yvalues.length; i++) {
    yvalues[i] = sin(x)*amplitude + sin(x+pos);
    x+=dx;
  }
}

void renderWave(int shade) {
  noStroke();
  fill(shade);
  // A simple way to draw the wave with an ellipse at each location
  for (int x = 0; x < yvalues.length; x++) {
    square(x*xspacing, (float)height/2+yvalues[x], 5);
  }
}

void export() {
  if(frames < totalFrames) {
    gifExport.setDelay(20);
    gifExport.addFrame();
    frames++;
  } else {
    gifExport.finish();
    frames++;
    println("gif saved");
    exit();
  }
}
