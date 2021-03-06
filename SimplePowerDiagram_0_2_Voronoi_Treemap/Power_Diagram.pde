class PowerDiagram{
  ArrayList<Circle> circles = new ArrayList<Circle>();
  Polygon basePolygon;
  
  PowerDiagram(Polygon polygon, ArrayList<Circle> circles_){
    this(polygon);
    for(Circle c : circles_){
      addCircle(c);
    }
  }
  
  PowerDiagram(Polygon polygon){
    this.basePolygon = polygon;
  }
  
  PowerDiagram(){//basePolygon is fullscreen
    basePolygon = new Polygon();
    basePolygon.vertices.add(new PVector(0, 0));
    basePolygon.vertices.add(new PVector(width, 0));
    basePolygon.vertices.add(new PVector(width, height));
    basePolygon.vertices.add(new PVector(0, height));
  }
  
  void addCircle(Circle target){
    target.cpolygon.setVertices(basePolygon.vertices);
    target.disable = false;
    for(int i=0; i<circles.size(); i++){
      Circle circle = circles.get(i);
      if(circle != null){
        PVector[] radAxis = circle.getRadicalAxis(target);//calculate mid axis or axis that passing trough intersection of two circle
        target.cpolygon.clip(radAxis[1], radAxis[0]);//det by nd
        circle.cpolygon.clip(radAxis[0], radAxis[1]);
        
        if(circle.cpolygon.vertices.size() < 3){
          circles.get(i).disable = true;
        }
      }
    }
    if(target.cpolygon.vertices.size() < 3){
      target.disable = true;
    }
    circles.add(target);
  }
  
  void show(){
    for(Circle c : circles){
      if(c != null)c.show(showCircle);
    }
  }
}
