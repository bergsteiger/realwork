{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}


{ Compare S1 and S2, both interpreted as appropriate to the
   LC_COLLATE category of the current locale.  }
function wcscoll(const __s1, __s2: Pwchar_t): Integer; cdecl;
  external libc name _PU + 'wcscoll';
{$EXTERNALSYM wcscoll}

function wcscoll_l(const __s1, __s2: Pwchar_t; Locale: locale_t): Integer; cdecl;
  external libc name _PU + 'wcscoll_l';
{$EXTERNALSYM wcscoll_l}
