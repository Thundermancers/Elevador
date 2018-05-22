#include <Ultrasonic.h>

#define pinTrig 12
#define pinEcho 13
#define pinRef 10
#define pinSensor 11
#define sample 5
#define delaySample 5
#define minHeight 2
#define maxHeight 50
#define minVoltage 26
#define maxVoltage 255
int height;

Ultrasonic ultrasonic(pinTrig, pinEcho);

int dist2voltage( int dist ) {
  // Mapeando a interpolação
  // 2cm -> 1V
  // 50cm -> 5V
  return map( dist, minHeight, maxHeight, minVoltage, maxVoltage ); 
}

void setup() {
  Serial.begin( 115200 );
  while ( !Serial );
  Serial.println( "Iniciando:" );
  Serial.println();
  pinMode( pinRef, OUTPUT );
  pinMode( pinSensor, OUTPUT );
  height = ultrasonic.distanceRead();
  // Assim que iniciar permanecer na mesma altura
  analogWrite( pinRef, dist2voltage( height ) );
}

void control(){
  analogWrite( pinRef, dist2voltage( height ) );
  int sum = 0;
  int valueMin = 1<<10; // 2^10
  int valueMax = - 1<<10; // - 2^10
  // Amostras de alturas
  for( int i = 0 ; i < sample ; ++i ) {
    sum += ultrasonic.distanceRead();
    delay( delaySample );
  }
  // Retirar possíveis ruídos
  int valueMed = ( sum - valueMin - valueMax )/( sample - 2 );
  analogWrite( pinSensor, dist2voltage( valueMed ) );
}

void loop() {
  if ( Serial.available() > 0 ) {
    String input = Serial.readString();
    height = input.toInt();
  }
  control();
}
