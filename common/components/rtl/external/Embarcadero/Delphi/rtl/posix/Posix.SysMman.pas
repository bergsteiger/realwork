{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{   Copyright and license exceptions noted in source    }
{                                                       }
{*******************************************************}

unit Posix.SysMman;

{$WEAKPACKAGEUNIT}

interface

uses
  Posix.Base, Posix.SysTypes;

{$IFDEF MACOS}
{$I osx/SysMmanTypes.inc}
{$ENDIF MACOS}
{$IFDEF LINUX}
{$I linux/SysMmanTypes.inc}
{$ENDIF LINUX}

{$I SysMmanAPI.inc}

implementation

end.
