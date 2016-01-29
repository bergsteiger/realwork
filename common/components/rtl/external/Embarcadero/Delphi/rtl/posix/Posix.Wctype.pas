{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{   Copyright and license exceptions noted in source    }
{                                                       }
{*******************************************************}

unit Posix.Wctype;

{$WEAKPACKAGEUNIT}

interface

uses Posix.Base, Posix.Wchar, Posix.Locale;

{$IFDEF MACOS}
{$I osx/WctypeTypes.inc}
{$ENDIF MACOS}
{$IFDEF LINUX}
{$I linux/WctypeTypes.inc}
{$ENDIF LINUX}

{$I WctypeAPI.inc}

implementation

end.
