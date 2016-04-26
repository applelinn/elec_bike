float motorSpeed[4];
float K; //generator const; unit W/rpm
float power[4];
int sensorVal[4];
int pins[8] = {2, 3, 5, 6, 7, 8, 10, 11}; //stores the pins of bikes

long time0[4] = {0.0,0.0,0.0,0.0};
long tlast=0;

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
}

void loop() {
  //read the pushbutton value into a variable
  
  for(int i = 0 ; i < 4; ++i)
  {
    //check if sensor i detects anything
    sensorVal[i] = digitalRead(pins[i*2]);
    if (sensorVal[i] == LOW) {
      digitalWrite(pins[i*2+1], HIGH); //if magnet, light up
      long t=millis();
      long deltaT=t-time0[i];
      if (deltaT > 200){
        motorSpeed[i] = 60000/deltaT;
        power[i]= motorSpeed[i]*motorSpeed[i]*((250.0/330)/330); //speed to power conversion
        //print all bikes
        Serial.print(millis());
        Serial.print(" ");
        for(int j = 0; j < 4; j++)
        {
          Serial.print(motorSpeed[j]);
          Serial.print(" ");
          Serial.print(power[j], 6);
          if (j!= 3)
            Serial.print(" ");
        }
        Serial.println();
        
        tlast=t; //tlast is just to make sure the graph flows with time even if there is no one cycling
      }
      time0[i]=t;
    } else {
      if(millis()-tlast>1500)
      {
        Serial.print(millis());
        Serial.println(" 0 0 0 0 0 0 0 0");
        tlast=millis();
      }
      digitalWrite(3, LOW);
    }
  }
    
  
  

}
