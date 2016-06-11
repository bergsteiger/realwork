{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

{$IFNDEF ANDROID} { Those functions are not implement in Android }
{ Return the output baud rate stored in *TERMIOS_P.  }
function cfgetospeed(const [Ref] __termios_p: termios): speed_t; cdecl;
  external libc name _PU + 'cfgetospeed'; 
{$EXTERNALSYM cfgetospeed}

{ Return the input baud rate stored in *TERMIOS_P.  }
function cfgetispeed(const [Ref] __termios_p: termios): speed_t; cdecl;
  external libc name _PU + 'cfgetispeed';
{$EXTERNALSYM cfgetispeed}

{ Set the output baud rate stored in *TERMIOS_P to SPEED.  }
function cfsetospeed(var __termios_p: termios; __speed: speed_t): Integer; cdecl;
  external libc name _PU + 'cfsetospeed';
{$EXTERNALSYM cfsetospeed}

{ Set the input baud rate stored in *TERMIOS_P to SPEED.  }
function cfsetispeed(var __termios_p: termios; __speed: speed_t): Integer; cdecl;
  external libc name _PU + 'cfsetispeed';
{$EXTERNALSYM cfsetispeed}

{ Set both the input and output baud rates in *TERMIOS_OP to SPEED.  }
function cfsetspeed(var __termios_p: termios; __speed: speed_t): Integer; cdecl;
  external libc name _PU + 'cfsetspeed';
{$EXTERNALSYM cfsetspeed}

{ Put the state of FD into *TERMIOS_P.  }
function tcgetattr(__fd: Integer; var __termios_p: termios): Integer; cdecl;
  external libc name _PU + 'tcgetattr';
{$EXTERNALSYM tcgetattr}

{ Set the state of FD to *TERMIOS_P.
   Values for OPTIONAL_ACTIONS (TCSA*) are in <bits/termios.h>.  }
function tcsetattr(__fd: Integer; __optional_actions: Integer; const __termios_p: termios): Integer; cdecl;
  external libc name _PU + 'tcsetattr';
{$EXTERNALSYM tcsetattr}


{ Set *TERMIOS_P to indicate raw mode.  }
procedure cfmakeraw(var __termios_p: termios); cdecl;
  external libc name _PU + 'cfmakeraw';
{$EXTERNALSYM cfmakeraw}

{ Send zero bits on FD.  }
function tcsendbreak(__fd: Integer; __duration: Integer): Integer; cdecl;
  external libc name _PU + 'tcsendbreak';
{$EXTERNALSYM tcsendbreak}

{ Wait for pending output to be written on FD.  }
function tcdrain(__fd: Integer): Integer; cdecl;
  external libc name _PU + 'tcdrain';
{$EXTERNALSYM tcdrain}

{ Flush pending data on FD.
   Values for QUEUE_SELECTOR (TC(I,O,IO)FLUSH) are in <bits/termios.h>.  }
function tcflush(__fd: Integer; __queue_selector: Integer): Integer; cdecl;
  external libc name _PU + 'tcflush';
{$EXTERNALSYM tcflush}

{ Suspend or restart transmission on FD.
   Values for ACTION (TC[IO](OFF,ON)) are in <bits/termios.h>.  }
function tcflow(__fd: Integer; __action: Integer): Integer; cdecl;
  external libc name _PU + 'tcflow';
{$EXTERNALSYM tcflow}
{$ENDIF ANDROID}
