{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{   Copyright and license exceptions noted in source    }
{                                                       }
{*******************************************************}

unit Posix.Grp;

{$WEAKPACKAGEUNIT}

interface

uses Posix.Base, Posix.SysTypes;

{$HPPEMIT '#include <grp.h>' }

{$IFDEF MACOS}
{$I osx/GrpTypes.inc}
{$ENDIF MACOS}
{$IFDEF LINUX}
{$I linux/GrpTypes.inc}
{$ENDIF LINUX}

{$I GrpAPI.inc}

implementation

end.
