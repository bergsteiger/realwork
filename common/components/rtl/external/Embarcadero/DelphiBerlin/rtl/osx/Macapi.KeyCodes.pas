{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Macapi.KeyCodes;

interface

const
  KEY_A                  =   0;        // $00
  KEY_S                  =   1;        // $01
  KEY_D                  =   2;        // $02
  KEY_F                  =   3;        // $03
  KEY_H                  =   4;        // $04
  KEY_G                  =   5;        // $05
  KEY_Z                  =   6;        // $06
  KEY_X                  =   7;        // $07
  KEY_C                  =   8;        // $08
  KEY_V                  =   9;        // $09
  KEY_PARA               =  10;        // $0A PlusMinus / Paragraph
  KEY_SECTION            =  10;        // $0A
  KEY_B                  =  11;        // $0B
  KEY_Q                  =  12;        // $0C
  KEY_W                  =  13;        // $0D
  KEY_E                  =  14;        // $0E
  KEY_R                  =  15;        // $0F
  KEY_Y                  =  16;        // $10
  KEY_T                  =  17;        // $11
  KEY_1                  =  18;        // $12
  KEY_2                  =  19;        // $13
  KEY_3                  =  20;        // $14
  KEY_4                  =  21;        // $15
  KEY_6                  =  22;        // $16
  KEY_5                  =  23;        // $17
  KEY_EQUAL              =  24;        // $18 =/+ key
  KEY_EQUALS             =  24;        // $18
  KEY_9                  =  25;        // $19
  KEY_7                  =  26;        // $1A
  KEY_MINUS              =  27;        // $1B -/_ key
  KEY_8                  =  28;        // $1C
  KEY_0                  =  29;        // $1D
  KEY_RIGHTBRACKET       =  30;        // $1E ]/} key
  KEY_RBRACKET           =  30;        // $1E
  KEY_O                  =  31;        // $1F
  KEY_U                  =  32;        // $20
  KEY_LEFTBRACKET        =  33;        // $21 [/{ key
  KEY_LBRACKET           =  33;        // $21
  KEY_I                  =  34;        // $22
  KEY_P                  =  35;        // $23
  KEY_ENTER              =  36;        // $24
  KEY_RETURN             =  36;        // $24
  KEY_L                  =  37;        // $25
  KEY_J                  =  38;        // $26
  KEY_QUOTE              =  39;        // $27 '/" key
  KEY_APOSTROPHE         =  39;        // $27
  KEY_K                  =  40;        // $28
  KEY_SEMICOLON          =  41;        // $29 ;/: key
  KEY_BACKSLASH          =  42;        // $2A \/| key
  KEY_COMMA              =  43;        // $2B ,/< key
  KEY_SLASH              =  44;        // $2C //? key
  KEY_N                  =  45;        // $2D
  KEY_M                  =  46;        // $2E
  KEY_PERIOD             =  47;        // $2F ./> key
  KEY_TAB                =  48;        // $30
  KEY_SPACE              =  49;        // $31
  KEY_TILDE              =  50;        // $32 `/~ key
  KEY_CIRCUMFLEX         =  50;        // $32
  KEY_BACKSPACE          =  51;        // $33
  KEY_BACK               =  51;        // $33
  KEY_ESC                =  53;        // $35
  KEY_ESCAPE             =  53;        // $35
  KEY_RMETA              =  54;        // $36
  KEY_LMETA              =  55;        // $37
  KEY_LSHIFT             =  56;        // $38
  KEY_CAPSLOCK           =  57;        // $39
  KEY_CAPITAL            =  57;        // $39
  KEY_LMENU              =  58;        // $3A
  KEY_LCONTROL           =  59;        // $3B
  KEY_RSHIFT             =  60;        // $3C
  KEY_RMENU              =  61;        // $3D
  KEY_RCONTROL           =  62;        // $3E
  KEY_FUNCTION           =  63;        // $3F
  KEY_F17                =  64;        // $40
  KEY_PADDEC             =  65;        // $41
  KEY_DECIMAL            =  65;        // $41
  KEY_PADMULT            =  67;        // $43
  KEY_MULTIPLY           =  67;        // $43
  KEY_PADADD             =  69;        // $45
  KEY_ADD                =  69;        // $45
  KEY_NUMLOCK            =  71;        // $47
  KEY_CLEAR              =  71;        // $47
  KEY_VOLUMEUP           =  72;        // $48
  KEY_VOLUMEDOWN         =  73;        // $49
  KEY_PADDIV             =  75;        // $4B
  KEY_DIVIDE             =  75;        // $4B
  KEY_PADENTER           =  76;        // $4C
  KEY_NUMPADENTER        =  76;        // $4C
  KEY_PADSUB             =  78;        // $4E
  KEY_SUBTRACT           =  78;        // $4E
  KEY_F18                =  79;        // $4F
  KEY_F19                =  80;        // $50
  KEY_NUMPADEQUAL        =  81;        // $51
  KEY_NUMPADEQUALS       =  81;        // $51
  KEY_NUMPAD0            =  82;        // $52
  KEY_NUMPAD1            =  83;        // $53
  KEY_NUMPAD2            =  84;        // $54
  KEY_NUMPAD3            =  85;        // $55
  KEY_NUMPAD4            =  86;        // $56
  KEY_NUMPAD5            =  87;        // $57
  KEY_NUMPAD6            =  88;        // $58
  KEY_NUMPAD7            =  89;        // $59
  KEY_F20                =  90;        // $5A
  KEY_NUMPAD8            =  91;        // $5B
  KEY_NUMPAD9            =  92;        // $5C
  KEY_CURRENCY           =  93;        // $5D OEM102 for 105/109 keyboard 
  KEY_UNDERLINE          =  94;        // $5E _ key for 109 keyboard 
  KEY_F5                 =  96;        // $60
  KEY_F6                 =  97;        // $61
  KEY_F7                 =  98;        // $62
  KEY_F3                 =  99;        // $63
  KEY_F8                 = 100;        // $64
  KEY_F9                 = 101;        // $65
  KEY_F11                = 103;        // $67
  KEY_F13                = 105;        // $69
  KEY_F16                = 106;        // $6A
  KEY_F14                = 107;        // $6B
  KEY_F10                = 109;        // $6D
  KEY_APPS               = 110;        // $6E
  KEY_F12                = 111;        // $6F
  KEY_F15                = 113;        // $71
  KEY_INS                = 114;        // $72
  KEY_INSERT             = 114;        // $72
  KEY_HOME               = 115;        // $73
  KEY_PAGUP              = 116;        // $74
  KEY_PRIOR              = 116;        // $74
  KEY_DEL                = 117;        // $75
  KEY_DELETE             = 117;        // $75
  KEY_F4                 = 118;        // $76
  KEY_END                = 119;        // $77
  KEY_F2                 = 120;        // $78
  KEY_PAGDN              = 121;        // $79
  KEY_NEXT               = 121;        // $79
  KEY_F1                 = 122;        // $7A
  KEY_LEFT               = 123;        // $7B
  KEY_RIGHT              = 124;        // $7C
  KEY_DOWN               = 125;        // $7D
  KEY_UP                 = 126;        // $7E
  KEY_POWER              = 32639;      // $7F7F


implementation

end.
