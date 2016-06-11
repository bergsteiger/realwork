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

unit Posix.SysStatvfs;

{$WEAKPACKAGEUNIT}
{$HPPEMIT NOUSINGNAMESPACE}

interface

uses
  Posix.Base, Posix.SysTypes;

{$IFNDEF ANDROID}
{$HPPEMIT '#include <sys/statvfs.h>' }
{$ENDIF}

{$IFDEF MACOS}
{$I osx/SysStatvfsTypes.inc}
{$ELSEIF defined(LINUX)}
{$I linux/SysStatvfsTypes.inc}
{$ENDIF}

{$I SysStatvfsAPI.inc}

implementation

end.
