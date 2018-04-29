/* Pins
  static const uint8_t D0   = 16;
  static const uint8_t D1   = 5;
  static const uint8_t D2   = 4;
  static const uint8_t D3   = 0;
  static const uint8_t D4   = 2;
  static const uint8_t D5   = 14;
  static const uint8_t D6   = 12;
  static const uint8_t D7   = 13;
  static const uint8_t D8   = 15;
  static const uint8_t D9   = 3;
  static const uint8_t D10  = 1;
 */

// Variables
volatile byte ticks;
unsigned long timeold;

// Functions 
void tick(){
  ticks++;
}

void setup() {
  Serial.begin(115200);
  pinMode(D5, INPUT);
  ticks=0;
  timeold=0;
  attachInterrupt(D5, tick, RISING);
}

void loop() {
  //Only process this every 0.1 seconds.
  if (millis() - timeold >= 100){
    detachInterrupt(0);
    timeold = millis();
    ticks = 0;
    Serial.print(ticks);
    Serial.println(" pulses in 0.1 seconds.");
    attachInterrupt(D5, tick, RISING);
    
  }
}
