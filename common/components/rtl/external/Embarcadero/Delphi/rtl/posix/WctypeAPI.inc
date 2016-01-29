{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

function iswalnum(WC: wint_t): Integer; cdecl;
  external libc name _PU + 'iswalnum';
{$EXTERNALSYM iswalnum}
function iswalnum_l(WC: wint_t; Locale: locale_t): Integer; cdecl;
  external libc name _PU + 'iswalnum_l';
{$EXTERNALSYM iswalnum_l}
function iswalpha(WC: wint_t): Integer; cdecl;
  external libc name _PU + 'iswalpha';
{$EXTERNALSYM iswalpha}
function iswalpha_l(WC: wint_t; Locale: locale_t): Integer; cdecl;
  external libc name _PU + 'iswalpha_l';
{$EXTERNALSYM iswalpha_l}
function iswblank(WC: wint_t): Integer; cdecl;
  external libc name _PU + 'iswblank';
{$EXTERNALSYM iswblank}
function iswblank_l(WC: wint_t; Locale:locale_t): Integer; cdecl;
  external libc name _PU + 'iswblank_l';
{$EXTERNALSYM iswblank_l}
function iswcntrl(WC: wint_t): Integer; cdecl;
  external libc name _PU + 'iswcntrl';
{$EXTERNALSYM iswcntrl}
function iswcntrl_l(WC: wint_t; Locale: locale_t): Integer; cdecl;
  external libc name _PU + 'iswcntrl_l';
{$EXTERNALSYM iswcntrl_l}
function iswctype(WC: wint_t; CharClass: wctype_t): Integer; cdecl;
  external libc name _PU + 'iswctype';
{$EXTERNALSYM iswctype}
function iswctype_l(WC: wint_t; CharClass: wctype_t; Locale: locale_t): Integer; cdecl;
  external libc name _PU + 'iswctype_l';
{$EXTERNALSYM iswctype_l}
function iswdigit(WC: wint_t): Integer; cdecl;
  external libc name _PU + 'iswdigit';
{$EXTERNALSYM iswdigit}
function iswdigit_l(WC: wint_t; Locale: locale_t): Integer; cdecl;
  external libc name _PU + 'iswdigit_l';
{$EXTERNALSYM iswdigit_l}
function iswgraph(WC: wint_t): Integer; cdecl;
  external libc name _PU + 'iswgraph';
{$EXTERNALSYM iswgraph}
function iswgraph_l(WC: wint_t; Locale: locale_t): Integer; cdecl;
  external libc name _PU + 'iswgraph_l';
{$EXTERNALSYM iswgraph_l}
function iswlower(WC: wint_t): Integer; cdecl;
  external libc name _PU + 'iswlower';
{$EXTERNALSYM iswlower}
function iswlower_l(WC: wint_t; Locale: locale_t): Integer; cdecl;
  external libc name _PU + 'iswlower_l';
{$EXTERNALSYM iswlower_l}
function iswprint(WC: wint_t): Integer; cdecl;
  external libc name _PU + 'iswprint';
{$EXTERNALSYM iswprint}
function iswprint_l(WC: wint_t; Locale: locale_t): Integer; cdecl;
  external libc name _PU + 'iswprint_l';
{$EXTERNALSYM iswprint_l}
function iswpunct(WC: wint_t): Integer; cdecl;
  external libc name _PU + 'iswpunct';
{$EXTERNALSYM iswpunct}
function iswpunct_l(WC: wint_t; Locale: locale_t): Integer; cdecl;
  external libc name _PU + 'iswpunct_l';
{$EXTERNALSYM iswpunct_l}
function iswspace(WC: wint_t): Integer; cdecl;
  external libc name _PU + 'iswspace';
{$EXTERNALSYM iswspace}
function iswspace_l(WC: wint_t; Locale: locale_t): Integer; cdecl;
  external libc name _PU + 'iswspace_l';
{$EXTERNALSYM iswspace_l}
function iswupper(WC: wint_t): Integer; cdecl;
  external libc name _PU + 'iswupper';
{$EXTERNALSYM iswupper}
function iswupper_l(WC: wint_t; Locale: locale_t): Integer; cdecl;
  external libc name _PU + 'iswupper_l';
{$EXTERNALSYM iswupper_l}
function iswxdigit(WC: wint_t): Integer; cdecl;
  external libc name _PU + 'iswxdigit';
{$EXTERNALSYM iswxdigit}
function iswxdigit_l(WC: wint_t; Locale: locale_t): Integer; cdecl;
  external libc name _PU + 'iswxdigit_l';
{$EXTERNALSYM iswxdigit_l}
function towctrans(WC: wint_t; Desc: wctrans_t): wint_t; cdecl;
  external libc name _PU + 'towctrans';
{$EXTERNALSYM towctrans}
function towctrans_l(WC: wint_t; Desc: wctrans_t; Locale: locale_t): wint_t; cdecl;
  external libc name _PU + 'towctrans_l';
{$EXTERNALSYM towctrans_l}
function towlower(WC: wint_t): wint_t; cdecl;
  external libc name _PU + 'towlower';
{$EXTERNALSYM towlower}
function towlower_l(WC: wint_t; Locale: locale_t): wint_t; cdecl;
  external libc name _PU + 'towlower_l';
{$EXTERNALSYM towlower_l}
function towupper(WC: wint_t): wint_t; cdecl;
  external libc name _PU + 'towupper';
{$EXTERNALSYM towupper}
function towupper_l(WC: wint_t; Locale: locale_t): wint_t; cdecl;
  external libc name _PU + 'towupper_l';
{$EXTERNALSYM towupper_l}
function wctrans(const CharClass: MarshaledAString): wctrans_t; cdecl;
  external libc name _PU + 'wctrans';
{$EXTERNALSYM wctrans}
function wctrans_l(const CharClass: MarshaledAString; Locale: locale_t): wctrans_t; cdecl;
  external libc name _PU + 'wctrans_l';
{$EXTERNALSYM wctrans_l}
function wctype(const CharClass: MarshaledAString): wctype_t; cdecl;
  external libc name _PU + 'wctype';
{$EXTERNALSYM wctype}
function wctype_l(const CharClass: MarshaledAString; Locale: locale_t): wctype_t; cdecl;
  external libc name _PU + 'wctype_l';
{$EXTERNALSYM wctype_l}
