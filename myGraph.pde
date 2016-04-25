import org.gicentre.utils.stat.*;

public class myGraph
{
  color lineColor, fontColor, startColor, darkerColor;
  float startX, startY, lenX, lenY;
  PImage icon;
  float betBarTxt; //spacing between bar and its markings
  int maxSpeed = 250; //speed at lineColor
  int numOfIcon; //number of icons to display
  float rPadding, lPadding, topPadding, botPadding; //padding from object side
  float rpm;
  float rpmSize, titleSize;
  String title;
  XYChart chart;
  PImage led, light;
  
  //constructor
  myGraph(float tempStartX, float tempStartY, float tempLenX, float tempLenY, color tempLineColor, PImage tempIcon, PImage tempLight, String tempTitle, color tempStartColor, color dark)
  {
    //bring in variables
    startX = tempStartX;
    startY = tempStartY;
    lenX = tempLenX;
    lenY = tempLenY;
    lineColor = tempLineColor;
    led = changeHue(tempIcon, lineColor);
    light = changeHue(tempLight, lineColor);
   
    rpm = 0;
    rpmSize = lenX/15;
    titleSize = lenY/10;
    rPadding = lenX/80;
    title = tempTitle;
    topPadding = lenY/80;
    startColor = tempStartColor; // lerpColor(#ffffff, lineColor, 0.1); // color(#ffffff);
    fontColor = startColor;
    darkerColor = dark;
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
    chart.setLineColour(startColor);
    chart.showXAxis(true); 
    chart.showYAxis(true);
  }

//  //update rpm
//  public void setRpm(int tempRpm)
//  {
//    rpm = tempRpm;
//    return;
//  }
  
  //change hue of led to the color theme of object
  private PImage changeHue(PImage source, color hue)
  {
    PImage dest;
    color temp;
    dest = createImage(source.width, source.height, RGB);
    dest.loadPixels();
    source.loadPixels();
    
    for (int x = 0; x < source.width; x++) {
      for (int y = 0; y < source.height; y++ ) {
        int loc = x + y*source.width;
       
        temp=source.pixels[loc];
        colorMode(HSB, 360, 100, 100);
        temp = color(hue(lineColor), saturation(temp), brightness(temp));
        colorMode(RGB, 255, 255, 255, 100);
        dest.pixels[loc] = color(red(temp), green(temp), blue(temp), alpha(source.pixels[loc]) + 1 ); //adjust the transparency effect
        
      }
    }
    dest.updatePixels();
    return dest;
  }
  
  //set Data
  public void setData(float[] dataX, float[] dataY)
  {
    chart.setData(dataX, dataY);
    return;
  }
  
  //update graph incl change color THIS ONE IS NOT DONE YET!!!
  public void updateChart(float dataS, float dataP)
  {
    // shift data for power array
    
    
    //change color
    chart.setLineColour(lerpColor(startColor, lineColor, dataS/maxSpeed));
    
    //update rpm
    rpm = dataS;
    
    //update num of icon
    return;
  }
  
//  //update # of icons
//  public void updateIcon(int num)
//  {
//    numOfIcon = num;
//    return;
//  }
  
  //draw icons
  private void drawIcon(int rpm, float startX, float startY, float w, float h)
  {
    
    image(modifyIcon(led, rpm), startX, startY, w, h);
    image(modifyIcon(light,rpm), startX, startY - h*0.1, w, h);
    return;
  }
  
  
  //modify image according to rmp
  private PImage modifyIcon (PImage source, float rpm)
  {
    PImage destination;
    destination = createImage(source.width, source.height, RGB);
    destination.loadPixels();
    source.loadPixels();
    
    for (int x = 0; x < source.width; x++) {
      for (int y = 0; y < source.height; y++ ) {
          int loc = x + y*source.width;
          colorMode(HSB, 360, 100, 100);
         
          color temp = source.pixels[loc];
          temp=color(hue(temp),constrain(10  + rpm, 10, brightness(temp)), constrain(saturation - rpm, 10, 100));  // increase brightness and descrease saturation
          colorMode(RGB, 255, 255, 255, 100);
          destination.pixels[loc] = color(red(temp), green(temp), blue(temp), constrain(alpha(source.pixels[loc]) + rpm - 20, 1, alpha(source.pixels[loc])+1) ; //make less transparent
        }
      }
    destination.updatePixels();
    return destination;
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
   text(rpm + " RPM", startX + lenX-rPadding, startY + titleSize); //temp y value
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
   fill(darkerColor);
   textSize(titleSize);
   textAlign(CENTER, TOP);
   text(title, startX + (float)lenX/2, startY + topPadding);
 }
 
 //draw whole object
 public void drawObject()
 {
   // drawBorder(); //draw border
   
   genBar(startX + lPadding + lenX/30, startY + lenY*0.85, lenX * 0.7, lenY/25); //speed bar and markings --temp values
   
   drawRpm(); //draw rpm
   
   drawTitle(); // draw title
   
   textSize(lenY/50); //text size for graph
   chart.draw(startX + lPadding*2, startY + topPadding*3 + titleSize, lenX *0.7, lenY*0.7); //draw graph
   
   drawIcon(0, startX + lenX *0.7, startY + lenY*0.3, lenX*0.3, lenY*0.35); //drawIcon
   return;
 }
}
