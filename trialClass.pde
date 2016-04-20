

myGraph g1;
PImage doge;
color clr = color(10, 140, 140); // color(#FF0000);

void setup()
{
  size(displayWidth, displayHeight);
  doge=loadImage("doge.png"); //icon
  g1 = new myGraph(0, 0, 0, 0, clr, doge);
}

void draw()
{
  g1.drawObject(); //
}
