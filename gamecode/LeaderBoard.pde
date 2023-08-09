public class LeaderBoard extends CurrentScreen {
  private boolean backOver = false;
  private int backButtonX = 250, backButtonY = 750, backButtonW = 90, backButtonH = 35; 
  
  public LeaderBoard (){}

  // Display leaderboard
  public void display(){
    background(255);
    // Make track img moving
    Track track1 = game.getTrack();
    track1.setSpeed(1);
    track1.moveTrack();

    textAlign(CENTER);
    textFont(racingFont);
    textSize(40);
    fill(0);
    text("Leaderboard",305,50);
    fill(255);
    textSize(30);
    text("user",200,100);
    text("score",290,100);
    text("date",395,100);
    drawTable();
    textFont(unicodeFont);
    textSize(30);
    
    // Check if mouse is over back button
   if(overButton(backButtonX, backButtonY, backButtonW, backButtonH)) {
     backOver = true;
   } else{
     backOver = false;
   }
     /* Display back button. If moused over, move image slightly 
     to provide visual feedback to player */
    if (backOver){
        image(game.backText, backButtonX-2, backButtonY-2);
     }
     else {
        image(game.backText, backButtonX, backButtonY);
     }

  // Reset game states if back button pressed
   if(mousePressed){
     if(backOver){
        if(!buttonClickAudio.isPlaying()) { // Check if the audio file is already playing
            buttonClickAudio.rewind(); // Rewind the file to the beginning
            buttonClickAudio.play(); // Play the file
        }
       game.setGameState(0);
     }
   }
  }

  // Draw leaderboard according to the result table
  public void drawTable(){
    fill(255);
    int yDiff = 0;
    textAlign(CENTER);
    textFont(racingFont);
    textSize(30);
    Table result = game.getTable();
    int i=0;
    for (TableRow row : result.rows()){
       text(row.getString("user"), 200, (150 + yDiff));
       text(row.getString("score"), 290, (150 + yDiff));
       text(row.getString("date"), 395, (150 + yDiff));
       yDiff += 50;
       i++;
       if (i>=9){
         break;
       }
    }
  }
  
   // Check if the mouse is over button
   private boolean overButton(int x, int y, int bWidth, int bHeight){
    // if ((sq(mouseX - x))/(sq(width/2)) + (sq(mouseY - y))/(sq(height/2)) <=1) {
      if (mouseX >= x && mouseX <= x + bWidth && mouseY >= y && mouseY <= y + bHeight) {
      return true;
    } else {
      return false;
    } 
  }

}
