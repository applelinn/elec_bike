import org.gicentre.utils.stat.*;

public class myGraph
{
  color lineColor;
  int startX, startY, lenX, lenY;
  PImage icon;
  float betBarTxt; //spacing between bar and its markings
  int maxSpeed = 250; //speed at lineColor
  int numOfIcon; //number of icons to display
  int rPadding, lPadding, topPadding; //padding from object side
  int rpm;
  color fontColor;
  float rpmSize, titleSize;
  String title;
  
  //constructor
  myGraph(int tempStartX, int tempStartY, int tempLenX, int tempLenY, color tempLineColor, PImage tempIcon, String tempTitle)
  {
    //bring in variables
    startX = tempStartX;
    startY = tempStartY;
    lenX = tempLenX;
    lenY = tempLenY;
    lineColor = tempLineColor;
    icon = tempIcon;
   
    rpm = 0;
    rpmSize = lenX/15;
    titleSize = lenX/20;
    rPadding = lenX/80;
    title = tempTitle;
    topPadding = lenY/80;
    fontColor = lineColor;  //XYChart lineChart = new XYChart(act2.this);
    
    //bring in icon
    
    // bar
    // generate bar from color choice
    
    //load icon
  }

  //update rpm
  public void setRpm(int tempRpm)
  {
    rpm = tempRpm;
    return;
  }
  
  //update graph incl change color
  
  //update # of icons
  public void updateIcon(int num)
  {
    numOfIcon = num;
    return;
  }
  
  //generate bar with markings
  private void genBar(int startX, int startY, int w, int h)
 {
    color zeroColor = lerpColor(#ffffff, lineColor, 0.1); // color(#ffffff); 
    for (int l = 0; l < w; l++)
    {
      color sc= lerpColor(zeroColor, lineColor, (float) l / (float) w);
      stroke(sc);
      line(l+startX, 0+startY, l+startX, h+startY);
    }
    
    betBarTxt = (float) h/3;
    
    //for the markings
    textSize(h*0.7);
    textAlign(CENTER, TOP);
    fill(lineColor);
    text("0 RPM", startX, startY + betBarTxt + h); //zero
    text("100 RPM", startX + (float) w/maxSpeed*100, startY + betBarTxt + h); //100
    text("200 RPM", startX + (float) w/maxSpeed*200, startY + betBarTxt + h); //200
    text("250 RPM", startX + (float) w/maxSpeed*250, startY + betBarTxt + h); //250
    
    
   return;
 }
 
 //draw rpm
 private void drawRpm()
 {
   //draw rpm
   textAlign(RIGHT, TOP); 
   fill(fontColor);
   textSize(rpmSize);
   text(rpm + " RPM", lenX-rPadding, 100); //temp y value
   return;
 }
 
 private void drawBorder()
 {
   fill(#000000,0);
   stroke(#000000);
   rect(startX, startY, lenX, lenY); //draw border
   return;
 }
 
 private void drawTitle()
 {
   fill(fontColor);
   textSize(titleSize);
   textAlign(CENTER, TOP);
   text(title, startX + (float)lenX/2, startY + topPadding);
 }
 
 //draw whole object
 public void drawObject()
 {
   drawBorder(); //draw border
   
   genBar(50, 10, 700, 30); //speed bar and markings --temp values
   
   drawRpm(); //draw rpm
   
   drawTitle();
   
   return;
 }
}
