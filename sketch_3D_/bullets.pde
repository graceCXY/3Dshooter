class bullet{
  float bx,bz;
  float dbx,dbz;
  
  bullet(float gx, float gz, float dgx,float dgz){
    bx = gx;
    bz = gz;
    dbx = dgx;
    dbz = dgz;
    
  }
  
  void show(){
    pushMatrix();
    translate(bx,(height/2)-(gs*0.5), bz);
    box(8);
    stroke(0);
    fill(255);
    popMatrix();
    
  }
  void move(){
    bx = bx + dbx;
    bz = bz + dbz;
  }
}