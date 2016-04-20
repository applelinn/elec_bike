

myGraph g1;
PImage doge;
color clr = color(10, 140, 140); // color(#FF0000);

float[] dataxP =  {0,1,2,3,4,5,6,7,8,9,10};
float[] datayP =  {0,0,0,0,0,0,0,0,0,0,0};

void setup()
{
  size(displayWidth, displayHeight);
  doge=loadImage("doge.png"); //icon
  g1 = new myGraph(40, 10, displayWidth-100, displayHeight-100, clr, doge, "Bike 1");
  g1.setData(dataxP, datayP);
}

void draw()
{
  g1.drawObject(); 
}
