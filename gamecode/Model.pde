import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import ddf.minim.*;


// constructor and initialize instance variables
public class model{
   private int difficultyLevel = 0, playerMovement = 2, score = 0;
   private int gameState = 0;
   private objects landmine1;
   private objects landmine2;
   private objects tank1;
   private objects tank2;
   private bot bot1;  
   private bot bot2;
   private bot bot3;
   public Track trackbase;
   private RealTimeTimer realTimeTimer;
   private ArrayList<bot> bots;
   private ArrayList<objects> landmines;
   private ArrayList<objects> tanks;
   private ArrayList<String> Names;
   private CurrentScreen currentScreen;
   private String fileName = "results.csv";
   private Table results;
   private ArrayList<String> rowInfo;
   private RealTimeTimer countdown;
   public PImage pinkBotImg, blueBotImg, playerImg, StartImage, trackImage, GameOver, landMineImage, tankImage, startTrack, tankImageRev, backText, easyText;
   public PImage gameOverMenu, gameOverNewGame,  medText, hardText, insanityText, onePlayerScreen, twoPlayerScreen, twoPGameOver, diffScreenImg, onePGameOver;
   public PImage noWinner, newGame, menu, twoPlayerText, SinglePlayer, button, pause;
   private ArrayList<Player> players;
   private boolean keyboardType; //true for arrow keys, false for wasd
   private boolean twoPlayer = false;
   public PImage[] explosion = new PImage[8];
   private boolean exploding = false;
   private int explosionIndex = 0;
   public int enterCount = 0;
   public int activePlayers = 1;
   public boolean tableLoad = true;
   
   // constructor
   model(){
      bots = new ArrayList<bot>(4);
      realTimeTimer = new RealTimeTimer(System.currentTimeMillis());
      Names = new ArrayList<String>();
      Names.add("");
      Names.add("");
      landmines = new ArrayList<objects>(4);
      tanks = new ArrayList<objects>(4);
      results = new Table();
      rowInfo = new ArrayList<String>();
      countdown = new RealTimeTimer(System.currentTimeMillis());
      countdown.stopTimer();
      keyboardType=true;
      players = new ArrayList<Player>();
      Player player1 = new Player();
      player1.setSpeed(playerMovement);
      players.add(player1);
      Player player2 = new Player();
      player2.setSpeed(playerMovement);
      player2.setPositionX(390);
      player2.setPositionY(400);
      players.add(player2);
   }
   
   // Removes the second car from the players list
   //player cars can only be made on start up so if 
   // then the car must be removed to play the game
   public void removeSecondCar(){
     if(players.size() > 1){
        players.remove(1);
     }
   }
   
   // Adds a second car to the players list
   //also setsa up various basic co-ordinated and speeds
   public void makeSecondCar(){
      Player player2 = new Player();
      player2.setSpeed(playerMovement);
      player2.setPositionX(390);
      player2.setPositionY(400);
      players.add(player2);
   }
   
   // Returns the Names ArrayList
   public ArrayList<String> getNames(){
     return Names;
   }
   
   
   // Resets the Names ArrayList and enterCount variable which controls which
   //name is being entered (player one or player two)
   public void resetNames(){
     Names.clear();
     Names.add("");
     Names.add("");
     enterCount = 0;
   }
  
  // Adds a character to the i-th element of the Names ArrayList 
   public void setNames(int i, char text ){
     String name = Names.get(i);
     name += text;
     Names.remove(i);
     Names.add(i, name);
   }
   
   // if backspace is pressed this removes the last character from the name attribute
   public void removeChar(int i){
     String name = Names.get(i);
     name = name.substring(0, name.length() - 1);
     Names.remove(i);
     Names.add(i, name);
   }
   
    // if this is called it means two player mode is slected
   public void setTwoPlayer(boolean multi){
     activePlayers = 2;
     twoPlayer = multi;
   }
    
   // Returns the value of twoPlayer (i.e. if in two player or not)
   public boolean getTwoPlayer(){
     return twoPlayer;
   }
   
   // Returns the players ArrayList
   public ArrayList<Player> getPlayer(){
     return players;
   }
   
   // Sets the value of trackbase to the Track passed in as an argument
   public void setTrack(Track newTrack){
     trackbase = newTrack;
   }

  // Instantiates two bots and adds them to the bots ArrayList. 
  //If twoPlayer is false, it will add 1-3 additional bots to the ArrayList beyond the two made on start up
  //, depending on the difficulty level.
   public ArrayList<bot> makeBots(){
     bot1 = new bot();
     bot2 = new bot();
     bots.add(bot1);
     bots.add(bot2);
     if(!twoPlayer){
       bot3 = new bot();
       bots.add(bot3);
       if(difficultyLevel >= 2){
         bot bot4 = new bot();
         bots.add(bot4);
       } 
       if(difficultyLevel >= 3){
         bot bot5 = new bot();
         bots.add(bot5);
       }
     }
     return bots;
   }
   
   // Returns the bots ArrayList
   public ArrayList<bot> getBots(){
      return bots;
   }
   
   // Sets the positions of the bots randomly, ensuring there are no overlapping positions
   //between bots
   public void setBotPositions(){
      for (bot bot: this.bots){
         bot.setPositionX(random(150,430));
         while (!checkBotGaps(bot)){
            bot.setPositionX(random(150,430));
         }
         bot.setPositionY(random(500,700));
      }
   }
  
   // Checks the horizontal distance between each bot to make sure there is no overlap
   public boolean checkBotGaps(bot bot){
      float leftGap = bot.getPositionX()-80;
      float rightGap = bot.getPositionX()+80;
      for (bot bot1: bots){
         float xPos = bot1.getPositionX();
         if (xPos!=bot.getPositionX()){
            if (xPos>leftGap && xPos<rightGap){
               return false;
            }
         }
      }
      return true;
   }

   // Instantiates two landmines and adds them to the landmines ArrayList. If the difficulty level is >=2 or >=3, it will add 1-2 additional landmines to the ArrayList.
   public ArrayList<objects> makeLandmines(){
     landmine1 = new landmine();
     landmines.add(landmine1);
     landmine2 = new landmine();
     landmines.add(landmine2);
     if(difficultyLevel >= 2){
       objects landmine3 = new landmine();
       landmines.add(landmine3);
     } 
     if(difficultyLevel >= 3){
       objects landmine4 = new landmine();
       landmines.add(landmine4);
     }
     return landmines;
   }
   
   // Returns the landmines ArrayList
   public ArrayList<objects> getLandmines(){
     return landmines;
   }
   
   // Sets the value of results to the Table passed in as an argument
   public void setTable(Table results1){
     results = results1;
   }
   
   // Returns the results Table
   public Table getTable(){
     return results;
   }
   
   // Sets the value of currentScreen to the CurrentScreen passed in as an argument
   //this is to allow the screen object to be passed around various methods in monaco.pde without the use of a 
   //global variable
   public void setEntryScreen(CurrentScreen screen){
     currentScreen = screen;
   }
   
   // Returns the screen object
   public CurrentScreen getEntryScreen(){
     return currentScreen;
   }
   
   //Sets the screen object to null.
   public void wipeEntryScreen(){
     currentScreen = null;
   }
   
   
   //Returns the filename of the results file
   public String getFileName(){
     return fileName;
   }
   
   //Adds a row of information to a list of row information for the leaderboard
   public void setRowInfo(String info){
     if(rowInfo.size() < 3){
        rowInfo.add(info);
     }
   }
   
   public void resetRowInfo(){
     rowInfo.clear();
   }
   
   //Returns the list of row information for the leaderboard
   public ArrayList<String> getRowInfo(){
     return rowInfo;
   }
   
   // Creates tanks and adds them to a list of tanks.
   public ArrayList<objects> makeTanks(){
     tank1 = new Tank();
     tanks.add(tank1);
     tank2 = new Tank();
     tanks.add(tank2);
     if(difficultyLevel >= 2){
       objects tank3 = new Tank();
       tanks.add(tank3);
     } 
     if(difficultyLevel >= 3){
       objects tank4 = new Tank();
       tanks.add(tank4);
     }
     return tanks;
   }
   
   
   //Returns the list of tanks.
   public ArrayList<objects> getTanks(){
     return tanks;
   }

   //Removes all bots from the game.
   public void removeBots(){
      bots = null;
      bots = new ArrayList<bot>();
   }
   
   //Removes all tanks from the game.
   public void removeTanks(){
     tanks = null;
     tanks = new ArrayList<objects>();
   }
   
   //Removes all landmines from the game.
   public void removeLandmines(){
     landmines = null;
     landmines = new ArrayList<objects>();
   }
   
   //Recreates the player object.
   public void recreatePlayer(){
      Player player1 = new Player();
      player1.setSpeed(playerMovement);
   }
   
   //Returns the track object.
   public Track getTrack(){
     return trackbase;
   }
   
   //Set the difficulty level of the game and the base speed for various objects
   public void setDifficulty(int level){
      if(level > 4){
         difficultyLevel = 1;
      }
      difficultyLevel = level;
      if(difficultyLevel == 1){
        playerMovement = 2;
      } else if(difficultyLevel == 2){
        playerMovement = 4;
      } else if(difficultyLevel == 3){
        playerMovement = 6;
      } else if(difficultyLevel == 4){
        playerMovement = 8;
      }
      players.get(0).setSpeed(playerMovement);
      if(twoPlayer){
        players.get(1).setSpeed(playerMovement);
      }
      trackbase.setSpeed(playerMovement);
      for (bot bot: bots){
          bot.setSpeed(playerMovement);
        }
   }
   
   //Returns the player's movement speed.
   public int getPlayerMovement(){
     return playerMovement;
   }
   
   //Returns the difficulty level of the game.
   public int getDifficulty(){
     return difficultyLevel;
   }
   
   //Returns the current state of the game.
   public int getGameState(){
     return gameState;
   }
   
   //Sets the current state of the game.
   public void setGameState(int newGameState){
      if(newGameState > 7 || newGameState <0){
         gameState = 0;
         return;
      } else{
         gameState = newGameState;
      }
   }
   
   //Stops the real-time timer.
   public void stopTimer(){
     realTimeTimer.stopTimer();
   }
   
   // Returns the current score of the player
   public int getScore(){
     return score;
   }
   
   
   //Set the score by difficulty 
   public void setScore(){
     score = realTimeTimer.getRunTime()*getDifficulty();
   }
   
   
   //Get time
   public RealTimeTimer getTimer(){
     return realTimeTimer;
   }
   
   //Reset score
   public void resetScore(){
     score=0;
   }
   
   //Reset time
   public void resetTime(){
     realTimeTimer.resetTimer();
   }
   
   
   //check key board type
   public boolean getKeyboard(){
     return keyboardType;
   }
   
   //this changes which keys respond to players, it is called at set intervals in hard mode in single player only
   public void changeKeyboard(){
     if(getDifficulty()>2 && !twoPlayer){
       if(keyboardType==true){
         keyboardType=false;
       }
       else{
         keyboardType=true;
       }
     }
   }
   
   public void resetKeyboardType(){
     keyboardType = true;
   }
   
   //Get countdown time
   public int getCountdownTime(){
     return countdown.getRunTime();
   }
   
   //Reset countdown time
   public void resetCountdownTime(){
     countdown.resetTimer();
   }
   
   //Stop countdown time
   public void stopCountdown(){
     countdown.stopTimer();
   }

  //Create explode animation
   public void exploAnimation(){
      if (exploding == true){
         exploding = false;
      } else {
          exploding = true;
          explosionIndex = 0;
      }
   }
   
   
   //Set explode animation
   public void setExploding(){
     exploding = true;
   }
   
   //Reset explode animation
   public void resetExploding(){
     exploding = false;
   }
   
   //Get explode animation
   public boolean getExploding(){
     return exploding;
   }
   
   //Reset live
   public void resetLives(){
     players.get(0).resetLives();
     if(twoPlayer){
       players.get(1).resetLives();
     }
   }
   
   //Reset player position
   public void resetPlayersPosition(){
     players.get(0).setPositionX(290);
     players.get(0).setPositionY(400);
     if(twoPlayer){
       players.get(0).setPositionX(190);
       players.get(0).setPositionY(400);
       players.get(1).setPositionX(390);
       players.get(1).setPositionY(400);
     }
   }

   //Remove player 
   public void removePlayer(Player player){
     
     players.remove(player);
   }
   
   //Get Exploding Index
   public int getExplodingIndex(){
      return explosionIndex;
   }
   
   //Set Exploding Index
   public void setExplodingIndex(int i){
      explosionIndex = i;
   }
   
   //Shift player, this is called by the crash detectors or the player class
   //if the shift was left to the classes themselves it would not be possible to 
   //shift the cars easily and in different directions
   public void shiftPlayers(){
     players.get(0).setPositionY(players.get(0).getPositionY() + 40);
     players.get(1).setPositionY(players.get(1).getPositionY() - 40);
   }
   
   
   //Reset instance for gameover
   //this resets various attributes to ensure a new game starts with a clean slate
   public void reset(){ 

      difficultyLevel = 0; playerMovement = 3; score = 0;
      bots = new ArrayList<bot>(4);
      realTimeTimer = new RealTimeTimer(System.currentTimeMillis());
      Names = new ArrayList<String>();
      Names.add("");
      Names.add("");
      landmines = new ArrayList<objects>(4);
      tanks = new ArrayList<objects>(4);
      countdown = new RealTimeTimer(System.currentTimeMillis());
      countdown.stopTimer();
      keyboardType=true;
      players = new ArrayList<Player>();
      Player player1 = new Player();
      player1.setSpeed(playerMovement);
      players.add(player1);
      Player player2 = new Player();
      player2.setSpeed(playerMovement);
      player2.setPositionX(390);
      player2.setPositionY(400);
      players.add(player2);
      twoPlayer = false;
      explosion = new PImage[8];
      exploding = false;
      explosionIndex = 0;
      enterCount = 0;
      activePlayers = 1;
   }
}
