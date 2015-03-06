

class Plane{
  Plane(){}
  
  void show(){
    imageMode(CENTER);
    image(shadow, mouseX, mouseY+30,width/7,width/7);
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
    bullets.add(new Bullet(new Vec2D(mouseX, mouseY-40)));
  }
  
  void launch(){
    missiles.add(new Missile(new Vec2D(mouseX, mouseY-60)));
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
    image(bullet, loc.x, loc.y, width/60, width/40);
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
  float direction;
  
  boolean isDestroyed;
  
  Missile (Vec2D _loc){
    loc = _loc;
    acceleration = new Vec2D(0, 0);
    direction = 0;
    isDestroyed = false;
    target = chooseTarget(enemies); 
    speed = target.loc.sub(loc).normalize();
  }
  
  void show(){
    if(isDestroyed){
      return;
    }
    target = chooseTarget(enemies); 
    accelerate();
    move();
    direct();
    translate(loc.x, loc.y);
    imageMode(CENTER);
    rotate(direction);
    image(missile, 0, 0, width/30, width/8);
    
  }
  
  void accelerate(){
    float distance = loc.distanceTo(target.loc.add(target.speed)); 
    Vec2D dir = target.loc.sub(loc);
    dir.normalize();
    acceleration = dir.scale(100/distance); 
  }
  
  void direct(){
    float x = speed.x;
    float y = speed.y;
    if(x<0){
      direction = (float)Math.atan(y / x) - PI/2;
    }
    else{
      direction = (float)Math.atan(y / x) + PI/2;
    }
  }
  
  void move(){
    speed.addSelf(acceleration);
    if (speed.x>30) speed.x = 30;
    if (speed.x<-30) speed.x = -30;
    if (speed.y>30) speed.y = 30;
    if (speed.y<-30) speed.y = -30;
    loc.addSelf(speed);
  }
  
 
  
  void destroy(){
    isDestroyed = true;
  }
  
  Enemy chooseTarget(ArrayList<Enemy> enemies){
    Enemy t = new Enemy();
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
    speed = new Vec2D(0,random(2,4));
    isDestroyed = false;
    destroyedState = 0;
  }

  
  void show(){
    if(isDestroyed && destroyedState > 15){
      loc.x = -100;
      loc.y = -100;
      return;
    };
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
