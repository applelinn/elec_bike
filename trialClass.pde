

myGraph g1;
PImage doge;
color red = color(255, 0, 0); // color(#FF0000);

void setup()
{
  size(displayWidth, displayHeight);
  doge=loadImage("doge.png"); //icon
  g1 = new myGraph(0, 0, 0, 0, red, doge);
}

void draw()
{
  g1.drawObject(); //
}
