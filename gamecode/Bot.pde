class bot extends Racer {
  
   bot(){}

    public void randomisePosition(){
      this.setPositionX(random(150,430));
      this.setPositionY(random(500,700));
    }

   public void moveObject(){
     //this moves the bots up thr screen, speed is dependent on the difficulty
     setPositionY(getPositionY() - getSpeed()-.75);
     //if off the screen then the program picks a random x annd y co-ordinate position at the bottom to re-enter
     if(getPositionY() < 0){
       setPositionX(random(150, 450));
       while (!game.checkBotGaps(this)){
            this.setPositionX(random(150,450));
         }
       setPositionY(random(1500, 0));
     }
     //checks if this bot is crashing with a player
     ArrayList<Player> players = game.getPlayer();
     for(Player player : players){
       if(crashDetector(player, this)){
         Player thisPlayer = player;    
         game.exploAnimation();
         //if the player has more than one life left then the game continues
         if(thisPlayer.getLives()>1){
            if(!explodeAudio.isPlaying()) { 
               explodeAudio.rewind(); 
               explodeAudio.play(); 
            }
            thisPlayer.loseLife();
            this.setPositionX(random(150, 450));
            this.setPositionY(random(1000,1200));
         }
         else{
           //else it ends, but lose life is still called so that the two player winner can be easily found
           thisPlayer.loseLife();
            backgroundAudio.pause();
            if(!gameOverAudio.isPlaying()) { 
               gameOverAudio.rewind(); 
               gameOverAudio.play(); 
            }
            gameOver();
         }
       }
     }
   }
}
