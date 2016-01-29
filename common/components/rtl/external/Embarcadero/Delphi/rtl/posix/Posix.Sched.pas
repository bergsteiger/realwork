{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{   Copyright and license exceptions noted in source    }
{                                                       }
{*******************************************************}

unit Posix.Sched;

{$WEAKPACKAGEUNIT}

interface

uses Posix.Base;

{$HPPEMIT '#include <sched.h>' }

{$IFDEF MACOS}
{$I osx/SchedTypes.inc}
{$ENDIF MACOS}
{$IFDEF LINUX}
{$I linux/SchedTypes.inc}
{$ENDIF LINUX}

{$I SchedAPI.inc}

implementation

end.
