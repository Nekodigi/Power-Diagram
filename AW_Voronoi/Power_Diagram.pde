class PowerDiagram{
  ArrayList<Circle> circles = new ArrayList<Circle>();
  Polygon basePolygon;
  
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
  
  void addCircle(Circle target){println("try addCircle-------------------------");
    ArrayList<Circle> oldCircles = new ArrayList<Circle>();
    for(Circle c : circles){
      oldCircles.add(c.clone());
    }
    target.setPolygon(basePolygon.clone());
    for(int i=0; i<circles.size(); i++){
      Circle circle = circles.get(i);
      if(circle != null){
        //PVector[] radAxis = circle.getRadicalAxis(target);//calculate mid axis or axis that passing trough intersection of two circle
        ArrayList<PVector> apGraph = apolloniusGraph(target.r, circle.r, target.center, circle.center);
        if(target.r < circle.r){println("t1");
          if(!target.polygon.clip(apGraph, BooleanOperation.Intersection)){circles = oldCircles;return;}
          if(!circle.polygon.clip(apGraph, BooleanOperation.Difference)){circles = oldCircles;return;};
        }else{println("t2");
          if(!target.polygon.clip(apGraph, BooleanOperation.Difference)){circles = oldCircles;return;}
          if(!circle.polygon.clip(apGraph, BooleanOperation.Intersection)){circles = oldCircles;return;};
        }
        if(circle.polygon.vertices.size() < 3){
          circles.get(i).disable = true;
        }
      }
    }
    if(target.polygon.vertices.size() < 3){
      target.disable = true;
    }
    if(target.disable == true){
      circles = oldCircles;
      return;
    }
    circles.add(target);
  }
  
  void show(){
    for(Circle c : circles){
      if(c != null)c.show();
    }
  }
}
