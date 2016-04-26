float motorSpeed[4];
float K; //generator const; unit W/rpm
float power[4];
int sensorVal[4];
int pins[8] = {2, 3, 5, 6, 8, 9, 11, 12}; //stores the pins of bikes

long time0[4] = {0.0,0.0,0.0,0.0};
long tlast[4] = {0,0,0,0};
long tlastmax=0;

void setup() {
  //start serial connection
  Serial.begin(9600);
  //configure pin2 as an input and enable the internal pull-up resistor

  //pin 2,3 bike 0
  pinMode(pins[0], INPUT_PULLUP);
  pinMode(pins[1], OUTPUT);

  //pin 5,6 bike 1
  pinMode(pins[2], INPUT_PULLUP);
  pinMode(pins[3], OUTPUT);

  //pin 7,8 bike 2
  pinMode(pins[4], INPUT_PULLUP);
  pinMode(pins[5], OUTPUT);

  //pin 10, 11 bike 3
  pinMode(pins[6], INPUT_PULLUP);
  pinMode(pins[7], OUTPUT);
  
  // K = ((250.0/330)/330); //K value too small
}

void loop() {
  //read the pushbutton value into a variable
  
  for(int i = 0 ; i < 4; ++i)
  {
    //check if sensor i detects anything
    sensorVal[i] = digitalRead(pins[i*2]);
    if (sensorVal[i] == LOW) {
      digitalWrite(13, HIGH); //if magnet, light up
      long t=millis();
      long deltaT=t-time0[i];
      if (deltaT > 200){
        motorSpeed[i] = 60000/deltaT;
        power[i]= motorSpeed[i]*motorSpeed[i]*((250.0/330)/330); //speed to power conversion
        //print all bikes
        Serial.print(millis());
        Serial.print(" ");
        tlast[i]=t; //tlast
        if(tlastmax<tlast[i])
          tlastmax= tlast[i];
        for(int j = 0; j < 4; j++)
        {
          if(millis() - tlast[j] >1500)
          {
            motorSpeed[j]=0;
            power[j]=0;
          }
          Serial.print(motorSpeed[j]);
          Serial.print(" ");
          Serial.print(power[j], 6);
          if (j!= 3)
            Serial.print(" ");
        }
        Serial.println();
        
       
      }
      time0[i]=t;
    } else {
      if(millis()-(tlastmax)>1500)
      {
        Serial.print(millis());
        Serial.println(" 0 0 0 0 0 0 0 0");
        tlastmax=millis();
      }
      digitalWrite(pins[2*i+1], LOW);
    }
  }
    
  
  

}
