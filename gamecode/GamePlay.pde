public class GamePlay extends CurrentScreen{
  
  GamePlay(){}
  
  public void display(){
    gamePlay();
  }
  
  private void gamePlay(){
    textFont(unicodeFont);
    
    // Check if the background audio is already playing, rewind it to the beginning and play it if not
    if(!backgroundAudio.isPlaying()) { 
          backgroundAudio.rewind(); 
          backgroundAudio.play(); 
    }
    
    // Hide the cursor and set the background color to white
    noCursor();
    background(255);
    game.setScore();
   // text("x: " + mouseX + " y: " + mouseY, mouseX, mouseY);
  
    // Move the track and display the player image
    Track track1 = game.getTrack();
    track1.setSpeed(game.getPlayerMovement());
    track1.moveTrack();

    ArrayList<Player> players = game.getPlayer();
    Player player1 = players.get(0);
    // If there is only one player, handle the key state for player1
      if(!game.getTwoPlayer()){
          player1.playerKeyStateHandler(0);
      }

    image(game.playerImg, player1.getPositionX(), player1.getPositionY(), player1.getWidth(), player1.getHeight());  
    // If player1 reaches the top of the screen, move them up and increase their speed
    if (player1.getPositionY()<150){
      player1.setPositionY((player1.getPositionY() + player1.getSpeed()/2));
      if (player1.getPositionY()<50){
        player1.setPositionY((player1.getPositionY() + player1.getSpeed()));
      }
    }
    
    // If player1 reaches the bottom of the screen, end the game and play the game over audio
    if(player1.getPositionY()>800) {
       game.setGameState(3);
       backgroundAudio.pause();
       if(!gameOverAudio.isPlaying()) { // Check if the audio file is already playing
          gameOverAudio.rewind(); // Rewind the file to the beginning
          gameOverAudio.play(); // Play the file
       }
       gameOver();
       player1.setPositionY(600);
       player1.setPositionX(200);
    }
    
    // If two player, handle the key state for player1 and player2
    if(game.getTwoPlayer()){
      player1.playerKeyStateHandler(1);
      Player player2 = players.get(1);
      player2.playerKeyStateHandler(0);
      image(game.pinkBotImg, player2.getPositionX(), player2.getPositionY(), player2.getWidth(), player2.getHeight());  
      if (player2.getPositionY()<150){
        player2.setPositionY((player2.getPositionY() + player2.getSpeed()/2));
        if (player2.getPositionY()<50){
          player2.setPositionY((player2.getPositionY() + player2.getSpeed()));
        }
      }
      
      // If player2 reaches the bottom of the screen, end the game and play the game over audio
      if(player2.getPositionY()>800) {
        game.setGameState(3);
        backgroundAudio.pause();
        if(!gameOverAudio.isPlaying()) { // Check if the audio file is already playing
          gameOverAudio.rewind(); // Rewind the file to the beginning
          gameOverAudio.play(); // Play the file
        }
        gameOver();
        player2.setPositionY(600);
        player2.setPositionX(200);
      }
      // If there are two players, remove the second player
      } else if (game.getPlayer().size() ==2 ) {
          game.removePlayer(game.getPlayer().get(1));
      }
 
      
      // Display the blue bot image and move it down if it reaches the top of the screen
      ArrayList<bot> bots = game.getBots();
      for (int i=0;i<bots.size();i++){
        image(game.blueBotImg, bots.get(i).getPositionX(), bots.get(i).getPositionY(), bots.get(i).getWidth(), bots.get(i).getHeight());
        bots.get(i).moveObject();
        if (bots.get(i).getPositionY()<0){
          bots.get(i).setPositionX(random(100,500));
          bots.get(i).setPositionY(800);
        }
      }
    
               
      // Display the tank image and move it across the screen
        if(game.getDifficulty() == 4){
         ArrayList<objects> tanks = game.makeTanks();
         for(objects tank : tanks){
           image(game.tankImage, tank.getPositionX(), tank.getPositionY(), 100, 80);
           tank.moveObject();
         }
        } else{
          ArrayList<objects> tanks = game.getTanks();
          for(objects tank : tanks){
            if(tank.direction == false){
              image(game.tankImage, tank.getPositionX(), tank.getPositionY(), 100, 80);
            }
            else if(tank.direction == true){
              image(game.tankImageRev, tank.getPositionX(), tank.getPositionY(), 100, 80);
            }
            tank.moveObject();
          }
        }
      
      // Display the landmine image and move it across the screen
      ArrayList<objects> landmines = game.getLandmines();
       
      for(int i = 0; i < landmines.size(); i++){
        if(landmines.get(i) != null){
          image(game.landMineImage, landmines.get(i).getPositionX(), landmines.get(i).getPositionY(), landmines.get(i).widthY, landmines.get(i).heightX);
          landmines.get(i).moveObject();
        }
      }
    
  

   // Display the score and keyboard type
    textAlign(LEFT);
    fill(150);
    textSize(30);
    fill(255);
    String keyboardInfo="";
    if(game.getDifficulty()>2 && game.getKeyboard()){
      keyboardInfo=" Keyboard:arrow keys";
    }
    if(game.getDifficulty()>2 && !game.getKeyboard()){
       keyboardInfo=" Keyboard:wasd";
    } 

    text("Score:" + str(game.getScore())+ "   "+ keyboardInfo, 20,35);
    
    //Lives
    displayLives(player1, 1);
    if(game.getTwoPlayer()){
      Player player2 = players.get(1);
      displayLives(player2, 2);
    }
  }
    
    // Display the player lives
    public void displayLives(Player player, int number){
    textAlign(LEFT);
    fill(255,192,203);
    textSize(36);
    String livesCnt="";
    if(player.getLives()==1){
      livesCnt="\u2665";
    }
    else if(player.getLives()==2){
      livesCnt="\u2665\u2665";
    }
    else if(player.getLives()==3){
      livesCnt="\u2665\u2665\u2665";
    }
    else if(player.getLives()==4){
      livesCnt="\u2665\u2665\u2665\u2665";
    }
    else if(player.getLives()==5){
      livesCnt="\u2665\u2665\u2665\u2665\u2665";
    }
    if(number == 1){
      text("Player 1" + livesCnt,320,80);
    } if(number == 2){
      text("Player 2" + livesCnt,320,120);
    }
  }
  
  //if enter pressed go to pause screen
  private void KEYPRESSED(char KEY){
    if(key == ENTER){
      game.setGameState(6);
    }
  }
}
