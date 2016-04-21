myGraph[] g;
color[] clr;
PImage doge;
//color clr = color(10, 140, 140); // color(#FF0000);
float smallW; //small object width
float smallH; //small object height

float[] dataxP =  {0,1,2,3,4,5,6,7,8,9,10};
float[] datayP =  {0,0,0,0,0,0,0,0,0,0,0};
color[] startClr;
color[] darker;

void setup()
{
  size(displayWidth, displayHeight);
  doge=loadImage("doge.png"); //icon
  g = new myGraph[5];
  smallW = displayWidth/4;
  smallH = displayHeight*0.4;
  
  //color
  clr = new color[5];
  startClr = new color[5];
  darker = new color[5];
  
  //small bikes
  clr[0]= color(#4cbb17); // (#6A8347); // (#71B238);
  startClr[0] = color(#b7ff49);
  darker[0] = color(#138808);
  
  clr[1]= color(#00d2ff);
  startClr[1] = color (#Ccf6ff); // (lerpColor(#ffffff, clr[1], 0.1)); //(#CCFFCC);
  darker[1] = color(#007e99);
  
  clr[2]= color(#7a4b8f);
  startClr[2] = color(#E4ddd3); // (lerpColor(#ffffff, clr[2], 0.1));
  darker[2] = color(#3d2758);
  
  clr[3]= color(#Fb6a4a);
  startClr[3] = color(#Fee5d9); //(lerpColor(#ffffff, clr[3], 0.1));
  darker[3] = color(#Cb181d);
  
  //total
  clr[4]= color(#000000);
  startClr[4] = color(lerpColor(#ffffff, clr[4], 0.1));
  darker[4] = color(#000000);
  
  for(int i = 0 ; i < 4; ++i)
  {
      g[i]= new myGraph(smallW*i, displayHeight-10-smallH, smallW, smallH, clr[i], doge, "Bike " + (i+1), startClr[i], darker[i]);
      g[i].setData(dataxP, datayP);
  }
  
  // the total graph
  g[4] = new myGraph(0, 0, displayWidth, displayHeight-10 - smallH, clr[4], doge, "Total", startClr[4], darker[4]);
  g[4].setData(dataxP, datayP);
}

void draw()
{
  background(#FCFBE3);
  for(int i = 0 ; i < 5; ++i)
  {
    g[i].drawObject(); 
  }
}
