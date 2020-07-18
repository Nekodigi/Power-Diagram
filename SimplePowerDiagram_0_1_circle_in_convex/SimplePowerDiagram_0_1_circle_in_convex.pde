//based on this code https://github.com/elemel/empower
//we can calculate voronoi diagram in convex polygon
float pCenter = 0.01;//power to center
float pAvoid = 0.05;//power to avoid other sphere;
int n = 50;//number of big circle vertices
float basehue;
PowerDiagram pd;
Polygon polygon;
ArrayList<Circle> circles = new ArrayList<Circle>();
boolean showCircle;

void setup(){
  size(500, 500);
  //fullScreen();
  colorMode(HSB, 360, 100, 100);
  polygon = new Polygon();
  for(int i=0; i<n; i++){
    float theta = map(i, 0, n, 0, TWO_PI);
    polygon.vertices.add(PVector.fromAngle(theta).mult(height/2).add(width/2, height/2));
  }
  polygon.calcCentroid();
  
  strokeWeight(5);
}

void draw(){
  background(360);
  pd = new PowerDiagram(polygon, circles);
  if(frameCount % 10 == 0){//circle sampling
    circles.add(new Circle(PVector.fromAngle(random(TWO_PI)).mult(sqrt(random(1))*height/2).add(width/2, height/2), random(50)));
  }
  for(Circle circle : circles){
    circle.update(circles, polygon);
  }
  
  pd.show();
}

void keyPressed(){
  if(key == 'r'){
    basehue = random(360);
    circles = new ArrayList<Circle>();
  }
  if(key == 'c'){
    showCircle = !showCircle;
  }
}

void mousePressed(){
  pd.addCircle(new Circle(new PVector(mouseX, mouseY), random(100)));
}
