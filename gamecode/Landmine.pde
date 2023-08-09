public class landmine extends objects {
 
 landmine(){
   setPositionY(random(-1000, 0));
   setPositionX(random(150,450));
 }
 
 // move landmine and detect crash
 public void moveObject(){
    setPositionY(getPositionY() + game.getPlayerMovement());
    if(getPositionY() > 800){
       setPositionX(random(250, 450));
       setPositionY(random(-1000, 0));
     }
  
     ArrayList<Player> players = game.getPlayer();
    //this iterates through the players and checks for crashes.
     for(Player player : players){
        if(crashDetector(player, this)){
           Player thisPlayer = player;
           game.exploAnimation();
           showExplosionAnimation(thisPlayer.getPositionX(), thisPlayer.getPositionX());
           if(thisPlayer.getLives()>1){
             //if the player has more than one life left then the game continues
            //   if(!explodeAudio.isPlaying()) { 
                 explodeAudio.rewind(); 
                 explodeAudio.play(); 
            //   }
            //note the call to the player object here remove a life
              thisPlayer.loseLife();
              setPositionY(random(-1000, -500));
              setPositionX(random(150, 450));
           }
           else{
           //else it ends, but lose life is still called so that the two player winner can be easily found
              //file1.stop();
              thisPlayer.loseLife();
              backgroundAudio.pause();
            //   if(!gameOverAudio.isPlaying()) { 
                 gameOverAudio.rewind(); 
                 gameOverAudio.play(); 
            //   }
              gameOver();
           }
        }
      }
     }
 }
