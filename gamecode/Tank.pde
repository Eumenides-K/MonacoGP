public class Tank extends objects{
 
  // constructor
 Tank(){
   //random number generator to put the tank on the left or right of the screen
   float x = random(1, 3);
   if(x <= 2){
        direction = false;
        setPositionX(random(-1000, 0));
   }
   else if(x >= 2){
        direction = true;
        setPositionX(random(800, 1800));
   }
   //Ensuring the tanks cover all the screen in insanity mode
   if(game.getDifficulty() == 4){
        setPositionY(random(800));
   } else{
        setPositionY(random(600));
   }

 }
 
 public void moveObject(){
   //If the direction is false then the tank is off the left of the screen
   if(direction == false){
     setPositionX(getPositionX() + (game.getPlayerMovement() + 0.5));
     //If true then off the right of the screen
   } else if(direction == true){
     setPositionX(getPositionX() - (game.getPlayerMovement() + 0.5));
   }
   //Reassigning the position of the tank using a random number generator
  if(getPositionX() > 900 && direction == false){
    setPositionY(random(600));
    float x = random(1, 3);
    if(x <= 2){
        direction = false;
        setPositionX(random(-1000, 0));
    }
    if(x >= 2){
        direction = true;
        setPositionX(random(800, 1800));
    }
  } else if(getPositionX() < -100 && direction == true){
    setPositionY(random(600));
    float x = random(1, 3);
    if(x <= 2){
        direction = false;
        setPositionX(random(-1000, 0));
    }
    if(x >= 2){
        direction = true;
        setPositionX(random(800, 1800));
    }
  }
  //This is the crash detector for the tank object which uses the defined method in the abstract object class
  ArrayList<Player> players = game.getPlayer();
  for(Player player : players){
    if(crashDetector(player, this)){
      Player thisPlayer = player;
      if(thisPlayer.getLives()>1){
        //if the player has more than one life left then the game continues
        if(!explodeAudio.isPlaying()) {
            explodeAudio.rewind(); 
            explodeAudio.play();
        }
        thisPlayer.loseLife();
        this.setPositionY(random(0, 700));
        this.setPositionX(random(800, 1500));
      }
      else{
        //else it ends, but lose life is still called so that the two player winner can be easily found
        thisPlayer.loseLife();
        file1.stop();
        if(!gameOverAudio.isPlaying()) { 
              gameOverAudio.rewind(); 
              gameOverAudio.play();
          }
        backgroundAudio.pause();
        gameOver();
      }
    }
  }
 }
 
}
