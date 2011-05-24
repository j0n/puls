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

  size(docWidth-10, 500);
  frameRate(30);
  smooth();
  w = width+16;
  yvalues = new float[w/xspacing];
}


void draw() {
  background(0);
	for(var c in curves){
		calculateCurve(c);
	}
}
void addCurve(key, count,c){
	curves[key] = {
        'current':count,
        'kk':0,
        'color':c
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
      calcWave(c.speed*i, k+(i*(c.count*0.4)),c.dx);
      renderWave(c.color,c.alpha);
  }
  c.kk = k;
}

void updateCurve(key, count){
    console.log('update', count);
    count = (count+1)*3;
    var c = curves[key];
    c.count = count;
    c.threshold = count * 5;
    c.speed = count*2/30000;
    c.period = 700 + count * 170 + Math.floor(Math.random(10)*1000);
    c.dx = (TWO_PI / c.period) * xspacing;
    c.change = c.change > 0 ? -(count*0.9) : count*0.9;
    c.alpha = count < 10 ? 20 : 30;
}

void calcWave(v, amp, dx) {
  theta += v;
  float x = theta;
  for (int i = 0; i < yvalues.length; i++) {
    yvalues[i] = sin(x)*amp-220;
    x+=dx;
  }
}

void renderWave(c, a) {
    //console.log(c);
  for (int x = 0; x < yvalues.length; x++) {
    noStroke();
    colorMode(RGB);
    fill(c,a);
    ellipseMode(CENTER);
    ellipse(x*xspacing,width/2+yvalues[x],10,10);
  }
}
window.addCurve = addCurve;
window.updateCurve = updateCurve;
window.puls.init();
