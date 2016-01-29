{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{   Copyright and license exceptions noted in source    }
{                                                       }
{*******************************************************}


unit Posix.Limits;

{$WEAKPACKAGEUNIT}

interface

uses
  Posix.Base;

{$IFDEF MACOS}
{$I osx/LimitsTypes.inc}
{$ENDIF MACOS}
{$IFDEF LINUX}
{$I linux/LimitsTypes.inc}
{$ENDIF LINUX}

implementation

end.
