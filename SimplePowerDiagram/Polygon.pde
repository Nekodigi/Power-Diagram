class Polygon{//calculate cell like cutting off the protruding part. 
  ArrayList<PVector> vertices = new ArrayList<PVector>();
  
  Polygon(){}
  
  Polygon(ArrayList<PVector> vertices){
    this.vertices = vertices;
  }
  
  Polygon clone(){
    return new Polygon(vertices);
  }
  
  void clip(PVector A, PVector B){//clip with AB
    ArrayList<PVector> Nvertices = new ArrayList<PVector>();//new vertices
    if(vertices.size() != 0){
    PVector prevV = vertices.get(vertices.size()-1);//previous point(start of testing edge)
    
    for(int i=0; i<vertices.size(); i++){
      PVector v = vertices.get(i);//end of testing edge
      
      if(isPointInside(v, A, B)){
        if(!isPointInside(prevV, A, B)){//when across line
          PVector ipos = intersection(prevV, v, A, B);
          Nvertices.add(ipos);
        }
        Nvertices.add(v);
      }else{
        if(isPointInside(prevV, A, B)){//when across line
          PVector ipos = intersection(prevV, v, A, B);
          Nvertices.add(ipos);
        }
      }
      prevV = v;
    }
    vertices = Nvertices;
    }
  }
  
  PVector intersection(PVector s1, PVector e1, PVector s2, PVector e2){
    float div = (s1.x - e1.x) * (s2.y - e2.y) - (s1.y - e1.y) * (s2.x - e2.x);
    float x = (s1.x * e1.y - s1.y * e1.x) * (s2.x - e2.x) - (s1.x - e1.x) * (s2.x * e2.y - s2.y * e2.x);
    float y = (s1.x * e1.y - s1.y * e1.x) * (s2.y - e2.y) - (s1.y - e1.y) * (s2.x * e2.y - s2.y * e2.x);
    return new PVector(x/div, y/div);
  }
  
  boolean isPointInside(PVector P, PVector A, PVector B){//calculate point in polygon by calculating which side of AB(foreach edge)
    return (P.x - A.x) * (B.y - A.y) - (P.y - A.y) * (B.x - A.x) < 0;
  }
  
  void show(){
    beginShape();
    for(PVector v : vertices){
      vertex(v.x, v.y);
    }
    endShape(CLOSE);
  }
}
