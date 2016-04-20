import org.gicentre.utils.stat.*;

public class myGraph
{
  color lineColor;
  int startX, startY, lenX, lenY;
  PImage icon;
  int fontSpeed;
  float betBarTxt; //spacing between bar and its markings
  int maxSpeed; //speed at lineColor
  
  //constructor
  myGraph(int tempStartX, int tempStartY, int tempLenX, int tempLenY, color tempLineColor, PImage tempIcon)
  {
    //bring in variables
    startX = tempStartX;
    startY = tempStartY;
    lenX = tempLenX;
    lenY = tempLenY;
    lineColor = tempLineColor;
    icon = tempIcon;
   
    maxSpeed = 250;  //XYChart lineChart = new XYChart(act2.this);
    
    //bring in icon
    
    // bar
    // generate bar from color choice
    
    //load icon
  }

  //update and display rpm
  
  //update graph incl change color
  
  //update # of icons
  
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
 
 //draw whole object
 public void drawObject()
 {
   genBar(50, 10, 700, 30); //speed bar and markings
   return;
 }
  
  
}
