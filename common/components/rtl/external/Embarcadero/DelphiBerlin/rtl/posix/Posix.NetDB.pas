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

unit Posix.NetDB;

{$WEAKPACKAGEUNIT}
{$HPPEMIT NOUSINGNAMESPACE}

interface

uses Posix.Base, Posix.SysSocket, Posix.NetinetIn;

{$HPPEMIT '#include <netdb.h>' }

{$IFDEF MACOS}
{$I osx/NetDBTypes.inc}
{$ELSEIF defined(LINUX)}
{$I linux/NetDBTypes.inc}
{$ELSEIF defined(ANDROID)}
{$I android/NetDBTypes.inc}
{$ENDIF}

{$I NetDBAPI.inc}

implementation

end.
