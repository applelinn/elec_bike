import org.gicentre.utils.stat.*;

public class myGraph
{
  color lineColor;
  int startX, startY, lenX, lenY;
  PImage icon;
  
  //constructor
  myGraph(int tempStartX, int tempStartY, int tempLenX, int tempLenY, color tempLineColor, PImage tempIcon)
  {
    //bes
    startX = tempStartX;
    startY = tempStartY;
    lenX = tempLenX;
    lenY = tempLenY;
    lineColor = tempLineColor;
    icon = tempIcon;
     //XYChart lineChart = new XYChart(act2.this);
    
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
    
    //for the markings
    //zero
    //100
    //200
    //250
    
   return;
 }
 
 //draw whole object
 public void drawObject()
 {
   genBar(50, 10, 300, 100); //speed bar
   return;
 }
  
  
}