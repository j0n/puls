// All Examples Written by Casey Reas and Ben Fry
// unless otherwise stated.
int xspacing = 8;   // How far apart should each horizontal location be spaced
int w;              // Width of entire wave

float theta = 0.0;       // Start angle at 0
float amplitude = 75.0;  // Height of wave
float period = 500.0;    // How many pixels before the wave repeats
float dx;                 // Value for incrementing X, to be calculated as a function of period and xspacing
float[] yvalues;          // Using an array to store height values for the wave (not entirely necessary)
float change = 5;
var k = 0;
var treshold = 100;

void setup() {
  size(1200,1200);
  frameRate(50);
  
  smooth();
  w = width+16;
  dx = (TWO_PI / period) * xspacing;
  yvalues = new float[w/xspacing];
}

void draw() {
  background(0);
  if(k > treshold){
    change = -5;
  }
  else if(k < -(treshold*2)){
      change = 5;
  }
   k = k + change;
   
    for(var i = 0;i<10;i++){
      calcWave(0.0009*i, 0.0+k+(i*15));
      renderWave(i);
    }
}

void calcWave(v, amp) {

  // Increment theta (try different values for 'angular velocity' here
  theta += v;
  // For every x value, calculate a y value with sine function
  float x = theta;
  for (int i = 0; i < yvalues.length; i++) {
    yvalues[i] = sin(x)*amp;
    x+=dx;
  }
}

void renderWave() {
  // A simple way to draw the wave with an ellipse at each location
  for (int x = 0; x < yvalues.length; x++) {
    noStroke();
    var i = mouseX/4;
    i = Math.floor(i);
    colorMode(RGB,30,i,255,100);
    fill(i,i,i,30);
    ellipseMode(CENTER);
    ellipse(x*xspacing,width/2+yvalues[x],16,16);
  }
}

