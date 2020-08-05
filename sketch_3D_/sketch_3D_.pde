//int[][] world={
//  {1, 0, 1, 0, 1}, 
//  {1, 0, 0, 0, 1}, 
//  {0, 0, 1, 0, 0}, 
//  {1, 0, 0, 0, 1}, 
//  {1, 0, 1, 0, 1}  
//};

//final int w = world.length;
//final int d = world[0].length;
float angle = 0;
float px, py, pz;

float dx, dy, dz;

//float dirX = width/2;
//float dirY = height/2+120;
//float dirZ = 0;
int gs = 250;
int movespeed = 8;

boolean forward, back, left, right;
boolean up, down, turnl, turnr;
boolean shift;
boolean canmove = true;

PVector dir;
ArrayList <bullet> bullets = new ArrayList<bullet>();
ArrayList <Fountain> fountains = new ArrayList<Fountain>();
//ArrayList <water> watercurrent = new ArrayList<water>();

PImage maze;

color black = color(0, 0, 0);
color white = color(255, 255, 255);

color indigo = color(200, 191, 231);
color purple = color(163, 73, 164);
color brown = color(185, 122, 87);
color dbrown = color(136, 0, 21);
color red = color(237, 28, 36);
color blue = color(0, 162, 232);
color lightb = color(153, 217, 234);
color orange = color(255, 127, 39);
color yellow = color(255, 201, 14);
color beige = color(239, 228, 176);
color green = color(0, 128, 0);
color lgreen = color(128, 128, 0);
color grey = color(127, 127, 127);
color lgrey = color(195, 195, 195);
color mint = color(140, 250, 131);
color bgreen = color(181, 230, 29);

void setup() {
  size(800, 600, P3D);
  dir = new PVector(0, 100);
  px = width/2;
  py = (height/2)-(gs*0.5);
  pz = (height/2.0)/tan(PI*30.0/180);

  maze = loadImage("mansion.png");
}
//
void draw() {
  background(lightb);

  dx = px + dir.x;
  dz = pz + dir.y;
  dy = (height/2)-(gs*0.5);
  camera(px, py, pz, dx, dy, dz, 0, 1, 0);
  drawWorld();
  drawFloor(height/2);

  handleInput();
  handleBullets();
  handlewater();
  collision();
  if (up == true) {
    py = py +1;
    dy = (height/2)-(gs*0.5);
  }
  if (down == true) {
    py = py-1;
    dy = (height/2)-(gs*0.5);
  }

  println(canmove);
  fill(222, 54, 54);
}

void handlewater(){
  int i = 0; 
  while (i< fountains.size() ) {
    Fountain fo = fountains.get(i);
    fo.show();
    fo.act();
    i++;
  }
}
void handleBullets() {
  int i = 0;
  while ( i < bullets.size()) {
    bullet b = bullets.get(i);
    b.show();
    b.move();
    i++;
  }
}
void handleInput() {
  if (mouseX<200&& mouseX>150) {
    angle = -PI/270;
  } else if (mouseX<=150 && mouseX>100) {
    angle = -PI/180;
  } else if (mouseX<=100 && mouseX>50) {
    angle = -PI/90;
  } else if (mouseX<=50) {
    angle = -PI/45;
  } else if (mouseX>width-200 && mouseX<width-150) {
    angle = PI/270;
  } else if (mouseX>=width-150 && mouseX<width-100) {
    angle = PI/180;
  } else if (mouseX>=width-100 && mouseX<width-50) {
    angle = PI/90;
  } else if (mouseX>=width-50) {
    angle = PI/45;
  } else {
    angle = 0;
  }
  dir.rotate(angle);

  if (mouseY<100) {
    py = py +1;
  }
  if (mouseY>500) {
    py = py -1;
  }

  //if(turnl == true){
  //  dir.rotate(-PI/90);
  //  println(dir);
  //}
  //if(turnr == true){
  //  dir.rotate(PI/90);
  //}

  //if (shift == true) { 
  //  bullets.add(new bullet(px, pz, cos(dir.heading())*3, sin(dir.heading())*3));
  //}

  if (canmove && forward == true) {
    //pz = pz + 10;
    px = px + cos(dir.heading() ) * movespeed;
    pz = pz + sin(dir.heading() ) * movespeed;
  }
  if (back == true) {
    //pz = pz-10;
    px = px - cos(dir.heading() ) * movespeed;
    pz = pz - sin(dir.heading() ) * movespeed;
  }
  if (right == true) {
    //px = px - 10;
    px = px + cos(dir.heading()+PI/2 ) * movespeed;
    pz = pz + sin(dir.heading()+PI/2 ) * movespeed;
  }
  if (left == true) {
    //px = px+10;
    px = px - cos(dir.heading()+PI/2 ) * movespeed;
    pz = pz - sin(dir.heading()+PI/2 ) * movespeed;
  }
}

void drawWorld() {
  int x = 0;
  int z = 0;
  //float h = 0;
  while (z < maze.height) {

    pushMatrix();
    //translate(x*gs, (height/2)-(h*0.5), z*gs);
    color c = maze.get(x, z);
    noStroke();
    if (c == green) {
      translate(x*gs, (height/2)-(gs*0.5), z*gs);
      //h = gs;
      fill(green);
      box(gs);
    }
    if (c == bgreen) {
      int tl = int(random(gs, gs*3));
      translate(x*gs, (height/2)-gs*7, z*gs);
      fill(green);
      box(tl);
    }
    if (c == lgreen) {
      translate(x*gs, (height/2)-(gs), z*gs);
      //h = 2*gs;
      fill(lgreen);
      box(gs, gs*2, gs);
    }
    if (c == purple) {
      translate(x*gs, (height/2)-(2*gs), z*gs);

      //h = 4*gs;
      fill(purple);
      box(gs, 4*gs, gs);
    }
    if ( c == orange) {
      translate(x*gs, (height/2)-(gs*0.25), z*gs);

      //h = 0.5*gs;
      fill(orange);
      box(gs, 0.5*gs, gs);
    }
    if (c == indigo) {
      translate(x*gs, (height/2)-(1.5*gs), z*gs);

      //h = 3.5*gs;
      fill(indigo);
      box(gs, 3.5*gs, gs);
    }
    if ( c == grey || c == lgrey) {
      translate(x*gs, (height/2)-(0.125*gs), z*gs);

      //h = 0.25*gs;
      fill(grey);
      box(gs, 0.25*gs, gs);
    }

    if ( c == dbrown) {
      translate(x*gs, (height/2)-(4*gs), z*gs);

      //h = 8*gs;
      fill(dbrown);
      box(gs, 8*gs, gs);
    }
    if ( c == brown) {
      translate(x*gs, (height/2)-(0.4*gs), z*gs);
      fill(brown);
      //h = 0.8*gs;
      box(gs, 0.8*gs, gs);
    }
    if ( c == yellow) {
      translate(x*gs, (height/2)-(0.2*gs), z*gs);

      //h = 0.4*gs;
      fill(yellow);
      box(gs, 0.4*gs, gs);
    }
    if (c == blue) {
      translate(x*gs, (height/2)-(0.1*gs), z*gs);
      //h = 0.2*gs;
      fill(blue);
      box(gs, 0.2*gs, gs);
    }
    if ( c == lightb) {
      int wh = int(random (gs*0.15, gs*0.25) );
      translate(x*gs, (height/2)-(wh*0.5), z*gs);
      fill(lightb, 100);
      box(gs, wh, gs);
    }
    if ( c== red) {
      translate(x*gs, (height/2)-(0.5*gs), z*gs);

      //h = 0.3*gs;
      fill(red);
      sphere(0.3*gs);
    }
    if (c == black) {
      translate(x*gs, (height/2)-(gs*0.15), z*gs);
      fill(black);
      //box(gs,0.3*gs, gs);
      
      Fountain f = new Fountain(gs, gs*0.3, gs,x*gs,(height/2)-(gs*0.15),z*gs);
      fountains.add(f);
    }
    popMatrix();

    x++;
    if (x == maze.width) {
      x = 0;
      z++;
    }
  }
}

void drawFloor(float floor) {
  int spacing = 4;
  pushMatrix();
  translate(0, floor, 0);
  rotateX(PI/2);
  for (int i = 0; i <= 20000; i = i+spacing) {
    fill(255);
    stroke(mint);
    strokeWeight(2);
    line(i, 0, i, 20000);
    line(0, i, 20000, i);
  }
  popMatrix();
}


void keyPressed() {
  if (key == 'w' || key == 'W') {
    forward = true;
  }  
  if (key == 's' || key == 'S') {
    back = true;
  }
  if (key == 'a' || key == 'A') {
    left = true;
  }
  if (key == 'd' || key == 'D') {
    right = true;
  }
  if (keyCode == UP) {
    up = true;
  }  
  if (keyCode == DOWN) {
    down = true;
  }
  if (keyCode == LEFT) {
    turnl = true;
  }
  if (keyCode == RIGHT) {
    turnr = true;
  }
}

void keyReleased() {
  if (key == 'w' || key == 'W') {
    forward = false;
  }  
  if (key == 's' || key == 'S') {
    back = false;
  }
  if (key == 'a' || key == 'A') {
    left = false;
  }
  if (key == 'd' || key == 'D') {
    right = false;
  }
  if (keyCode == UP) {
    up = false;
  }  
  if (keyCode == DOWN) {
    down = false;
  }
  if (keyCode == LEFT) {
    turnl = false;
  }
  if (keyCode == RIGHT) {
    turnr = false;
  }
  if (key == ' ') {
    bullets.add(new bullet(px, pz, cos(dir.heading())*3, sin(dir.heading())*3));
  }
}

void collision() {
  canmove = true;
  float futureX = px + cos(dir.heading())*movespeed;
  float futureZ = pz + sin(dir.heading())*movespeed;
  for (int r = 0; r<maze.height; r++) {
    for (int c = 0; c<maze.width; c++) {
      //pushMatrix();
      color co = maze.get(r, c);
      if (co != white ) {
        float cubeCenterX = r*gs;
        float cubeCenterZ = c*gs;

        if (futureX<(cubeCenterX+gs*0.6) && futureX>(cubeCenterX-gs*0.6) && futureZ<(cubeCenterZ+gs*0.6) && futureZ>(cubeCenterZ-gs*0.6) ) {
          canmove = false;
        }
      }
    }
  }
}