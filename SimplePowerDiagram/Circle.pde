class Circle{
  PVector center;
  float r;
  Polygon polygon;
  boolean disable;
  color col;
  
  Circle(PVector center, float r){
    this.col = color(basehue, random(100), 100);
    this.center = center;
    this.r = r;
  }
  
  PVector[] getRadicalAxis(Circle other){
    PVector dir = PVector.sub(other.center, center);
    float dist = dir.mag();
    dir.div(dist);//same as normalize
    float dist1;
    
    if (r == other.r){
      dist1 = dist / 2;
    }else{
      dist1 = (dist*dist + r*r - other.r*other.r) / (2*dist);
    }
    
    PVector[] result = new PVector[2];
    result[0] = PVector.add(center, PVector.mult(dir, dist1));
    result[1] = new PVector(result[0].x - dir.y, result[0].y + dir.x);
    return result;
  }
  
  void show(){
    if(disable)fill(0, 50);
    else fill(col, 50);
    ellipse(center.x, center.y, r*2, r*2);
    fill(col, 100);
    polygon.show();
  }
}
