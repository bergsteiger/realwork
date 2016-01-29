{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{   Copyright and license exceptions noted in source    }
{                                                       }
{*******************************************************}

unit Posix.Fnmatch;

{$WEAKPACKAGEUNIT}

interface

uses
  Posix.Base;

{$IFDEF MACOS}
{$I osx/FnMatchTypes.inc}
{$ENDIF MACOS}
{$IFDEF LINUX}
{$I linux/FnMatchTypes.inc}
{$ENDIF LINUX}

{$I FnMatchAPI.inc}

implementation

end.
