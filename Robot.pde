class Robot extends Enemy{
	// Requirement #5: Complete Dinosaur Class

	final int PLAYER_DETECT_RANGE_ROW = 2;
	final int LASER_COOLDOWN = 180;
	final int HAND_OFFSET_Y = 37;
	final int HAND_OFFSET_X_FORWARD = 64;
	final int HAND_OFFSET_X_BACKWARD = 16;
  float speed = 2f;
  float stop = 0;
  int timer = 180;
  Laser laser;
  
  void checkCollision(Player player){

    if(isHit(x, y, w, h, player.x, player.y, player.w, player.h)){

      player.hurt();

    }
    
    laser.checkCollision(player);
  }

  void display(){
    int direction = (speed > 0) ? RIGHT : LEFT;
    pushMatrix();
      translate(x, y);
      if (direction == RIGHT) {
        scale(1, 1);
        image(robot, 0, 0, w, h); 
      } else {
        scale(-1, 1);
        image(robot, -w, 0, w, h); 
      }
    
    popMatrix();
    
    laser.display();
  }
  
  void update(){

    boolean checkX = (speed < 0 && player.x+w/2 < x) 
    || (speed > 0 && player.x+w/2 > x);

    boolean checkY = (abs(player.row - y/SOIL_SIZE))<=PLAYER_DETECT_RANGE_ROW ;
    
    boolean laserReady = LASER_COOLDOWN==timer;
    
    if(checkX==true && checkY==true ){
      if(laserReady==true){
        laser.fire(x+HAND_OFFSET_X_FORWARD,y+HAND_OFFSET_Y,player.x+w/2,player.y+w/2);
        timer = 0;
      }
      if(laserReady==false){
        timer++;
      }
    }else{
      x += speed;
      if (x < 0 || x > width - w) { 
        speed *= -1 ;
      }
    }
     laser.update();
  }
  

  
  Robot (float x, float y){
    super(x,y);
    
    laser = new Laser();
  }

	// HINT: Player Detection in update()
	/*

	boolean checkX = ( Is facing forward AND player's center point is in front of my hand point )
					OR ( Is facing backward AND player's center point (x + w/2) is in front of my hand point )

	boolean checkY = player is less than (or equal to) 2 rows higher or lower than me

	if(checkX AND checkY){
		Is laser's cooldown ready?
			True  > Fire laser from my hand!
			False > Don't do anything
	}else{
		Keep moving!
	}

	*/
}
