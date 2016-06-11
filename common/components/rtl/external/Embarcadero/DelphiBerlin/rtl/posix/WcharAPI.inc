{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}


{ Compare S1 and S2, both interpreted as appropriate to the
   LC_COLLATE category of the current locale.  }
function wcscoll(const __s1, __s2: Pwchar_t): Integer; cdecl;
  external libc name _PU + 'wcscoll';
{$EXTERNALSYM wcscoll}

{$IFNDEF ANDROID}
function wcscoll_l(const __s1, __s2: Pwchar_t; Locale: locale_t): Integer; cdecl;
  external libc name _PU + 'wcscoll_l';
{$EXTERNALSYM wcscoll_l}

{$IFDEF LINUX}
function wcscasecmp(const __s1, __s2: Pwchar_t): Integer; cdecl;
  external libc name _PU + 'wcscasecmp';
{$EXTERNALSYM wcscasecmp}
function wcscasecmp_l(const __s1, __s2: Pwchar_t; Locale: locale_t): Integer; cdecl;
  external libc name _PU + 'wcscasecmp_l';
{$EXTERNALSYM wcscasecmp_l}
function wcsncasecmp(const __s1, __s2: Pwchar_t; n: size_t): Integer; cdecl;
  external libc name _PU + 'wcsncasecmp';
{$EXTERNALSYM wcsncasecmp}
function wcsncasecmp_l(const __s1, __s2: Pwchar_t; n: size_t; Locale: locale_t): Integer; cdecl;
  external libc name _PU + 'wcsncasecmp_l';
{$EXTERNALSYM wcsncasecmp_l}
{$ENDIF LINUX}

{$ENDIF !ANDROID}
