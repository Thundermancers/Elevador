#include <Ultrasonic.h>

#define pinTrig 12
#define pinEcho 13;
#define pinRef 10
#define pinSensor 11
#define sample 5
int height;

Ultrasonic ultrasonic(12, 13);

int dist2voltage( double dist ){
  return 0;
}

void setup(){
  Serial.begin(115200);
  while (!Serial);
  Serial.println("Iniciando:");
  Serial.println();
  pinMode(pinRef, OUTPUT);
  pinMode(pinSensor, OUTPUT);
  height = ultrasonic.distanceRead();
  // Assim que iniciar permanecer na mesma altura
  analogWrite(pinRef, dist2voltage(height) );
}

void control(){
  analogWrite(pinRef, dist2voltage(height) );
  int sum = 0;
  for( int i = 0 ; i < sample ; ++i ){
    sum += ultrasonic.distanceRead();
    delay(10);
  }
  analogWrite(pinSensor, dist2voltage(sum/sample) );
}

void loop() {
  if (Serial.available() > 0) 
  {
    String input = Serial.readString();
    height = input.toInt();
  }
  control();
}
