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

unit Posix.NetIf;

{$WEAKPACKAGEUNIT}
{$HPPEMIT NOUSINGNAMESPACE}

interface

uses Posix.Base, Posix.SysTypes, Posix.SysSocket;

{$HPPEMIT '#include <net/if.h>' }
{$IFNDEF ANDROID}
{$HPPEMIT '#include <ifaddrs.h>' }
{$ENDIF ANDROID}

{$IFDEF MACOS}
{$I osx/NetIfTypes.inc}
{$ELSEIF defined(LINUX)}
{$I linux/NetIfTypes.inc}
{$ELSEIF defined(ANDROID)}
{$I android/NetIfTypes.inc}
{$ENDIF}

{$I NetIfAPI.inc}

implementation

end.
