{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Androidapi.KeyCodes;

interface

const
  AKEYCODE_UNKNOWN               =   0;            // $00 Unknown key code.
  AKEYCODE_SOFT_LEFT             =   1;            // $01 Soft Left key. Usually situated below the display on phones and used as a multi-function feature key for selecting a software defined function shown on the bottom left of the display.
  AKEYCODE_SOFT_RIGHT            =   2;            // $02 Soft Right key. Usually situated below the display on phones and used as a multi-function feature key for selecting a software defined function shown on the bottom right of the display.
  AKEYCODE_HOME                  =   3;            // $03 Home key. This key is handled by the framework and is never delivered to applications.
  AKEYCODE_BACK                  =   4;            // $04 Back key.
  AKEYCODE_CALL                  =   5;            // $05 Call key.
  AKEYCODE_ENDCALL               =   6;            // $06 End Call key.
  AKEYCODE_0                     =   7;            // $07 '0' key.
  AKEYCODE_1                     =   8;            // $08 '1' key.
  AKEYCODE_2                     =   9;            // $09 '2' key.
  AKEYCODE_3                     =  10;            // $0A '3' key.
  AKEYCODE_4                     =  11;            // $0B '4' key.
  AKEYCODE_5                     =  12;            // $0C '5' key.
  AKEYCODE_6                     =  13;            // $0D '6' key.
  AKEYCODE_7                     =  14;            // $0E '7' key.
  AKEYCODE_8                     =  15;            // $0F '8' key.
  AKEYCODE_9                     =  16;            // $10 '9' key.
  AKEYCODE_STAR                  =  17;            // $11 '*' key.
  AKEYCODE_POUND                 =  18;            // $12 '#' key.
  AKEYCODE_DPAD_UP               =  19;            // $13 Directional Pad Up key. May also be synthesized from trackball motions.
  AKEYCODE_DPAD_DOWN             =  20;            // $14 Directional Pad Down key. May also be synthesized from trackball motions.
  AKEYCODE_DPAD_LEFT             =  21;            // $15 Directional Pad Left key. May also be synthesized from trackball motions.
  AKEYCODE_DPAD_RIGHT            =  22;            // $16 Directional Pad Right key. May also be synthesized from trackball motions.
  AKEYCODE_DPAD_CENTER           =  23;            // $17 Directional Pad Center key. May also be synthesized from trackball motions.
  AKEYCODE_VOLUME_UP             =  24;            // $18 Volume Up key. Adjusts the speaker volume up.
  AKEYCODE_VOLUME_DOWN           =  25;            // $19 Volume Down key. Adjusts the speaker volume down.
  AKEYCODE_POWER                 =  26;            // $1A Power key.
  AKEYCODE_CAMERA                =  27;            // $1B Camera key. Used to launch a camera application or take pictures.
  AKEYCODE_CLEAR                 =  28;            // $1C Clear key.
  AKEYCODE_A                     =  29;            // $1D 'A' key.
  AKEYCODE_B                     =  30;            // $1E 'B' key.
  AKEYCODE_C                     =  31;            // $1F 'C' key.
  AKEYCODE_D                     =  32;            // $20 'D' key.
  AKEYCODE_E                     =  33;            // $21 'E' key.
  AKEYCODE_F                     =  34;            // $22 'F' key.
  AKEYCODE_G                     =  35;            // $23 'G' key.
  AKEYCODE_H                     =  36;            // $24 'H' key.
  AKEYCODE_I                     =  37;            // $25 'I' key.
  AKEYCODE_J                     =  38;            // $26 'J' key.
  AKEYCODE_K                     =  39;            // $27 'K' key.
  AKEYCODE_L                     =  40;            // $28 'L' key.
  AKEYCODE_M                     =  41;            // $29 'M' key.
  AKEYCODE_N                     =  42;            // $2A 'N' key.
  AKEYCODE_O                     =  43;            // $2B 'O' key.
  AKEYCODE_P                     =  44;            // $2C 'P' key.
  AKEYCODE_Q                     =  45;            // $2D 'Q' key.
  AKEYCODE_R                     =  46;            // $2E 'R' key.
  AKEYCODE_S                     =  47;            // $2F 'S' key.
  AKEYCODE_T                     =  48;            // $30 'T' key.
  AKEYCODE_U                     =  49;            // $31 'U' key.
  AKEYCODE_V                     =  50;            // $32 'V' key.
  AKEYCODE_W                     =  51;            // $33 'W' key.
  AKEYCODE_X                     =  52;            // $34 'X' key.
  AKEYCODE_Y                     =  53;            // $35 'Y' key.
  AKEYCODE_Z                     =  54;            // $36 'Z' key.
  AKEYCODE_COMMA                 =  55;            // $37 ',' key.
  AKEYCODE_PERIOD                =  56;            // $38 '.' key.
  AKEYCODE_ALT_LEFT              =  57;            // $39 Left Alt modifier key.
  AKEYCODE_ALT_RIGHT             =  58;            // $3A Right Alt modifier key.
  AKEYCODE_SHIFT_LEFT            =  59;            // $3B Left Shift modifier key.
  AKEYCODE_SHIFT_RIGHT           =  60;            // $3C Right Shift modifier key.
  AKEYCODE_TAB                   =  61;            // $3D Tab key.
  AKEYCODE_SPACE                 =  62;            // $3E Space key.
  AKEYCODE_SYM                   =  63;            // $3F Symbol modifier key. Used to enter alternate symbols.
  AKEYCODE_EXPLORER              =  64;            // $40 Explorer special function key. Used to launch a browser application.
  AKEYCODE_ENVELOPE              =  65;            // $41 Envelope special function key. Used to launch a mail application.
  AKEYCODE_ENTER                 =  66;            // $42 Enter key.
  AKEYCODE_DEL                   =  67;            // $43 Backspace key. Deletes characters before the insertion point, unlike KEYCODE_FORWARD_DEL.
  AKEYCODE_GRAVE                 =  68;            // $44 '`' (backtick) key.
  AKEYCODE_MINUS                 =  69;            // $45 '-'.
  AKEYCODE_EQUALS                =  70;            // $46 '=' key.
  AKEYCODE_LEFT_BRACKET          =  71;            // $47 '[' key.
  AKEYCODE_RIGHT_BRACKET         =  72;            // $48 ']' key.
  AKEYCODE_BACKSLASH             =  73;            // $49 '\' key.
  AKEYCODE_SEMICOLON             =  74;            // $4A ';' key.
  AKEYCODE_APOSTROPHE            =  75;            // $4B ''' (apostrophe) key.
  AKEYCODE_SLASH                 =  76;            // $4C '/' key.
  AKEYCODE_AT                    =  77;            // $4D '@' key.
  AKEYCODE_NUM                   =  78;            // $4E Number modifier key. Used to enter numeric symbols. This key is not Num Lock; it is more like KEYCODE_ALT_LEFTand is interpreted as an ALT key by MetaKeyKeyListener.
  AKEYCODE_HEADSETHOOK           =  79;            // $4F Headset Hook key. Used to hang up calls and stop media.
  AKEYCODE_FOCUS                 =  80;            // $50 Camera Focus key. Used to focus the camera.
  AKEYCODE_PLUS                  =  81;            // $51 '+' key.
  AKEYCODE_MENU                  =  82;            // $52 Menu key.
  AKEYCODE_NOTIFICATION          =  83;            // $53 Notification key.
  AKEYCODE_SEARCH                =  84;            // $54 Search key.
  AKEYCODE_MEDIA_PLAY_PAUSE      =  85;            // $55 Play/Pause media key.
  AKEYCODE_MEDIA_STOP            =  86;            // $56 Stop media key.
  AKEYCODE_MEDIA_NEXT            =  87;            // $57 Play Next media key.
  AKEYCODE_MEDIA_PREVIOUS        =  88;            // $58 Play Previous media key.
  AKEYCODE_MEDIA_REWIND          =  89;            // $59 Rewind media key.
  AKEYCODE_MEDIA_FAST_FORWARD    =  90;            // $5A Fast Forward media key.
  AKEYCODE_MUTE                  =  91;            // $5B Mute key. Mutes the microphone, unlike KEYCODE_VOLUME_MUTE.
  AKEYCODE_PAGE_UP               =  92;            // $5C Page Up key.
  AKEYCODE_PAGE_DOWN             =  93;            // $5D Page Down key.
  AKEYCODE_PICTSYMBOLS           =  94;            // $5E Picture Symbols modifier key. Used to switch symbol sets (Emoji, Kao-moji).
  AKEYCODE_SWITCH_CHARSET        =  95;            // $5F Switch Charset modifier key. Used to switch character sets (Kanji, Katakana).
  AKEYCODE_BUTTON_A              =  96;            // $60 A Button key. On a game controller, the A button should be either the button labeled A or the first button on the bottom row of controller buttons.
  AKEYCODE_BUTTON_B              =  97;            // $61 B Button key. On a game controller, the B button should be either the button labeled B or the second button on the bottom row of controller buttons.
  AKEYCODE_BUTTON_C              =  98;            // $62 C Button key. On a game controller, the C button should be either the button labeled C or the third button on the bottom row of controller buttons.
  AKEYCODE_BUTTON_X              =  99;            // $63 X Button key. On a game controller, the X button should be either the button labeled X or the first button on the upper row of controller buttons.
  AKEYCODE_BUTTON_Y              = 100;            // $64 Y Button key. On a game controller, the Y button should be either the button labeled Y or the second button on the upper row of controller buttons.
  AKEYCODE_BUTTON_Z              = 101;            // $65 Z Button key. On a game controller, the Z button should be either the button labeled Z or the third button on the upper row of controller buttons.
  AKEYCODE_BUTTON_L1             = 102;            // $66 L1 Button key. On a game controller, the L1 button should be either the button labeled L1 (or L) or the top left trigger button.
  AKEYCODE_BUTTON_R1             = 103;            // $67 R1 Button key. On a game controller, the R1 button should be either the button labeled R1 (or R) or the top right trigger button.
  AKEYCODE_BUTTON_L2             = 104;            // $68 L2 Button key. On a game controller, the L2 button should be either the button labeled L2 or the bottom left trigger button.
  AKEYCODE_BUTTON_R2             = 105;            // $69 R2 Button key. On a game controller, the R2 button should be either the button labeled R2 or the bottom right trigger button.
  AKEYCODE_BUTTON_THUMBL         = 106;            // $6A Left Thumb Button key. On a game controller, the left thumb button indicates that the left (or only) joystick is pressed.
  AKEYCODE_BUTTON_THUMBR         = 107;            // $6B Right Thumb Button key. On a game controller, the right thumb button indicates that the right joystick is pressed.
  AKEYCODE_BUTTON_START          = 108;            // $6C Start Button key. On a game controller, the button labeled Start.
  AKEYCODE_BUTTON_SELECT         = 109;            // $6D Select Button key. On a game controller, the button labeled Select.
  AKEYCODE_BUTTON_MODE           = 110;            // $6E Mode Button key. On a game controller, the button labeled Mode.
  AKEYCODE_ESCAPE                = 111;            // $6F Escape key.
  AKEYCODE_FORWARD_DEL           = 112;            // $70 Forward Delete key. Deletes characters ahead of the insertion point, unlike KEYCODE_DEL.
  AKEYCODE_CTRL_LEFT             = 113;            // $71 Left Control modifier key.
  AKEYCODE_CTRL_RIGHT            = 114;            // $72 Right Control modifier key.
  AKEYCODE_CAPS_LOCK             = 115;            // $73 Caps Lock key.
  AKEYCODE_SCROLL_LOCK           = 116;            // $74 Scroll Lock key.
  AKEYCODE_META_LEFT             = 117;            // $75 Left Meta modifier key.
  AKEYCODE_META_RIGHT            = 118;            // $76 Right Meta modifier key.
  AKEYCODE_FUNCTION              = 119;            // $77 Function modifier key.
  AKEYCODE_SYSRQ                 = 120;            // $78 System Request / Print Screen key.
  AKEYCODE_BREAK                 = 121;            // $79 Break / Pause key.
  AKEYCODE_MOVE_HOME             = 122;            // $7A Home Movement key. Used for scrolling or moving the cursor around to the start of a line or to the top of a list.
  AKEYCODE_MOVE_END              = 123;            // $7B End Movement key. Used for scrolling or moving the cursor around to the end of a line or to the bottom of a list.
  AKEYCODE_INSERT                = 124;            // $7C Insert key. Toggles insert / overwrite edit mode.
  AKEYCODE_FORWARD               = 125;            // $7D Forward key. Navigates forward in the history stack. Complement of KEYCODE_BACK.
  AKEYCODE_MEDIA_PLAY            = 126;            // $7E Play media key.
  AKEYCODE_MEDIA_PAUSE           = 127;            // $7F Pause media key.
  AKEYCODE_MEDIA_CLOSE           = 128;            // $80 Close media key. May be used to close a CD tray, for example.
  AKEYCODE_MEDIA_EJECT           = 129;            // $81 Eject media key. May be used to eject a CD tray, for example.
  AKEYCODE_MEDIA_RECORD          = 130;            // $82 Record media key.
  AKEYCODE_F1                    = 131;            // $83 F1 key.
  AKEYCODE_F2                    = 132;            // $84 F2 key.
  AKEYCODE_F3                    = 133;            // $85 F3 key.
  AKEYCODE_F4                    = 134;            // $86 F4 key.
  AKEYCODE_F5                    = 135;            // $87 F5 key.
  AKEYCODE_F6                    = 136;            // $88 F6 key.
  AKEYCODE_F7                    = 137;            // $89 F7 key.
  AKEYCODE_F8                    = 138;            // $8A F8 key.
  AKEYCODE_F9                    = 139;            // $8B F9 key.
  AKEYCODE_F10                   = 140;            // $8C F10 key.
  AKEYCODE_F11                   = 141;            // $8D F11 key.
  AKEYCODE_F12                   = 142;            // $8E F12 key.
  AKEYCODE_NUM_LOCK              = 143;            // $8F Num Lock key. This is the Num Lock key; it is different from KEYCODE_NUM. This key alters the behavior of other keys on the numeric keypad.
  AKEYCODE_NUMPAD_0              = 144;            // $90 Numeric keypad '0' key.
  AKEYCODE_NUMPAD_1              = 145;            // $91 Numeric keypad '1' key.
  AKEYCODE_NUMPAD_2              = 146;            // $92 Numeric keypad '2' key.
  AKEYCODE_NUMPAD_3              = 147;            // $93 Numeric keypad '3' key.
  AKEYCODE_NUMPAD_4              = 148;            // $94 Numeric keypad '4' key.
  AKEYCODE_NUMPAD_5              = 149;            // $95 Numeric keypad '5' key.
  AKEYCODE_NUMPAD_6              = 150;            // $96 Numeric keypad '6' key.
  AKEYCODE_NUMPAD_7              = 151;            // $97 Numeric keypad '7' key.
  AKEYCODE_NUMPAD_8              = 152;            // $98 Numeric keypad '8' key.
  AKEYCODE_NUMPAD_9              = 153;            // $99 Numeric keypad '9' key.
  AKEYCODE_NUMPAD_DIVIDE         = 154;            // $9A Numeric keypad '/' key (for division).
  AKEYCODE_NUMPAD_MULTIPLY       = 155;            // $9B Numeric keypad '*' key (for multiplication).
  AKEYCODE_NUMPAD_SUBTRACT       = 156;            // $9C Numeric keypad '-' key (for subtraction).
  AKEYCODE_NUMPAD_ADD            = 157;            // $9D Numeric keypad '+' key (for addition).
  AKEYCODE_NUMPAD_DOT            = 158;            // $9E Numeric keypad '.' key (for decimals or digit grouping).
  AKEYCODE_NUMPAD_COMMA          = 159;            // $9F Numeric keypad ',' key (for decimals or digit grouping).
  AKEYCODE_NUMPAD_ENTER          = 160;            // $A0 Numeric keypad Enter key.
  AKEYCODE_NUMPAD_EQUALS         = 161;            // $A1 Numeric keypad '=' key.
  AKEYCODE_NUMPAD_LEFT_PAREN     = 162;            // $A2 Numeric keypad '(' key.
  AKEYCODE_NUMPAD_RIGHT_PAREN    = 163;            // $A3 Numeric keypad ')' key.
  AKEYCODE_VOLUME_MUTE           = 164;            // $A4 Volume Mute key. Mutes the speaker, unlike KEYCODE_MUTE. This key should normally be implemented as a toggle such that the first press mutes the speaker and the second press restores the original volume.
  AKEYCODE_INFO                  = 165;            // $A5 Info key. Common on TV remotes to show additional information related to what is currently being viewed.
  AKEYCODE_CHANNEL_UP            = 166;            // $A6 Channel up key. On TV remotes, increments the television channel.
  AKEYCODE_CHANNEL_DOWN          = 167;            // $A7 Channel down key. On TV remotes, decrements the television channel.
  AKEYCODE_ZOOM_IN               = 168;            // $A8 Zoom in key.
  AKEYCODE_ZOOM_OUT              = 169;            // $A9 Zoom out key.
  AKEYCODE_TV                    = 170;            // $AA TV key. On TV remotes, switches to viewing live TV.
  AKEYCODE_WINDOW                = 171;            // $AB Window key. On TV remotes, toggles picture-in-picture mode or other windowing functions.
  AKEYCODE_GUIDE                 = 172;            // $AC Guide key. On TV remotes, shows a programming guide.
  AKEYCODE_DVR                   = 173;            // $AD DVR key. On some TV remotes, switches to a DVR mode for recorded shows.
  AKEYCODE_BOOKMARK              = 174;            // $AE Bookmark key. On some TV remotes, bookmarks content or web pages.
  AKEYCODE_CAPTIONS              = 175;            // $AF Toggle captions key. Switches the mode for closed-captioning text, for example during television shows.
  AKEYCODE_SETTINGS              = 176;            // $B0 Settings key. Starts the system settings activity.
  AKEYCODE_TV_POWER              = 177;            // $B1 TV power key. On TV remotes, toggles the power on a television screen.
  AKEYCODE_TV_INPUT              = 178;            // $B2 TV input key. On TV remotes, switches the input on a television screen.
  AKEYCODE_STB_POWER             = 179;            // $B3 Set-top-box power key. On TV remotes, toggles the power on an external Set-top-box.
  AKEYCODE_STB_INPUT             = 180;            // $B4 Set-top-box input key. On TV remotes, switches the input mode on an external Set-top-box.
  AKEYCODE_AVR_POWER             = 181;            // $B5 A/V Receiver power key. On TV remotes, toggles the power on an external A/V Receiver.
  AKEYCODE_AVR_INPUT             = 182;            // $B6 A/V Receiver input key. On TV remotes, switches the input mode on an external A/V Receiver.
  AKEYCODE_PROG_RED              = 183;            // $B7 Red "programmable" key. On TV remotes, acts as a contextual/programmable key.
  AKEYCODE_PROG_GREEN            = 184;            // $B8 Green "programmable" key. On TV remotes, actsas a contextual/programmable key.
  AKEYCODE_PROG_YELLOW           = 185;            // $B9 Yellow "programmable" key. On TV remotes, acts as a contextual/programmable key.
  AKEYCODE_PROG_BLUE             = 186;            // $BA Blue "programmable" key. On TV remotes, acts as a contextual/programmable key.
  AKEYCODE_APP_SWITCH            = 187;            // $BB App switch key. Should bring up the application switcher dialog.
  AKEYCODE_BUTTON_1              = 188;            // $BC Generic Game Pad Button #1.
  AKEYCODE_BUTTON_2              = 189;            // $BD Generic Game Pad Button #2.
  AKEYCODE_BUTTON_3              = 190;            // $BE Generic Game Pad Button #3.
  AKEYCODE_BUTTON_4              = 191;            // $BF Generic Game Pad Button #4.
  AKEYCODE_BUTTON_5              = 192;            // $C0 Generic Game Pad Button #5.
  AKEYCODE_BUTTON_6              = 193;            // $C1 Generic Game Pad Button #6.
  AKEYCODE_BUTTON_7              = 194;            // $C2 Generic Game Pad Button #7.
  AKEYCODE_BUTTON_8              = 195;            // $C3 Generic Game Pad Button #8.
  AKEYCODE_BUTTON_9              = 196;            // $C4 Generic Game Pad Button #9.
  AKEYCODE_BUTTON_10             = 197;            // $C5 Generic Game Pad Button #10.
  AKEYCODE_BUTTON_11             = 198;            // $C6 Generic Game Pad Button #11.
  AKEYCODE_BUTTON_12             = 199;            // $C7 Generic Game Pad Button #12.
  AKEYCODE_BUTTON_13             = 200;            // $C8 Generic Game Pad Button #13.
  AKEYCODE_BUTTON_14             = 201;            // $C9 Generic Game Pad Button #14.
  AKEYCODE_BUTTON_15             = 202;            // $CA Generic Game Pad Button #15.
  AKEYCODE_BUTTON_16             = 203;            // $CB Generic Game Pad Button #16.
  AKEYCODE_LANGUAGE_SWITCH       = 204;            // $CC Language Switch key. Toggles the current input language such as switching between English and Japanese on a QWERTY keyboard. On some devices, the same function may be performed by pressing Shift+Spacebar.
  AKEYCODE_MANNER_MODE           = 205;            // $CD Manner Mode key. Toggles silent or vibrate mode on and off to make the device behave more politely in certain settings such as on a crowded train. On some devices, the key may only operate when long-pressed.
  AKEYCODE_3D_MODE               = 206;            // $CE 3D Mode key. Toggles the display between 2D and 3D mode.
  AKEYCODE_CONTACTS              = 207;            // $CF Contacts special function key. Used to launch an address book application.
  AKEYCODE_CALENDAR              = 208;            // $D0 Calendar special function key. Used to launch a calendar application.
  AKEYCODE_MUSIC                 = 209;            // $D1 Music special function key. Used to launch a music player application.
  AKEYCODE_CALCULATOR            = 210;            // $D2 Calculator special function key. Used to launch a calculator application.
  AKEYCODE_ZENKAKU_HANKAKU       = 211;            // $D3 Japanese full-width / half-width key.
  AKEYCODE_EISU                  = 212;            // $D4 Japanese alphanumeric key.
  AKEYCODE_MUHENKAN              = 213;            // $D5 Japanese non-conversion key.
  AKEYCODE_HENKAN                = 214;            // $D6 Japanese conversion key.
  AKEYCODE_KATAKANA_HIRAGANA     = 215;            // $D7 Japanese katakana / hiragana key.
  AKEYCODE_YEN                   = 216;            // $D8 Japanese Yen key.
  AKEYCODE_RO                    = 217;            // $D9 Japanese Ro key.
  AKEYCODE_KANA                  = 218;            // $DA Japanese kana key.
  AKEYCODE_ASSIST                = 219;            // $DB Assist key. Launches the global assist activity. Not delivered to applications.
  AKEYCODE_BRIGHTNESS_DOWN       = 220;            // $DC Brightness Down key. Adjusts the screen brightness down.
  AKEYCODE_BRIGHTNESS_UP         = 221;            // $DD Brightness Up key. Adjusts the screen brightness up.

{ NOTE: If you add a new keycode here you must also add it to several other files.
  Refer to frameworks/base/core/java/android/view/KeyEvent.java for the full list.
}

implementation



end.

