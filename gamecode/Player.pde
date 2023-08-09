class Player extends Racer {
  private String name = new String("");
  private int lives = 5;
  
  Player () {
    setPositionX(290);
    setPositionY(400);
  }
  
  //ensures the players are not on top of each other on boot up of game
  public boolean checkPlayerGaps(Player onePlayer, Player twoPlayer){
   float leftGap = onePlayer.getPositionX()-40;
   float rightGap = onePlayer.getPositionX()+40;
   float xPos = twoPlayer.getPositionX();
   if (xPos != onePlayer.getPositionX()){
      if (xPos>leftGap && xPos<rightGap){
         return false;
      }
   }
   return true;
  }
  
   public int getLives(){
     return lives;
   }
   
   public void loseLife(){
     if(lives>=1){
       lives = lives - 1;
     }
   }
   
   public void resetLives(){
     lives = 5;
   }
   
   public void setPlayerName(String text){
     name += text;
   }
   
   public String getPlayerName(){
     return name;
   }


  public void moveUp(){
    this.setPositionY(this.getPositionY() - this.getSpeed());
  }

  public void moveDown(){
    this.setPositionY(this.getPositionY() + this.getSpeed());
  }

  public void moveLeft(){
    //This slows down the car on the buffer region of the track and prevents from going off the side of the track
    if(this.getPositionX()<=110){
      this.setPositionX(this.getPositionX() + this.getSpeed()/10);
    }
    if(this.getPositionX() < 115){
      this.setPositionX(this.getPositionX() + 50);
    }
    else if(this.getPositionX()<140 || this.getPositionX()>440){
      this.setPositionX(this.getPositionX() - this.getSpeed()/10);
    }
    else{
      this.setPositionX(this.getPositionX() - this.getSpeed());
    }
  }

  public void moveRight(){
    //As above re slowing down and stopping the side of the track
    if(this.getPositionX()>=475){
      this.setPositionX(this.getPositionX() - this.getSpeed()/10);
    }
    else if(this.getPositionX() > 470){
      this.setPositionX(this.getPositionX() - 50);
    }
    else if(this.getPositionX()<140 || this.getPositionX()>440){
      this.setPositionX(this.getPositionX() + this.getSpeed()/10);
    }
    else{
      this.setPositionX(this.getPositionX() + this.getSpeed());
    }
  }
  


  public void playerKeyStateHandler(int number){
    //Used to control movements and also calls the crash detector
    if(number == 0){
      arrowKeys();
    }
    if(number == 1){
      wasdKeys();
    }
    Player otherPlayer = null;
    if(game.getTwoPlayer()){
      ArrayList<Player> players = game.getPlayer();
      for(Player player : players){
        if(player != this){
          otherPlayer = player;
        }
      }
      if(otherPlayer != null){
        if(crashDetector(otherPlayer, this)){
          if(lives > 1){
            loseLife();
          } else{
            gameOver();
          }
        }
      }
    }
  }
  
  private void arrowKeys(){
    if (keyStates[up]){
      this.moveUp();
    }
    if (keyStates[down]){
      this.moveDown();
    }
    if (keyStates[left]){
      this.moveLeft();
    }
    if (keyStates[right]){
      this.moveRight();
    }
    if(!keyStates[up] && !keyStates[down] && !keyStates[left] && !keyStates[right]){
      this.setPositionY(this.getPositionY() + game.getTrack().getSpeed());
    }
  }
  
  private void wasdKeys(){
    if (keyStates[wKey]){
      this.moveUp();
    }
    if (keyStates[sKey]){
      this.moveDown();
    }
    if (keyStates[aKey]){
      this.moveLeft();
    }
    if (keyStates[dKey]){
      this.moveRight();
    }
    if(!keyStates[wKey] && !keyStates[sKey] && !keyStates[aKey] && !keyStates[dKey]){
      this.setPositionY(this.getPositionY() + game.getTrack().getSpeed());
    }
  }
  
  //Different crash detector for the player, player crashes.  Implementation is the same but passing in two player objects instead
  public boolean crashDetector(Player otherPlayer, Player thisPlayer){
  float playerX = thisPlayer.getPositionX();
  float playerXPlusWidth = thisPlayer.getPositionX() + thisPlayer.getWidth();
  float playerY = thisPlayer.getPositionY();
  float playerYPlusHeight = thisPlayer.getPositionY() +thisPlayer.getHeight();
  float botX = otherPlayer.getPositionX();
  float botXPlusWidth = otherPlayer.getPositionX() + getWidth();
  float botY = otherPlayer.getPositionY();
  float botYPlusHeight = otherPlayer.getPositionY() + getHeight();
  if(playerX > botX && playerX < botXPlusWidth && playerY > botY && playerY < botYPlusHeight){
    //This shifts both players, if the players crashed and didn't shift then the program would crash
    //note the differences to the other object class crashdetectors
    game.shiftPlayers();
    return true;
  } else if(playerXPlusWidth > botX && playerXPlusWidth < botXPlusWidth && playerY > botY && playerY < botYPlusHeight){
    game.shiftPlayers();
    return true;
  } else if(playerX > botX && playerX < botXPlusWidth && playerYPlusHeight > botY && playerYPlusHeight < botYPlusHeight){
    game.shiftPlayers();
    return true;
  } else if(playerXPlusWidth > botX && playerXPlusWidth < botXPlusWidth && playerYPlusHeight > botY && playerYPlusHeight < botYPlusHeight){
    game.shiftPlayers();
    return true;
  }
  return false;
  }   
}
