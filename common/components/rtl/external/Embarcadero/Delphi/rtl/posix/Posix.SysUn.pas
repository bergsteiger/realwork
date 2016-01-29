{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{   Copyright and license exceptions noted in source    }
{                                                       }
{*******************************************************}

unit Posix.SysUn;

{$WEAKPACKAGEUNIT}

interface

uses Posix.Base, Posix.SysSocket;

{$HPPEMIT '#include <sys/un.h>' }

{$IFDEF MACOS}
{$I osx/SysUnTypes.inc}
{$ENDIF MACOS}
{$IFDEF LINUX}
{$I linux/SysUnTypes.inc}
{$ENDIF LINUX}

implementation

end.
