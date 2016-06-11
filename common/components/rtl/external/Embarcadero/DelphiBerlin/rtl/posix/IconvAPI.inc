{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

{$IFNDEF ANDROID}
function iconv(cd: iconv_t; InBuf: PMarshaledAString; InBytesLeft: Psize_t;
	 OutBuf: PMarshaledAString; OutBytesLeft: Psize_t): size_t; cdecl;
  external libiconv name _PU + 'iconv';
{$EXTERNALSYM iconv}

function iconv_open(ToCode: MarshaledAString; FromCode: MarshaledAString): iconv_t; cdecl;
  external libiconv name _PU + 'iconv_open';
{$EXTERNALSYM iconv_open}

function iconv_close(cd: iconv_t): Integer; cdecl;
  external libiconv name _PU + 'iconv_close';
{$EXTERNALSYM iconv_close}
{$ENDIF !ANDROID}
