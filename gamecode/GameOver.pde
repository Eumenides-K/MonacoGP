public class GameOver extends CurrentScreen{
   private int restartButtonX = 170, restartButtonY = 730, restartButtonW= 410, restartButtonH = 45; 
   private int menuButtonX = 170, menuButtonY = 650, menuButtonW = 410, menuButtonH = 45; 
   private boolean menuOver = false, restartOver = false;
   ArrayList<String> rowInfo;
   private int buttonWidth = 160, buttonHeight = 40;
  
  GameOver(){
     rowInfo = new ArrayList<>();
  }
   
   public void display(){
     textFont(racingFont);
   // Set game state to game over
   game.setGameState(3);
   cursor();

   // Randomise bot positions for next game
  for (bot bot: game.getBots()){
    bot.randomisePosition();
  }
  // Render correct player screen
   if(!game.getTwoPlayer()){
     image(game.onePGameOver, 0, 0, width, height);
     displayButton(menuOver, game.menu, 175, 645);
     displayButton(restartOver, game.newGame, 175, 730);
     displayOnePlayer();
     drawTable();
   }else if(game.getTwoPlayer()){
     image(game.twoPGameOver, 0, 0, width, height);
     displayButton(menuOver, game.menu, 175, 645);
     displayButton(restartOver, game.newGame, 175, 730);
     displayTwoPlayers();
   }
  // Check if mouse is hovering over any button
   if(overButton(menuButtonX, menuButtonY, menuButtonW, menuButtonH)) {
     menuOver = true;
     restartOver = false;
   } else if(overButton(restartButtonX, restartButtonY, restartButtonW, restartButtonH)){
     restartOver = true;
     menuOver = false;
   } else{
     menuOver = restartOver = false;
   }

    // Reset game state attributes as necessary
   if(mousePressed){
     if(menuOver){
       gameOverAudio.pause();
       if(!buttonClickAudio.isPlaying()) { 
            buttonClickAudio.rewind(); 
            buttonClickAudio.play(); 
        }
       game.resetCountdownTime();
       //game.resetPlayersPosition();
       game.setBotPositions();
       game.makeLandmines();
       game.makeTanks();
       game.resetLives();
       game.makeSecondCar();
       game.setGameState(0);
       game.resetNames();
       game.resetKeyboardType();
     }
     if(restartOver){
        gameOverAudio.pause();
        if(!buttonClickAudio.isPlaying()) {
            buttonClickAudio.rewind();
            buttonClickAudio.play(); 
        }
       game.resetCountdownTime();
       game.resetPlayersPosition();
       game.setBotPositions();
       game.makeLandmines();
       game.makeTanks();
       game.resetLives();
       //backgroundAudio.play();
       //backgroundAudio.loop();
       game.setGameState(1);
       game.resetKeyboardType();
     }
   }
 }
 
 // Render single player game over screen
 private void displayOnePlayer(){
   textSize(40);
   fill(255);
   textAlign(LEFT);
   text(game.getNames().get(0), 340, 210);
   text(game.getScore(), 340, 240);
   textAlign(CENTER);
   //Menu button
 }
 
   // function to display buttons
  private void displayButton(boolean buttonOver, PImage buttonImg, int buttonX, int buttonY){
    if (buttonOver){
      image(buttonImg, buttonX-10, buttonY-10);
    }
    else {
      image(buttonImg, buttonX, buttonY);
    }
  }
 
 
 // Render two player game over screen
 private void displayTwoPlayers(){
   textFont(racingFont);
   textSize(30);
   textAlign(LEFT);
   ArrayList<Player> players = game.getPlayer();
   if(players.get(0).getLives() > 0){
     textAlign(CENTER);
     fill(255);
     textSize(70);
     text(game.getNames().get(0), 300, 290);
     text(game.getScore(), 300, 440);
   } else if(players.get(1).getLives() > 0){
     textAlign(CENTER);
     fill(255);
     textSize(70);
     text(game.getNames().get(1), 300, 290);
     text(game.getScore(), 300, 440);
   }
 }
 
 // Remove existing obstacles and reset player object
 public void newPositions(){
   game.removeTanks();
   game.removeLandmines();
   game.recreatePlayer();
 }
 
 // Draw results leaderboard
 public void drawTable(){
   fill(0);
   int yDiff = 0;
   textAlign(CENTER);
   textFont(racingFont);
   textSize(30);
   fill(255);
   rowInfo = game.getRowInfo();
   int i = 0;
   while(i < 3 && i < rowInfo.size()){
      String[] split = rowInfo.get(i).split("  ");
      text(split[0], 200, (400 + yDiff));
      text(split[1], 310, (400 + yDiff));
      text(split[2], 410, (400 + yDiff));
      i++;
      yDiff += 50;
   }
 }
 
 // Check if mouse is hovering over button
  private boolean overButton(int x, int y, int bWidth, int bHeight){
     if (mouseX >= x && mouseX <= x + bWidth && mouseY >= y && mouseY <= y + bHeight) {
      return true;
    } else {
      return false;
    }  
  }
}
