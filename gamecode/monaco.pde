import processing.core.PApplet;
import processing.sound.*; //<>// //<>// //<>// //<>//
import java.nio.file.Files;
import java.util.concurrent.TimeUnit;
import ddf.minim.*;
Minim minim;
AudioPlayer backgroundAudio;
AudioPlayer explodeAudio;
AudioPlayer gameOverAudio;
AudioPlayer buttonClickAudio;
AudioPlayer engineAudio;
PFont unicodeFont;
PFont racingFont;
SoundFile file1;
String audioName = "Data/racing.aif";
String audioPath;
model game;

Runnable task=() -> game.changeKeyboard();
ScheduledExecutorService executor = Executors.newScheduledThreadPool(1);

void setup(){
    size(600,800);
    game = new model();
    loadImages();
    createFileIfNotExists();
    minim = new Minim(this);
    backgroundAudio = minim.loadFile("Data/racing.aif");
    explodeAudio = minim.loadFile("Data/expl0.mp3");
    gameOverAudio = minim.loadFile("Data/gamecode_Data_carcrashEQ.aiff");
    buttonClickAudio=minim.loadFile("Data/Keystroke.mp3");
    engineAudio=minim.loadFile("Data/Engine.mp3");
    Track track = new Track(game.trackImage);
    track.setSpeed(game.getPlayerMovement());
    game.setTrack(track);
    unicodeFont = createFont("Arial Unicode MS", 30);//Use unicode font in order to print heart symbol
    textFont(unicodeFont);
    racingFont = createFont("Data/Dankduck.ttf", 45);
    executor.scheduleAtFixedRate(task, 10, 10, TimeUnit.SECONDS);
}

// key states for left, up, right, down, a, w, d, s keys
boolean[] keyStates = new boolean[8];
  final int left = 0;
  final int up = 1;
  final int right = 2;
  final int down = 3;
  final int aKey = 4;
  final int wKey = 5;
  final int dKey = 6;
  final int sKey = 7;

 // https://stackoverflow.com/questions/21376781/how-processing-knows-that-user-is-pressing-multiple-key-at-the-same-time
  void keyPressed(){
    int keyVal;
    if (key==CODED) {
        keyVal = keyCode;
    } else {
        keyVal = key;
    }
    if(!game.getTwoPlayer()){
      singlePlayerPresses(keyVal);
    } else{
      twoPlayerPresses(keyVal);
    }
  }

void singlePlayerPresses(int keyVal){
  if(game.getKeyboard()){
    arrowKeys(keyVal);
  } else{
    wasdKeys(keyVal);
  }
}

void twoPlayerPresses(int keyVal){
    switch (keyVal){
    case LEFT :
      keyStates[left]=true;
      break;
    case UP:
      keyStates[up]=true;
      break;
    case RIGHT:
      keyStates[right]=true;
      break;
    case DOWN:
      keyStates[down]=true;
      break;
    case 'a'|'A':
      keyStates[aKey]=true;
      break;
    case 'w'|'W':
      keyStates[wKey]=true;
      break;
    case 'd'|'D':
      keyStates[dKey]=true;
    break;
    case 's'|'S':
      keyStates[sKey]=true;
      break;
    default:
      break;
    }
}

void arrowKeys(int keyVal){
  switch (keyVal){
    case LEFT :
      keyStates[left]=true;
      break;
    case UP:
      keyStates[up]=true;
      break;
    case RIGHT:
      keyStates[right]=true;
      break;
    case DOWN:
      keyStates[down]=true;
      break;
    default:
      break;
  }
}

void wasdKeys(int keyVal){
  switch (keyVal){
    case 'a'|'A':
      keyStates[left]=true;
      break;
    case 'w'|'W':
      keyStates[up]=true;
      break;
    case 'd'|'D':
      keyStates[right]=true;
    break;
    case 's'|'S':
      keyStates[down]=true;
      break;
    default:
      break;
  }
}

 // handle key releases
  void keyReleased(){
    int keyVal;
    if (key==CODED) {
        keyVal = keyCode;
    } else {
        keyVal = key;
    }
    //Prevents the keyboard change being called in two player mode
    if(!game.getTwoPlayer()){
      singlePlayerReleased(keyVal);
    } else{
      twoPlayerReleased(keyVal);
    }
    //special cases for keyboard entry in other screens such as username entry and difficulty
   if(game.getGameState() == 4){
     UserNameCarChoice screen = (UserNameCarChoice)game.getEntryScreen();
     screen.KEYPRESSED(key);
   }
    if(game.getGameState() == 2){
     Difficulty1 screen = (Difficulty1)game.getEntryScreen();
     if(screen != null){
       screen.KEYPRESSED(key);
     }
    }
   if(game.getGameState()==5){
     GamePlay screen = (GamePlay)game.getEntryScreen();
     screen.KEYPRESSED(key);
   }
   else if(game.getGameState()==6){
     PauseGame screen = (PauseGame)game.getEntryScreen();
     screen.KEYPRESSED(key);
   }
  }

  void singlePlayerReleased(int keyVal){
        switch (keyVal){
        case LEFT:
          keyStates[left]=false;
          break;
        case 'a'|'A':
          keyStates[left]=false;
          break;
        case UP:
          keyStates[up]=false;
          break;
        case 'w'|'W':
          keyStates[up]=false;
          break;
        case RIGHT:
          keyStates[right]=false;
          break;
        case 'd'|'D':
          keyStates[right]=false;
          break;
        case DOWN:
          keyStates[down]=false;
          break;
        case 's'|'S':
          keyStates[down]=false;
          break;
        default:
          break;
    }
  }

    void twoPlayerReleased(int keyVal){
        switch (keyVal){
        case LEFT:
          keyStates[left]=false;
          break;
        case 'a'|'A':
          keyStates[aKey]=false;
          break;
        case UP:
          keyStates[up]=false;
          break;
        case 'w'|'W':
          keyStates[wKey]=false;
          break;
        case RIGHT:
          keyStates[right]=false;
          break;
        case 'd'|'D':
          keyStates[dKey]=false;
          break;
        case DOWN:
          keyStates[down]=false;
          break;
        case 's'|'S':
          keyStates[sKey]=false;
          break;
        default:
          break;
    }
  }

private void addToTable(){
  Table results = game.getTable();
  //this takes the previously created table object, adds the latest results to it, re-sorts and
  //then returns to model to print to the screen
  if(game.tableLoad){
    if(!game.getTwoPlayer()){
       game.resetRowInfo();
       TableRow newRow = results.addRow();
       newRow.setString("user", game.getNames().get(0));
       newRow.setInt("score", game.getScore());
       String date = String.valueOf(day()) + "/" + String.valueOf(month());
       newRow.setString("date", date);
       results.sortReverse("score");
       for(int i = 0; i < 3 && i < results.getRowCount(); i++){
         String rowInfo = results.getString(i, "user") + "  " + results.getString(i, "score") + "  " + results.getString(i, "date");
         game.setRowInfo(rowInfo);
      }
    saveTable(results, game.getFileName());
    }
    game.tableLoad = false;
  }
}

//if the file "results.csv" does not exist it creates it
private void createFileIfNotExists(){
  try {
    File f = new File(sketchPath(game.getFileName()));
    if(!f.createNewFile()){
      loadDataFromTable();
    } else{
      Table results = new Table();
      results.addColumn("user");
      results.addColumn("score");
      results.addColumn("date");
      results.setColumnType("score", Table.INT);
      game.setTable(results);
    }
  } catch(IOException ioe) {
    println("Can't seem to create file " + game.getFileName());
  }
}

//if the file does exist it loads the information from it and stors in model
private void loadDataFromTable(){
  Table results = loadTable(sketchPath(game.getFileName()), "header");
  results.setColumnType("score", Table.INT);
  game.setTable(results);
}

private void loadImages(){
    size(600,800);
    frameRate(100);
    thread("loadBot");
    thread("loadTrack");
    thread("loadObjects");
    thread("loadScreens");
    thread("loadExpl");
    thread("loadText");
    audioPath = sketchPath(audioName);
    file1 = new SoundFile(this, audioPath);
    game.makeBots();
    game.setBotPositions();
    game.makeLandmines();
    game.makeTanks();
}


public void loadExpl(){
  for (int i=0; i<game.explosion.length; i++){
     game.explosion[i] = loadImage("data/expl" + i + ".png");
  }
}


public void loadBot(){
  game.blueBotImg=requestImage("Data/blueBot.png");
  game.pinkBotImg =requestImage("Data/pinkBot.png");
  game.playerImg =requestImage("Data/possCar.png");
}

public void loadTrack(){
  game.trackImage = requestImage("Data/tracksmaller.jpg");
  game.startTrack = requestImage("Data/startTrack-min.jpg");
}

public void loadObjects(){
  game.landMineImage = requestImage("Data/bomb.png");
  game.tankImage = requestImage("Data/simpletank.png");
  game.tankImageRev = requestImage("Data/simpletankRev.png");
}

public void loadScreens(){
  game.StartImage = loadImage("Data/badge.png");
  game.diffScreenImg = loadImage("Data/diffScreen/diffScreenImg.png");
  game.onePlayerScreen = loadImage("Data/usernameScreen/onePlayerScreen.png");
  game.twoPlayerScreen = loadImage("Data/usernameScreen/twoPlayerScreen.png");
  game.onePGameOver = loadImage("Data/gameOver/singlePlayer.png");
  game.twoPGameOver = loadImage("Data/gameOver/twoPlayer.png");
}

public void loadText(){
  game.backText = requestImage("Data/diffScreen/back-text.png");
  game.easyText = requestImage("Data/diffScreen/easy-text.png");
  game.medText = requestImage("Data/diffScreen/med-text.png");
  game.hardText = requestImage("Data/diffScreen/hard-text.png");
  game.insanityText = requestImage("Data/diffScreen/insanity-text.png");
  game.SinglePlayer = loadImage("Data/startScreen/singlePlayerText.png");
  game.twoPlayerText = loadImage("Data/startScreen/twoPlayerText.png");
  game.button = requestImage("Data/startScreen/button.png");
  game.menu = loadImage("Data/gameOver/mainMenu2.png");
  game.newGame = loadImage("Data/gameOver/newGame2.png");
  game.pause = loadImage("Data/pauseText.png");
}


void draw() {
  // draw different screens based on game state
  if(game.getGameState() == 0) {
    startScreen();
  } else if (game.getGameState() == 1) {
    game.tableLoad = true;
     countDown();
  } else if(game.getGameState() == 2) {
    difficulty();
  } else if(game.getGameState() == 3) {
     addToTable();
     gameOver();
  } else if(game.getGameState() == 4){
     userNameCarChoice();
  } else if(game.getGameState() == 5) {
     gamePlay();
  } else if(game.getGameState() == 6) {
    pauseScreen();
  } else if(game.getGameState() == 7) {
    leaderBoard();
  }
}


//calls the various screen classes and display methods
public void gameOver() {
  game.stopTimer();
  GameOver screen = new GameOver();
  screen.newPositions();
  Track track = game.getTrack();
  track.resetTrack();
  screen.display();
}


public void startScreen() {
  CurrentScreen screen = new StartScreen();
  screen.display();
}

public void countDown(){
  CountDown screen = new CountDown();
  screen.display();
}

public void gamePlay(){
  GamePlay screen = new GamePlay();
  screen.display();
  game.setEntryScreen(screen);
}

public void difficulty() {
  CurrentScreen screen = new Difficulty1();
  screen.display();
  game.setEntryScreen(screen);
}

public void userNameCarChoice(){
  CurrentScreen screen = new UserNameCarChoice();
  screen.display();
  game.setEntryScreen(screen);
}

public void pauseScreen(){
  CurrentScreen screen = new PauseGame();
  screen.display();
  game.setEntryScreen(screen);
}

public void leaderBoard(){
  CurrentScreen screen = new LeaderBoard();
  screen.display();
  game.setEntryScreen(screen);
}
