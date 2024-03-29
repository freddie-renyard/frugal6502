// Shift register pins
#define SHIFT_REG_OE 2
#define REG_DATA 3
#define REG_LATCH 4
#define REG_CLOCK 5

#define CLK_SPEED A3

// RAM pins
#define CH_EN A0 // Chip enable. Write enable is the MSB of the shift register.
#define RAM_WRITE A5 // Status pin to disable the 6502's buses when the arduino is writing
#define RST_VEC 0x0200 // 6502 reset vector

// Clock Pin
#define CLK_PIN 12

// Define the data bus output pins
int data_pins[8] = {A1, A4, A2, 6, 7, 8, 9, 10};

// Define the program. To do: Move into PROGMEM
const uint8_t program[] = {0x20, 0x1f, 0x2, 0xa2, 0x0, 0x20, 0x40, 0x2, 0x20, 0x49, 0x2, 0x20, 0xe9, 0x2, 0x20, 0x55, 0x2, 0xa5, 0x0, 0x20, 0xac, 0x2, 0x20, 0xcd, 0x2, 0x20, 0x34, 0x2, 0x4c, 0x0, 0x2, 0xa9, 0x1, 0x8d, 0x0, 0x80, 0xa9, 0x38, 0x8d, 0x0, 0x80, 0xa9, 0xe, 0x8d, 0x0, 0x80, 0xa9, 0x6, 0x8d, 0x0, 0x80, 0x60, 0xa2, 0x40, 0x20, 0x3a, 0x2, 0x60, 0xca, 0xe0, 0x0, 0xd0, 0xfb, 0x60, 0xbd, 0x0, 0x4, 0xe8, 0xc9, 0x0, 0xd0, 0x7, 0x60, 0xa9, 0xc0, 0x8d, 0x0, 0x80, 0x60, 0x8d, 0x1, 0x80, 0x4c, 0x40, 0x2, 0x8d, 0x1, 0x80, 0x85, 0x5, 0x20, 0x9b, 0x2, 0xa6, 0x2, 0xca, 0x86, 0x2, 0xa9, 0x0, 0x85, 0x1, 0x20, 0x6a, 0x2, 0x60, 0xa9, 0x3e, 0x8d, 0x1, 0x80, 0xa5, 0x2, 0xc5, 0x1, 0x90, 0x12, 0xe5, 0x1, 0x4a, 0x65, 0x1, 0xaa, 0xbd, 0x0, 0x4, 0xc5, 0x5, 0xf0, 0xa, 0x90, 0xb, 0x4c, 0x95, 0x2, 0xa9, 0xff, 0x85, 0x0, 0x60, 0x86, 0x0, 0x60, 0xe8, 0x86, 0x1, 0x4c, 0x6a, 0x2, 0xca, 0x86, 0x2, 0x4c, 0x6a, 0x2, 0xa2, 0x0, 0x4c, 0xa0, 0x2, 0xbd, 0x0, 0x4, 0xe8, 0xc9, 0x0, 0xd0, 0xf8, 0xca, 0x86, 0x2, 0x60, 0x85, 0x7, 0xf8, 0xa9, 0x0, 0x85, 0x8, 0x85, 0x9, 0xa2, 0x8, 0x4c, 0xba, 0x2, 0x6, 0x7, 0xa5, 0x8, 0x65, 0x8, 0x85, 0x8, 0xa5, 0x9, 0x65, 0x9, 0x85, 0x9, 0xca, 0xd0, 0xef, 0xd8, 0x60, 0xa5, 0x9, 0x69, 0x30, 0x8d, 0x1, 0x80, 0xa5, 0x8, 0x4a, 0x4a, 0x4a, 0x4a, 0x69, 0x30, 0x8d, 0x1, 0x80, 0xa5, 0x8, 0x29, 0xf, 0x69, 0x30, 0x8d, 0x1, 0x80, 0x60, 0x20, 0xf5, 0x2, 0x4a, 0x4a, 0x4a, 0x4a, 0xaa, 0xbd, 0x0, 0x4, 0x60, 0xa5, 0x6, 0xa, 0xa, 0x18, 0x65, 0x6, 0x18, 0x69, 0x11, 0x85, 0x6, 0x60, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x61, 0x62, 0x63, 0x64, 0x65, 0x66, 0x67, 0x68, 0x69, 0x6a, 0x6b, 0x6c, 0x6d, 0x6e, 0x6f, 0x70, 0x71, 0x0};

// Clock period in milliseconds
int period = 100;

// Set this byte to 1 to put the device in debugging mode.
byte debug = 0;

// Serial Parameters
#define BAUD 9600

// Clock parameters
// Set limits to check any erroneous readings from analogRead.
const int lower = (0 << 3);
const int upper = (1024 << 3);

void setup() {
  
    setup_general();
    setup_write();

    if (debug)  {
        write_nop();
        Serial.begin(BAUD);
    }
    
    write_prog();
    end_write();
    setup_timer();
}

void loop() {
    // put your main code here, to run repeatedly:
    if (debug) 
        print_data_bus();
}

void update_period () {
  
    int value =  (analogRead(CLK_SPEED) << 3);

    if (value > lower && value < upper) {
        OCR1A = value;
    }
}
void print_data_bus () {
    // Read and display the current state of the data bus 
    // on the serial monitor. Useful for debugging.
    
    byte received = 0x00;
    for (int i = 0; i < 8; i++) {
        bitWrite(received, i, digitalRead(data_pins[i]));
    }
    
    Serial.println(received, HEX);

}

void setup_timer () {
    // Set up timer 1 for clock generation.

    // Clear the bits in both timer configuration registers.
    TCCR1A = 0;        
    TCCR1B = 0;  
    TCNT1 = 0;

    TCCR1B |= (1 << WGM12);   // Set timer to CTC mode.

    // Set timer prescale to 1024
    TCCR1B |= (1 << CS10);  
    TCCR1B |= (1 << CS12);     

    // Enable interrupt on comparison to OCR1A.
    TIMSK1 = (1 << OCIE1A);

    // Set an initial value of the comparison register.
    OCR1A = 2;
}

ISR(TIMER1_COMPA_vect) { 
    // The interrupt which is called when timer2 
    // is equal to the compare register. It toggles
    // the clock output pin and sets a new period
    // by reading the clock speed potentiometer.
    digitalWrite(CLK_PIN, digitalRead(CLK_PIN) ^ 1);
    update_period();
}

void setup_general() {
    pinMode(CLK_SPEED, INPUT);
    
    // Setup the shift register pins
    pinMode(REG_DATA, OUTPUT);
    pinMode(REG_LATCH, OUTPUT);
    
    pinMode(REG_CLOCK, OUTPUT);
    digitalWrite(CLK_PIN, LOW);
}

void setup_write() {

    // Disable the 6502 output buses first.
    pinMode(RAM_WRITE, OUTPUT);
    digitalWrite(RAM_WRITE, LOW);
    
    // Set up RAM control pins
   
    pinMode(CH_EN, OUTPUT);
    digitalWrite(CH_EN, HIGH);
  
    pinMode(CLK_PIN, OUTPUT);
    digitalWrite(CLK_PIN, LOW);

    pinMode(SHIFT_REG_OE, OUTPUT);
    digitalWrite(SHIFT_REG_OE, LOW);

    for (int i = 0; i < 8; i++) {
        pinMode(data_pins[i], OUTPUT);
    }
  
}

void end_write () {

  // Set address bus to high impendance
  digitalWrite(SHIFT_REG_OE, HIGH);

  // Set data bus to high impedance
  for (int i = 0; i < 8; i++) {
      pinMode(data_pins[i], INPUT);
  }

  pinMode(CH_EN, INPUT);
  digitalWrite(RAM_WRITE, HIGH);
  //pinMode(RAM_WRITE, INPUT_PULLUP);
  
}

void write_prog () {

  for (int i = 0; i < sizeof(program); i++) {
      ram_write(i + RST_VEC, program[i]);
  }

  // Load the RAM with the start address.
  ram_write(0x7ffc, 0x00);
  ram_write(0x7ffd, 0x02);
}

void write_nop () {
    // Fill the RAM with NOP instructions (0xEA opcode)
    // Useful for debugging.

    // Write to 255 contiguous addresses in RAM
    for (unsigned int i = 0; i < 0x8000; i++) {
        ram_write(i, 0xea);
    }
    
}

void ram_write(unsigned int addr, unsigned int data) {
    // Write a data word to an address in the external 32kb RAM.

    // Begin shift register write
    digitalWrite(REG_LATCH, LOW);

    // Shift the data into the 16bit shift register
    shiftOut(REG_DATA, REG_CLOCK, LSBFIRST, addr);
    shiftOut(REG_DATA, REG_CLOCK, LSBFIRST, (addr >> 8));

    // Latch the data.
    digitalWrite(REG_LATCH, HIGH);

    // Prepare the RAM for a write
    digitalWrite(CH_EN, LOW);
    digitalWrite(CLK_PIN, HIGH);

    for (int i = 0; i < 8; i++) {
        digitalWrite(data_pins[i], bitRead(data, i));
    }

    digitalWrite(CH_EN, HIGH);
    digitalWrite(CLK_PIN, LOW);
}
