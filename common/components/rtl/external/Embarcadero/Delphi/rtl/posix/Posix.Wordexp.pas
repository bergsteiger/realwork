{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{   Copyright and license exceptions noted in source    }
{                                                       }
{*******************************************************}

unit Posix.Wordexp;

{$WEAKPACKAGEUNIT}

interface

uses Posix.Base, Posix.SysTypes;

{$IFDEF MACOS}
{$I osx/WordexpTypes.inc}
{$ENDIF MACOS}
{$IFDEF LINUX}
{$I linux/WordexpTypes.inc}
{$ENDIF LINUX}

{$HPPEMIT '#include <wordexp.h>'}


{$I WordexpAPI.inc}

implementation

end.
