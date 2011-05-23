int xspacing = 18;   // How far apart should each horizontal location be spaced
int w;              // Width of entire wave

float theta = 0.0;       // Start angle at 0
float period = 1500.0;    // How many pixels before the wave repeats
float dx;                 // Value for incrementing X, to be calculated as a function of period and xspacing
float[] yvalues;          // Using an array to store height values for the wave (not entirely necessary)
var currentPersCount = 0;
var curves = {};

void setup() {
   var db = document.body;
   var dde = document.documentElement;
   var docWidth = Math.max(db.scrollWidth, dde.scrollWidth, db.offsetWidth, dde.offsetWidth, db.clientWidth, dde.clientWidth)

  size(docWidth-3, 500);
  frameRate(30);
  smooth();
  w = width+16;
  yvalues = new float[w/xspacing];
	addCurve('solde',5, 1555, 200);
	addCurve('njutbar',25, 1600, 12);
	addCurve('kaffebar',1, 1500, 120);
}


void draw() {
  background(0);
	for(var c in curves){
		calculateCurve(c);
	}
}
void addCurve(key, count,p,c ){
	curves[key] = {'current':count, 'next': count, 'period':p, 'color':c};
}
void calculateCurve(key){
	var c = curves[key];
	var k, treshold,change, cp, p;
	var cp = c.next;
	var p = c.current;
	var pe = c.period;

  if(cp != p && p != 0){
      cp = p;
      change = k > 0 ? -(cp*0.9) : cp*0.9;
  }

  if(cp == 0){ cp = 1;}
  treshold = cp * 5;

  if(k > treshold){
    change = -(cp*0.3);
    k = treshold;
  }
  else if(k < -(treshold)){
    change = (cp*0.3);
    k = -treshold;
  }
  else{
     k = k + change;
  }
  var speed = (cp)*2/30000;
  var yT = cp/100;//y treshold
  dx = (PI / pe) * xspacing;
  for(var i = 0;i<10;i++){
      calcWave(speed*i, k+(i*(cp + 2)));
      renderWave(c.color);
  }
}

void calcWave(v, amp) {
  theta += v;
  float x = theta;
  for (int i = 0; i < yvalues.length; i++) {
    yvalues[i] = sin(x)*amp-420;
    x+=dx;
  }
}

void renderWave(i) {
  for (int x = 0; x < yvalues.length; x++) {
    noStroke();
    //var i = mouseX/4;
    i = Math.floor(i);
    colorMode(RGB,30,i,255,100);
    fill(i,i,i,30);
    ellipseMode(CENTER);
    ellipse(x*xspacing,width/2+yvalues[x],16,16);
  }
}

