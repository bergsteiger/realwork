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

unit Posix.Wctype;

{$WEAKPACKAGEUNIT}
{$HPPEMIT NOUSINGNAMESPACE}

interface

uses Posix.Base, Posix.Wchar, Posix.Locale;

{$IFDEF MACOS}
{$I osx/WctypeTypes.inc}
{$ELSEIF defined(LINUX)}
{$I linux/WctypeTypes.inc}
{$ENDIF}

{$I WctypeAPI.inc}

implementation

end.
