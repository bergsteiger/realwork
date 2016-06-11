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

unit Posix.Wordexp;

{$WEAKPACKAGEUNIT}
{$HPPEMIT NOUSINGNAMESPACE}

interface

uses Posix.Base, Posix.SysTypes;

{$IFDEF MACOS}
{$I osx/WordexpTypes.inc}
{$ELSEIF defined(LINUX)}
{$I linux/WordexpTypes.inc}
{$ENDIF}

{$IFNDEF ANDROID}
{$HPPEMIT '#include <wordexp.h>'}
{$ENDIF}

{ Wordexp functions not implement in Android }
{$I WordexpAPI.inc}

implementation

end.
