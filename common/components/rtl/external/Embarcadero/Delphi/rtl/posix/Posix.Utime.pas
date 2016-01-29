{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{   Copyright and license exceptions noted in source    }
{                                                       }
{*******************************************************}

unit Posix.Utime;

{$WEAKPACKAGEUNIT}

interface

uses Posix.Base, Posix.SysTypes;

(*$HPPEMIT '#include <utime.h>' *)

{$IFDEF MACOS}
{$I osx/UtimeTypes.inc}
{$ENDIF MACOS}
{$IFDEF LINUX}
{$I linux/UtimeTypes.inc}
{$ENDIF LINUX}

{$I UtimeAPI.inc}

implementation

end.
