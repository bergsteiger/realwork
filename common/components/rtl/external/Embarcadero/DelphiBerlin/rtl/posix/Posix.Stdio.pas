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

unit Posix.Stdio;

{$WEAKPACKAGEUNIT}
{$HPPEMIT NOUSINGNAMESPACE}

interface

uses Posix.Base;

{$IFDEF MACOS}
{$I osx/StdioTypes.inc}
{$ELSEIF defined(LINUX)}
{$I linux/StdioTypes.inc}
{$ELSEIF defined(ANDROID)}
{$I android/StdioTypes.inc}
{$ENDIF}

{$I StdioAPI.inc}

implementation

end.
