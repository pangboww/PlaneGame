PImage planeM, planeL, planeR;
PImage bullet;
PImage missile;
PImage enemy;
ArrayList<PImage> explosion;

class Plane{
  Plane(){}
  
  void show(){
    imageMode(CENTER);
    image(choosePlaneImage(), mouseX, mouseY, width/7, width/7);

  }
  
  PImage choosePlaneImage(){
    if(pmouseX > mouseX){
      return planeL;
    } else if(pmouseX < mouseX){
      return planeR;
    } else {
      return planeM;
    }
  }
  
  void fire(){
    bullets.add(new Bullet(new Vec2D(mouseX, mouseY)));
  }
  
  void launch(){
    missiles.add(new Missile(new Vec2D(mouseX, mouseY), enemies));
  }
   
}

class Bullet {
  Vec2D loc;
  Vec2D speed;
  boolean isDestroyed;
  
  Bullet (Vec2D _loc){
    loc = _loc;
    speed = new Vec2D(0, -10);
    isDestroyed = false;
  }
  
  
  void show(){
    if(isDestroyed){
      return;
    }
    imageMode(CENTER);
    move();
    image(bullet, loc.x, loc.y, width/40, width/10);
  }
  
  void move(){
    loc.addSelf(speed);
  }
  
  void destroy(){
    isDestroyed = true;
  }
}

class Missile {
  Vec2D loc;
  Vec2D speed;
  Vec2D acceleration;
  Enemy target;
  
  boolean isDestroyed;
  
  Missile (Vec2D _loc, ArrayList<Enemy> _enemies){
    loc = _loc;
    speed = new Vec2D(0, -3);
    acceleration = new Vec2D(0, 0);
    isDestroyed = false;
    target = chooseTarget(_enemies);
  }
  
  void show(){
    if(isDestroyed){
      return;
    }
    imageMode(CENTER);
    accelerate();
    move();
    image(missile, loc.x, loc.y, width/30, width/8);
  }
  
  void accelerate(){
    float distance = loc.distanceTo(target.loc);
    Vec2D dir = target.loc.subSelf(loc);
    dir.normalize();
    acceleration = dir.scale(100/distance);
  }
  
  void move(){
    speed.addSelf(acceleration);
    loc.addSelf(speed);
  }
  
  void destroy(){
    isDestroyed = true;
  }
  
  Enemy chooseTarget(ArrayList<Enemy> enemies){
    Enemy t = null;
    float pdistance = width * height;
    float distance;
    for(int i = 0; i < enemies.size(); i++){
      Enemy e = (Enemy) enemies.get(i);
      distance = loc.distanceTo(e.loc);
      if(distance < pdistance){
        pdistance = distance;
        t = e;
      }
    }
    return t;
  }
  
  
}

class Enemy {
  Vec2D loc;
  Vec2D speed;
  boolean isDestroyed;
  int destroyedState;
  
  Enemy(){
    loc = new Vec2D(random(30, width-30), 0);
    speed = new Vec2D(0,random(0,7));
    isDestroyed = false;
    destroyedState = 0;
  }

  
  void show(){
    if(isDestroyed && destroyedState > 15) return;
    if(isDestroyed){
      imageMode(CENTER);
      image(explosion.get(destroyedState), loc.x, loc.y, width/7, width/7);
      destroyedState++;
      move();
      return;
    }
    move();
    imageMode(CENTER);
    image(enemy, loc.x, loc.y, width/7, width/7);
  }
  
  
  
  void move(){
    loc.addSelf(speed);
  }
  
  void destroy(){
    isDestroyed = true;
  }
  
}
