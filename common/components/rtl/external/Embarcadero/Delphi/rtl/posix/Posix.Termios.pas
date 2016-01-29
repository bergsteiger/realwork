{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{   Copyright and license exceptions noted in source    }
{                                                       }
{*******************************************************}

unit Posix.Termios;

{$WEAKPACKAGEUNIT}

interface

uses Posix.Base;

{$IFDEF MACOS}
{$I osx/TermiosTypes.inc}
{$ENDIF MACOS}
{$IFDEF LINUX}
{$I linux/TermiosTypes.inc}
{$ENDIF LINUX}

{$I TermiosAPI.inc}

{ Compare a character C to a value VAL from the `c_cc' array in a
   `struct termios'.  If VAL is _POSIX_VDISABLE, no character can match it.  }
function CCEQ(val, c: cc_t): Boolean;
{$EXTERNALSYM CCEQ}

implementation
{$HPPEMIT '#include <termios.h>' }

// Macros from termios.h

function CCEQ(val, c: cc_t): Boolean;
begin
  Result := (c = val) and (val <> _POSIX_VDISABLE);
end;

end.
