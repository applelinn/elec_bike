myGraph[] g;
color[] clr;
PImage doge;
//color clr = color(10, 140, 140); // color(#FF0000);
float smallW; //small object width
float smallH; //small object height

float[] dataxP =  {0,1,2,3,4,5,6,7,8,9,10};
float[] datayP =  {0,0,0,0,0,0,0,0,0,0,0};

void setup()
{
  size(displayWidth, displayHeight);
  doge=loadImage("doge.png"); //icon
  g = new myGraph[5];
  smallW = displayWidth/4;
  smallH = displayHeight*0.4;
  
  //color
  clr = new color[5];
  //small bikes
  clr[0]= color(10, 140, 140);
  clr[1]= color(140, 10, 140);
  clr[2]= color(140, 140, 10);
  clr[3]= color(10, 140, 140);
  //total
  clr[4]= color(#000000);
  
  for(int i = 0 ; i < 4; ++i)
  {
      g[i]= new myGraph(smallW*i, displayHeight-smallH, smallW, smallH, clr[i], doge, "Bike " + (i+1));
      g[i].setData(dataxP, datayP);
  }
  
  // the total graph
  g[4] = new myGraph(0, 0, displayWidth, displayHeight - smallH, clr[4], doge, "Total");
  g[4].setData(dataxP, datayP);
}

void draw()
{
  for(int i = 0 ; i < 5; ++i)
  {
    g[i].drawObject(); 
  }
}
