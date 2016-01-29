{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{   Copyright and license exceptions noted in source    }
{                                                       }
{*******************************************************}

unit Posix.Locale;

{$WEAKPACKAGEUNIT}

interface

uses Posix.Base;

{$IFDEF MACOS}
{$I osx/LocaleTypes.inc}
{$ENDIF MACOS}
{$IFDEF LINUX}
{$I linux/LocaleTypes.inc}
{$ENDIF LINUX}

{$I LocaleAPI.inc}

(*$HPPEMIT '#include <locale.h>' *)

implementation

end.
