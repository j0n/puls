int xspacing = 10;   // How far apart should each horizontal location be spaced
int w;              // Width of entire wave

float theta = 0.0;       // Start angle at 0
float period = 1500.0;    // How many pixels before the wave repeats
float[] yvalues;          // Using an array to store height values for the wave (not entirely necessary)
var currentPersCount = 0;
var curves = {};

void setup() {
   var db = document.body;
   var dde = document.documentElement;
   var docWidth = Math.max(db.scrollWidth, dde.scrollWidth, db.offsetWidth, dde.offsetWidth, db.clientWidth, dde.clientWidth)

  size(docWidth, 300);
  frameRate(30);
  smooth();
  w = width+16;
  yvalues = new float[w/xspacing];
}


void draw() {
  background(255,255,255);
	for(var c in curves){
		calculateCurve(c);
	}
}
void addCurve(key, count,c){
	curves[key] = {
        'current':count,
        'kk':0,
        'color':c,
        'theta':0.00,
        'yvalues':new float[w/xspacing]
    };
    updateCurve(key, count);
}
void calculateCurve(key){
  var c = curves[key];
  var k = c.kk;

  if(k > c.threshold){
    c.change = -(c.count*0.3);
    k = c.threshold;
  }
  else if(k < -(c.threshold)){
    c.change = (c.count*0.3);
    k = -c.threshold;
  }
  else{
     k = k + c.change;
  }

  for(var i = 0;i<10;i++){
      calcWave(c,c.speed*i, k+(i*(c.count*0.4)));
      renderWave(c);
  }
  c.kk = k;
}

void updateCurve(key, count){
    
    count = (count+1)*2;
    var c = curves[key];
    c.count = count;
    c.threshold = count  + Math.floor(Math.random()*10);
    c.speed = count/1000;
    c.period = 700 + (count * 70) + Math.floor(Math.random()*1000);
    c.dx = (TWO_PI / c.period) * xspacing;
    c.change = c.change > 0 ? -(count*0.4) : count*0.4;
    c.alpha = count < 10 ? 30 : 40;
}

void calcWave(c,v, amp) {
  c.theta += v;
  float x = c.theta;
  for (int i = 0; i < yvalues.length; i++) {
    yvalues[i] = sin(x)*amp-420;
    x+=c.dx;
  }
}

void renderWave(c) {
    //console.log(c);
  for (int x = 0; x < yvalues.length; x++) {
    noStroke();
    colorMode(RGB,255,255,255,255);
    fill(c.color,c.alpha);
    ellipseMode(CENTER);
    ellipse(x*xspacing,width/2+yvalues[x],10,10);
  }
}
window.addCurve = addCurve;
window.updateCurve = updateCurve;
window.puls.init();
