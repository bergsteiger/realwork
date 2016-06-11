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

unit Posix.SysUio;

{$WEAKPACKAGEUNIT}
{$HPPEMIT NOUSINGNAMESPACE}

interface

uses Posix.Base, Posix.SysTypes;

{$HPPEMIT '#include <sys/uio.h>' }

{$IFDEF MACOS}
{$I osx/SysUioTypes.inc}
{$ELSEIF defined(LINUX)}
{$I linux/SysUioTypes.inc}
{$ELSEIF defined(ANDROID)}
{$I android/SysUioTypes.inc}
{$ENDIF}

{$I SysUioAPI.inc}

implementation

end.
