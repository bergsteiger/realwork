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

unit Posix.SysUn;

{$WEAKPACKAGEUNIT}
{$HPPEMIT NOUSINGNAMESPACE}

interface

uses Posix.Base, Posix.SysSocket;

{$HPPEMIT '#include <sys/un.h>' }

{$IFDEF MACOS}
{$I osx/SysUnTypes.inc}
{$ELSEIF defined(LINUX)}
{$I linux/SysUnTypes.inc}
{$ELSEIF defined(ANDROID)}
{$I android/SysUnTypes.inc}
{$ENDIF}

implementation

end.
