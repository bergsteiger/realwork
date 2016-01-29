{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{   Copyright and license exceptions noted in source    }
{                                                       }
{*******************************************************}

unit Posix.NetIf;

{$WEAKPACKAGEUNIT}

interface

uses Posix.Base, Posix.SysTypes, Posix.SysSocket;

{$HPPEMIT '#include <net/if.h>' }
{$HPPEMIT '#include <ifaddrs.h>' }

{$IFDEF MACOS}
{$I osx/NetIfTypes.inc}
{$ENDIF MACOS}
{$IFDEF LINUX}
{$I linux/NetIfTypes.inc}
{$ENDIF LINUX}

{$I NetIfAPI.inc}

implementation

end.
