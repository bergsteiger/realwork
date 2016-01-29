{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{   Copyright and license exceptions noted in source    }
{                                                       }
{*******************************************************}

unit Posix.Pwd;

{$WEAKPACKAGEUNIT}

interface

uses Posix.Base, Posix.SysTypes;

{$HPPEMIT '#include <pwd.h>' }

{$IFDEF MACOS}
{$I osx/PwdTypes.inc}
{$ENDIF MACOS}
{$IFDEF LINUX}
{$I linux/PwdTypes.inc}
{$ENDIF LINUX}

{$I PwdAPI.inc}

implementation

end.
