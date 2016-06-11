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

unit Posix.String_;

{$WEAKPACKAGEUNIT}
{$HPPEMIT NOUSINGNAMESPACE}

interface

uses Posix.Base, Posix.SysTypes, Posix.Locale;

{$IFDEF MACOS}
{$I osx/StringTypes.inc}
{$ELSEIF defined(LINUX)}
{$I linux/StringTypes.inc}
{$ELSEIF defined(ANDROID)}
{$I android/StringTypes.inc}
{$ENDIF}

{$I StringAPI.inc}

implementation

end.
