#include <Ultrasonic.h>

int pinTrig = 12;
int pinEcho = 13;
Ultrasonic ultrasonic(12, 13);

int pinRight = 11;
int pinLeft = 10;
int way;

void setOff(){
  digitalWrite(pinRight, LOW);
  digitalWrite(pinLeft, LOW);
  delay(10);
}

void moveLeft(){
  setOff();
  digitalWrite(pinLeft, HIGH);
}

void moveRight(){
  setOff();
  digitalWrite(pinRight, HIGH);
}

void setup() {
  Serial.begin(115200);
  pinMode(pinRight, OUTPUT);
  pinMode(pinLeft, OUTPUT);
  setOff();
}

// the loop function runs over and over again forever
void loop() {
  int dist = ultrasonic.distanceRead();
  Serial.print("Distance in CM: ");
  Serial.println(dist);
  int a = 10;
  if( dist > a ){
      moveLeft();
  }
  else if( dist < a ){
    moveRight();
  }
  else {
    setOff();
  }
  delay(10);
}
