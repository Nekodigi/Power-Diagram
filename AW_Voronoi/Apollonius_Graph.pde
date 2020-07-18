ArrayList<PVector> apolloniusGraph(float r1, float r2, PVector A, PVector B){
  ArrayList<PVector> results = new ArrayList<PVector>();
  int res = 20;
  float guideOff = r1 < r2 ? -(width + height) : (width + height);
  
  float c = A.dist(B);
  PVector u = PVector.sub(B, A).normalize();
  PVector v = new PVector(-u.y, u.x);
  float min = (c - (r1 + r2))/2;
  
  for(int i=0; i<=res; i++){
    float d = pow((res-i)*2, 2) + min;
    
    float b = r1 + d;
    float a = r2 + d;
    
    float cosA = (b*b + c*c - a*a)/(2*b*c);//using law of cosine
    float sinA = sqrt(1-cosA*cosA);
    PVector C = UVmap(u, v, cosA*b, sinA*b).add(A);
    if(i == 0)results.add(UVmap(u, v, cosA*b+guideOff, sinA*b).add(A));
    results.add(new PVector(C.x, C.y));
  }
  
  for(int i=1; i<=res; i++){
    float d = pow(i*2, 2) + min;
    
    float b = r1 + d;
    float a = r2 + d;
    
    float cosA = (b*b + c*c - a*a)/(2*b*c);//using law of cosine
    float sinA = sqrt(1-cosA*cosA);
    
    PVector C = UVmap(u, v, cosA*b, -sinA*b).add(A);
    results.add(new PVector(C.x, C.y));
    if(i == res)results.add(UVmap(u, v, cosA*b+guideOff, -sinA*b).add(A));
  }
  if(r1 < r2){//anyway it's seem nessesary 
    ArrayList<PVector> Nresults = new ArrayList<PVector>();
    for(int i=results.size()-1; i>=0; i--){
      Nresults.add(results.get(i));
    }
    results = Nresults;
  }
  return results;
}
