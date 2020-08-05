class Fountain{
  float fx,fy,fz,fpx,fpy,fpz;
  float sprayspeed;
  float dfy;
  
  Fountain(float ix, float iy, float iz,float jx,float jy,float jz){
    fx = ix;
    fy = iy;
    fz = iz;
    fpx = jx;
    fpy = jy;
    fpz = jz;
    sprayspeed = 0;
    //fill(black);
    
  }
  
  void show(){
    fill(black);
    stroke(black);
    box(fx,fy,fz);
    //pushMatrix();
    //translate(fx,fy,fz);
    //fill(black);
    //stroke(black);
    //box(gs,gs*0.3,gs);
    //popMatrix();
  }
  
  void act(){
    //dfy = dfy -1;
    
    fpy = fpy - 1;
    if ( frameCount % 180 == 0) {
      translate(fpx,fpy,fpz);
      fill(lightb);
      box(gs*0.1,gs*0.1,gs*0.1);
      println("muahaha");
    }
    if(dfy<(height/2)-(gs*0.5) ){
      sprayspeed = -1;
    }
    
    
  }
}