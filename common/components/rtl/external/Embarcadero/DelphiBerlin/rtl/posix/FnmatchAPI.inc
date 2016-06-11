{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

{ Match STRING against the filename pattern PATTERN,
   returning zero if it matches, FNM_NOMATCH if not.  }
function fnmatch(Pattern: MarshaledAString; FName: MarshaledAString; Flags: Integer): Integer; cdecl;
  external libc name _PU + 'fnmatch';
{$EXTERNALSYM fnmatch}
