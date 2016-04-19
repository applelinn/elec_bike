import org.gicentre.utils.stat.*;    // For chart classes.
import processing.serial.*;

Serial port;
float readS; //read speed
float readP; //read power
// Displays a simple line chart representing a time series.

XYChart lineChartS; //speed line chart
XYChart lineChartP; //power linechart

//data initialization
float[] dataxP =  {0,1,2,3,4,5,6,7,8,9,10};
float[] datayP =  {0,0,0,0,0,0,0,0,0,0,0};
float[] dataxS =  {0,1,2,3,4,5,6,7,8,9,10};
float[] datayS =  {0,0,0,0,0,0,0,0,0,0,0};

boolean isRead=false;
color clr=color(255,255,255);
PImage doge;
PImage bar;

String[] appliance;
float[] rating; //watts req for appliance
String[] lines;
String[] temp;
PrintWriter output;
int prev = 0;
float sum = 0;

// Loads data into the chart and customises its appearance.
void setup()
{
  size(displayWidth, displayHeight);
  textFont(createFont("Arial",10),10);

  //create new charts
  lineChartS = new XYChart(this);
  lineChartP = new XYChart(this);

  //set intial data to zero
  lineChartP.setData(dataxP, datayP);
  lineChartS.setData(dataxS, datayS);

  // Axis formatting and labels.
  //lineChartS.showXAxis(true); 
  //lineChartS.showYAxis(true); 
  lineChartP.showXAxis(true); 
  lineChartP.showYAxis(true);

  lineChartS.setYFormat("####.#### W");  // Energy
  lineChartS.setXFormat("0000");      // time     
  lineChartP.setYFormat("#####.#### W");  // Energy
  lineChartP.setXFormat("0000");      // time

  // Symbol colours
  lineChartS.setPointColour(#4A708B);
  lineChartS.setPointSize(5);
  lineChartS.setLineWidth(8);
  // size(1000,800);
  lineChartS.setLineColour(color(178,178,255));
  lineChartS.setAxisColour(#FFFFFF);

  lineChartP.setPointColour(color(125,0,0)); // blue(#4A708B);
  lineChartP.setPointSize(5);
  lineChartP.setLineWidth(8);
  // size(1000,800);
  lineChartP.setLineColour(#87CEEB);
  lineChartP.setAxisColour(#FFFFFF);

  //arduino part
  port = new Serial(this, "COM3", 9600);
  port.bufferUntil('\n');

  //doge part
  doge=loadImage("doge.png");
  
  //load bar img
  bar=loadImage("red bar numbered.png");

  //set data for energy req to use appliances
  lines = loadStrings("data.txt"); //each lines[i] has the format "appliance rate"
  appliance = new String[lines.length];
  rating = new float[lines.length];
  //extract numbers
  for(int i=0; i<lines.length; i++)
  {
    temp = split(lines[i], ' ');
    text(temp[0] ,100, 100);
    appliance[i]=(temp[0]);
    rating[i] = (Float.valueOf(temp[1]).floatValue());
  }
  
  //for data
  output = createWriter( "data2.txt" );
}


long time = 0;
// Draws the chart and a title.
void draw()
{
  background(#313131);
  textSize(15);
  
  //lineChartS.draw(40+lineChartP.getRightSpacing(), 70, width-405,height-520); // (30,400,width-50,height-500);

  lineChartP.draw(30, 60, width-360,height-480);

  float[] tempxS = dataxS;
  float[] tempyS = datayS;    
  float[] tempxP = dataxP;
  float[] tempyP = datayP;

  if(isRead) //if there is data to read then update
  {
    //shift array
    for(int i = 0 ; i < 10 ; i++)
    {
      tempxS[i]=tempxS[i+1];
      tempyS[i]=tempyS[i+1];
      tempxP[i]=tempxP[i+1];
      tempyP[i]=tempyP[i+1];
    }

    tempxS[10] = tempxS[9] + 1;
    tempyS[10] = readS; //tempy[9] + random(10) * 1000;
    tempxP[10] = tempxP[9] + 1;
    tempyP[10] = readP; //tempy[9] + random(10) * 1000;
    isRead=false;

    //color changing for graph
    if(tempyS[10] > 255)
      clr = color(0,255,0);
    else
      clr= color(255, 255-tempyS[10], 255 - tempyS[10]);

    dataxS = tempxS;
    datayS = tempyS;
    dataxP = tempxP;
    datayP = tempyP;
  }

  lineChartS.setData(dataxS, datayS);
  // lineChart.draw(15,15,width-30,height-30);
  lineChartS.setMinX(dataxP[0]);
  lineChartS.setMinY(0);
  lineChartP.setMinY(0);
  lineChartP.setLineColour(clr);

  lineChartP.setData(dataxP, datayP);
  lineChartP.setMinX(dataxP[0]);
  
  lineChartP.setMaxX(dataxP[10]);
  lineChartS.setMaxX(dataxP[10]);

  //rpm number display
  int xRpm=1500;
  int yRpm=60;
  fill(217,217,217);
  // rect(xRpm-150, yRpm-30, 250, 40, 7);

  fill(#ffffff);
  textSize(32);
  textAlign(RIGHT);
  text(tempyS[10], xRpm, yRpm);
  text("RPM", xRpm+80, yRpm);

  //doge
  imageMode(CENTER);
  // Im playful image(doge, xRpm, yRpm+80, tempyS[10]+50, tempyS[10]+50);
  int numLight= (int) (tempyP[10]/rating[0]);
  //testing text(numLight, 100, 100);
  for(int i=0; i<numLight; i++)
  {
    image(doge, xRpm+40-80*(i%4), yRpm+50+100*(i/4), 80, 80);
  }
  
  image(bar, xRpm-800, yRpm+450);
  
  //for data
  if (prev != (int) tempxS[10]) //(prev < (int)tempyS[10] || prev > (int)tempyS[10] || prev == (int) tempyS[10])
  {
    sum = sum + tempyP[10];
    output.println(tempxS[10] + " " + tempyS[10] + " " + tempyP[10] + sum);
    prev = (int) tempxS[10];
    output.flush();
  }
}

void serialEvent(Serial port)
{
  readS = float(port.readStringUntil(' '));
  readP = float(port.readStringUntil('\n'));
  isRead=true;
}

void keyPressed() {
  output.flush();  // Writes the remaining data to the file
  output.close();  // Finishes the file
  exit();  // Stops the program
}
