
int rings[] = new int[500];
int disintegrated = 0;


class BrownianParticle{
    PVector pos;
    PVector vel;
    int last = 199;
    boolean slow = false;
    boolean thanosed = false;

    BrownianParticle(PVector pos){
        this.pos = pos;
        vel = new PVector(400,400);
        vel.sub(pos);
        vel.normalize();
    }

    void show(){
        if(thanosed){
            stroke(0);
            strokeWeight(3);
            point(pos.x, pos.y);
            stroke(255);
        }
        else{
            stroke(255);
            strokeWeight(3);
            point(pos.x, pos.y);
        }
    }

    void update(){
        int w = 1;        
        int d = ((int)dist(pos.x, pos.y, 400, 400))/w;

        PVector temp = vel.copy();
        if(d <= 300/w && d > 200/w && d != last){
            rings[d]++;
            rings[last]--;
            last = d;
            temp.mult((rings[d]-rings[d-1])*.01);
        }
        if(d <= 200/w && d > 100/w && d != last){
            rings[d]++;
            rings[last]--;
            last = d;
            if(!this.slow){
                vel.mult(0.1);
                this.slow = true;
            }
            temp.mult((rings[d]-rings[d-1])*.001);
        }
        if(d <= 100/w && d > 55/w && d != last){
            if(random(0.0,1.0) >= disintegrated/(N*.4)
             && random(0.0,1.0) >= .95){
                disintegrated++;
                thanosed = true;
                vel.x = 0;
                vel.y = 0;
            }
            rings[d]++;
            rings[last]--;
            last = d;
            temp.mult((rings[d]-rings[d-1])*.001);

        }
        if(d <= 55/w && d > 0 && d != last){
            rings[d]++;
            rings[last]--;
            last = d;
            vel.mult(random(0.5,0.9));
            temp = vel.copy();
        }
        pos.add(temp);


    }
}

// create an array of particles of N particles
int N = 5000;
BrownianParticle[] particles = new BrownianParticle[N];

int R = 400;
int Res = 600;

int[] frames = new int[Res];

void setup(){
    size(1600,800);
    background(0);

    for(int i = 0; i < N; i++){
        float angle = random(TAU);
        particles[i] = new BrownianParticle(
            new PVector(400+random(-60,60)+R*cos(angle), 400+random(-60,60)+R*sin(angle))
        );
    }
}

int Cframe = 0;


void draw(){
    background(0);
    fill(color(95,35,107));
    circle(400,400,600);

    fill(color(0xAF,0xBB,0xF2));
    circle(400,400,400);

    fill(color(0xED,0x85,0x54));
    circle(400,400,200);

    fill(color(0xF5,0xEB,0x6D));
    circle(400,400,100);

    stroke(255);
    int yOff = 200;
    line(930,750-yOff,1570,750-yOff);
    line(950,780-yOff,950,350-yOff);
    
    
    int count = 0;
    for(BrownianParticle p : particles){
      if(dist(p.pos.x,p.pos.y,400,400) < 52){
        count++;
      }
    }
    
    frames[Cframe++%Res] = count;
    
    beginShape();
    noFill();
    stroke(color(250,180,180));
    for(int i = 0; i < Res;++i){
      int X = (Cframe > Res)?Cframe%Res:0;
      curveVertex(950+ (500.0/Res)*i ,750- frames[(i+X)%Res]/8-yOff);
    }
    endShape();
      
    
    
    
    
    
    
    
    
    for(int i = 0; i < 42; ++i){
        print(rings[i] + " ");
    }
    println();

    for(int i = 0; i < N; i++){
        particles[i].show();
        particles[i].update();
    }
}
