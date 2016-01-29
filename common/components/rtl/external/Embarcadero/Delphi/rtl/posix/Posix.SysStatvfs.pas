{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{   Copyright and license exceptions noted in source    }
{                                                       }
{*******************************************************}

unit Posix.SysStatvfs;

{$WEAKPACKAGEUNIT}

interface

uses
  Posix.Base, Posix.SysTypes;

{$HPPEMIT '#include <sys/statvfs.h>' }

{$IFDEF MACOS}
{$I osx/SysStatvfsTypes.inc}
{$ENDIF MACOS}
{$IFDEF LINUX}
{$I linux/SysStatvfsTypes.inc}
{$ENDIF LINUX}

{$I SysStatvfsAPI.inc}

implementation

end.
