myGraph[] g;
PImage doge;
color clr = color(10, 140, 140); // color(#FF0000);
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
  smallH = displayHeight*0.3;
  
  for(int i = 0 ; i < 4; ++i)
  {
      g[i]= new myGraph(smallW*i, displayHeight*0.7, smallW, smallH, clr, doge, "Bike " + i);
      g[i].setData(dataxP, datayP);
  }
}

void draw()
{
  for(int i = 0 ; i < 4; ++i)
  {
    g[i].drawObject(); 
  }
}
