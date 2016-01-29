{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{   Copyright and license exceptions noted in source    }
{                                                       }
{*******************************************************}

unit Posix.Dlfcn;

{$WEAKPACKAGEUNIT}

interface

uses Posix.Base;

{$IFDEF MACOS}
{$I osx/DlfcnTypes.inc}
{$ENDIF MACOS}
{$IFDEF LINUX}
{$I linux/DlfcnTypes.inc}
{$ENDIF LINUX}

{$I DlfcnAPI.inc}

{$HPPEMIT '#include <dlfcn.h>'}


implementation

end.
