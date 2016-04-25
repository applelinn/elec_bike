float[] motorSpeed;
float K; //generator const; unit W/rpm
float[] power;
int[] SensorVal;
int[] pins = {2, 3, 5, 6, 7, 8, 10, 11}; //stores the pins of bikes

void setup() {
  //start serial connection
  Serial.begin(9600);
  //configure pin2 as an input and enable the internal pull-up resistor

  //pin 2,3 bike 0
  pinMode(2, INPUT_PULLUP);
  pinMode(3, OUTPUT);

  //pin 5,6 bike 1
  pinMode(5, INPUT_PULLUP);
  pinMode(6, OUTPUT);

  //pin 7,8 bike 2
  pinMode(7, INPUT_PULLUP);
  pinMode(8, OUTPUT);

  //pin 10, 11 bike 3
  pinMode(10, INPUT_PULLUP);
  pinMode(11, OUTPUT);
  
  // K = ((250.0/330)/330); //K value too small

  // set up array to store all bikes data simultaneously
  motorSpeed = new float[4];
  power = new float[4];
  sensorVal = new int[4];
}

long time0=0;
long tlast=0;

void loop() {
  //read the pushbutton value into a variable
  
  for(int i = 0 ; i < 4; ++i)
  {
    //check if sensor i detects anything
    sensorVal[i] = digitalRead(pins[i*2]);
  }
    
  
  if (sensorVal == LOW) {
    digitalWrite(13, HIGH); //if magnet, light up
    long t=millis();
    long deltaT=t-time0;
    if (deltaT > 200){
      motorSpeed = 60000/deltaT;
      power= motorSpeed*motorSpeed*((250.0/330)/330); //speed to power conversion
      Serial.print(motorSpeed);
      //yl   Serial.println(" rpm");
      Serial.print(" ");
      Serial.println(power, 6);
      tlast=t;
    }
    time0=t;
  } else {
    if(millis()-tlast>1500)
    {
      Serial.println("0 0");
      tlast=millis();
    }
    digitalWrite(3, LOW);
  }

}
