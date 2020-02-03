// Color constants
public static final int BLACK = 0x0;
public static final int RED = 0x4; 
public static final int GREEN = 0x2; 
public static final int BLUE = 0x1;
public static final int YELLOW = RED + GREEN; 
public static final int CYAN = GREEN + BLUE; 
public static final int MAGENTA = BLUE + RED;
public static final int WHITE = RED + GREEN + BLUE;

// Trace Mode constants
public static final int TRACE_OFF = 0;
public static final int BLACK_LEFT = 1;
public static final int BLACK_RIGHT = 2;
public static final int BLACK_BOTH = 3;
public static final int BLACK_SEG_LEFT = 4;
public static final int BLACK_SEG_RIGHT = 5;
public static final int BLACK_SEG_FORWARD = 6;
public static final int BLACK_SEG_UTURN = 7;
public static final int WHITE_LEFT = 9;
public static final int WHITE_RIGHT = 10;
public static final int WHITE_BOTH  = 11;
public static final int WHITE_SEG_LEFT = 12;
public static final int WHITE_SEG_RIGHT = 13;
public static final int WHITE_SEG_FORWARD = 14;
public static final int WHITE_SEG_UTURN = 15;

// Proximity Sensor IR current
public static final int MA_5 = 1;
public static final int MA_10 = 2;
public static final int MA_20 = 3;
public static final int MA_50 = 4;
public static final int MA_100 = 5;
public static final int MA_150 = 6;
public static final int MA_200 = 7;

// G sensor
public static final int G_2G = 0;
public static final int G_4G = 1;
public static final int G_8G = 2;
public static final int G_16G = 3;

public static final int G_8HZ = 0;
public static final int G_16HZ = 1;
public static final int G_32HZ = 2;
public static final int G_64HZ = 3;
public static final int G_125HZ = 4;
public static final int G_250HZ = 5;
public static final int G_500HZ = 6;
public static final int G_1000HZ = 7;

// IO mode of PIN
public static final int SA = 0;
public static final int SB = 1;
public static final int SC = 2;
public static final int LA = 3;
public static final int LB = 4;
public static final int LC = 5;
public static final int MAB = 6;
public static final int MCD = 7;

public static final int DIGITAL_IN = 0;
public static final int ANALOG_IN = 1;
public static final int PWM_OUT = 2;
public static final int SERVO_OUT = 3;
public static final int PULSE_IN = 4;

public static final int PULL_DN_2M = 0;
public static final int PULL_UP_50K = 1;
public static final int PULL_DN_50K = 2;

public static final int ADC_VCC = 0;
public static final int ADC_BGV = 1;

// M port
public static final int NORMAL_MODE = 0;
public static final int MONO_SERVO_MODE = 1;
public static final int STEP_MOTOR_SW_MODE = 2;
public static final int STEP_MOTOR_HW_MODE = 3;

public static final int DC_MOTOR   = 0;
public static final int ANALOG_SERVO = 1;
public static final int BUZZ_OUT = 2;

public static final int OFF_COILS  = 0;
public static final int WAVE_DRIVE = 1;
public static final int FULL_DRIVE = 2;
public static final int HALF_DRIVE = 3;

public static final int REMOTE_DISABLE = -1;
public static final int REMOTE_ON = 1;
public static final int REMOTE_OFF = 0;

// Serial
public static final int BAUD_9600 = 0;
public static final int BAUD_14400 = 1;
public static final int BAUD_19200 = 2;
public static final int BAUD_28800 = 3;
public static final int BAUD_38400 = 4;
public static final int BAUD_57600 = 5;
public static final int BAUD_76800 = 6;
public static final int BAUD_115200 = 7;

// Define PIANO key name and key number */
public static final int MUTE = 0;
public static final int A0 = 1;   // 27.5000 Hz  (First Tone)
public static final int As0 = 2;  // 29.1353 Hz
public static final int B0 = 3;   // 30.8677 Hz
public static final int C1 = 4;   // 32.7032 Hz
public static final int Cs1 = 5;  // 34.6479 Hz
public static final int D1 = 6;   // 36.7081 Hz
public static final int Ds1 = 7;  // 38.8909 Hz
public static final int E1 = 8;   // 41.2035 Hz
public static final int F1 = 9;   // 43.6536 Hz
public static final int Fs1 = 10; // 46.2493 Hz
public static final int G1 = 11;  // 48.9995 Hz
public static final int Gs1 = 12; // 51.9130 Hz
public static final int A1 = 13;  // 55.0000 Hz
public static final int As1 = 14; // 58.2705 Hz
public static final int B1 = 15;  // 61.7354 Hz
public static final int C2 = 16;  // 65.4064 Hz (Low C)
public static final int Cs2 = 17; // 69.2957 Hz
public static final int D2 = 18;  // 73.4162 Hz
public static final int Ds2 = 19; // 77.7817 Hz
public static final int E2 = 20;  // 82.4069 Hz
public static final int F2 = 21;  // 87.3071 Hz
public static final int Fs2 = 22; // 92.4986 Hz
public static final int G2 = 23;  // 97.9989 Hz
public static final int Gs2 = 24; // 103.826 Hz
public static final int A2 = 25;  // 110.000 Hz
public static final int As2 = 26; // 116.541 Hz
public static final int B2 = 27;  // 123.471 Hz
public static final int C3 = 28;  // 130.813 Hz
public static final int Cs3 = 29; // 138.591 Hz
public static final int D3 = 30;  // 146.832 Hz
public static final int Ds3 = 31; // 155.563 Hz
public static final int E3 = 32;  // 164.814 Hz
public static final int F3 = 33;  // 174.614 Hz
public static final int Fs3 = 34; // 184.997 Hz
public static final int G3 = 35;  // 195.998 Hz
public static final int Gs3 = 36; // 207.652 Hz
public static final int A3 = 37;  // 220.000 Hz
public static final int As3 = 38; // 233.082 Hz
public static final int B3 = 38;  // 246.942 Hz
public static final int C4 = 40;  // 261.626 Hz  (Middle C)
public static final int Cs4 = 41; // 277.183 Hz
public static final int D4 = 42;  // 293.665 Hz
public static final int Ds4 = 43; // 311.127 Hz
public static final int E4 = 44;  // 329.628 Hz
public static final int F4 = 45;  // 349.228 Hz
public static final int Fs4 = 46; // 369.994 Hz
public static final int G4 = 47;  // 391.995 Hz
public static final int Gs4 = 48; // 415.305 Hz
public static final int A4 = 49;  // 440.000 Hz (Consert Pitch)
public static final int As4 = 50; // 466.164 Hz
public static final int B4 = 51;  // 493.883 Hz
public static final int C5 = 52;  // 523.251 Hz
public static final int Cs5 = 53; // 554.365 Hz
public static final int D5 = 54;  // 587.330 Hz
public static final int Ds5 = 55; // 622.254 Hz
public static final int E5 = 56;  // 659.255 Hz
public static final int F5 = 57;  // 698.456 Hz
public static final int Fs5 = 58; // 739.989 Hz
public static final int G5 = 59;  // 783.991 Hz
public static final int Gs5 = 60; // 830.609 Hz
public static final int A5 = 61;  // 880.000 Hz
public static final int As5 = 62; // 932.328 Hz
public static final int B5 = 63;  // 987.767 Hz
public static final int C6 = 64;  // 1046.50 Hz  (High C)
public static final int Cs6 = 65; // 1108.73 Hz
public static final int D6 = 66;  // 1174.66 Hz
public static final int Ds6 = 67; // 1244.51 Hz
public static final int E6 = 68;  // 1318.51 Hz
public static final int F6 = 69;  // 1396.91 Hz
public static final int Fs6 = 70; // 1479.98 Hz
public static final int G6 = 71;  // 1567.98 Hz
public static final int Gs6 = 72; // 1661.22 Hz
public static final int A6 = 73;  // 1760.00 Hz
public static final int As6 = 74; // 1864.66 Hz
public static final int B6 = 75;  // 1975.53 Hz
public static final int C7 = 76;  // 2093.00 Hz
public static final int Cs7 = 77; // 2217.46 Hz
public static final int D7 = 78;  // 2349.32 Hz
public static final int Ds7 = 79; // 2489.02 Hz
public static final int E7 = 80;  // 2637.02 Hz
public static final int F7 = 81;  // 2793.83 Hz
public static final int Fs7 = 82; // 2959.83 Hz
public static final int G7 = 83;  // 3135.96 Hz
public static final int Gs7 = 84; // 3322.44 Hz
public static final int A7 = 85;  // 3520.00 Hz
public static final int As7 = 86; // 3729.31 Hz
public static final int B7 = 87;  // 3951.07 Hz
public static final int C8 = 88;  // 4186.01 Hz (Last Tone)

// Sound Clip
public static final int BEEP = 1;
public static final int BEEP_2 = 2;
public static final int BEEP_3 = 3;
public static final int BEEP_REP = 4;
public static final int BEEP_RND = 5;
public static final int BEEP_RND_REP = 6;
public static final int SNORE = 7;
public static final int SNORE_REP = 8;
public static final int SIREN = 9;
public static final int SIREN_REP = 10;
public static final int ENGINE = 11;
public static final int ENGINE_REP = 12;
public static final int FART_A = 13;
public static final int FART_B = 14;
public static final int NOISE = 15;
public static final int NOISE_REP = 16;
public static final int WISTLE = 17;
public static final int CHOP_CHOP = 18;
public static final int CHOP_CHOP_REP = 19;

public static final int R2D2 = 0x20;
public static final int DIBIDIP = 0x21;
public static final int ADLIB = 0x22;
public static final int MISSION = 0x23;

public static final int HAPPY_SONG = 0x30;
public static final int ANGRY_SONG = 0x31;
public static final int SAD_SONG = 0x32;
public static final int SLEEP_SONG = 0x33;
public static final int TOY_SONG = 0x34;
public static final int BIRTHDAY_SONG = 0x35;

// Sound out
public static final int PIEZO = 0;

// DHT Temperature / Humidity Sensor
public static final int DHT_11 = 1;
public static final int DHT_21 = 2;
public static final int DHT_22 = 3;

// Neo Pixel Type
public static final int NEO_CHIP_RGB = 0;
public static final int NEO_CHIP_RGBW = 1;

public static final int NEO_MODE_0 = 0;
public static final int NEO_MODE_1 = 1;
public static final int NEO_MODE_2 = 2;
public static final int NEO_MODE_3 = 3;
public static final int NEO_MODE_4 = 4;
public static final int NEO_MODE_5 = 5;

public static final int NEO_CMD_FILL = 0;
public static final int NEO_CMD_CHANGE = 1;
public static final int NEO_CMD_BRIGHT = 2;
public static final int NEO_CMD_PATTERN = 3;
public static final int NEO_CMD_SHIFT = 4;
public static final int NEO_CMD_CLEAR = 5;

public static final int NEO_BLACK = 0;
public static final int NEO_RED = 4;
public static final int NEO_YELLOW = 6;
public static final int NEO_GREEN = 2;
public static final int NEO_CYAN = 3;
public static final int NEO_BLUE = 1;
public static final int NEO_MAGENTA = 5;
public static final int NEO_WHITE = 7;
public static final int NEO_WHITE_RGBW = 8;
