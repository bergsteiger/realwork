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

unit Posix.NetinetIp6 platform;

{$WEAKPACKAGEUNIT}
{$HPPEMIT NOUSINGNAMESPACE}

interface

uses
  Posix.Base, Posix.SysTypes, Posix.NetinetIn;

{$IFNDEF IOS}
{$HPPEMIT '#include <netinet/ip6.h>' }
{$ENDIF}

{$IFDEF MACOS}
{$I osx/NetinetIp6Types.inc}
{$ELSEIF defined(LINUX)}
{$I linux/NetinetIp6Types.inc}
{$ELSEIF defined(ANDROID)}
{$I android/NetinetIp6Types.inc}
{$ENDIF}

implementation

end.
