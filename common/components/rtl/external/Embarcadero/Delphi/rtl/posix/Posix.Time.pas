{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{   Copyright and license exceptions noted in source    }
{                                                       }
{*******************************************************}

unit Posix.Time;

{$WEAKPACKAGEUNIT}

interface

uses Posix.Base, Posix.SysTypes;

{$IFDEF MACOS}
{$I osx/TimeTypes.inc}
{$ENDIF MACOS}
{$IFDEF LINUX}
{$I linux/TimeTypes.inc}
{$ENDIF LINUX}

{$I TimeAPI.inc}

implementation

end.
