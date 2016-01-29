{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{   Copyright and license exceptions noted in source    }
{                                                       }
{*******************************************************}

unit Posix.NetinetIp6 platform;

{$WEAKPACKAGEUNIT}

interface

uses
  Posix.Base, Posix.SysTypes, Posix.NetinetIn;

{$HPPEMIT '#include <netinet/ip6.h>' }

{$IFDEF MACOS}
{$I osx/NetinetIp6Types.inc}
{$ENDIF MACOS}
{$IFDEF LINUX}
{$I linux/NetinetIp6Types.inc}
{$ENDIF LINUX}

implementation

end.
