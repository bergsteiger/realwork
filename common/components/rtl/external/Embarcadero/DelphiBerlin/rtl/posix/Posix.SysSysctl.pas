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

unit Posix.SysSysctl;

{$WEAKPACKAGEUNIT}
{$HPPEMIT NOUSINGNAMESPACE}

interface

uses Posix.Base, Posix.SysTypes;

{$IFDEF ANDROID}
{$HPPEMIT '#include <linux/sysctl.h>' }
{$ELSE}
{$HPPEMIT '#include <sys/sysctl.h>' }
{$ENDIF}
{$DEFINE IN_POSIXSYSSYSCTL}

{$IFDEF MACOS}
{$I osx/SysSysctlTypes.inc}
{$ELSEIF defined(LINUX)}
{$I linux/SysSysctlTypes.inc}
{$ELSEIF defined(ANDROID)}
{$I android/SysSysctlTypes.inc}
{$ENDIF}

{$I SysSysctlAPI.inc}

implementation

end.
