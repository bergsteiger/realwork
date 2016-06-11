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

unit Posix.Langinfo;

{$WEAKPACKAGEUNIT}
{$HPPEMIT NOUSINGNAMESPACE}

interface

uses Posix.Base, Posix.Locale;

{$IFDEF MACOS}
{$I osx/LanginfoTypes.inc}
{$ELSEIF defined(LINUX)}
{$I linux/LanginfoTypes.inc}
{$ENDIF}
{ LangInfo functions not implement in Android }

{$I LanginfoAPI.inc}

implementation

end.
