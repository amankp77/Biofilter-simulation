class Particle{
  PVector pos;
  PVector vel;
  
  Particle(PVector pos, PVector vel){
     this.pos = pos;
     this.vel = vel;
  }
  
  void show(){
    strokeWeight(0);
    fill(color(255,0,0));
    circle(pos.x,pos.y,5);
  }
  
  void move(Particle[] particles){
    if(pos.x < 100){
      vel.x = vel.x*-1;
      pos.x += 2;
    }
    if(pos.x > 700){
      vel.x = vel.x*-1;
      pos.x -= 2;
    }
    if(pos.y < 500){
      vel.y = vel.y*-1;
      pos.y += 2;
    }
    if(pos.y > 700){
      vel.y = vel.y*-1;
      pos.y -= 2;
    }
    pos.add(vel);
  }
}
int N = 5000;

class Graph{
  int arr[];
  int density[];
  
  Graph(){
    arr = new int[N];
    density = new int[70];
  }
  void Generate(Particle[] particles){
    for(int i = 0; i < arr.length; i++){
      arr[i] = (int)particles[i].pos.x;
    }
    // sort array
    arr = sort(arr);
  }

  void fromArray(int[] arr){
    this.density = arr;
  }

  void ideal(){
    for(int i = 1; i < 60; ++i){
      density[i] += ((density[i] - density[i-1])/10 - (density[i+1] - density[i])/10)/10;
    }
  }

  void transform(color x){
    // count particles between x and x + 10,
    // from 100 to 700
    // and draw bar graph
    for(int i = 10; i < 70; i++){
      int count = 0;
      for(int j = 0; j < arr.length; j++){
        if(arr[j] >= i*10 && arr[j] < (i+1)*10){
          count++;
        }
      }
      strokeWeight(0);
      fill(x);
      density[i] = count;
      rect(i*10,400,10,-count);
    }
  }

  void show(color x){
    for(int i = 0; i < density.length; i++){
      strokeWeight(0);
      fill(x);
      rect(i*10,400,10,-density[i]);
    }
  }
}


// dc/dt = K*d^2c/dx^2


Particle[] particles = new Particle[N];
Graph g2 = new Graph();

void setup(){
  size(800,800);
  strokeWeight(4);
  // initialize particles
  for(int i = 0; i < particles.length; i++){
    // set all particles in rectangle 100, 300 and 400, 500
    particles[i] = new Particle(new PVector(random(120,280),random(520,680)),new PVector(random(-1,1),random(-1,1)));
  }
  g.Generate(particles);
  g.transform(color(255,0,0,90));  

}

Graph g = new Graph();

void draw(){
  background(0);
  stroke(255);
  fill(0);
  strokeWeight(4);
  rect(100,500,600,200);
  strokeWeight(0);
  for(int i = 0; i < particles.length; i++){
    particles[i].show();
    particles[i].move(particles);
  }
  g.transform(color(255,0,0,90));
  g.Generate(particles);
}
