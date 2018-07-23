#include <Ultrasonic.h>

#define pinTrig 12
#define pinEcho 13
#define pinRight 7
#define pinLeft 6
#define pinSpeed 5
#define sample 5
#define dutyCycleUp 0.3
#define dutyCycleDown 0.3
#define delaySample 5
int height;

Ultrasonic ultrasonic(pinTrig, pinEcho);

void stopElevator(){
  digitalWrite(pinRight, LOW);
  digitalWrite(pinLeft, LOW);
  analogWrite(pinSpeed, 0);
  delay(20);
}

void turnLeft(){
  stopElevator();
  analogWrite(pinSpeed, dutyCycleDown * 255);
  digitalWrite(pinRight, LOW);
  digitalWrite(pinLeft, HIGH);  
}

void turnRight(){
  stopElevator();
  analogWrite(pinSpeed, dutyCycleUp * 255);
  digitalWrite(pinRight, HIGH);
  digitalWrite(pinLeft, LOW);
}


void control(){
  int sum = 0;
  int valueMin = 1<<10; // 2^10
  int valueMax = - 1<<10; // - 2^10
  // Amostras de alturas
  for( int i = 0 ; i < sample ; ++i ) {
    int microsec = ultrasonic.timing();
    double h = ultrasonic.convert(microsec, Ultrasonic::CM);
    Serial.println(h);
    sum += int(h);
    valueMin = min(valueMin, h);
    valueMax = max(valueMax, h);
    delay( delaySample );
  }
  // Retirar possíveis ruídos
  int valueMed = ( sum - valueMin - valueMax )/( sample - 2 );
  Serial.print( "------------------------ " );
  Serial.print( valueMed );
  Serial.print( " " );
  Serial.print( valueMin );
  Serial.print( " " );
  Serial.print( valueMax );
  Serial.print( " " );
  if( int(valueMed) > height ) {
    turnLeft();
  }
  else if( int(valueMed) < height ) {
    turnRight();
  }
  else {
    stopElevator();
  }
}

void setup() {
  Serial.begin( 115200 );
  while ( !Serial );
  Serial.println( "Iniciando:" );
  Serial.println();
  pinMode( pinRight, OUTPUT );
  pinMode( pinLeft, OUTPUT );
  pinMode( pinSpeed, OUTPUT );
  stopElevator();
  int microsec = ultrasonic.timing();
  height = ultrasonic.convert(microsec, Ultrasonic::CM);
  // Assim que iniciar permanecer na mesma altura
}

void loop() {
  if ( Serial.available() > 0 ) {
    String input = Serial.readString();
    height = input.toInt();
    Serial.print("Altura desejada: ");
    Serial.print(height);
  }
  control();
}
