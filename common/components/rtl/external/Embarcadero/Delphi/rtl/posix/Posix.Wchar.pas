{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{   Copyright and license exceptions noted in source    }
{                                                       }
{*******************************************************}

unit Posix.Wchar;

{$WEAKPACKAGEUNIT}

interface

uses Posix.Base, Posix.Locale, Posix.StdDef;

{$IFDEF MACOS}
{$I osx/WcharTypes.inc}
{$ENDIF MACOS}
{$IFDEF LINUX}
{$I linux/WcharTypes.inc}
{$ENDIF LINUX}

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
