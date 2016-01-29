{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

{ Do word expansion of WORDS into PWORDEXP. }
function wordexp(Words: MarshaledAString; var WordExp: wordexp_t; Flags: Integer): Integer; cdecl;
  external libc name _PU + 'wordexp';
{$EXTERNALSYM wordexp}

{ Free the storage allocated by a `wordexp' call.  }
procedure wordfree(var WordExp: wordexp_t); cdecl;
  external libc name _PU + 'wordfree';
{$EXTERNALSYM wordfree}
