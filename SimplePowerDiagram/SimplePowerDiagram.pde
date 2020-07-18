//based on this code https://github.com/elemel/empower
//we can calculate voronoi diagram in convex polygon
float basehue;
PowerDiagram pd;
int n = 100;

void setup(){
  size(500, 500);
  //fullScreen();
  colorMode(HSB, 360, 100, 100);
  Polygon basePolygon = new Polygon();
  for(int i=0; i<n; i++){
    float theta = map(i, 0, n, 0, TWO_PI);
    basePolygon.vertices.add(PVector.fromAngle(theta).mult(height/2).add(width/2, height/2));
  }
  pd = new PowerDiagram(basePolygon);
  
  strokeWeight(5);
}

void draw(){
  background(360);
  if(frameCount % 10 == 0){//circle sampling
    pd.addCircle(new Circle(PVector.fromAngle(random(TWO_PI)).mult(sqrt(random(1))*height/2).add(width/2, height/2), random(50)));
  }
  
  pd.show();
}

void keyPressed(){
  if(key == 'r'){
    basehue = random(360);
    Polygon basePolygon = new Polygon();
    for(int i=0; i<n; i++){
      float theta = map(i, 0, n, 0, TWO_PI);
      basePolygon.vertices.add(PVector.fromAngle(theta).mult(height/2).add(width/2, height/2));
    }
    pd = new PowerDiagram(basePolygon);
  }
}

void mousePressed(){
  pd.addCircle(new Circle(new PVector(mouseX, mouseY), random(50)));
}
