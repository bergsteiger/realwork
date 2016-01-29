{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{   Copyright and license exceptions noted in source    }
{                                                       }
{*******************************************************}

unit Posix.SysTypes;

{$WEAKPACKAGEUNIT}

interface

uses Posix.StdDef;

{$IFDEF MACOS}
{$I osx/SysTypesTypes.inc}
{$ENDIF MACOS}
{$IFDEF LINUX}
{$I linux/SysTypesTypes.inc}
{$ENDIF LINUX}

{$HPPEMIT '#include <pthread.h>'}


type
  size_t = Posix.StdDef.size_t;
  {$EXTERNALSYM size_t}
  Psize_t = Posix.StdDef.Psize_t;

implementation

end.
