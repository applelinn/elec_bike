import org.gicentre.utils.stat.*;

public class myGraph
{
  color lineColor, fontColor, startColor;
  int startX, startY, lenX, lenY;
  PImage icon;
  float betBarTxt; //spacing between bar and its markings
  int maxSpeed = 250; //speed at lineColor
  int numOfIcon; //number of icons to display
  int rPadding, lPadding, topPadding, botPadding; //padding from object side
  int rpm;
  float rpmSize, titleSize;
  String title;
  XYChart chart;
  
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
    startColor = lerpColor(#ffffff, lineColor, 0.1); // color(#ffffff);
    fontColor = startColor;
    botPadding = lenY/60;
    lPadding = rPadding;
    
    //create graph
    chart = new XYChart(trialClass.this);
    
    //set up graph
    chart.setYFormat("####.#### W");  // Energy
    chart.setXFormat("0000");      // time   
    chart.setPointSize(5); //temp number
    chart.setLineWidth(8);  //temp number
    chart.setPointColour(lerpColor(#000000, lineColor, 0.5));
  }

  //update rpm
  public void setRpm(int tempRpm)
  {
    rpm = tempRpm;
    return;
  }
  
  //set Data
  public void setData(float[] dataX, float[] dataY)
  {
    // chart.
    return;
  }
  
  //update graph incl change color
  public void updateChart(float dataS, float dataP)
  {
    // shift data
    //change color
    chart.setLineColour(lerpColor(startColor, lineColor, dataS/maxSpeed)); //think about this
    //update rpm
    //update icon
    return;
  }
  
  //update # of icons
  public void updateIcon(int num)
  {
    numOfIcon = num;
    return;
  }
  
  //generate bar with markings
  private void genBar(float startX, float startY, float w, float h)
 {
    color zeroColor = startColor; 
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
   fill(lineColor);
   textSize(titleSize);
   textAlign(CENTER, TOP);
   text(title, startX + (float)lenX/2, startY + topPadding);
 }
 
 //draw whole object
 public void drawObject()
 {
   drawBorder(); //draw border
   
   genBar(startX + lPadding + lenX/60, startY + lenY - botPadding - lenY/25*2, lenX * 0.7, lenY/25); //speed bar and markings --temp values
   
   drawRpm(); //draw rpm
   
   drawTitle(); // draw title
   
   return;
 }
}
