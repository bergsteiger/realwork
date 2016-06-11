{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

{$IFNDEF ANDROID}
function nl_langinfo(item: nl_item): MarshaledAString; cdecl;
  external libc name _PU + 'nl_langinfo';
{$EXTERNALSYM nl_langinfo}

function nl_langinfo_l(item: nl_item; Locale: locale_t): MarshaledAString; cdecl;
  external libc name _PU + 'nl_langinfo_l';
{$EXTERNALSYM nl_langinfo_l}
{$ENDIF}
