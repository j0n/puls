// All Examples Written by Casey Reas and Ben Fry
// unless otherwise stated.
int xspacing = 18;   // How far apart should each horizontal location be spaced
int w;              // Width of entire wave

float theta = 0.0;       // Start angle at 0
float period = 1500.0;    // How many pixels before the wave repeats
float dx;                 // Value for incrementing X, to be calculated as a function of period and xspacing
float[] yvalues;          // Using an array to store height values for the wave (not entirely necessary)
float change = 5;
var k = 0;
var treshold = 10;
var currentPersCount = 0;

void setup() {
   var db = document.body;
   var dde = document.documentElement;
     
   var docWidth = Math.max(db.scrollWidth, dde.scrollWidth, db.offsetWidth, dde.offsetWidth, db.clientWidth, dde.clientWidth)
  size(docWidth-3, 500);
  frameRate(30);
  smooth();
  w = width+16;
  dx = (TWO_PI / period) * xspacing;
  yvalues = new float[w/xspacing];
}

void draw() {
  if(currentPersCount != persCount && persCount != 0){
      currentPersCount = persCount;
      change = k > 0 ? -(currentPersCount*0.9) : currentPersCount*0.9;
  }
  background(0);

  if(currentPersCount == 0){ currentPersCount = 1;}
  treshold = currentPersCount * 5;

  if(k > treshold){
    change = -(currentPersCount*0.3);
    k = treshold;
  }
  else if(k < -(treshold)){
    change = (currentPersCount*0.3);
    k = -treshold;
  }
  else{
     k = k + change;
  }
  var speed = (currentPersCount)*2/10000;
  var yT = currentPersCount/100;//y treshold
  for(var i = 0;i<10;i++){
      calcWave(speed*i, k+100+(i*10));
      renderWave();
  }
}
void drawCurv(){

}

void calcWave(v, amp) {
  theta += v;
  float x = theta;
  for (int i = 0; i < yvalues.length; i++) {
    yvalues[i] = sin(x)*amp-220;
    x+=dx;
  }
}

void renderWave() {
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

