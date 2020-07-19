//based on this code https://github.com/elemel/empower
//we can calculate voronoi diagram in convex polygon
float pCenter = 0.01;//power to center
float pAvoid = 0.05;//power to avoid other sphere;
int n = 50;//number of big circle vertices
float basehue;
PowerDiagram pd;
Polygon polygon;
ArrayList<Circle> circles = new ArrayList<Circle>();
ArrayList<Circle> circlesc = new ArrayList<Circle>();
boolean showCircle;

void setup(){
  size(500, 500);
  //fullScreen();
  colorMode(HSB, 360, 100, 100, 100);
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
  polygon.update();
  polygon.show();
  //for(Circle circle : circles){
  //  circle.update(circles, polygon);
  //}
  
  //pd.show();
}

void keyPressed(){
  if(key == 'r'){
    basehue = random(360);
    polygon.children = new ArrayList<Circle>();
  }
  if(key == 'c'){
    showCircle = !showCircle;
  }
}

void mousePressed(){
  if(mouseButton == LEFT){//add main cell
    polygon.children.add(new Circle(new PVector(mouseX, mouseY), random(60)));
  }
  if(mouseButton == RIGHT){//add sub cell
    if(polygon.children.size() > 0){
      for(Circle c : polygon.children){
        if(c.cpolygon.isInside(new PVector(mouseX, mouseY), 0)){
          c.cpolygon.children.add(new Circle(new PVector(mouseX, mouseY), random(20)));
        }
      }
    }
  }
}
