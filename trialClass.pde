

myGraph g1;
PImage doge;
color clr = color(10, 140, 140); // color(#FF0000);

void setup()
{
  size(displayWidth, displayHeight);
  doge=loadImage("doge.png"); //icon
  g1 = new myGraph(40, 10, displayWidth-100, displayHeight-100, clr, doge, "Bike 1");
}

void draw()
{
  g1.drawObject(); //
}
