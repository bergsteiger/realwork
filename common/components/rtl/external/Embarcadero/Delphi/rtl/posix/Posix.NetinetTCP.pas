{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{   Copyright and license exceptions noted in source    }
{                                                       }
{*******************************************************}

unit Posix.NetinetTCP;

{$WEAKPACKAGEUNIT}

interface

uses Posix.Base;

{$IFDEF MACOS}
{$I osx/NetinetTCPTypes.inc}
{$ENDIF MACOS}
{$IFDEF LINUX}
{$I linux/NetinetTCPTypes.inc}
{$ENDIF LINUX}

implementation

end.
