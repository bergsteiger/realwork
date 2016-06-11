{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{   Copyright and license exceptions noted in source    }
{                                                       }
{*******************************************************}

unit Posix.Termios;

{$WEAKPACKAGEUNIT}
{$HPPEMIT NOUSINGNAMESPACE}

interface

uses Posix.Base
     {$IFDEF ANDROID}
    ,Posix.SysTypes
    ,Posix.StrOpts
    ,Posix.SysWait
     {$ENDIF ANDROID}
     ;

{$IFDEF MACOS}
{$I osx/TermiosTypes.inc}
{$ELSEIF defined(LINUX)}
{$I linux/TermiosTypes.inc}
{$ELSEIF defined(ANDROID)}
{$I android/TermiosTypes.inc}
{$ENDIF}

{$I TermiosAPI.inc}

{ Compare a character C to a value VAL from the `c_cc' array in a
   `struct termios'.  If VAL is _POSIX_VDISABLE, no character can match it.  }
function CCEQ(val, c: cc_t): Boolean;
{$EXTERNALSYM CCEQ}

{$IFDEF ANDROID}
function cfgetospeed(const [Ref] __termios_p: termios): speed_t;
{$EXTERNALSYM cfgetospeed}

{ Return the input baud rate stored in *TERMIOS_P.  }
function cfgetispeed(const [Ref] __termios_p: termios): speed_t;
{$EXTERNALSYM cfgetispeed}

{ Set the output baud rate stored in *TERMIOS_P to SPEED.  }
function cfsetospeed(var __termios_p: termios; __speed: speed_t): Integer;
{$EXTERNALSYM cfsetospeed}

{ Set the input baud rate stored in *TERMIOS_P to SPEED.  }
function cfsetispeed(var __termios_p: termios; __speed: speed_t): Integer;
{$EXTERNALSYM cfsetispeed}

{ Put the state of FD into *TERMIOS_P.  }
function tcgetattr(__fd: Integer; var __termios_p: termios): Integer;
{$EXTERNALSYM tcgetattr}

{ Set the state of FD to *TERMIOS_P.
   Values for OPTIONAL_ACTIONS (TCSA*) are in <bits/termios.h>.  }
function tcsetattr(__fd: Integer; __optional_actions: Integer; const __termios_p: termios): Integer;
{$EXTERNALSYM tcsetattr}


{ Set *TERMIOS_P to indicate raw mode.  }
procedure cfmakeraw(var __termios_p: termios); cdecl;// NO POSIX
{$EXTERNALSYM cfmakeraw}

{ Send zero bits on FD.  }
function tcsendbreak(__fd: Integer; __duration: Integer): Integer;
{$EXTERNALSYM tcsendbreak}

{ Flush pending data on FD.
   Values for QUEUE_SELECTOR (TC(I,O,IO)FLUSH) are in <bits/termios.h>.  }
function tcflush(__fd: Integer; __queue_selector: Integer): Integer;
{$EXTERNALSYM tcflush}

function tcgetsid(__fd: Integer): pid_t;
{$EXTERNALSYM tcgetsid}

{ Suspend or restart transmission on FD.
   Values for ACTION (TC[IO](OFF,ON)) are in <bits/termios.h>.  }
function tcflow(__fd: Integer; __action: Integer): Integer;
{$EXTERNALSYM tcflow}

{$ENDIF ANDROID}


implementation
{$HPPEMIT '#include <termios.h>' }

// Macros from termios.h

function CCEQ(val, c: cc_t): Boolean;
begin
  Result := (c = val) and (val <> _POSIX_VDISABLE);
end;


{$IFDEF ANDROID}

function cfgetospeed(const [Ref] __termios_p: termios): speed_t;
begin
  Result := (__termios_p.c_cflag and CBAUD);
end;

function cfgetispeed(const [Ref] __termios_p: termios): speed_t;
begin
  Result := (__termios_p.c_cflag and CBAUD);
end;

function cfsetospeed(var __termios_p: termios; __speed: speed_t): Integer;
begin
  __termios_p.c_cflag := ((__termios_p.c_cflag and not CBAUD) or (__speed and CBAUD));
  Result := 0;
end;

function cfsetispeed(var __termios_p: termios; __speed: speed_t): Integer;
begin
  __termios_p.c_cflag := ((__termios_p.c_cflag and not CBAUD) or (__speed and CBAUD));
  Result := 0;
end;

function tcgetattr(__fd: Integer; var __termios_p: termios): Integer;
begin
  Result := ioctl(__fd, TCGETS, PInteger(@__termios_p));
end;

function tcsetattr(__fd: Integer; __optional_actions: Integer; const __termios_p: termios): Integer;
begin
  Result := ioctl(__fd, __optional_actions, PInteger(@__termios_p));
end;

procedure cfmakeraw(var __termios_p: termios); cdecl;
begin
  __termios_p.c_iflag := __termios_p.c_iflag and (not (IGNBRK or BRKINT or PARMRK or ISTRIP or INLCR or IGNCR or ICRNL or IXON));
  __termios_p.c_oflag := __termios_p.c_oflag and (not OPOST);
  __termios_p.c_lflag := __termios_p.c_lflag and (not (ECHO or ECHONL or ICANON or ISIG or IEXTEN));
  __termios_p.c_cflag := __termios_p.c_cflag and (not (CSIZE or PARENB));
  __termios_p.c_cflag := __termios_p.c_cflag or CS8;
end;

function tcsendbreak(__fd: Integer; __duration: Integer): Integer;
begin
  Result := ioctl(__fd, TCSBRKP, __duration);
end;

function tcflush(__fd: Integer; __queue_selector: Integer): Integer;
begin
  Result := ioctl(__fd, TCFLSH, __queue_selector);
end;

function tcgetsid(__fd: Integer): pid_t;
var
  _pid: pid_t;
begin
  if ioctl(__fd, TIOCGSID, @_pid) <> 0 then
    Result := Ppid_t(-1)^
  else
    Result := _pid;
end;

function tcflow(__fd: Integer; __action: Integer): Integer;
begin
  Result := ioctl(__fd, TCXONC, __action);
end;

{$ENDIF ANDROID}

end.
