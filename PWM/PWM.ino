
int LEDpin = D5;

void setup(){
  Serial.begin(115200);
  analogWrite(LEDpin, 512);  /* set initial 50% duty cycle */
}

void loop(){
}
