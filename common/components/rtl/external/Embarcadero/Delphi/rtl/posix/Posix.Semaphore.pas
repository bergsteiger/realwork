{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{   Copyright and license exceptions noted in source    }
{                                                       }
{*******************************************************}

unit Posix.Semaphore;

{$WEAKPACKAGEUNIT}

interface

uses Posix.Base, Posix.SysTypes;

{$IFDEF MACOS}
{$I osx/SemaphoreTypes.inc}
{$ENDIF MACOS}
{$IFDEF LINUX}
{$I linux/SemaphoreTypes.inc}
{$ENDIF LINUX}

{$I SemaphoreAPI.inc}

implementation

end.
