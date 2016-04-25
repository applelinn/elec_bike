import org.gicentre.utils.stat.*;    // For chart classes.
import processing.serial.*;

Serial port;
float readS; //read speed
float readP; //read power
// Displays a simple line chart representing a time series.

//data initialization
float[] dataxP =  {0,1,2,3,4,5,6,7,8,9,10};
float[] datayP =  {0,0,0,0,0,0,0,0,0,0,0};

boolean isRead=false;

//PImage doge;
//done in class PImage bar;
PImage led, light;

//reading txt stuff
//String[] appliance;
//float[] rating; //watts req for appliance
//String[] lines;
//String[] temp;
//PrintWriter output;

int prev = 0;
float sum = 0;
long time = 0;
float tempRpm = 0;

GraphObj[] g;
float smallW; //small object width
float smallH; //small object height
color[] startClr;
color[] darker;
color[] clr;

// Loads data into the chart and customises its appearance.
void setup()
{
  size(displayWidth, displayHeight);
  textFont(createFont("Arial",10),10);

//----------------------------------------oop part---------------------------------------------------------/ 
  //load images
  led = loadImage("led.png");
  light = loadImage("light.png");
  
  //size of individual bike graphs
  smallW = displayWidth/4;
  smallH = displayHeight*0.4;
  
  //colors of all graphs. each graph has 3 colors, the main clr a lighter startCLr and a darker darker
  clr = new color[5];
  startClr = new color[5];
  darker = new color[5];
  
  //small bikes
  clr[0]= color(#4cbb17); // (#6A8347); // (#71B238);
  startClr[0] = color(#c5ff6d); //(#b7ff49);
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
  
  //create new charts
  g = new GraphObj[5];
  //the individual bikes graph
  for(int i = 0 ; i < 4; ++i)
  {
      g[i]= new GraphObj(smallW*i, displayHeight-10-smallH, smallW, smallH, clr[i], led, light, "Bike " + (i+1), startClr[i], darker[i]);
      g[i].setData(dataxP, datayP); //set intial data
  }
  // the total graph
  g[4] = new GraphObj(0, 0, displayWidth, displayHeight-10 - smallH, clr[4], led, light, "Total", startClr[4], darker[4]);
  g[4].setData(dataxP, datayP);
//-------------------------oop end----------------------------------------------------------/

//--------------------------arduino part----------------------------------------------------/
  port = new Serial(this, "COM3", 9600);
  port.bufferUntil('\n'); // take in a line at a time
//--------------------------arduino end-----------------------------------------------------/

//--------------------------data extraction (for testing time only)--------------------------------------/

//  //set data for energy req to use appliances
//  lines = loadStrings("data.txt"); //each lines[i] has the format "appliance rate"
//  appliance = new String[lines.length];
//  rating = new float[lines.length];
//  //extract numbers
//  for(int i=0; i<lines.length; i++)
//  {
//    temp = split(lines[i], ' ');
//    text(temp[0] ,100, 100);
//    appliance[i]=(temp[0]);
//    rating[i] = (Float.valueOf(temp[1]).floatValue());
//  }
  
//  //for data
//  output = createWriter( "data2.txt" );
//------------------------data extraction end------------------------------------------------/
}

//-------------------------DRAW---------------------------------------------------------------------------------------------------------------/
void draw()
{
  background(#000000); //(#313131); 
  textSize(15);
  
  //--------------------update data-----------------------------------------------------------/
  if(isRead) //if there is data to read then update
  {
    //-----------------------------update rpm---------------------------/
    tempRpm = readS; //temporarily read only one value
    for(int i = 0 ; i < 5; i++)
    {
      g[i].setRpm(tempRpm); //temporarily read only one value
    }
    
    //------------------------------update grpah--------------------------/
    //update the power chart
    
    for(int i = 0; i <5 ; i++)
    {
      g[i].updateChart(readP);
    }
      

    isRead=false;
  }
  


//  //for data testing
//  if (prev != (int) tempxS[10]) //(prev < (int)tempyS[10] || prev > (int)tempyS[10] || prev == (int) tempyS[10])
//  {
//    sum = sum + tempyP[10];
//    output.println(tempxS[10] + " " + tempyS[10] + " " + tempyP[10] + sum);
//    prev = (int) tempxS[10];
//    output.flush();
//  }

  //draw objects
  for(int i = 0 ; i < 5; ++i)
  {
    g[i].drawObject(); 
  }
  
}

void serialEvent(Serial port)
{
  readS = float(port.readStringUntil(' '));
  readP = float(port.readStringUntil('\n'));
  isRead=true;
}


// for test data
//void keyPressed() {
//  output.flush();  // Writes the remaining data to the file
//  output.close();  // Finishes the file
//  exit();  // Stops the program
//}