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

unit Posix.Wchar;

{$WEAKPACKAGEUNIT}
{$HPPEMIT NOUSINGNAMESPACE}

interface

uses Posix.Base, Posix.Locale, Posix.StdDef;

{$IFDEF MACOS}
{$I osx/WcharTypes.inc}
{$ELSEIF defined(LINUX)}
{$I linux/WcharTypes.inc}
{$ELSEIF defined(ANDROID)}
{$I android/WcharTypes.inc}
{$ENDIF}

{$HPPEMIT '#include <wchar.h>'}

type
  size_t = Posix.StdDef.size_t;
  {$EXTERNALSYM size_t}
  Psize_t = Posix.StdDef.Psize_t;

  wchar_t = Posix.StdDef.wchar_t;
  {$EXTERNALSYM wchar_t}
  Pwchar_t = Posix.StdDef.Pwchar_t;

{$I WcharAPI.inc}

implementation

end.
