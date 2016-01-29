{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{   Copyright and license exceptions noted in source    }
{                                                       }
{*******************************************************}

unit Posix.Stdio;

{$WEAKPACKAGEUNIT}

interface

uses Posix.Base;

{$IFDEF MACOS}
{$I osx/StdioTypes.inc}
{$ENDIF MACOS}
{$IFDEF LINUX}
{$I linux/StdioTypes.inc}
{$ENDIF LINUX}

{$I StdioAPI.inc}

implementation

end.
