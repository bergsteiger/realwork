{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{   Copyright and license exceptions noted in source    }
{                                                       }
{*******************************************************}

unit Posix.Stdlib;

{$WEAKPACKAGEUNIT}

interface

uses
  Posix.Base, Posix.SysTypes, Posix.StdDef;

{$IFDEF MACOS}
{$I osx/StdlibTypes.inc}
{$ENDIF MACOS}
{$IFDEF LINUX}
{$I linux/StdlibTypes.inc}
{$ENDIF LINUX}

{$I StdlibAPI.inc}

implementation

end.
