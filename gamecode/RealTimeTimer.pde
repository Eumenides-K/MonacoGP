public class RealTimeTimer{
  private long startTime;
  private boolean stopTimer=false;
  private int runTime;
  
  // constructor
  public RealTimeTimer(long startTime){
    this.startTime=startTime;
  }
  
  // get time elapsed in current timing period
  public int getRunTime(){
    if(!stopTimer){
      runTime=(int)((System.currentTimeMillis()-startTime)/1000.0);
    }
    return runTime;
  }
  
  // pause the timer
  public void stopTimer(){
    stopTimer=true;
  }
  
  // set a new timer
  public void resetTimer(){
    startTime=System.currentTimeMillis();
    stopTimer=false;
  }
}
