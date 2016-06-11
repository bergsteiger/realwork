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


unit Posix.Limits;

{$WEAKPACKAGEUNIT}
{$HPPEMIT NOUSINGNAMESPACE}

interface

uses
  Posix.Base;

{$IFDEF MACOS}
{$I osx/LimitsTypes.inc}
{$ELSEIF defined(LINUX)}
{$I linux/LimitsTypes.inc}
{$ELSEIF defined(ANDROID)}
{$I android/LimitsTypes.inc}
{$ENDIF}

implementation

end.
