class Circle{
  PVector center;
  float r;
  Polygon cpolygon;
  boolean disable;
  color col;
  
  
  Circle(PVector center, float r){
    this.col = color(basehue, random(100), 100);
    this.center = center;
    this.r = r;
    this.cpolygon = new Polygon();
  }
  
  void update(ArrayList<Circle> others, Polygon polygon_){
    PVector toCenter = PVector.sub(polygon_.centroid, this.center);
    if(!polygon_.isInside(center, r))this.center.add(toCenter.mult(pCenter));
    for(Circle other : others){
      if(other != this){
        PVector dp = PVector.sub(other.center, this.center);
        float dst = dp.mag();
        float goalDst = (this.r + other.r);
        if(dst < goalDst){
          PVector targetPos = PVector.add(this.center, dp.setMag(goalDst));
          other.center = PVector.lerp(other.center, targetPos, pAvoid);
        }
      }
    }
    cpolygon.update();
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
  
  void show(boolean showCircle){
    fill(col, 100);
    cpolygon.show();
    if(disable)fill(0, 50);
    else fill(col, 50);
    if(showCircle)ellipse(center.x, center.y, r*2, r*2);
  }
}
