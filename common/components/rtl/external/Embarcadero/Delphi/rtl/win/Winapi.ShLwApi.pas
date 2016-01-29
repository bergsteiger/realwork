{******************************************************************}
{                                                                  }
{                Delphi Runtime Library                            }
{       Shell Ligtweight Utilities interface unit                  }
{                                                                  }
{ Portions created by Microsoft are                                }
{ Copyright (C) 1995-1999 Microsoft Corporation.                   }
{ All Rights Reserved.                                             }
{                                                                  }
{ The original file is: shlwapi.h, released 2 March 1999.          }
{ The original Pascal code is: ShLwApi.pas, released 1 Dec 1999.   }
{ The initial developer of the Pascal code is Marcel van Brakel    }
{ (brakelm@chello.nl).                                             }
{                                                                  }
{ Portions created by Marcel van Brakel are                        }
{ Copyright (C) 1999 Marcel van Brakel.                            }
{                                                                  }
{ Obtained through:                                                }
{ Joint Endeavour of Delphi Innovators (Project JEDI)              }
{                                                                  }
{ You may retrieve the latest version of this file at the Project  }
{ JEDI home page, located at http://delphi-jedi.org                }
{                                                                  }
{ The contents of this file are used with permission, subject to   }
{ the Mozilla Public License Version 1.1 (the "License"); you may  }
{ not use this file except in compliance with the License. You may }
{ obtain a copy of the License at                                  }
{ http://www.mozilla.org/NPL/NPL-1_1Final.html                     }
{                                                                  }
{ Software distributed under the License is distributed on an      }
{ "AS IS" basis, WITHOUT WARRANTY OF ANY KIND, either express or   }
{ implied. See the License for the specific language governing     }
{ rights and limitations under the License.                        }
{                                                                  }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc.            }
{                                                                  }
{******************************************************************}

unit Winapi.ShLwApi;

{$ALIGN ON}
{$MINENUMSIZE 4}
{$WEAKPACKAGEUNIT}

interface

{$HPPEMIT ''}
{$HPPEMIT '#if !defined(_INC_SHLWAPI)'}
{$HPPEMIT ' #include <shlwapi.h>'}
{$HPPEMIT ' #if defined(StrToInt) && !defined(NO_UNDEF_StrToInt)'}
{$HPPEMIT '  #undef StrToInt // Conflicts /w System::Sysutils::StrToInt'}
{$HPPEMIT ' #endif'}
{$HPPEMIT '#endif'}
{$HPPEMIT ''}

uses
  Winapi.Windows, Winapi.ActiveX, Winapi.ShlObj;

{.$INCLUDE SHLWAPI.INC}
     { _WIN32_IE >= _WIN32_IE_IE50 }
   { _WIN32_IE >= _WIN32_IE_IE501 }
{ $DEFINE _WIN32_IE_55}    { _WIN32_IE >= _WIN32_IE_IE55 }
{ $DEFINE _WIN32_IE_6}     { _WIN32_IE >= _WIN32_IE_IE60 }
{ $DEFINE _WIN32_IE_602}   { _WIN32_IE >= 0x0602 }
{ $DEFINE _WIN32_IE_60SP2} { _WIN32_IE >= _WIN32_IE_IE60SP2 }
{ $DEFINE _WIN32_IE_603}   { _WIN32_IE >= 0x0603 }
{ $DEFINE _WIN32_IE_7}     { _WIN32_IE >= _WIN32_IE_IE70 }
{ $DEFINE _WIN32_IE_8}     { _WIN32_IE >= _WIN32_IE_IE80 }
{ $DEFINE NTDDI_VERSION_VISTA}    { NTDDI_VERSION >= NTDDI_VISTA }
{ $DEFINE NTDDI_VERSION_VISTASP1} { NTDDI_VERSION >= NTDDI_VISTASP1 }
{ $DEFINE NTDDI_VERSION_WIN7}     { NTDDI_VERSION >= NTDDI_WIN7 }


// Users of this header may define any number of these constants to avoid
// the definitions of each functional group.
//
//    NO_SHLWAPI_STRFCNS    String functions
//    NO_SHLWAPI_PATH       Path functions
//    NO_SHLWAPI_REG        Registry functions
//    NO_SHLWAPI_STREAM     Stream functions
//    NO_SHLWAPI_GDI        GDI helper functions

type
  IID = TGUID;
  {$EXTERNALSYM IID}
  REFIID = TGUID;
  {$EXTERNALSYM REFIID}


// String Routines

function StrChr(lpStart: LPCWSTR; wMatch: WORD): LPWSTR; stdcall;
{$EXTERNALSYM StrChr}
function StrChrA(lpStart: LPCSTR; wMatch: WORD): LPSTR; stdcall;
{$EXTERNALSYM StrChrA}
function StrChrW(lpStart: LPCWSTR; wMatch: WORD): LPWSTR; stdcall;
{$EXTERNALSYM StrChrW}
function StrChrI(lpStart: LPCWSTR; wMatch: WORD): LPWSTR; stdcall;
{$EXTERNALSYM StrChrI}
function StrChrIA(lpStart: LPCSTR; wMatch: WORD): LPSTR; stdcall;
{$EXTERNALSYM StrChrIA}
function StrChrIW(lpStart: LPCWSTR; wMatch: WORD): LPWSTR; stdcall;
{$EXTERNALSYM StrChrIW}
function StrCmpN(lpStr1, lpStr2: LPCWSTR; nChar: Integer): Integer; stdcall;
{$EXTERNALSYM StrCmpN}
function StrCmpNA(lpStr1, lpStr2: LPCSTR; nChar: Integer): Integer; stdcall;
{$EXTERNALSYM StrCmpNA}
function StrCmpNW(lpStr1, lpStr2: LPCWSTR; nChar: Integer): Integer; stdcall;
{$EXTERNALSYM StrCmpNW}
function StrCmpNI(lpStr1, lpStr2: LPCWSTR; nChar: Integer): Integer; stdcall;
{$EXTERNALSYM StrCmpNI}
function StrCmpNIA(lpStr1, lpStr2: LPCSTR; nChar: Integer): Integer; stdcall;
{$EXTERNALSYM StrCmpNIA}
function StrCmpNIW(lpStr1, lpStr2: LPCWSTR; nChar: Integer): Integer; stdcall;
{$EXTERNALSYM StrCmpNIW}
function StrCSpn(lpStr_, lpSet: LPCWSTR): Integer; stdcall;
{$EXTERNALSYM StrCSpn}
function StrCSpnA(lpStr_, lpSet: LPCSTR): Integer; stdcall;
{$EXTERNALSYM StrCSpnA}
function StrCSpnW(lpStr_, lpSet: LPCWSTR): Integer; stdcall;
{$EXTERNALSYM StrCSpnW}
function StrCSpnI(lpStr1, lpSet: LPCWSTR): Integer; stdcall;
{$EXTERNALSYM StrCSpnI}
function StrCSpnIA(lpStr1, lpSet: LPCSTR): Integer; stdcall;
{$EXTERNALSYM StrCSpnIA}
function StrCSpnIW(lpStr1, lpSet: LPCWSTR): Integer; stdcall;
{$EXTERNALSYM StrCSpnIW}
function StrDup(lpSrch: LPCWSTR): LPWSTR; stdcall;
{$EXTERNALSYM StrDup}
function StrDupA(lpSrch: LPCSTR): LPSTR; stdcall;
{$EXTERNALSYM StrDupA}
function StrDupW(lpSrch: LPCWSTR): LPWSTR; stdcall;
{$EXTERNALSYM StrDupW}

function StrFormatByteSize(qdw: LONGLONG; szBuf: PWideChar; uiBufSize: UINT): PWideChar; stdcall;
{$EXTERNALSYM StrFormatByteSize}
function StrFormatByteSizeA(dw: DWORD; szBuf: PAnsiChar; uiBufSize: UINT): PAnsiChar; stdcall;
{$EXTERNALSYM StrFormatByteSizeA}
function StrFormatByteSizeW(qdw: LONGLONG; szBuf: PWideChar; uiBufSize: UINT): PWideChar; stdcall;
{$EXTERNALSYM StrFormatByteSizeW}

function StrFormatByteSize64(qdw: LONGLONG; pszBuf: LPWSTR; cchBuf:UINT): LPWSTR; stdcall;
{$EXTERNALSYM StrFormatByteSize64}
function StrFormatByteSize64A(qdw: LONGLONG; pszBuf: LPSTR; cchBuf:UINT): LPSTR; stdcall;
{$EXTERNALSYM StrFormatByteSize64A}
function StrFormatByteSize64W(qdw: LONGLONG; pszBuf: LPWSTR; cchBuf:UINT): LPWSTR; stdcall;
{$EXTERNALSYM StrFormatByteSize64W}



function StrFormatKBSize(qdw: LONGLONG; szBuf: LPWSTR; uiBufSize: UINT): LPWSTR; stdcall;
{$EXTERNALSYM StrFormatKBSize}
function StrFormatKBSizeA(qdw: LONGLONG; szBuf: LPSTR; uiBufSize: UINT): LPSTR; stdcall;
{$EXTERNALSYM StrFormatKBSizeA}
function StrFormatKBSizeW(qdw: LONGLONG; szBuf: LPWSTR; uiBufSize: UINT): LPWSTR; stdcall;
{$EXTERNALSYM StrFormatKBSizeW}



function StrFromTimeInterval(pszOut: LPWSTR; cchMax: UINT; dwTimeMS: DWORD;
  digits: Integer): Integer; stdcall;
{$EXTERNALSYM StrFromTimeInterval}
function StrFromTimeIntervalA(pszOut: LPSTR; cchMax: UINT; dwTimeMS: DWORD;
  digits: Integer): Integer; stdcall;
{$EXTERNALSYM StrFromTimeIntervalA}
function StrFromTimeIntervalW(pszOut: LPWSTR; cchMax: UINT; dwTimeMS: DWORD;
  digits: Integer): Integer; stdcall;
{$EXTERNALSYM StrFromTimeIntervalW}
function StrIsIntlEqual(fCaseSens: BOOL; lpString1, lpString2: LPCWSTR; nChar: Integer): BOOL; stdcall;
{$EXTERNALSYM StrIsIntlEqual}
function StrIsIntlEqualA(fCaseSens: BOOL; lpString1, lpString2: LPCSTR; nChar: Integer): BOOL; stdcall;
{$EXTERNALSYM StrIsIntlEqualA}
function StrIsIntlEqualW(fCaseSens: BOOL; lpString1, lpString2: LPCWSTR; nChar: Integer): BOOL; stdcall;
{$EXTERNALSYM StrIsIntlEqualW}
function StrNCat(psz1: LPWSTR; psz2: LPCWSTR; cchMax: IntPtr): LPWSTR; stdcall;
{$EXTERNALSYM StrNCat}
function StrNCatA(psz1: LPSTR; psz2: LPCSTR; cchMax: IntPtr): LPSTR; stdcall;
{$EXTERNALSYM StrNCatA}
function StrNCatW(psz1: LPWSTR; psz2: LPCWSTR; cchMax: IntPtr): LPWSTR; stdcall;
{$EXTERNALSYM StrNCatW}
function StrPBrk(psz, pszSet: LPCWSTR): LPWSTR; stdcall;
{$EXTERNALSYM StrPBrk}
function StrPBrkA(psz, pszSet: LPCSTR): LPSTR; stdcall;
{$EXTERNALSYM StrPBrkA}
function StrPBrkW(psz, pszSet: LPCWSTR): LPWSTR; stdcall;
{$EXTERNALSYM StrPBrkW}
function StrRChr(lpStart, lpEnd: LPCWSTR; wMatch: WORD): LPWSTR; stdcall;
{$EXTERNALSYM StrRChr}
function StrRChrA(lpStart, lpEnd: LPCSTR; wMatch: WORD): LPSTR; stdcall;
{$EXTERNALSYM StrRChrA}
function StrRChrW(lpStart, lpEnd: LPCWSTR; wMatch: WORD): LPWSTR; stdcall;
{$EXTERNALSYM StrRChrW}
function StrRChrI(lpStart, lpEnd: LPCWSTR; wMatch: WORD): LPWSTR; stdcall;
{$EXTERNALSYM StrRChrI}
function StrRChrIA(lpStart, lpEnd: LPCSTR; wMatch: WORD): LPSTR; stdcall;
{$EXTERNALSYM StrRChrIA}
function StrRChrIW(lpStart, lpEnd: LPCWSTR; wMatch: WORD): LPWSTR; stdcall;
{$EXTERNALSYM StrRChrIW}
function StrRStrI(lpSource, lpLast, lpSrch: LPCWSTR): LPWSTR; stdcall;
{$EXTERNALSYM StrRStrI}
function StrRStrIA(lpSource, lpLast, lpSrch: LPCSTR): LPSTR; stdcall;
{$EXTERNALSYM StrRStrIA}
function StrRStrIW(lpSource, lpLast, lpSrch: LPCWSTR): LPWSTR; stdcall;
{$EXTERNALSYM StrRStrIW}
function StrSpn(psz, pszSet: LPCWSTR): Integer; stdcall;
{$EXTERNALSYM StrSpn}
function StrSpnA(psz, pszSet: LPCSTR): Integer; stdcall;
{$EXTERNALSYM StrSpnA}
function StrSpnW(psz, pszSet: LPCWSTR): Integer; stdcall;
{$EXTERNALSYM StrSpnW}
function StrStr(lpFirst, lpSrch: LPCWSTR): LPWSTR; stdcall;
{$EXTERNALSYM StrStr}
function StrStrA(lpFirst, lpSrch: LPCSTR): LPSTR; stdcall;
{$EXTERNALSYM StrStrA}
function StrStrW(lpFirst, lpSrch: LPCWSTR): LPWSTR; stdcall;
{$EXTERNALSYM StrStrW}
function StrStrI(lpFirst, lpSrch: LPCWSTR): LPWSTR; stdcall;
{$EXTERNALSYM StrStrI}
function StrStrIA(lpFirst, lpSrch: LPCSTR): LPSTR; stdcall;
{$EXTERNALSYM StrStrIA}
function StrStrIW(lpFirst, lpSrch: LPCWSTR): LPWSTR; stdcall;
{$EXTERNALSYM StrStrIW}
function StrToInt(lpSrch: LPCWSTR): Integer; stdcall;
{$EXTERNALSYM StrToInt}
function StrToIntA(lpSrch: LPCSTR): Integer; stdcall;
{$EXTERNALSYM StrToIntA}
function StrToIntW(lpSrch: LPCWSTR): Integer; stdcall;
{$EXTERNALSYM StrToIntW}
function StrToIntEx(pszString: LPCWSTR; dwFlags: DWORD; var piRet: Integer): BOOL; stdcall;
{$EXTERNALSYM StrToIntEx}
function StrToIntExA(pszString: LPCSTR; dwFlags: DWORD; var piRet: Integer): BOOL; stdcall;
{$EXTERNALSYM StrToIntExA}
function StrToIntExW(pszString: LPCWSTR; dwFlags: DWORD; var piRet: Integer): BOOL; stdcall;
{$EXTERNALSYM StrToIntExW}
function StrTrim(psz: LPWSTR; pszTrimChars: LPCWSTR): BOOL; stdcall;
{$EXTERNALSYM StrTrim}
function StrTrimA(psz: LPSTR; pszTrimChars: LPCSTR): BOOL; stdcall;
{$EXTERNALSYM StrTrimA}
function StrTrimW(psz: LPWSTR; pszTrimChars: LPCWSTR): BOOL; stdcall;
{$EXTERNALSYM StrTrimW}

function ChrCmpI(w1, w2: WORD): BOOL; stdcall;
{$EXTERNALSYM ChrCmpI}
function ChrCmpIA(w1, w2: WORD): BOOL; stdcall;
{$EXTERNALSYM ChrCmpIA}
function ChrCmpIW(w1, w2: WORD): BOOL; stdcall;
{$EXTERNALSYM ChrCmpIW}

function StrIntlEqN(s1, s2: LPCWSTR; nChar: Integer): BOOL;
{$EXTERNALSYM StrIntlEqN}
function StrIntlEqNA(s1, s2: LPCSTR; nChar: Integer): BOOL;
{$EXTERNALSYM StrIntlEqNA}
function StrIntlEqNW(s1, s2: LPCWSTR; nChar: Integer): BOOL;
{$EXTERNALSYM StrIntlEqNW}

function StrIntlEqNI(s1, s2: LPCWSTR; nChar: Integer): BOOL;
{$EXTERNALSYM StrIntlEqNI}
function StrIntlEqNIA(s1, s2: LPCSTR; nChar: Integer): BOOL;
{$EXTERNALSYM StrIntlEqNIA}
function StrIntlEqNIW(s1, s2: LPCWSTR; nChar: Integer): BOOL;
{$EXTERNALSYM StrIntlEqNIW}



function StrCatBuff(pszDest, pszSrc: LPWSTR; cchDestBuffSize: Integer): LPWSTR; stdcall;
{$EXTERNALSYM StrCatBuff}
function StrCatBuffA(pszDest, pszSrc: LPSTR; cchDestBuffSize: Integer): LPSTR; stdcall;
{$EXTERNALSYM StrCatBuffA}
function StrCatBuffW(pszDest, pszSrc: LPWSTR; cchDestBuffSize: Integer): LPWSTR; stdcall;
{$EXTERNALSYM StrCatBuffW}
function StrCpyNX(psz1: LPWSTR; psz2: LPCWSTR; cchMax: Integer): LPWSTR; stdcall;
{$EXTERNALSYM StrCpyNX}
function StrCpyNXA(psz1: LPSTR; psz2: LPCSTR; cchMax: Integer): LPSTR; stdcall;
{$EXTERNALSYM StrCpyNXA}
function StrCpyNXW(psz1: LPWSTR; psz2: LPCWSTR; cchMax: Integer): LPWSTR; stdcall;
{$EXTERNALSYM StrCpyNXW}





(*
LWSTDAPI_(int)      wvnsprintfA(LPSTR lpOut, int cchLimitIn, LPCSTR lpFmt, va_list arglist);
LWSTDAPI_(int)      wvnsprintfW(LPWSTR lpOut, int cchLimitIn, LPCWSTR lpFmt, va_list arglist);
LWSTDAPIV_(int)     wnsprintfA(LPSTR lpOut, int cchLimitIn, LPCSTR lpFmt, ...);
LWSTDAPIV_(int)     wnsprintfW(LPWSTR lpOut, int cchLimitIn, LPCWSTR lpFmt, ...);
*)

function StrRetToStr(pstr: PStrRet; const pidl: PItemIdList; out ppsz: LPWSTR): HRESULT; stdcall;
{$EXTERNALSYM StrRetToStr}
function StrRetToStrA(pstr: PStrRet; const pidl: PItemIdList; out ppsz: LPSTR): HRESULT; stdcall;
{$EXTERNALSYM StrRetToStrA}
function StrRetToStrW(pstr: PStrRet; const pidl: PItemIdList; out ppsz: LPWSTR): HRESULT; stdcall;
{$EXTERNALSYM StrRetToStrW}

function StrRetToBuf(pstr: PStrRet; const pidl: PItemIdList; pszBuf: LPWSTR; cchBuf: UINT): HRESULT; stdcall;
{$EXTERNALSYM StrRetToBuf}
function StrRetToBufA(pstr: PStrRet; const pidl: PItemIdList; pszBuf: LPSTR; cchBuf: UINT): HRESULT; stdcall;
{$EXTERNALSYM StrRetToBufA}
function StrRetToBufW(pstr: PStrRet; const pidl: PItemIdList; pszBuf: LPWSTR; cchBuf: UINT): HRESULT; stdcall;
{$EXTERNALSYM StrRetToBufW}

// helper to duplicate a string using the task allocator

function SHStrDup(psz: LPCWSTR; out ppwsz: PWideChar): HRESULT; stdcall;
{$EXTERNALSYM SHStrDup}
function SHStrDupA(psz: LPCSTR; out ppwsz: PWideChar): HRESULT; stdcall;
{$EXTERNALSYM SHStrDupA}
function SHStrDupW(psz: LPCWSTR; out ppwsz: PWideChar): HRESULT; stdcall;
{$EXTERNALSYM SHStrDupW}

// Backward compatible to NT's non-standard naming (strictly
// for comctl32)

function IntlStrEqWorker(fCaseSens: BOOL; lpString1, lpString2: LPCWSTR; nChar: Integer): BOOL; stdcall;
{$EXTERNALSYM IntlStrEqWorker}
function IntlStrEqWorkerA(fCaseSens: BOOL; lpString1, lpString2: LPCSTR; nChar: Integer): BOOL; stdcall;
{$EXTERNALSYM IntlStrEqWorkerA}
function IntlStrEqWorkerW(fCaseSens: BOOL; lpString1, lpString2: LPCWSTR; nChar: Integer): BOOL; stdcall;
{$EXTERNALSYM IntlStrEqWorkerW}

function IntlStrEqN(s1, s2: LPCWSTR; nChar: Integer): BOOL;
{$EXTERNALSYM IntlStrEqN}
function IntlStrEqNA(s1, s2: LPCSTR; nChar: Integer): BOOL;
{$EXTERNALSYM IntlStrEqNA}
function IntlStrEqNW(s1, s2: LPCWSTR; nChar: Integer): BOOL;
{$EXTERNALSYM IntlStrEqNW}

 // IE 5

const
  SZ_CONTENTTYPE_HTMLA = 'text/html';
  {$EXTERNALSYM SZ_CONTENTTYPE_HTMLA}
  SZ_CONTENTTYPE_HTMLW = 'text/html';
  {$EXTERNALSYM SZ_CONTENTTYPE_HTMLW}
  SZ_CONTENTTYPE_HTML = SZ_CONTENTTYPE_HTMLW;
  {$EXTERNALSYM SZ_CONTENTTYPE_HTML}
  SZ_CONTENTTYPE_CDFA  = 'application/x-cdf';
  {$EXTERNALSYM SZ_CONTENTTYPE_CDFA}
  SZ_CONTENTTYPE_CDFW  = 'application/x-cdf';
  {$EXTERNALSYM SZ_CONTENTTYPE_CDFW}
  SZ_CONTENTTYPE_CDF = SZ_CONTENTTYPE_CDFW;
  {$EXTERNALSYM SZ_CONTENTTYPE_CDF}

function PathIsHTMLFile(pszPath: LPCWSTR): BOOL;
{$EXTERNALSYM PathIsHTMLFile}
function PathIsHTMLFileA(pszPath: LPCSTR): BOOL;
{$EXTERNALSYM PathIsHTMLFileA}
function PathIsHTMLFileW(pszPath: LPCWSTR): BOOL;
{$EXTERNALSYM PathIsHTMLFileW}
  {$EXTERNALSYM PathIsHTMLFile}

// Flags for StrToIntEx

const
  STIF_DEFAULT      = $00000000;
  {$EXTERNALSYM STIF_DEFAULT}
  STIF_SUPPORT_HEX  = $00000001;
  {$EXTERNALSYM STIF_SUPPORT_HEX}

function StrCatA(psz1, psz2: PAnsiChar): PAnsiChar;
{$EXTERNALSYM StrCatA}
function StrCatW(psz1, psz2: PWideChar): PWideChar; stdcall;
{$EXTERNALSYM StrCatW}
{$IFDEF UNICODE}
function StrCat(psz1, psz2: PWideChar): PWideChar; stdcall;
{$EXTERNALSYM StrCat}
{$ELSE}
function StrCat(psz1, psz2: PAnsiChar): PAnsiChar;
{$EXTERNALSYM StrCat}
{$ENDIF}

function StrCmpA(psz1, psz2: PAnsiChar): Integer;
{$EXTERNALSYM StrCmpA}
function StrCmpW(psz1, psz2: PWideChar): Integer; stdcall;
{$EXTERNALSYM StrCmpW}
{$IFDEF UNICODE}
function StrCmp(psz1, psz2: PWideChar): Integer; stdcall;
{$EXTERNALSYM StrCmp}
{$ELSE}
function StrCmp(psz1, psz2: PAnsiChar): Integer;
{$EXTERNALSYM StrCmp}
{$ENDIF}

function StrCmpIA(psz1, psz2: PAnsiChar): Integer; 
{$EXTERNALSYM StrCmpIA}
function StrCmpIW(psz1, psz2: PWideChar): Integer; stdcall;
{$EXTERNALSYM StrCmpIW}
{$IFDEF UNICODE}
function StrCmpI(psz1, psz2: PWideChar): Integer; stdcall;
{$EXTERNALSYM StrCmpI}
{$ELSE}
function StrCmpI(psz1, psz2: PAnsiChar): Integer; 
{$EXTERNALSYM StrCmpI}
{$ENDIF}

function StrCpyA(psz1, psz2: PAnsiChar): PAnsiChar;
{$EXTERNALSYM StrCpyA}
function StrCpyW(psz1, psz2: PWideChar): PWideChar; stdcall;
{$EXTERNALSYM StrCpyW}
{$IFDEF UNICODE}
function StrCpy(psz1, psz2: PWideChar): PWideChar; stdcall;
{$EXTERNALSYM StrCpy}
{$ELSE}
function StrCpy(psz1, psz2: PAnsiChar): PAnsiChar; 
{$EXTERNALSYM StrCpy}
{$ENDIF}

function StrCpyNA(psz1, psz2: PAnsiChar; cchMax: Integer): PAnsiChar;
{$EXTERNALSYM StrCpyNA}
function StrCpyNW(psz1, psz2: PWideChar; cchMax: Integer): PWideChar; stdcall;
{$EXTERNALSYM StrCpyNW}
{$IFDEF UNICODE}
function StrCpyN(psz1, psz2: PWideChar; cchMax: Integer): PWideChar; stdcall;
{$EXTERNALSYM StrCpyN}
{$ELSE}
function StrCpyN(psz1, psz2: PAnsiChar; cchMax: Integer): PAnsiChar; 
{$EXTERNALSYM StrCpyN}
{$ENDIF}

function StrToLong(lpSrch: LPCWSTR): Integer;
{$EXTERNALSYM StrToLong}
function StrToLongA(lpSrch: LPCSTR): Integer;
{$EXTERNALSYM StrToLongA}
function StrToLongW(lpSrch: LPCWSTR): Integer;
{$EXTERNALSYM StrToLongW}
function StrNCmp(lpStr1, lpStr2: LPCWSTR; nChar: IntPtr): Integer;
{$EXTERNALSYM StrNCmp}
function StrNCmpA(lpStr1, lpStr2: LPCSTR; nChar: IntPtr): Integer;
{$EXTERNALSYM StrNCmpA}
function StrNCmpW(lpStr1, lpStr2: LPCWSTR; nChar: IntPtr): Integer;
{$EXTERNALSYM StrNCmpW}
function StrNCmpI(lpStr1, lpStr2: LPCWSTR; nChar: Integer): Integer;
{$EXTERNALSYM StrNCmpI}
function StrNCmpIA(lpStr1, lpStr2: LPCSTR; nChar: Integer): Integer;
{$EXTERNALSYM StrNCmpIA}
function StrNCmpIW(lpStr1, lpStr2: LPCWSTR; nChar: Integer): Integer;
{$EXTERNALSYM StrNCmpIW}
function StrNCpy(psz1, psz2: LPCWSTR; cchMax: IntPtr): LPWSTR;
{$EXTERNALSYM StrNCpy}
function StrNCpyA(psz1, psz2: LPCSTR; cchMax: IntPtr): LPSTR;
{$EXTERNALSYM StrNCpyA}
function StrNCpyW(psz1, psz2: LPCWSTR; cchMax: IntPtr): LPWSTR;
{$EXTERNALSYM StrNCpyW}
function StrCatN(psz1: LPWSTR; psz2: LPCWSTR; cchMax: Integer): LPWSTR;
{$EXTERNALSYM StrCatN}
function StrCatNA(psz1: LPSTR; psz2: LPCSTR; cchMax: Integer): LPSTR;
{$EXTERNALSYM StrCatNA}
function StrCatNW(psz1: LPWSTR; psz2: LPCWSTR; cchMax: Integer): LPWSTR;
{$EXTERNALSYM StrCatNW}
 // NO_SHLWAPI_STRFCNS


// Path Routines

function PathAddBackslash(pszPath: LPWSTR): LPWSTR; stdcall;
{$EXTERNALSYM PathAddBackslash}
function PathAddBackslashA(pszPath: LPSTR): LPSTR; stdcall;
{$EXTERNALSYM PathAddBackslashA}
function PathAddBackslashW(pszPath: LPWSTR): LPWSTR; stdcall;
{$EXTERNALSYM PathAddBackslashW}
function PathAddExtension(pszPath: LPWSTR; pszExt: LPCWSTR): BOOL; stdcall;
{$EXTERNALSYM PathAddExtension}
function PathAddExtensionA(pszPath: LPSTR; pszExt: LPCSTR): BOOL; stdcall;
{$EXTERNALSYM PathAddExtensionA}
function PathAddExtensionW(pszPath: LPWSTR; pszExt: LPCWSTR): BOOL; stdcall;
{$EXTERNALSYM PathAddExtensionW}
function PathAppend(pszPath: LPWSTR; pMore: LPCWSTR): BOOL; stdcall;
{$EXTERNALSYM PathAppend}
function PathAppendA(pszPath: LPSTR; pMore: LPCSTR): BOOL; stdcall;
{$EXTERNALSYM PathAppendA}
function PathAppendW(pszPath: LPWSTR; pMore: LPCWSTR): BOOL; stdcall;
{$EXTERNALSYM PathAppendW}
function PathBuildRoot(szRoot: LPWSTR; iDrive: Integer): LPWSTR; stdcall;
{$EXTERNALSYM PathBuildRoot}
function PathBuildRootA(szRoot: LPSTR; iDrive: Integer): LPSTR; stdcall;
{$EXTERNALSYM PathBuildRootA}
function PathBuildRootW(szRoot: LPWSTR; iDrive: Integer): LPWSTR; stdcall;
{$EXTERNALSYM PathBuildRootW}
function PathCanonicalize(pszBuf: LPWSTR; pszPath: LPCWSTR): BOOL; stdcall;
{$EXTERNALSYM PathCanonicalize}
function PathCanonicalizeA(pszBuf: LPSTR; pszPath: LPCSTR): BOOL; stdcall;
{$EXTERNALSYM PathCanonicalizeA}
function PathCanonicalizeW(pszBuf: LPWSTR; pszPath: LPCWSTR): BOOL; stdcall;
{$EXTERNALSYM PathCanonicalizeW}
function PathCombine(szDest: LPWSTR; lpszDir, lpszFile: LPCWSTR): LPWSTR; stdcall;
{$EXTERNALSYM PathCombine}
function PathCombineA(szDest: LPSTR; lpszDir, lpszFile: LPCSTR): LPSTR; stdcall;
{$EXTERNALSYM PathCombineA}
function PathCombineW(szDest: LPWSTR; lpszDir, lpszFile: LPCWSTR): LPWSTR; stdcall;
{$EXTERNALSYM PathCombineW}
function PathCompactPath(hDC: HDC; pszPath: LPWSTR; dx: UINT): BOOL; stdcall;
{$EXTERNALSYM PathCompactPath}
function PathCompactPathA(hDC: HDC; pszPath: LPSTR; dx: UINT): BOOL; stdcall;
{$EXTERNALSYM PathCompactPathA}
function PathCompactPathW(hDC: HDC; pszPath: LPWSTR; dx: UINT): BOOL; stdcall;
{$EXTERNALSYM PathCompactPathW}
function PathCompactPathEx(pszOut: LPWSTR; pszSrc: LPCWSTR; cchMax: UINT; dwFlags: DWORD): BOOL; stdcall;
{$EXTERNALSYM PathCompactPathEx}
function PathCompactPathExA(pszOut: LPSTR; pszSrc: LPCSTR; cchMax: UINT; dwFlags: DWORD): BOOL; stdcall;
{$EXTERNALSYM PathCompactPathExA}
function PathCompactPathExW(pszOut: LPWSTR; pszSrc: LPCWSTR; cchMax: UINT; dwFlags: DWORD): BOOL; stdcall;
{$EXTERNALSYM PathCompactPathExW}
function PathCommonPrefix(pszFile1, pszFile2: LPCWSTR; achPath: LPWSTR): Integer; stdcall;
{$EXTERNALSYM PathCommonPrefix}
function PathCommonPrefixA(pszFile1, pszFile2: LPCSTR; achPath: LPSTR): Integer; stdcall;
{$EXTERNALSYM PathCommonPrefixA}
function PathCommonPrefixW(pszFile1, pszFile2: LPCWSTR; achPath: LPWSTR): Integer; stdcall;
{$EXTERNALSYM PathCommonPrefixW}
function PathFileExists(pszPath: LPCWSTR): BOOL; stdcall;
{$EXTERNALSYM PathFileExists}
function PathFileExistsA(pszPath: LPCSTR): BOOL; stdcall;
{$EXTERNALSYM PathFileExistsA}
function PathFileExistsW(pszPath: LPCWSTR): BOOL; stdcall;
{$EXTERNALSYM PathFileExistsW}
function PathFindExtension(pszPath: LPCWSTR): LPWSTR; stdcall;
{$EXTERNALSYM PathFindExtension}
function PathFindExtensionA(pszPath: LPCSTR): LPSTR; stdcall;
{$EXTERNALSYM PathFindExtensionA}
function PathFindExtensionW(pszPath: LPCWSTR): LPWSTR; stdcall;
{$EXTERNALSYM PathFindExtensionW}
function PathFindFileName(pszPath: LPCWSTR): LPWSTR; stdcall;
{$EXTERNALSYM PathFindFileName}
function PathFindFileNameA(pszPath: LPCSTR): LPSTR; stdcall;
{$EXTERNALSYM PathFindFileNameA}
function PathFindFileNameW(pszPath: LPCWSTR): LPWSTR; stdcall;
{$EXTERNALSYM PathFindFileNameW}
function PathFindNextComponent(pszPath: LPCWSTR): LPWSTR; stdcall;
{$EXTERNALSYM PathFindNextComponent}
function PathFindNextComponentA(pszPath: LPCSTR): LPSTR; stdcall;
{$EXTERNALSYM PathFindNextComponentA}
function PathFindNextComponentW(pszPath: LPCWSTR): LPWSTR; stdcall;
{$EXTERNALSYM PathFindNextComponentW}
function PathFindOnPath(pszPath: LPWSTR; ppszOtherDirs: PLPCTSTR): BOOL; stdcall;
{$EXTERNALSYM PathFindOnPath}
function PathFindOnPathA(pszPath: LPSTR; ppszOtherDirs: PLPCTSTR): BOOL; stdcall;
{$EXTERNALSYM PathFindOnPathA}
function PathFindOnPathW(pszPath: LPWSTR; ppszOtherDirs: PLPCTSTR): BOOL; stdcall;
{$EXTERNALSYM PathFindOnPathW}
function PathGetArgs(pszPath: LPCWSTR): LPWSTR; stdcall;
{$EXTERNALSYM PathGetArgs}
function PathGetArgsA(pszPath: LPCSTR): LPSTR; stdcall;
{$EXTERNALSYM PathGetArgsA}
function PathGetArgsW(pszPath: LPCWSTR): LPWSTR; stdcall;
{$EXTERNALSYM PathGetArgsW}



function PathFindSuffixArray(pszPath: LPCWSTR; const apszSuffix: Array of LPCWSTR;
  iArraySize: Integer): LPCWSTR; stdcall;
{$EXTERNALSYM PathFindSuffixArray}
function PathFindSuffixArrayA(pszPath: LPCSTR; const apszSuffix: Array of LPCSTR;
  iArraySize: Integer): LPCSTR; stdcall;
{$EXTERNALSYM PathFindSuffixArrayA}
function PathFindSuffixArrayW(pszPath: LPCWSTR; const apszSuffix: Array of LPCWSTR;
  iArraySize: Integer): LPCWSTR; stdcall;
{$EXTERNALSYM PathFindSuffixArrayW}
function PathIsLFNFileSpec(lpName: LPCWSTR): BOOL; stdcall;
{$EXTERNALSYM PathIsLFNFileSpec}
function PathIsLFNFileSpecA(lpName: LPCSTR): BOOL; stdcall;
{$EXTERNALSYM PathIsLFNFileSpecA}
function PathIsLFNFileSpecW(lpName: LPCWSTR): BOOL; stdcall;
{$EXTERNALSYM PathIsLFNFileSpecW}



function PathGetCharType(ch: WideChar): UINT; stdcall;
{$EXTERNALSYM PathGetCharType}
function PathGetCharTypeA(ch: AnsiChar): UINT; stdcall;
{$EXTERNALSYM PathGetCharTypeA}
function PathGetCharTypeW(ch: WideChar): UINT; stdcall;
{$EXTERNALSYM PathGetCharTypeW}

// Return flags for PathGetCharType

const
  GCT_INVALID   = $0000;
  {$EXTERNALSYM GCT_INVALID}
  GCT_LFNCHAR   = $0001;
  {$EXTERNALSYM GCT_LFNCHAR}
  GCT_SHORTCHAR = $0002;
  {$EXTERNALSYM GCT_SHORTCHAR}
  GCT_WILD      = $0004;
  {$EXTERNALSYM GCT_WILD}
  GCT_SEPARATOR = $0008;
  {$EXTERNALSYM GCT_SEPARATOR}

function PathGetDriveNumber(pszPath: LPCWSTR): Integer; stdcall;
{$EXTERNALSYM PathGetDriveNumber}
function PathGetDriveNumberA(pszPath: LPCSTR): Integer; stdcall;
{$EXTERNALSYM PathGetDriveNumberA}
function PathGetDriveNumberW(pszPath: LPCWSTR): Integer; stdcall;
{$EXTERNALSYM PathGetDriveNumberW}
function PathIsDirectory(pszPath: LPCWSTR): BOOL; stdcall;
{$EXTERNALSYM PathIsDirectory}
function PathIsDirectoryA(pszPath: LPCSTR): BOOL; stdcall;
{$EXTERNALSYM PathIsDirectoryA}
function PathIsDirectoryW(pszPath: LPCWSTR): BOOL; stdcall;
{$EXTERNALSYM PathIsDirectoryW}



function PathIsDirectoryEmpty(pszPath: LPCWSTR): BOOL; stdcall;
{$EXTERNALSYM PathIsDirectoryEmpty}
function PathIsDirectoryEmptyA(pszPath: LPCSTR): BOOL; stdcall;
{$EXTERNALSYM PathIsDirectoryEmptyA}
function PathIsDirectoryEmptyW(pszPath: LPCWSTR): BOOL; stdcall;
{$EXTERNALSYM PathIsDirectoryEmptyW}



function PathIsFileSpec(pszPath: LPCWSTR): BOOL; stdcall;
{$EXTERNALSYM PathIsFileSpec}
function PathIsFileSpecA(pszPath: LPCSTR): BOOL; stdcall;
{$EXTERNALSYM PathIsFileSpecA}
function PathIsFileSpecW(pszPath: LPCWSTR): BOOL; stdcall;
{$EXTERNALSYM PathIsFileSpecW}
function PathIsPrefix(pszPrefix, pszPath: LPCWSTR): BOOL; stdcall;
{$EXTERNALSYM PathIsPrefix}
function PathIsPrefixA(pszPrefix, pszPath: LPCSTR): BOOL; stdcall;
{$EXTERNALSYM PathIsPrefixA}
function PathIsPrefixW(pszPrefix, pszPath: LPCWSTR): BOOL; stdcall;
{$EXTERNALSYM PathIsPrefixW}
function PathIsRelative(pszPath: LPCWSTR): BOOL; stdcall;
{$EXTERNALSYM PathIsRelative}
function PathIsRelativeA(pszPath: LPCSTR): BOOL; stdcall;
{$EXTERNALSYM PathIsRelativeA}
function PathIsRelativeW(pszPath: LPCWSTR): BOOL; stdcall;
{$EXTERNALSYM PathIsRelativeW}
function PathIsRoot(pszPath: LPCWSTR): BOOL; stdcall;
{$EXTERNALSYM PathIsRoot}
function PathIsRootA(pszPath: LPCSTR): BOOL; stdcall;
{$EXTERNALSYM PathIsRootA}
function PathIsRootW(pszPath: LPCWSTR): BOOL; stdcall;
{$EXTERNALSYM PathIsRootW}
function PathIsSameRoot(pszPath1, pszPath2: LPCWSTR): BOOL; stdcall;
{$EXTERNALSYM PathIsSameRoot}
function PathIsSameRootA(pszPath1, pszPath2: LPCSTR): BOOL; stdcall;
{$EXTERNALSYM PathIsSameRootA}
function PathIsSameRootW(pszPath1, pszPath2: LPCWSTR): BOOL; stdcall;
{$EXTERNALSYM PathIsSameRootW}
function PathIsUNC(pszPath: LPCWSTR): BOOL; stdcall;
{$EXTERNALSYM PathIsUNC}
function PathIsUNCA(pszPath: LPCSTR): BOOL; stdcall;
{$EXTERNALSYM PathIsUNCA}
function PathIsUNCW(pszPath: LPCWSTR): BOOL; stdcall;
{$EXTERNALSYM PathIsUNCW}



function PathIsNetworkPath(pszPath: LPCWSTR): BOOL; stdcall;
{$EXTERNALSYM PathIsNetworkPath}
function PathIsNetworkPathA(pszPath: LPCSTR): BOOL; stdcall;
{$EXTERNALSYM PathIsNetworkPathA}
function PathIsNetworkPathW(pszPath: LPCWSTR): BOOL; stdcall;
{$EXTERNALSYM PathIsNetworkPathW}



function PathIsUNCServer(pszPath: LPCWSTR): BOOL; stdcall;
{$EXTERNALSYM PathIsUNCServer}
function PathIsUNCServerA(pszPath: LPCSTR): BOOL; stdcall;
{$EXTERNALSYM PathIsUNCServerA}
function PathIsUNCServerW(pszPath: LPCWSTR): BOOL; stdcall;
{$EXTERNALSYM PathIsUNCServerW}
function PathIsUNCServerShare(pszPath: LPCWSTR): BOOL; stdcall;
{$EXTERNALSYM PathIsUNCServerShare}
function PathIsUNCServerShareA(pszPath: LPCSTR): BOOL; stdcall;
{$EXTERNALSYM PathIsUNCServerShareA}
function PathIsUNCServerShareW(pszPath: LPCWSTR): BOOL; stdcall;
{$EXTERNALSYM PathIsUNCServerShareW}
function PathIsContentType(pszPath, pszContentType: LPCWSTR): BOOL; stdcall;
{$EXTERNALSYM PathIsContentType}
function PathIsContentTypeA(pszPath, pszContentType: LPCSTR): BOOL; stdcall;
{$EXTERNALSYM PathIsContentTypeA}
function PathIsContentTypeW(pszPath, pszContentType: LPCWSTR): BOOL; stdcall;
{$EXTERNALSYM PathIsContentTypeW}
function PathIsURL(pszPath: LPCWSTR): BOOL; stdcall;
{$EXTERNALSYM PathIsURL}
function PathIsURLA(pszPath: LPCSTR): BOOL; stdcall;
{$EXTERNALSYM PathIsURLA}
function PathIsURLW(pszPath: LPCWSTR): BOOL; stdcall;
{$EXTERNALSYM PathIsURLW}
function PathMakePretty(pszPath: LPWSTR): BOOL; stdcall;
{$EXTERNALSYM PathMakePretty}
function PathMakePrettyA(pszPath: LPSTR): BOOL; stdcall;
{$EXTERNALSYM PathMakePrettyA}
function PathMakePrettyW(pszPath: LPWSTR): BOOL; stdcall;
{$EXTERNALSYM PathMakePrettyW}
function PathMatchSpec(pszFile, pszSpec: LPCWSTR): BOOL; stdcall;
{$EXTERNALSYM PathMatchSpec}
function PathMatchSpecA(pszFile, pszSpec: LPCSTR): BOOL; stdcall;
{$EXTERNALSYM PathMatchSpecA}
function PathMatchSpecW(pszFile, pszSpec: LPCWSTR): BOOL; stdcall;
{$EXTERNALSYM PathMatchSpecW}
function PathParseIconLocation(pszIconFile: LPWSTR): Integer; stdcall;
{$EXTERNALSYM PathParseIconLocation}
function PathParseIconLocationA(pszIconFile: LPSTR): Integer; stdcall;
{$EXTERNALSYM PathParseIconLocationA}
function PathParseIconLocationW(pszIconFile: LPWSTR): Integer; stdcall;
{$EXTERNALSYM PathParseIconLocationW}
procedure PathQuoteSpaces(lpsz: LPWSTR); stdcall;
{$EXTERNALSYM PathQuoteSpaces}
procedure PathQuoteSpacesA(lpsz: LPSTR); stdcall;
{$EXTERNALSYM PathQuoteSpacesA}
procedure PathQuoteSpacesW(lpsz: LPWSTR); stdcall;
{$EXTERNALSYM PathQuoteSpacesW}
function PathRelativePathTo(pszPath: LPWSTR; pszFrom: LPCWSTR; dwAttrFrom: DWORD;
  pszTo: LPCWSTR; dwAttrTo: DWORD): BOOL; stdcall;
{$EXTERNALSYM PathRelativePathTo}
function PathRelativePathToA(pszPath: LPSTR; pszFrom: LPCSTR; dwAttrFrom: DWORD;
  pszTo: LPCSTR; dwAttrTo: DWORD): BOOL; stdcall;
{$EXTERNALSYM PathRelativePathToA}
function PathRelativePathToW(pszPath: LPWSTR; pszFrom: LPCWSTR; dwAttrFrom: DWORD;
  pszTo: LPCWSTR; dwAttrTo: DWORD): BOOL; stdcall;
{$EXTERNALSYM PathRelativePathToW}
procedure PathRemoveArgs(pszPath: LPWSTR); stdcall;
{$EXTERNALSYM PathRemoveArgs}
procedure PathRemoveArgsA(pszPath: LPSTR); stdcall;
{$EXTERNALSYM PathRemoveArgsA}
procedure PathRemoveArgsW(pszPath: LPWSTR); stdcall;
{$EXTERNALSYM PathRemoveArgsW}
function PathRemoveBackslash(pszPath: LPWSTR): LPWSTR; stdcall;
{$EXTERNALSYM PathRemoveBackslash}
function PathRemoveBackslashA(pszPath: LPSTR): LPSTR; stdcall;
{$EXTERNALSYM PathRemoveBackslashA}
function PathRemoveBackslashW(pszPath: LPWSTR): LPWSTR; stdcall;
{$EXTERNALSYM PathRemoveBackslashW}
procedure PathRemoveBlanks(pszPath: LPWSTR); stdcall;
{$EXTERNALSYM PathRemoveBlanks}
procedure PathRemoveBlanksA(pszPath: LPSTR); stdcall;
{$EXTERNALSYM PathRemoveBlanksA}
procedure PathRemoveBlanksW(pszPath: LPWSTR); stdcall;
{$EXTERNALSYM PathRemoveBlanksW}
procedure PathRemoveExtension(pszPath: LPWSTR); stdcall;
{$EXTERNALSYM PathRemoveExtension}
procedure PathRemoveExtensionA(pszPath: LPSTR); stdcall;
{$EXTERNALSYM PathRemoveExtensionA}
procedure PathRemoveExtensionW(pszPath: LPWSTR); stdcall;
{$EXTERNALSYM PathRemoveExtensionW}
function PathRemoveFileSpec(pszPath: LPWSTR): BOOL; stdcall;
{$EXTERNALSYM PathRemoveFileSpec}
function PathRemoveFileSpecA(pszPath: LPSTR): BOOL; stdcall;
{$EXTERNALSYM PathRemoveFileSpecA}
function PathRemoveFileSpecW(pszPath: LPWSTR): BOOL; stdcall;
{$EXTERNALSYM PathRemoveFileSpecW}
function PathRenameExtension(pszPath: LPWSTR; pszExt: LPCWSTR): BOOL; stdcall;
{$EXTERNALSYM PathRenameExtension}
function PathRenameExtensionA(pszPath: LPSTR; pszExt: LPCSTR): BOOL; stdcall;
{$EXTERNALSYM PathRenameExtensionA}
function PathRenameExtensionW(pszPath: LPWSTR; pszExt: LPCWSTR): BOOL; stdcall;
{$EXTERNALSYM PathRenameExtensionW}
function PathSearchAndQualify(pszPath: LPCWSTR; pszBuf: LPWSTR; cchBuf: UINT): BOOL; stdcall;
{$EXTERNALSYM PathSearchAndQualify}
function PathSearchAndQualifyA(pszPath: LPCSTR; pszBuf: LPSTR; cchBuf: UINT): BOOL; stdcall;
{$EXTERNALSYM PathSearchAndQualifyA}
function PathSearchAndQualifyW(pszPath: LPCWSTR; pszBuf: LPWSTR; cchBuf: UINT): BOOL; stdcall;
{$EXTERNALSYM PathSearchAndQualifyW}
procedure PathSetDlgItemPath(hDlg: HWND; id: Integer; pszPath: LPCWSTR); stdcall;
{$EXTERNALSYM PathSetDlgItemPath}
procedure PathSetDlgItemPathA(hDlg: HWND; id: Integer; pszPath: LPCSTR); stdcall;
{$EXTERNALSYM PathSetDlgItemPathA}
procedure PathSetDlgItemPathW(hDlg: HWND; id: Integer; pszPath: LPCWSTR); stdcall;
{$EXTERNALSYM PathSetDlgItemPathW}
function PathSkipRoot(pszPath: LPCWSTR): LPWSTR; stdcall;
{$EXTERNALSYM PathSkipRoot}
function PathSkipRootA(pszPath: LPCSTR): LPSTR; stdcall;
{$EXTERNALSYM PathSkipRootA}
function PathSkipRootW(pszPath: LPCWSTR): LPWSTR; stdcall;
{$EXTERNALSYM PathSkipRootW}
procedure PathStripPath(pszPath: LPWSTR); stdcall;
{$EXTERNALSYM PathStripPath}
procedure PathStripPathA(pszPath: LPSTR); stdcall;
{$EXTERNALSYM PathStripPathA}
procedure PathStripPathW(pszPath: LPWSTR); stdcall;
{$EXTERNALSYM PathStripPathW}
function PathStripToRoot(pszPath: LPWSTR): BOOL; stdcall;
{$EXTERNALSYM PathStripToRoot}
function PathStripToRootA(pszPath: LPSTR): BOOL; stdcall;
{$EXTERNALSYM PathStripToRootA}
function PathStripToRootW(pszPath: LPWSTR): BOOL; stdcall;
{$EXTERNALSYM PathStripToRootW}
procedure PathUnquoteSpaces(lpsz: LPWSTR); stdcall;
{$EXTERNALSYM PathUnquoteSpaces}
procedure PathUnquoteSpacesA(lpsz: LPSTR); stdcall;
{$EXTERNALSYM PathUnquoteSpacesA}
procedure PathUnquoteSpacesW(lpsz: LPWSTR); stdcall;
{$EXTERNALSYM PathUnquoteSpacesW}
function PathMakeSystemFolder(pszPath: LPCWSTR): BOOL; stdcall;
{$EXTERNALSYM PathMakeSystemFolder}
function PathMakeSystemFolderA(pszPath: LPCSTR): BOOL; stdcall;
{$EXTERNALSYM PathMakeSystemFolderA}
function PathMakeSystemFolderW(pszPath: LPCWSTR): BOOL; stdcall;
{$EXTERNALSYM PathMakeSystemFolderW}
function PathUnmakeSystemFolder(pszPath: LPCWSTR): BOOL; stdcall;
{$EXTERNALSYM PathUnmakeSystemFolder}
function PathUnmakeSystemFolderA(pszPath: LPCSTR): BOOL; stdcall;
{$EXTERNALSYM PathUnmakeSystemFolderA}
function PathUnmakeSystemFolderW(pszPath: LPCWSTR): BOOL; stdcall;
{$EXTERNALSYM PathUnmakeSystemFolderW}
function PathIsSystemFolder(pszPath: LPCWSTR; dwAttrb: DWORD): BOOL; stdcall;
{$EXTERNALSYM PathIsSystemFolder}
function PathIsSystemFolderA(pszPath: LPCSTR; dwAttrb: DWORD): BOOL; stdcall;
{$EXTERNALSYM PathIsSystemFolderA}
function PathIsSystemFolderW(pszPath: LPCWSTR; dwAttrb: DWORD): BOOL; stdcall;
{$EXTERNALSYM PathIsSystemFolderW}



procedure PathUndecorate(pszPath: LPWSTR); stdcall;
{$EXTERNALSYM PathUndecorate}
procedure PathUndecorateA(pszPath: LPSTR); stdcall;
{$EXTERNALSYM PathUndecorateA}
procedure PathUndecorateW(pszPath: LPWSTR); stdcall;
{$EXTERNALSYM PathUndecorateW}
function PathUnExpandEnvStrings(pszPath: LPCWSTR; pszBuf: LPWSTR; cchBuf: UINT): BOOL; stdcall;
{$EXTERNALSYM PathUnExpandEnvStrings}
function PathUnExpandEnvStringsA(pszPath: LPCSTR; pszBuf: LPSTR; cchBuf: UINT): BOOL; stdcall;
{$EXTERNALSYM PathUnExpandEnvStringsA}
function PathUnExpandEnvStringsW(pszPath: LPCWSTR; pszBuf: LPWSTR; cchBuf: UINT): BOOL; stdcall;
{$EXTERNALSYM PathUnExpandEnvStringsW}

const
  URL_SCHEME_INVALID     = -1;
  {$EXTERNALSYM URL_SCHEME_INVALID}
  URL_SCHEME_UNKNOWN     =  0;
  {$EXTERNALSYM URL_SCHEME_UNKNOWN}
  URL_SCHEME_FTP         =  1;
  {$EXTERNALSYM URL_SCHEME_FTP}
  URL_SCHEME_HTTP        =  2;
  {$EXTERNALSYM URL_SCHEME_HTTP}
  URL_SCHEME_GOPHER      =  3;
  {$EXTERNALSYM URL_SCHEME_GOPHER}
  URL_SCHEME_MAILTO      =  4;
  {$EXTERNALSYM URL_SCHEME_MAILTO}
  URL_SCHEME_NEWS        =  5;
  {$EXTERNALSYM URL_SCHEME_NEWS}
  URL_SCHEME_NNTP        =  6;
  {$EXTERNALSYM URL_SCHEME_NNTP}
  URL_SCHEME_TELNET      =  7;
  {$EXTERNALSYM URL_SCHEME_TELNET}
  URL_SCHEME_WAIS        =  8;
  {$EXTERNALSYM URL_SCHEME_WAIS}
  URL_SCHEME_FILE        =  9;
  {$EXTERNALSYM URL_SCHEME_FILE}
  URL_SCHEME_MK          =  10;
  {$EXTERNALSYM URL_SCHEME_MK}
  URL_SCHEME_HTTPS       =  11;
  {$EXTERNALSYM URL_SCHEME_HTTPS}
  URL_SCHEME_SHELL       =  12;
  {$EXTERNALSYM URL_SCHEME_SHELL}
  URL_SCHEME_SNEWS       =  13;
  {$EXTERNALSYM URL_SCHEME_SNEWS}
  URL_SCHEME_LOCAL       =  14;
  {$EXTERNALSYM URL_SCHEME_LOCAL}
  URL_SCHEME_JAVASCRIPT  =  15;
  {$EXTERNALSYM URL_SCHEME_JAVASCRIPT}
  URL_SCHEME_VBSCRIPT    =  16;
  {$EXTERNALSYM URL_SCHEME_VBSCRIPT}
  URL_SCHEME_ABOUT       =  17;
  {$EXTERNALSYM URL_SCHEME_ABOUT}
  URL_SCHEME_RES         =  18;
  {$EXTERNALSYM URL_SCHEME_RES}
  URL_SCHEME_MAXVALUE    =  19;
  {$EXTERNALSYM URL_SCHEME_MAXVALUE}

type
  URL_SCHEME = Integer;
  {$EXTERNALSYM URL_SCHEME}

const
  URL_PART_NONE       = 0;
  {$EXTERNALSYM URL_PART_NONE}
  URL_PART_SCHEME     = 1;
  {$EXTERNALSYM URL_PART_SCHEME}
  URL_PART_HOSTNAME   = 2;
  {$EXTERNALSYM URL_PART_HOSTNAME}
  URL_PART_USERNAME   = 3;
  {$EXTERNALSYM URL_PART_USERNAME}
  URL_PART_PASSWORD   = 4;
  {$EXTERNALSYM URL_PART_PASSWORD}
  URL_PART_PORT       = 5;
  {$EXTERNALSYM URL_PART_PORT}
  URL_PART_QUERY      = 6;
  {$EXTERNALSYM URL_PART_QUERY}

type
  URL_PART = DWORD;
  {$EXTERNALSYM URL_PART}

const
  URLIS_URL        = 0;
  {$EXTERNALSYM URLIS_URL}
  URLIS_OPAQUE     = 1;
  {$EXTERNALSYM URLIS_OPAQUE }
  URLIS_NOHISTORY  = 2;
  {$EXTERNALSYM URLIS_NOHISTORY}
  URLIS_FILEURL    = 3;
  {$EXTERNALSYM URLIS_FILEURL}
  URLIS_APPLIABLE  = 4;
  {$EXTERNALSYM URLIS_APPLIABLE}
  URLIS_DIRECTORY  = 5;
  {$EXTERNALSYM URLIS_DIRECTORY}
  URLIS_HASQUERY   = 6;
  {$EXTERNALSYM URLIS_HASQUERY}

type
  TUrlIs = DWORD;

const
  URL_UNESCAPE                   = $10000000;
  {$EXTERNALSYM URL_UNESCAPE}
  URL_ESCAPE_UNSAFE              = $20000000;
  {$EXTERNALSYM URL_ESCAPE_UNSAFE}
  URL_PLUGGABLE_PROTOCOL         = $40000000;
  {$EXTERNALSYM URL_PLUGGABLE_PROTOCOL}
  URL_WININET_COMPATIBILITY      = DWORD($80000000);
  {$EXTERNALSYM URL_WININET_COMPATIBILITY}
  URL_DONT_ESCAPE_EXTRA_INFO     = $02000000;
  {$EXTERNALSYM URL_DONT_ESCAPE_EXTRA_INFO}
  URL_DONT_UNESCAPE_EXTRA_INFO   = URL_DONT_ESCAPE_EXTRA_INFO;
  {$EXTERNALSYM URL_DONT_UNESCAPE_EXTRA_INFO}
  URL_BROWSER_MODE               = URL_DONT_ESCAPE_EXTRA_INFO;
  {$EXTERNALSYM URL_BROWSER_MODE}
  URL_ESCAPE_SPACES_ONLY         = $04000000;
  {$EXTERNALSYM URL_ESCAPE_SPACES_ONLY}
  URL_DONT_SIMPLIFY              = $08000000;
  {$EXTERNALSYM URL_DONT_SIMPLIFY}
  URL_NO_META                    = URL_DONT_SIMPLIFY;
  {$EXTERNALSYM URL_NO_META}
  URL_UNESCAPE_INPLACE           = $00100000;
  {$EXTERNALSYM URL_UNESCAPE_INPLACE}
  URL_CONVERT_IF_DOSPATH         = $00200000;
  {$EXTERNALSYM URL_CONVERT_IF_DOSPATH}
  URL_UNESCAPE_HIGH_ANSI_ONLY    = $00400000;
  {$EXTERNALSYM URL_UNESCAPE_HIGH_ANSI_ONLY}
  URL_INTERNAL_PATH              = $00800000; // Will escape #'s in paths
  {$EXTERNALSYM URL_INTERNAL_PATH}
  URL_FILE_USE_PATHURL           = $00010000;
  {$EXTERNALSYM URL_FILE_USE_PATHURL}
  URL_ESCAPE_PERCENT             = $00001000;
  {$EXTERNALSYM URL_ESCAPE_PERCENT}
  URL_ESCAPE_SEGMENT_ONLY        = $00002000; // Treat the entire URL param as one URL segment.
  {$EXTERNALSYM URL_ESCAPE_SEGMENT_ONLY}

  URL_PARTFLAG_KEEPSCHEME        = $00000001;
  {$EXTERNALSYM URL_PARTFLAG_KEEPSCHEME}

  URL_APPLY_DEFAULT              = $00000001;
  {$EXTERNALSYM URL_APPLY_DEFAULT}
  URL_APPLY_GUESSSCHEME          = $00000002;
  {$EXTERNALSYM URL_APPLY_GUESSSCHEME}
  URL_APPLY_GUESSFILE            = $00000004;
  {$EXTERNALSYM URL_APPLY_GUESSFILE}
  URL_APPLY_FORCEAPPLY           = $00000008;
  {$EXTERNALSYM URL_APPLY_FORCEAPPLY}

function UrlCompare(psz1, psz2: LPCWSTR; fIgnoreSlash: BOOL): Integer; stdcall;
{$EXTERNALSYM UrlCompare}
function UrlCompareA(psz1, psz2: LPCSTR; fIgnoreSlash: BOOL): Integer; stdcall;
{$EXTERNALSYM UrlCompareA}
function UrlCompareW(psz1, psz2: LPCWSTR; fIgnoreSlash: BOOL): Integer; stdcall;
{$EXTERNALSYM UrlCompareW}
function UrlCombine(pszBase, pszRelative: LPCWSTR; pszCombined: LPWSTR;
  out pcchCombined: DWORD; dwFlags: DWORD): HRESULT; stdcall;
{$EXTERNALSYM UrlCombine}
function UrlCombineA(pszBase, pszRelative: LPCSTR; pszCombined: LPSTR;
  out pcchCombined: DWORD; dwFlags: DWORD): HRESULT; stdcall;
{$EXTERNALSYM UrlCombineA}
function UrlCombineW(pszBase, pszRelative: LPCWSTR; pszCombined: LPWSTR;
  out pcchCombined: DWORD; dwFlags: DWORD): HRESULT; stdcall;
{$EXTERNALSYM UrlCombineW}
function UrlCanonicalize(pszUrl: LPCWSTR; pszCanonicalized: LPWSTR;
  pcchCanonicalized: LPDWORD; dwFlags: DWORD): HRESULT; stdcall;
{$EXTERNALSYM UrlCanonicalize}
function UrlCanonicalizeA(pszUrl: LPCSTR; pszCanonicalized: LPSTR;
  pcchCanonicalized: LPDWORD; dwFlags: DWORD): HRESULT; stdcall;
{$EXTERNALSYM UrlCanonicalizeA}
function UrlCanonicalizeW(pszUrl: LPCWSTR; pszCanonicalized: LPWSTR;
  pcchCanonicalized: LPDWORD; dwFlags: DWORD): HRESULT; stdcall;
{$EXTERNALSYM UrlCanonicalizeW}
function UrlIsOpaque(pszURL: LPCWSTR): BOOL; stdcall;
{$EXTERNALSYM UrlIsOpaque}
function UrlIsOpaqueA(pszURL: LPCSTR): BOOL; stdcall;
{$EXTERNALSYM UrlIsOpaqueA}
function UrlIsOpaqueW(pszURL: LPCWSTR): BOOL; stdcall;
{$EXTERNALSYM UrlIsOpaqueW}
function UrlIsNoHistory(pszURL: LPCWSTR): BOOL; stdcall;
{$EXTERNALSYM UrlIsNoHistory}
function UrlIsNoHistoryA(pszURL: LPCSTR): BOOL; stdcall;
{$EXTERNALSYM UrlIsNoHistoryA}
function UrlIsNoHistoryW(pszURL: LPCWSTR): BOOL; stdcall;
{$EXTERNALSYM UrlIsNoHistoryW}
function UrlIsFileUrl(pszURL: LPCWSTR): BOOL;
{$EXTERNALSYM UrlIsFileUrl}
function UrlIsFileUrlA(pszURL: LPCSTR): BOOL;
{$EXTERNALSYM UrlIsFileUrlA}
function UrlIsFileUrlW(pszURL: LPCWSTR): BOOL;
{$EXTERNALSYM UrlIsFileUrlW}
function UrlIs(pszUrl: LPCWSTR; UrlIs: TUrlIs): BOOL; stdcall;
{$EXTERNALSYM UrlIs}
function UrlIsA(pszUrl: LPCSTR; UrlIs: TUrlIs): BOOL; stdcall;
{$EXTERNALSYM UrlIsA}
function UrlIsW(pszUrl: LPCWSTR; UrlIs: TUrlIs): BOOL; stdcall;
{$EXTERNALSYM UrlIsW}
function UrlGetLocation(psz1: LPCWSTR): LPCWSTR; stdcall;
{$EXTERNALSYM UrlGetLocation}
function UrlGetLocationA(psz1: LPCSTR): LPCSTR; stdcall;
{$EXTERNALSYM UrlGetLocationA}
function UrlGetLocationW(psz1: LPCWSTR): LPCWSTR; stdcall;
{$EXTERNALSYM UrlGetLocationW}
function UrlUnescape(pszUrl, pszUnescaped: LPWSTR; pcchUnescaped: LPDWORD;
  dwFlags: DWORD): HRESULT; stdcall;
{$EXTERNALSYM UrlUnescape}
function UrlUnescapeA(pszUrl, pszUnescaped: LPSTR; pcchUnescaped: LPDWORD;
  dwFlags: DWORD): HRESULT; stdcall;
{$EXTERNALSYM UrlUnescapeA}
function UrlUnescapeW(pszUrl, pszUnescaped: LPWSTR; pcchUnescaped: LPDWORD;
  dwFlags: DWORD): HRESULT; stdcall;
{$EXTERNALSYM UrlUnescapeW}
function UrlEscape(pszUrl: LPCWSTR; pszEscaped: LPWSTR; pcchEscaped: LPDWORD;
  dwFlags: DWORD): HRESULT; stdcall;
{$EXTERNALSYM UrlEscape}
function UrlEscapeA(pszUrl: LPCSTR; pszEscaped: LPSTR; pcchEscaped: LPDWORD;
  dwFlags: DWORD): HRESULT; stdcall;
{$EXTERNALSYM UrlEscapeA}
function UrlEscapeW(pszUrl: LPCWSTR; pszEscaped: LPWSTR; pcchEscaped: LPDWORD;
  dwFlags: DWORD): HRESULT; stdcall;
{$EXTERNALSYM UrlEscapeW}
function UrlCreateFromPath(pszPath: LPCWSTR; pszUrl: LPWSTR; pcchUrl: LPDWORD;
  dwFlags: DWORD): HRESULT; stdcall;
{$EXTERNALSYM UrlCreateFromPath}
function UrlCreateFromPathA(pszPath: LPCSTR; pszUrl: LPSTR; pcchUrl: LPDWORD;
  dwFlags: DWORD): HRESULT; stdcall;
{$EXTERNALSYM UrlCreateFromPathA}
function UrlCreateFromPathW(pszPath: LPCWSTR; pszUrl: LPWSTR; pcchUrl: LPDWORD;
  dwFlags: DWORD): HRESULT; stdcall;
{$EXTERNALSYM UrlCreateFromPathW}
function PathCreateFromUrl(pszUrl: LPCWSTR; pszPath: LPWSTR; pcchPath: LPDWORD;
  dwFlags: DWORD): HRESULT; stdcall;
{$EXTERNALSYM PathCreateFromUrl}
function PathCreateFromUrlA(pszUrl: LPCSTR; pszPath: LPSTR; pcchPath: LPDWORD;
  dwFlags: DWORD): HRESULT; stdcall;
{$EXTERNALSYM PathCreateFromUrlA}
function PathCreateFromUrlW(pszUrl: LPCWSTR; pszPath: LPWSTR; pcchPath: LPDWORD;
  dwFlags: DWORD): HRESULT; stdcall;
{$EXTERNALSYM PathCreateFromUrlW}
function UrlHash(pszUrl: LPCWSTR; pbHash: PBYTE; cbHash: DWORD): HRESULT; stdcall;
{$EXTERNALSYM UrlHash}
function UrlHashA(pszUrl: LPCSTR; pbHash: PBYTE; cbHash: DWORD): HRESULT; stdcall;
{$EXTERNALSYM UrlHashA}
function UrlHashW(pszUrl: LPCWSTR; pbHash: PBYTE; cbHash: DWORD): HRESULT; stdcall;
{$EXTERNALSYM UrlHashW}
function UrlGetPart(pszIn: LPCWSTR; pszOut: LPWSTR; pcchOut: LPDWORD; dwPart,
  dwFlags: DWORD): HRESULT; stdcall;
{$EXTERNALSYM UrlGetPart}
function UrlGetPartA(pszIn: LPCSTR; pszOut: LPSTR; pcchOut: LPDWORD; dwPart,
  dwFlags: DWORD): HRESULT; stdcall;
{$EXTERNALSYM UrlGetPartA}
function UrlGetPartW(pszIn: LPCWSTR; pszOut: LPWSTR; pcchOut: LPDWORD; dwPart,
  dwFlags: DWORD): HRESULT; stdcall;
{$EXTERNALSYM UrlGetPartW}
function UrlApplyScheme(pszIn: LPCWSTR; pszOut: LPWSTR; pcchOut: LPDWORD;
  dwFlags: DWORD): HRESULT; stdcall;
{$EXTERNALSYM UrlApplyScheme}
function UrlApplySchemeA(pszIn: LPCSTR; pszOut: LPSTR; pcchOut: LPDWORD;
  dwFlags: DWORD): HRESULT; stdcall;
{$EXTERNALSYM UrlApplySchemeA}
function UrlApplySchemeW(pszIn: LPCWSTR; pszOut: LPWSTR; pcchOut: LPDWORD;
  dwFlags: DWORD): HRESULT; stdcall;
{$EXTERNALSYM UrlApplySchemeW}
function HashData(pbData: PBYTE; cbData: DWORD; pbHash: PBYTE; cbHash: DWORD): HRESULT; stdcall;
{$EXTERNALSYM HashData}

function UrlEscapeSpaces(pszUrl: LPCWSTR; pszEscaped: LPWSTR; pcchEscaped: LPDWORD): HRESULT; stdcall;
{$EXTERNALSYM UrlEscapeSpaces}
function UrlEscapeSpacesA(pszUrl: LPCSTR; pszEscaped: LPSTR; pcchEscaped: LPDWORD): HRESULT; stdcall;
{$EXTERNALSYM UrlEscapeSpacesA}
function UrlEscapeSpacesW(pszUrl: LPCWSTR; pszEscaped: LPWSTR; pcchEscaped: LPDWORD): HRESULT; stdcall;
{$EXTERNALSYM UrlEscapeSpacesW}
function UrlUnescapeInPlace(pszUrl: LPWSTR; dwFlags: DWORD): HRESULT;
{$EXTERNALSYM UrlUnescapeInPlace}
function UrlUnescapeInPlaceA(pszUrl: LPSTR; dwFlags: DWORD): HRESULT;
{$EXTERNALSYM UrlUnescapeInPlaceA}
function UrlUnescapeInPlaceW(pszUrl: LPWSTR; dwFlags: DWORD): HRESULT;
{$EXTERNALSYM UrlUnescapeInPlaceW}

 //  IE 5
 //  NO_SHLWAPI_PATH


// Registry Routines

// SHDeleteEmptyKey mimics RegDeleteKey as it behaves on NT.
// SHDeleteKey mimics RegDeleteKey as it behaves on Win95.

function SHDeleteEmptyKey(hKey: HKEY; pszSubKey: LPCWSTR): DWORD; stdcall;
{$EXTERNALSYM SHDeleteEmptyKey}
function SHDeleteEmptyKeyA(hKey: HKEY; pszSubKey: LPCSTR): DWORD; stdcall;
{$EXTERNALSYM SHDeleteEmptyKeyA}
function SHDeleteEmptyKeyW(hKey: HKEY; pszSubKey: LPCWSTR): DWORD; stdcall;
{$EXTERNALSYM SHDeleteEmptyKeyW}
function SHDeleteKey(hKey: HKEY; pszSubKey: LPCWSTR): DWORD; stdcall;
{$EXTERNALSYM SHDeleteKey}
function SHDeleteKeyA(hKey: HKEY; pszSubKey: LPCSTR): DWORD; stdcall;
{$EXTERNALSYM SHDeleteKeyA}
function SHDeleteKeyW(hKey: HKEY; pszSubKey: LPCWSTR): DWORD; stdcall;
{$EXTERNALSYM SHDeleteKeyW}

// These functions open the key, get/set/delete the value, then close
// the key.

function SHDeleteValue(hKey: HKEY; pszSubKey, pszValue: LPCWSTR): DWORD; stdcall;
{$EXTERNALSYM SHDeleteValue}
function SHDeleteValueA(hKey: HKEY; pszSubKey, pszValue: LPCSTR): DWORD; stdcall;
{$EXTERNALSYM SHDeleteValueA}
function SHDeleteValueW(hKey: HKEY; pszSubKey, pszValue: LPCWSTR): DWORD; stdcall;
{$EXTERNALSYM SHDeleteValueW}
function SHGetValue(hKey: HKEY; pszSubKey, pszValue: LPCWSTR; pdwType: LPDWORD;
  pvData: Pointer; var pcbData: DWORD): DWORD; stdcall;
{$EXTERNALSYM SHGetValue}
function SHGetValueA(hKey: HKEY; pszSubKey, pszValue: LPCSTR; pdwType: LPDWORD;
  pvData: Pointer; var pcbData: DWORD): DWORD; stdcall;
{$EXTERNALSYM SHGetValueA}
function SHGetValueW(hKey: HKEY; pszSubKey, pszValue: LPCWSTR; pdwType: LPDWORD;
  pvData: Pointer; var pcbData: DWORD): DWORD; stdcall;
{$EXTERNALSYM SHGetValueW}
function SHSetValue(hKey: HKEY; pszSubKey, pszValue: LPCWSTR; dwType: DWORD;
  pvData: Pointer; cbData: DWORD): DWORD; stdcall;
{$EXTERNALSYM SHSetValue}
function SHSetValueA(hKey: HKEY; pszSubKey, pszValue: LPCSTR; dwType: DWORD;
  pvData: Pointer; cbData: DWORD): DWORD; stdcall;
{$EXTERNALSYM SHSetValueA}
function SHSetValueW(hKey: HKEY; pszSubKey, pszValue: LPCWSTR; dwType: DWORD;
  pvData: Pointer; cbData: DWORD): DWORD; stdcall;
{$EXTERNALSYM SHSetValueW}

// These functions work just like RegQueryValueEx, except if the
// data type is REG_EXPAND_SZ, then these will go ahead and expand
// out the string.  *pdwType will always be massaged to REG_SZ
// if this happens.  REG_SZ values are also guaranteed to be null
// terminated.

function SHQueryValueEx(hKey: HKEY; pszValue: LPCWSTR; pdwReserved, pdwType: LPDWORD;
  pvData: Pointer; var pcbData: DWORD): DWORD; stdcall;
{$EXTERNALSYM SHQueryValueEx}
function SHQueryValueExA(hKey: HKEY; pszValue: LPCSTR; pdwReserved, pdwType: LPDWORD;
  pvData: Pointer; var pcbData: DWORD): DWORD; stdcall;
{$EXTERNALSYM SHQueryValueExA}
function SHQueryValueExW(hKey: HKEY; pszValue: LPCWSTR; pdwReserved, pdwType: LPDWORD;
  pvData: Pointer; var pcbData: DWORD): DWORD; stdcall;
{$EXTERNALSYM SHQueryValueExW}

// Enumeration functions support.

function SHEnumKeyEx(hKey: HKEY; dwIndex: DWORD; pszName: LPWSTR; var pcchName: DWORD): Longint; stdcall;
{$EXTERNALSYM SHEnumKeyEx}
function SHEnumKeyExA(hKey: HKEY; dwIndex: DWORD; pszName: LPSTR; var pcchName: DWORD): Longint; stdcall;
{$EXTERNALSYM SHEnumKeyExA}
function SHEnumKeyExW(hKey: HKEY; dwIndex: DWORD; pszName: LPWSTR; var pcchName: DWORD): Longint; stdcall;
{$EXTERNALSYM SHEnumKeyExW}
function SHEnumValue(hKey: HKEY; dwIndex: DWORD; pszValueName: LPWSTR;
  var pcchValueName: DWORD; pdwType: LPDWORD; pvData: Pointer; pcbData: LPDWORD): Longint; stdcall;
{$EXTERNALSYM SHEnumValue}
function SHEnumValueA(hKey: HKEY; dwIndex: DWORD; pszValueName: LPSTR;
  var pcchValueName: DWORD; pdwType: LPDWORD; pvData: Pointer; pcbData: LPDWORD): Longint; stdcall;
{$EXTERNALSYM SHEnumValueA}
function SHEnumValueW(hKey: HKEY; dwIndex: DWORD; pszValueName: LPWSTR;
  var pcchValueName: DWORD; pdwType: LPDWORD; pvData: Pointer; pcbData: LPDWORD): Longint; stdcall;
{$EXTERNALSYM SHEnumValueW}
function SHQueryInfoKey(hKey: HKEY; pcSubKeys, pcchMaxSubKeyLen, pcValues,
  pcchMaxValueNameLen: LPDWORD): Longint; stdcall;
{$EXTERNALSYM SHQueryInfoKey}
function SHQueryInfoKeyA(hKey: HKEY; pcSubKeys, pcchMaxSubKeyLen, pcValues,
  pcchMaxValueNameLen: LPDWORD): Longint; stdcall;
{$EXTERNALSYM SHQueryInfoKeyA}
function SHQueryInfoKeyW(hKey: HKEY; pcSubKeys, pcchMaxSubKeyLen, pcValues,
  pcchMaxValueNameLen: LPDWORD): Longint; stdcall;
{$EXTERNALSYM SHQueryInfoKeyW}



// recursive key copy
function SHCopyKey(hkeySrc: HKEY; szSrcSubKey: LPCWSTR; hkeyDest: HKEY;
  fReserved: DWORD): DWORD; stdcall;
{$EXTERNALSYM SHCopyKey}
function SHCopyKeyA(hkeySrc: HKEY; szSrcSubKey: LPCSTR; hkeyDest: HKEY;
  fReserved: DWORD): DWORD; stdcall;
{$EXTERNALSYM SHCopyKeyA}
function SHCopyKeyW(hkeySrc: HKEY; szSrcSubKey: LPCWSTR; hkeyDest: HKEY;
  fReserved: DWORD): DWORD; stdcall;
{$EXTERNALSYM SHCopyKeyW}

// Getting and setting file system paths with environment variables

function SHRegGetPath(hKey: HKEY; pcszSubKey, pcszValue: LPCWSTR; pszPath: LPWSTR;
  dwFlags: DWORD): DWORD; stdcall;
{$EXTERNALSYM SHRegGetPath}
function SHRegGetPathA(hKey: HKEY; pcszSubKey, pcszValue: LPCSTR; pszPath: LPSTR;
  dwFlags: DWORD): DWORD; stdcall;
{$EXTERNALSYM SHRegGetPathA}
function SHRegGetPathW(hKey: HKEY; pcszSubKey, pcszValue: LPCWSTR; pszPath: LPWSTR;
  dwFlags: DWORD): DWORD; stdcall;
{$EXTERNALSYM SHRegGetPathW}
function SHRegSetPath(hKey: HKEY; pcszSubKey, pcszValue, pcszPath: LPCWSTR;
  dwFlags: DWORD): DWORD; stdcall;
{$EXTERNALSYM SHRegSetPath}
function SHRegSetPathA(hKey: HKEY; pcszSubKey, pcszValue, pcszPath: LPCSTR;
  dwFlags: DWORD): DWORD; stdcall;
{$EXTERNALSYM SHRegSetPathA}
function SHRegSetPathW(hKey: HKEY; pcszSubKey, pcszValue, pcszPath: LPCWSTR;
  dwFlags: DWORD): DWORD; stdcall;
{$EXTERNALSYM SHRegSetPathW}



//////////////////////////////////////////////
// User Specific Registry Access Functions
//////////////////////////////////////////////

// Type definitions.

const
  SHREGDEL_DEFAULT    = $00000000;       // Delete's HKCU, or HKLM if HKCU is not found.
  {$EXTERNALSYM SHREGDEL_DEFAULT}
  SHREGDEL_HKCU       = $00000001;       // Delete HKCU only
  {$EXTERNALSYM SHREGDEL_HKCU}
  SHREGDEL_HKLM       = $00000010;       // Delete HKLM only.
  {$EXTERNALSYM SHREGDEL_HKLM}
  SHREGDEL_BOTH       = $00000011;       // Delete both HKCU and HKLM.
  {$EXTERNALSYM SHREGDEL_BOTH}

  SHREGENUM_DEFAULT   = $00000000;       // Enumerates HKCU or HKLM if not found.
  {$EXTERNALSYM SHREGENUM_DEFAULT}
  SHREGENUM_HKCU      = $00000001;       // Enumerates HKCU only
  {$EXTERNALSYM SHREGENUM_HKCU}
  SHREGENUM_HKLM      = $00000010;       // Enumerates HKLM only.
  {$EXTERNALSYM SHREGENUM_HKLM}
  SHREGENUM_BOTH      = $00000011;       // Enumerates both HKCU and HKLM without duplicates.
  {$EXTERNALSYM SHREGENUM_BOTH}          // This option is NYI.

  SHREGSET_HKCU       = $00000001;       // Write to HKCU if empty.
  {$EXTERNALSYM SHREGSET_HKCU}
  SHREGSET_FORCE_HKCU = $00000002;       // Write to HKCU.
  {$EXTERNALSYM SHREGSET_FORCE_HKCU}
  SHREGSET_HKLM       = $00000004;       // Write to HKLM if empty.
  {$EXTERNALSYM SHREGSET_HKLM}
  SHREGSET_FORCE_HKLM = $00000008;       // Write to HKLM.
  {$EXTERNALSYM SHREGSET_FORCE_HKLM}
  SHREGSET_DEFAULT    = SHREGSET_FORCE_HKCU or SHREGSET_HKLM; // Default is SHREGSET_FORCE_HKCU | SHREGSET_HKLM.
  {$EXTERNALSYM SHREGSET_DEFAULT}

type
  TSHRegDelFlags = DWORD;
  TSHRegEnumFlags = DWORD;

  HUSKEY = THandle;                      // HUSKEY is a Handle to a User Specific KEY.
  {$EXTERNALSYM HUSKEY}
  PHUSKEY = ^HUSKEY;
  {$EXTERNALSYM PHUSKEY}

function SHRegCreateUSKey(pszPath: LPCWSTR; samDesired: REGSAM; hRelativeUSKey: HUSKEY;
  phNewUSKey: PHUSKEY; dwFlags: DWORD): Longint; stdcall;
{$EXTERNALSYM SHRegCreateUSKey}
function SHRegCreateUSKeyA(pszPath: LPCSTR; samDesired: REGSAM; hRelativeUSKey: HUSKEY;
  phNewUSKey: PHUSKEY; dwFlags: DWORD): Longint; stdcall;
{$EXTERNALSYM SHRegCreateUSKeyA}
function SHRegCreateUSKeyW(pszPath: LPCWSTR; samDesired: REGSAM; hRelativeUSKey: HUSKEY;
  phNewUSKey: PHUSKEY; dwFlags: DWORD): Longint; stdcall;
{$EXTERNALSYM SHRegCreateUSKeyW}
function SHRegOpenUSKey(pszPath: LPCWSTR; samDesired: REGSAM; hRelativeUSKey: HUSKEY;
  phNewUSKey: PHUSKEY; fIgnoreHKCU: BOOL): Longint; stdcall;
{$EXTERNALSYM SHRegOpenUSKey}
function SHRegOpenUSKeyA(pszPath: LPCSTR; samDesired: REGSAM; hRelativeUSKey: HUSKEY;
  phNewUSKey: PHUSKEY; fIgnoreHKCU: BOOL): Longint; stdcall;
{$EXTERNALSYM SHRegOpenUSKeyA}
function SHRegOpenUSKeyW(pszPath: LPCWSTR; samDesired: REGSAM; hRelativeUSKey: HUSKEY;
  phNewUSKey: PHUSKEY; fIgnoreHKCU: BOOL): Longint; stdcall;
{$EXTERNALSYM SHRegOpenUSKeyW}
function SHRegQueryUSValue(hUSKey: HUSKEY; pszValue: LPCWSTR; pdwType: LPDWORD;
  pvData: Pointer; pcbData: LPDWORD; fIgnoreHKCU: BOOL; pvDefaultData: Pointer; dwDefaultDataSize: DWORD): Longint; stdcall;
{$EXTERNALSYM SHRegQueryUSValue}
function SHRegQueryUSValueA(hUSKey: HUSKEY; pszValue: LPCSTR; pdwType: LPDWORD;
  pvData: Pointer; pcbData: LPDWORD; fIgnoreHKCU: BOOL; pvDefaultData: Pointer; dwDefaultDataSize: DWORD): Longint; stdcall;
{$EXTERNALSYM SHRegQueryUSValueA}
function SHRegQueryUSValueW(hUSKey: HUSKEY; pszValue: LPCWSTR; pdwType: LPDWORD;
  pvData: Pointer; pcbData: LPDWORD; fIgnoreHKCU: BOOL; pvDefaultData: Pointer; dwDefaultDataSize: DWORD): Longint; stdcall;
{$EXTERNALSYM SHRegQueryUSValueW}
function SHRegWriteUSValue(hUSKey: HUSKEY; pszValue: LPCWSTR; dwType: DWORD;
  pvData: Pointer; cbData, dwFlags: DWORD): Longint; stdcall;
{$EXTERNALSYM SHRegWriteUSValue}
function SHRegWriteUSValueA(hUSKey: HUSKEY; pszValue: LPCSTR; dwType: DWORD;
  pvData: Pointer; cbData, dwFlags: DWORD): Longint; stdcall;
{$EXTERNALSYM SHRegWriteUSValueA}
function SHRegWriteUSValueW(hUSKey: HUSKEY; pszValue: LPCWSTR; dwType: DWORD;
  pvData: Pointer; cbData, dwFlags: DWORD): Longint; stdcall;
{$EXTERNALSYM SHRegWriteUSValueW}
function SHRegDeleteUSValue(hUSKey: HUSKEY; pszValue: LPCWSTR; delRegFlags: TSHRegDelFlags): Longint; stdcall;
{$EXTERNALSYM SHRegDeleteUSValue}
function SHRegDeleteUSValueA(hUSKey: HUSKEY; pszValue: LPCSTR; delRegFlags: TSHRegDelFlags): Longint; stdcall;
{$EXTERNALSYM SHRegDeleteUSValueA}
function SHRegDeleteUSValueW(hUSKey: HUSKEY; pszValue: LPCWSTR; delRegFlags: TSHRegDelFlags): Longint; stdcall;
{$EXTERNALSYM SHRegDeleteUSValueW}
function SHRegDeleteEmptyUSKey(hUSKey: HUSKEY; pwzSubKey: LPCWSTR; delRegFlags: TSHRegDelFlags): Longint; stdcall;
{$EXTERNALSYM SHRegDeleteEmptyUSKey}
function SHRegDeleteEmptyUSKeyA(hUSKey: HUSKEY; pwzSubKey: LPCSTR; delRegFlags: TSHRegDelFlags): Longint; stdcall;
{$EXTERNALSYM SHRegDeleteEmptyUSKeyA}
function SHRegDeleteEmptyUSKeyW(hUSKey: HUSKEY; pwzSubKey: LPCWSTR; delRegFlags: TSHRegDelFlags): Longint; stdcall;
{$EXTERNALSYM SHRegDeleteEmptyUSKeyW}
function SHRegEnumUSKey(hUSKey: HUSKEY; dwIndex: DWORD; pszName: LPWSTR;
  pcchName: LPDWORD; enumRegFlags: TSHRegEnumFlags): Longint; stdcall;
{$EXTERNALSYM SHRegEnumUSKey}
function SHRegEnumUSKeyA(hUSKey: HUSKEY; dwIndex: DWORD; pszName: LPSTR;
  pcchName: LPDWORD; enumRegFlags: TSHRegEnumFlags): Longint; stdcall;
{$EXTERNALSYM SHRegEnumUSKeyA}
function SHRegEnumUSKeyW(hUSKey: HUSKEY; dwIndex: DWORD; pszName: LPWSTR;
  pcchName: LPDWORD; enumRegFlags: TSHRegEnumFlags): Longint; stdcall;
{$EXTERNALSYM SHRegEnumUSKeyW}
function SHRegEnumUSValue(hUSKey: HUSKEY; dwIndex: DWORD; pszValueName: LPCWSTR;
  pcchValueName, pdwType: LPDWORD; pvData: Pointer; pcbData: LPDWORD; enumRegFlags: TSHRegEnumFlags): Longint; stdcall;
{$EXTERNALSYM SHRegEnumUSValue}
function SHRegEnumUSValueA(hUSKey: HUSKEY; dwIndex: DWORD; pszValueName: LPCSTR;
  pcchValueName, pdwType: LPDWORD; pvData: Pointer; pcbData: LPDWORD; enumRegFlags: TSHRegEnumFlags): Longint; stdcall;
{$EXTERNALSYM SHRegEnumUSValueA}
function SHRegEnumUSValueW(hUSKey: HUSKEY; dwIndex: DWORD; pszValueName: LPCWSTR;
  pcchValueName, pdwType: LPDWORD; pvData: Pointer; pcbData: LPDWORD; enumRegFlags: TSHRegEnumFlags): Longint; stdcall;
{$EXTERNALSYM SHRegEnumUSValueW}
function SHRegQueryInfoUSKey(hUSKey: HUSKEY; pcSubKeys, pcchMaxSubKeyLen,
  pcValues, pcchMaxValueNameLen: LPDWORD; enumRegFlags: TSHRegEnumFlags): Longint; stdcall;
{$EXTERNALSYM SHRegQueryInfoUSKey}
function SHRegQueryInfoUSKeyA(hUSKey: HUSKEY; pcSubKeys, pcchMaxSubKeyLen,
  pcValues, pcchMaxValueNameLen: LPDWORD; enumRegFlags: TSHRegEnumFlags): Longint; stdcall;
{$EXTERNALSYM SHRegQueryInfoUSKeyA}
function SHRegQueryInfoUSKeyW(hUSKey: HUSKEY; pcSubKeys, pcchMaxSubKeyLen,
  pcValues, pcchMaxValueNameLen: LPDWORD; enumRegFlags: TSHRegEnumFlags): Longint; stdcall;
{$EXTERNALSYM SHRegQueryInfoUSKeyW}
function SHRegCloseUSKey(hUSKey: HUSKEY): Longint; stdcall;
{$EXTERNALSYM SHRegCloseUSKey}

// These calls are equal to an SHRegOpenUSKey, SHRegQueryUSValue, and then a SHRegCloseUSKey.

function SHRegGetUSValue(pszSubKey, pszValue: LPCWSTR; pdwType: LPDWORD; pvData: Pointer;
  var pcbData: DWORD; fIgnoreHKCU: BOOL; pvDefaultData: Pointer; dwDefaultDataSize: DWORD): Longint; stdcall;
{$EXTERNALSYM SHRegGetUSValue}
function SHRegGetUSValueA(pszSubKey, pszValue: LPCSTR; pdwType: LPDWORD; pvData: Pointer;
  var pcbData: DWORD; fIgnoreHKCU: BOOL; pvDefaultData: Pointer; dwDefaultDataSize: DWORD): Longint; stdcall;
{$EXTERNALSYM SHRegGetUSValueA}
function SHRegGetUSValueW(pszSubKey, pszValue: LPCWSTR; pdwType: LPDWORD; pvData: Pointer;
  var pcbData: DWORD; fIgnoreHKCU: BOOL; pvDefaultData: Pointer; dwDefaultDataSize: DWORD): Longint; stdcall;
{$EXTERNALSYM SHRegGetUSValueW}
function SHRegSetUSValue(pszSubKey, pszValue: LPCWSTR; dwType: DWORD; pvData: Pointer;
  cbData, dwFlags: DWORD): Longint; stdcall;
{$EXTERNALSYM SHRegSetUSValue}
function SHRegSetUSValueA(pszSubKey, pszValue: LPCSTR; dwType: DWORD; pvData: Pointer;
  cbData, dwFlags: DWORD): Longint; stdcall;
{$EXTERNALSYM SHRegSetUSValueA}
function SHRegSetUSValueW(pszSubKey, pszValue: LPCWSTR; dwType: DWORD; pvData: Pointer;
  cbData, dwFlags: DWORD): Longint; stdcall;
{$EXTERNALSYM SHRegSetUSValueW}


function SHRegGetBoolUSValue(pszSubKey, pszValue: LPCWSTR; fIgnoreHKCU, fDefault: BOOL): BOOL; stdcall;
{$EXTERNALSYM SHRegGetBoolUSValue}
function SHRegGetBoolUSValueA(pszSubKey, pszValue: LPCSTR; fIgnoreHKCU, fDefault: BOOL): BOOL; stdcall;
{$EXTERNALSYM SHRegGetBoolUSValueA}
function SHRegGetBoolUSValueW(pszSubKey, pszValue: LPCWSTR; fIgnoreHKCU, fDefault: BOOL): BOOL; stdcall;
{$EXTERNALSYM SHRegGetBoolUSValueW}



function SHRegGetIntW(hk: HKEY; pwzKey: LPCWSTR; iDefault: Integer): Integer; stdcall;
{$EXTERNALSYM SHRegGetIntW}

                                                                             

//  Association APIs
//
//  these APIs are to assist in accessing the data in HKCR
//  getting the Command strings and exe paths
//  for different verbs and extensions are simplified this way

const
  ASSOCF_INIT_NOREMAPCLSID           = $00000001;  //  do not remap clsids to progids
  {$EXTERNALSYM ASSOCF_INIT_NOREMAPCLSID}
  ASSOCF_INIT_BYEXENAME              = $00000002;  //  executable is being passed in
  {$EXTERNALSYM ASSOCF_INIT_BYEXENAME}
  ASSOCF_OPEN_BYEXENAME              = $00000002;  //  executable is being passed in
  {$EXTERNALSYM ASSOCF_OPEN_BYEXENAME}
  ASSOCF_INIT_DEFAULTTOSTAR          = $00000004;  //  treat "*" as the BaseClass
  {$EXTERNALSYM ASSOCF_INIT_DEFAULTTOSTAR}
  ASSOCF_INIT_DEFAULTTOFOLDER        = $00000008;  //  treat "Folder" as the BaseClass
  {$EXTERNALSYM ASSOCF_INIT_DEFAULTTOFOLDER}
  ASSOCF_NOUSERSETTINGS              = $00000010;  //  dont use HKCU
  {$EXTERNALSYM ASSOCF_NOUSERSETTINGS}
  ASSOCF_NOTRUNCATE                  = $00000020;  //  dont truncate the return string
  {$EXTERNALSYM ASSOCF_NOTRUNCATE}
  ASSOCF_VERIFY                      = $00000040;  //  verify data is accurate (DISK HITS)
  {$EXTERNALSYM ASSOCF_VERIFY}
  ASSOCF_REMAPRUNDLL                 = $00000080;  //  actually gets info about rundlls target if applicable
  {$EXTERNALSYM ASSOCF_REMAPRUNDLL}
  ASSOCF_NOFIXUPS                    = $00000100;  //  attempt to fix errors if found
  {$EXTERNALSYM ASSOCF_NOFIXUPS}
  ASSOCF_IGNOREBASECLASS             = $00000200;  //  dont recurse into the baseclass
  {$EXTERNALSYM ASSOCF_IGNOREBASECLASS}
  ASSOCF_INIT_IGNOREUNKNOWN          = $00000400;  //  "Unknown" ProgID should be ignored; otherwise fail
  {$EXTERNALSYM ASSOCF_INIT_IGNOREUNKNOWN}

type
  ASSOCF = DWORD;
  {$EXTERNALSYM ASSOCF}

const
  ASSOCSTR_COMMAND          = 1;  //  shell\verb\command string
  {$EXTERNALSYM ASSOCSTR_COMMAND}
  ASSOCSTR_EXECUTABLE       = 2;  //  the executable part of command string
  {$EXTERNALSYM ASSOCSTR_EXECUTABLE}
  ASSOCSTR_FRIENDLYDOCNAME  = 3;  //  friendly name of the document type
  {$EXTERNALSYM ASSOCSTR_FRIENDLYDOCNAME}
  ASSOCSTR_FRIENDLYAPPNAME  = 4;  //  friendly name of executable
  {$EXTERNALSYM ASSOCSTR_FRIENDLYAPPNAME}
  ASSOCSTR_NOOPEN           = 5;  //  noopen value
  {$EXTERNALSYM ASSOCSTR_NOOPEN}
  ASSOCSTR_SHELLNEWVALUE    = 6;  //  query values under the shellnew key
  {$EXTERNALSYM ASSOCSTR_SHELLNEWVALUE}
  ASSOCSTR_DDECOMMAND       = 7;  //  template for DDE commands
  {$EXTERNALSYM ASSOCSTR_DDECOMMAND}
  ASSOCSTR_DDEIFEXEC        = 8;  //  DDECOMMAND to use if just create a process
  {$EXTERNALSYM ASSOCSTR_DDEIFEXEC}
  ASSOCSTR_DDEAPPLICATION   = 9;  //  Application name in DDE broadcast
  {$EXTERNALSYM ASSOCSTR_DDEAPPLICATION}
  ASSOCSTR_DDETOPIC         = 10; //  Topic Name in DDE broadcast
  {$EXTERNALSYM ASSOCSTR_DDETOPIC}
  ASSOCSTR_INFOTIP          = 11; //  info tip for an item, or list of properties to create info tip from
  {$EXTERNALSYM ASSOCSTR_INFOTIP}
  ASSOCSTR_MAX              = 12; //  last item in enum...
  {$EXTERNALSYM ASSOCSTR_MAX}

type
  ASSOCSTR = DWORD;
  {$EXTERNALSYM ASSOCSTR}

const
  ASSOCKEY_SHELLEXECCLASS = 1;  //  the key that should be passed to ShellExec(hkeyClass)
  {$EXTERNALSYM ASSOCKEY_SHELLEXECCLASS}
  ASSOCKEY_APP            = 2;  //  the "Application" key for the association
  {$EXTERNALSYM ASSOCKEY_APP}
  ASSOCKEY_CLASS          = 3;  //  the progid or class key
  {$EXTERNALSYM ASSOCKEY_CLASS}
  ASSOCKEY_BASECLASS      = 4;  //  the BaseClass key
  {$EXTERNALSYM ASSOCKEY_BASECLASS}
  ASSOCKEY_MAX            = 5;  //  last item in enum...
  {$EXTERNALSYM ASSOCKEY_MAX}

type
  ASSOCKEY = DWORD;
  {$EXTERNALSYM ASSOCKEY}

const
  ASSOCDATA_MSIDESCRIPTOR     = 1;   //  Component Descriptor to pass to MSI APIs
  {$EXTERNALSYM ASSOCDATA_MSIDESCRIPTOR}
  ASSOCDATA_NOACTIVATEHANDLER = 2;   //  restrict attempts to activate window
  {$EXTERNALSYM ASSOCDATA_NOACTIVATEHANDLER}
  ASSOCDATA_QUERYCLASSSTORE   = 3;   //  should check with the NT Class Store
  {$EXTERNALSYM ASSOCDATA_QUERYCLASSSTORE}
  ASSOCDATA_HASPERUSERASSOC   = 4;   //  defaults to user specified association
  {$EXTERNALSYM ASSOCDATA_HASPERUSERASSOC}
  ASSOCDATA_MAX               = 5;
  {$EXTERNALSYM ASSOCDATA_MAX}

type
  ASSOCDATA = DWORD;
  {$EXTERNALSYM ASSOCDATA}

const
  ASSOCENUM_NONE = 0;
  {$EXTERNALSYM ASSOCENUM_NONE}

type
  ASSOCENUM = DWORD;
  {$EXTERNALSYM ASSOCENUM}

const
  IID_IQueryAssociations: TGUID = (D1: $c46ca590; D2: $3c3f; D3: $11d2; D4: ($be, $e6, $00, $00, $f8, $05, $ca, $57));
  {$EXTERNALSYM IID_IQueryAssociations}
  CLSID_QueryAssociations: TGUID = (D1: $c46ca590; D2: $3c3f; D3: $11d2; D4: ($be, $e6, $00, $00, $f8, $05, $ca, $57));
  {$EXTERNALSYM CLSID_QueryAssociations}
  SID_IQueryAssociations = '{c46ca590-3c3f-11d2-bee6-0000f805ca57}';

type
  IQueryAssociation = interface (IUnknown)
  [SID_IQueryAssociations]
    function Init(flags: ASSOCF; pszAssoc: LPCWSTR; hkProgid: HKEY; hwnd: HWND): HRESULT; stdcall;
    function GetString(flags: ASSOCF; str: ASSOCSTR; pszExtra: LPCWSTR; pszOut: LPWSTR; out pcchOut: DWORD): HRESULT; stdcall;
    function GetKey(flags: ASSOCF; key: ASSOCKEY; pszExtra: LPCWSTR; out phkeyOut: HKEY): HRESULT; stdcall;
    function GetData(flags: ASSOCF; data: ASSOCDATA; pszExtra: LPCWSTR; pvOut: Pointer; out pcbOut: DWORD): HRESULT; stdcall;
    function GetEnum(flags: ASSOCF; assocenum: ASSOCENUM; pszExtra: LPCWSTR; riid: REFIID; ppvOut: Pointer): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IQueryAssociation}

function AssocCreate(const [Ref] clsid: TCLSID; const [Ref] riid: IID; out ppv): HRESULT; stdcall;
{$EXTERNALSYM AssocCreate}

function AssocQueryString(flags: ASSOCF; str: ASSOCSTR; pszAssoc, pszExtra: LPCWSTR;
  pszOut: LPWSTR; pcchOut: PDWORD): HRESULT; stdcall;
{$EXTERNALSYM AssocQueryString}
function AssocQueryStringA(flags: ASSOCF; str: ASSOCSTR; pszAssoc, pszExtra: LPCSTR;
  pszOut: LPSTR; pcchOut: PDWORD): HRESULT; stdcall;
{$EXTERNALSYM AssocQueryStringA}
function AssocQueryStringW(flags: ASSOCF; str: ASSOCSTR; pszAssoc, pszExtra: LPCWSTR;
  pszOut: LPWSTR; pcchOut: PDWORD): HRESULT; stdcall;
{$EXTERNALSYM AssocQueryStringW}
function AssocQueryStringByKey(flags: ASSOCF; str: ASSOCSTR; hkAssoc: HKEY;
  pszExtra: LPCWSTR; pszOut: LPWSTR; pcchOut: PDWORD): HRESULT; stdcall;
{$EXTERNALSYM AssocQueryStringByKey}
function AssocQueryStringByKeyA(flags: ASSOCF; str: ASSOCSTR; hkAssoc: HKEY;
  pszExtra: LPCSTR; pszOut: LPSTR; pcchOut: PDWORD): HRESULT; stdcall;
{$EXTERNALSYM AssocQueryStringByKeyA}
function AssocQueryStringByKeyW(flags: ASSOCF; str: ASSOCSTR; hkAssoc: HKEY;
  pszExtra: LPCWSTR; pszOut: LPWSTR; pcchOut: PDWORD): HRESULT; stdcall;
{$EXTERNALSYM AssocQueryStringByKeyW}
function AssocQueryKey(flags: ASSOCF; key: ASSOCKEY; pszAssoc, pszExtra: LPCWSTR;
  out phkeyOut: HKEY): HRESULT; stdcall;
{$EXTERNALSYM AssocQueryKey}
function AssocQueryKeyA(flags: ASSOCF; key: ASSOCKEY; pszAssoc, pszExtra: LPCSTR;
  out phkeyOut: HKEY): HRESULT; stdcall;
{$EXTERNALSYM AssocQueryKeyA}
function AssocQueryKeyW(flags: ASSOCF; key: ASSOCKEY; pszAssoc, pszExtra: LPCWSTR;
  out phkeyOut: HKEY): HRESULT; stdcall;
{$EXTERNALSYM AssocQueryKeyW}

 //  IE 5
 //  NO_SHLWAPI_REG


// Stream Routines

function SHOpenRegStream(hkey: HKEY; pszSubkey, pszValue: LPCWSTR; grfMode: DWORD): IStream; stdcall;
{$EXTERNALSYM SHOpenRegStream}
function SHOpenRegStreamA(hkey: HKEY; pszSubkey, pszValue: LPCSTR; grfMode: DWORD): IStream; stdcall;
{$EXTERNALSYM SHOpenRegStreamA}
function SHOpenRegStreamW(hkey: HKEY; pszSubkey, pszValue: LPCWSTR; grfMode: DWORD): IStream; stdcall;
{$EXTERNALSYM SHOpenRegStreamW}



function SHOpenRegStream2(hkey: HKEY; pszSubkey, pszValue: LPCWSTR; grfMode: DWORD): IStream; stdcall;
{$EXTERNALSYM SHOpenRegStream2}
function SHOpenRegStream2A(hkey: HKEY; pszSubkey, pszValue: LPCSTR; grfMode: DWORD): IStream; stdcall;
{$EXTERNALSYM SHOpenRegStream2A}
function SHOpenRegStream2W(hkey: HKEY; pszSubkey, pszValue: LPCWSTR; grfMode: DWORD): IStream; stdcall;
{$EXTERNALSYM SHOpenRegStream2W}

function SHCreateStreamOnFile(pszFile: LPCWSTR; grfMode: DWORD; out ppstm: IStream): HRESULT; stdcall;
{$EXTERNALSYM SHCreateStreamOnFile}
function SHCreateStreamOnFileA(pszFile: LPCSTR; grfMode: DWORD; out ppstm: IStream): HRESULT; stdcall;
{$EXTERNALSYM SHCreateStreamOnFileA}
function SHCreateStreamOnFileW(pszFile: LPCWSTR; grfMode: DWORD; out ppstm: IStream): HRESULT; stdcall;
{$EXTERNALSYM SHCreateStreamOnFileW}

 // IE 5
 // NO_SHLWAPI_STREAM



// SHAutoComplete
//      hwndEdit - HWND of editbox, ComboBox or ComboBoxEx.
//      dwFlags - Flags to indicate what to AutoAppend or AutoSuggest for the editbox.
//
// WARNING:
//    Caller needs to have called CoInitialize() or OleInitialize()
//    and cannot call CoUninit/OleUninit until after
//    WM_DESTROY on hwndEdit.
//
//  dwFlags values:

const
  SHACF_DEFAULT                  = $00000000;  // Currently (SHACF_FILESYSTEM | SHACF_URLALL)
  {$EXTERNALSYM SHACF_DEFAULT }
  SHACF_FILESYSTEM               = $00000001;  // This includes the File System as well as the rest of the shell (Desktop\My Computer\Control Panel\)
  {$EXTERNALSYM SHACF_FILESYSTEM }
  SHACF_URLHISTORY               = $00000002;  // URLs in the User's History
  {$EXTERNALSYM SHACF_URLHISTORY }
  SHACF_URLMRU                   = $00000004;  // URLs in the User's Recently Used list.
  {$EXTERNALSYM SHACF_URLMRU }
  SHACF_USETAB                   = $00000008;  // URLs in the User's Recently Used list.
  {$EXTERNALSYM SHACF_USETAB}
  SHACF_FILESYS_ONLY             = $00000010;  // Don't AutoComplete non-File System items.
  {$EXTERNALSYM SHACF_FILESYS_ONLY}

  SHACF_URLALL                   = SHACF_URLHISTORY or SHACF_URLMRU;
  {$EXTERNALSYM SHACF_URLALL }
  SHACF_AUTOSUGGEST_FORCE_ON     = $10000000;  // Ignore the registry default and force the feature on.
  {$EXTERNALSYM SHACF_AUTOSUGGEST_FORCE_ON }
  SHACF_AUTOSUGGEST_FORCE_OFF    = $20000000;  // Ignore the registry default and force the feature off.
  {$EXTERNALSYM SHACF_AUTOSUGGEST_FORCE_OFF }
  SHACF_AUTOAPPEND_FORCE_ON      = $40000000;  // Ignore the registry default and force the feature on. (Also know as AutoComplete)
  {$EXTERNALSYM SHACF_AUTOAPPEND_FORCE_ON }
  SHACF_AUTOAPPEND_FORCE_OFF     = DWORD($80000000);  // Ignore the registry default and force the feature off. (Also know as AutoComplete)
  {$EXTERNALSYM SHACF_AUTOAPPEND_FORCE_OFF}

function SHAutoComplete(hwndEdit: HWND; dwFlags: DWORD): HRESULT; stdcall;
{$EXTERNALSYM SHAutoComplete}

procedure SHSetThreadRef(punk: IUnknown); stdcall;
{$EXTERNALSYM SHSetThreadRef}
procedure SHGetThreadRef(out ppunk: IUnknown); stdcall;
{$EXTERNALSYM SHGetThreadRef}

function SHSkipJunction(pbc: IBindCtx; const pclsid: TCLSID): BOOL; stdcall;
{$EXTERNALSYM SHSkipJunction}

 // _WIN32_IE >= $0500


const
  CTF_INSIST         = $00000001;     // SHCreateThread() dwFlags - call pfnThreadProc synchronously if CreateThread() fails
  {$EXTERNALSYM CTF_INSIST}
  CTF_THREAD_REF     = $00000002;     // hold a reference to the creating thread
  {$EXTERNALSYM CTF_THREAD_REF}
  CTF_PROCESS_REF    = $00000004;     // hold a reference to the creating process
  {$EXTERNALSYM CTF_PROCESS_REF}
  CTF_COINIT         = $00000008;     // init COM for the created thread
  {$EXTERNALSYM CTF_COINIT}

function SHCreateThread(pfnThreadProc: TThreadStartRoutine; pData: Pointer;
  dwFlags: DWORD; pfnCallback: TThreadStartRoutine): BOOL; stdcall;
{$EXTERNALSYM SHCreateThread}




// GDI helper functions

function SHCreateShellPalette(hdc: HDC): HPALETTE; stdcall;
{$EXTERNALSYM SHCreateShellPalette}


procedure ColorRGBToHLS(clrRGB: TColorRef; out pwHue, pwLuminance, pwSaturation: WORD); stdcall;
{$EXTERNALSYM ColorRGBToHLS}
function ColorHLSToRGB(wHue, wLuminance, wSaturation: WORD): TColorRef; stdcall;
{$EXTERNALSYM ColorHLSToRGB}
function ColorAdjustLuma(clrRGB: TColorRef; n: Integer; fScale: Boolean): TColorRef; stdcall;
{$EXTERNALSYM ColorAdjustLuma}
 // _WIN32_IE >= $0500
 // NO_SHLWAPI_GDI

// DllGetVersion

type
  PDllVersionInfo = ^TDllVersionInfo;
  _DLLVERSIONINFO = record
    cbSize: DWORD;
    dwMajorVersion: DWORD; // Major version
    dwMinorVersion: DWORD; // Minor version
    dwBuildNumber: DWORD;  // Build Number
    dwPlatformId: DWORD;   // DLLVER_PLATFORM_*
  end;
  {$EXTERNALSYM _DLLVERSIONINFO}
  TDllVersionInfo = _DLLVERSIONINFO;

const
  DLLVER_PLATFORM_WINDOWS = $00000001; // Windows 95
  {$EXTERNALSYM DLLVER_PLATFORM_WINDOWS}
  DLLVER_PLATFORM_NT      = $00000002; // Windows NT
  {$EXTERNALSYM DLLVER_PLATFORM_NT}



type
  PDllVersionInfo2 = ^TDllVersionInfo2;
  _DLLVERSIONINFO2 = record
    info1: TDllVersionInfo;
    dwFlags: DWORD;                         // No flags currently defined
    ullVersion: Int64;                      // Encoded as:
                                            // Major 0xFFFF 0000 0000 0000
                                            // Minor 0x0000 FFFF 0000 0000
                                            // Build 0x0000 0000 FFFF 0000
                                            // QFE   0x0000 0000 0000 FFFF
  end;
  {$EXTERNALSYM _DLLVERSIONINFO2}
  DLLVERSIONINFO2 = _DLLVERSIONINFO2;
  {$EXTERNALSYM DLLVERSIONINFO2}
  TDllVersionInfo2 = DLLVERSIONINFO2;

const
  DLLVER_MAJOR_MASK = Int64($FFFF000000000000);
  {$EXTERNALSYM DLLVER_MAJOR_MASK}
  DLLVER_MINOR_MASK = Int64($0000FFFF00000000);
  {$EXTERNALSYM DLLVER_MINOR_MASK}
  DLLVER_BUILD_MASK = Int64($00000000FFFF0000);
  {$EXTERNALSYM DLLVER_BUILD_MASK}
  DLLVER_QFE_MASK   = Int64($000000000000FFFF);
  {$EXTERNALSYM DLLVER_QFE_MASK}



function MAKEDLLVERULL(Major, Minor, Build, Qfe: Word): Int64;
{$EXTERNALSYM MAKEDLLVERULL}
  
// The caller should always GetProcAddress('DllGetVersion'), not
// implicitly link to it.

type
  DllGetVersionProc = function (var pdvi: TDllVersionInfo): HRESULT; stdcall;
  {$EXTERNALSYM DLLGETVERSIONPROC}

// DllInstall (to be implemented by self-installing DLLs)
// STDAPI DllInstall(BOOL bInstall, LPCWSTR pszCmdLine);
// procedure DllInstall(bInstall: BOOL; pszCmdLine: LPCWSTR); stdcall;

implementation

const
  shlwapi32 = 'shlwapi.dll';


function StrChr; external shlwapi32 name 'StrChrW';
function StrChrA; external shlwapi32 name 'StrChrA';
function StrChrW; external shlwapi32 name 'StrChrW';
function StrChrI; external shlwapi32 name 'StrChrIW';
function StrChrIA; external shlwapi32 name 'StrChrIA';
function StrChrIW; external shlwapi32 name 'StrChrIW';
function StrCmpN; external shlwapi32 name 'StrCmpNW';
function StrCmpNA; external shlwapi32 name 'StrCmpNA';
function StrCmpNW; external shlwapi32 name 'StrCmpNW';
function StrCmpNI; external shlwapi32 name 'StrCmpNIW';
function StrCmpNIA; external shlwapi32 name 'StrCmpNIA';
function StrCmpNIW; external shlwapi32 name 'StrCmpNIW';
function StrCSpn; external shlwapi32 name 'StrCSpnW';
function StrCSpnA; external shlwapi32 name 'StrCSpnA';
function StrCSpnW; external shlwapi32 name 'StrCSpnW';
function StrCSpnI; external shlwapi32 name 'StrCSpnIW';
function StrCSpnIA; external shlwapi32 name 'StrCSpnIA';
function StrCSpnIW; external shlwapi32 name 'StrCSpnIW';
function StrDup; external shlwapi32 name 'StrDupW';
function StrDupA; external shlwapi32 name 'StrDupA';
function StrDupW; external shlwapi32 name 'StrDupW';
function StrFormatByteSize; external shlwapi32 name 'StrFormatByteSizeW';
function StrFormatByteSizeA; external shlwapi32 name 'StrFormatByteSizeA';
function StrFormatByteSizeW; external shlwapi32 name 'StrFormatByteSizeW';
function StrFormatByteSize64; external shlwapi32 name 'StrFormatByteSize64W';
function StrFormatByteSize64A; external shlwapi32 name 'StrFormatByteSize64A';
function StrFormatByteSize64W; external shlwapi32 name 'StrFormatByteSize64W';



function StrFormatKBSize; external shlwapi32 name 'StrFormatKBSizeW';
function StrFormatKBSizeA; external shlwapi32 name 'StrFormatKBSizeA';
function StrFormatKBSizeW; external shlwapi32 name 'StrFormatKBSizeW';



function StrFromTimeInterval; external shlwapi32 name 'StrFromTimeIntervalW';
function StrFromTimeIntervalA; external shlwapi32 name 'StrFromTimeIntervalA';
function StrFromTimeIntervalW; external shlwapi32 name 'StrFromTimeIntervalW';
function StrIsIntlEqual; external shlwapi32 name 'StrIsIntlEqualW';
function StrIsIntlEqualA; external shlwapi32 name 'StrIsIntlEqualA';
function StrIsIntlEqualW; external shlwapi32 name 'StrIsIntlEqualW';
function StrNCat; external shlwapi32 name 'StrNCatW';
function StrNCatA; external shlwapi32 name 'StrNCatA';
function StrNCatW; external shlwapi32 name 'StrNCatW';
function StrPBrk; external shlwapi32 name 'StrPBrkW';
function StrPBrkA; external shlwapi32 name 'StrPBrkA';
function StrPBrkW; external shlwapi32 name 'StrPBrkW';
function StrRChr; external shlwapi32 name 'StrRChrW';
function StrRChrA; external shlwapi32 name 'StrRChrA';
function StrRChrW; external shlwapi32 name 'StrRChrW';
function StrRChrI; external shlwapi32 name 'StrRChrIW';
function StrRChrIA; external shlwapi32 name 'StrRChrIA';
function StrRChrIW; external shlwapi32 name 'StrRChrIW';
function StrRStrI; external shlwapi32 name 'StrRStrIW';
function StrRStrIA; external shlwapi32 name 'StrRStrIA';
function StrRStrIW; external shlwapi32 name 'StrRStrIW';
function StrSpn; external shlwapi32 name 'StrSpnW';
function StrSpnA; external shlwapi32 name 'StrSpnA';
function StrSpnW; external shlwapi32 name 'StrSpnW';
function StrStr; external shlwapi32 name 'StrStrW';
function StrStrA; external shlwapi32 name 'StrStrA';
function StrStrW; external shlwapi32 name 'StrStrW';
function StrStrI; external shlwapi32 name 'StrStrIW';
function StrStrIA; external shlwapi32 name 'StrStrIA';
function StrStrIW; external shlwapi32 name 'StrStrIW';
function StrToInt; external shlwapi32 name 'StrToIntW';
function StrToIntA; external shlwapi32 name 'StrToIntA';
function StrToIntW; external shlwapi32 name 'StrToIntW';
function StrToIntEx; external shlwapi32 name 'StrToIntExW';
function StrToIntExA; external shlwapi32 name 'StrToIntExA';
function StrToIntExW; external shlwapi32 name 'StrToIntExW';
function StrTrim; external shlwapi32 name 'StrTrimW';
function StrTrimA; external shlwapi32 name 'StrTrimA';
function StrTrimW; external shlwapi32 name 'StrTrimW';

function ChrCmpI; external shlwapi32 name 'StrCmpIW';
function ChrCmpIA; external shlwapi32 name 'StrCmpIA';
function ChrCmpIW; external shlwapi32 name 'StrCmpIW';

function StrIntlEqN; external shlwapi32 name 'StrIntlEqNW';
function StrIntlEqNA; external shlwapi32 name 'StrIntlEqNA';
function StrIntlEqNW; external shlwapi32 name 'StrIntlEqNW';

function StrIntlEqNI; external shlwapi32 name 'StrIntlEqNIW';
function StrIntlEqNIA; external shlwapi32 name 'StrIntlEqNIA';
function StrIntlEqNIW; external shlwapi32 name 'StrIntlEqNIW';



function StrCatBuff; external shlwapi32 name 'StrCatBuffW';
function StrCatBuffA; external shlwapi32 name 'StrCatBuffA';
function StrCatBuffW; external shlwapi32 name 'StrCatBuffW';

function StrCpyNX; external shlwapi32 name 'StrCpyNXW';
function StrCpyNXA; external shlwapi32 name 'StrCpyNXA';
function StrCpyNXW; external shlwapi32 name 'StrCpyNXW';





(*
LWSTDAPI_(int)      wvnsprintfA(LPSTR lpOut, int cchLimitIn, LPCSTR lpFmt, va_list arglist);
LWSTDAPI_(int)      wvnsprintfW(LPWSTR lpOut, int cchLimitIn, LPCWSTR lpFmt, va_list arglist);
LWSTDAPIV_(int)     wnsprintfA(LPSTR lpOut, int cchLimitIn, LPCSTR lpFmt, ...);
LWSTDAPIV_(int)     wnsprintfW(LPWSTR lpOut, int cchLimitIn, LPCWSTR lpFmt, ...);
*)

function StrRetToStr; external shlwapi32 name 'StrRetToStrW';
function StrRetToStrA; external shlwapi32 name 'StrRetToStrA';
function StrRetToStrW; external shlwapi32 name 'StrRetToStrW';

function StrRetToBuf; external shlwapi32 name 'StrRetToBufW';
function StrRetToBufA; external shlwapi32 name 'StrRetToBufA';
function StrRetToBufW; external shlwapi32 name 'StrRetToBufW';

function SHStrDup; external shlwapi32 name 'SHStrDupW';
function SHStrDupA; external shlwapi32 name 'SHStrDupA';
function SHStrDupW; external shlwapi32 name 'SHStrDupW';

function IntlStrEqWorker; external shlwapi32 name 'IntlStrEqWorkerW';
function IntlStrEqWorkerA; external shlwapi32 name 'IntlStrEqWorkerA';
function IntlStrEqWorkerW; external shlwapi32 name 'IntlStrEqWorkerW';


function IntlStrEqN(s1, s2: LPCWSTR; nChar: Integer): BOOL;
begin
  Result := IntlStrEqWorker(True, s1, s2, nChar)
end;

function IntlStrEqNA(s1, s2: LPCSTR; nChar: Integer): BOOL;
begin
  Result := IntlStrEqWorkerA(True, s1, s2, nChar)
end;

function IntlStrEqNW(s1, s2: LPCWSTR; nChar: Integer): BOOL;
begin
  Result := IntlStrEqWorkerW(True, s1, s2, nChar)
end;

 // IE 5


function PathIsHTMLFile(pszPath: LPCWSTR): BOOL;
begin
  Result := PathIsContentType(pszPath, SZ_CONTENTTYPE_HTML)
end;

function PathIsHTMLFileA(pszPath: LPCSTR): BOOL;
begin
  Result := PathIsContentTypeA(pszPath, SZ_CONTENTTYPE_HTMLA)
end;

function PathIsHTMLFileW(pszPath: LPCWSTR): BOOL;
begin
  Result := PathIsContentTypeW(pszPath, SZ_CONTENTTYPE_HTMLW)
end;

function StrCatA(psz1, psz2: PAnsiChar): PAnsiChar;
begin
  Result := lstrcata(psz1, psz2);
end;

function StrCatW; external shlwapi32 name 'StrCatW';

{$IFDEF UNICODE}
function StrCat; external shlwapi32 name 'StrCatW';
{$ELSE}
function StrCat(psz1, psz2: PAnsiChar): PAnsiChar;
begin
  Result := lstrcata(psz1, psz2);
end;
{$ENDIF}

function StrCmpA(psz1, psz2: PAnsiChar): Integer;
begin
  Result := lstrcmpa(psz1, psz2);
end;

function StrCmpW; external shlwapi32 name 'StrCmpW';

{$IFDEF UNICODE}
function StrCmp; external shlwapi32 name 'StrCmpW';
{$ELSE}
function StrCmp(psz1, psz2: PAnsiChar): Integer;
begin
  Result := lstrcmpa(psz1, psz2);
end;
{$ENDIF}

function StrCmpIA(psz1, psz2: PAnsiChar): Integer;
begin
  Result := lstrcmpia(psz1, psz2);
end;

function StrCmpIW; external shlwapi32 name 'StrCmpW';
{$IFDEF UNICODE}
function StrCmpI; external shlwapi32 name 'StrCmpW';
{$ELSE}
function StrCmpI(psz1, psz2: PAnsiChar): Integer;
begin
  Result := lstrcmpia(psz1, psz2);
end;
{$ENDIF}

function StrCpyA(psz1, psz2: PAnsiChar): PAnsiChar;
begin
  Result := lstrcpya(psz1, psz2);
end;
function StrCpyW; external shlwapi32 name 'StrCpyW';
{$IFDEF UNICODE}
function StrCpy; external shlwapi32 name 'StrCpyW';
{$ELSE}
function StrCpy(psz1, psz2: PAnsiChar): PAnsiChar;
begin
  Result := lstrcpya(psz1, psz2);
end;
{$ENDIF}

function StrCpyNA(psz1, psz2: PAnsiChar; cchMax: Integer): PAnsiChar;
begin
  Result := lstrcpyna(psz1, psz2, cchMax);
end;
function StrCpyNW; external shlwapi32 name 'StrCpyNW';
{$IFDEF UNICODE}
function StrCpyN; external shlwapi32 name 'StrCpyNW';
{$ELSE}
function StrCpyN(psz1, psz2: PAnsiChar; cchMax: Integer): PAnsiChar;
begin
  Result := lstrcpyn(psz1, psz2, cchMax);
end;
{$ENDIF}

function StrToLong(lpSrch: LPCWSTR): Integer;
begin
  Result := StrToInt(lpSrch);
end;

function StrToLongA(lpSrch: LPCSTR): Integer;
begin
  Result := StrToIntA(lpSrch);
end;

function StrToLongW(lpSrch: LPCWSTR): Integer;
begin
  Result := StrToIntW(lpSrch);
end;

function StrNCmp(lpStr1, lpStr2: LPCWSTR; nChar: IntPtr): Integer;
begin
  Result := StrCmpN(lpStr1, lpStr2, nChar);
end;

function StrNCmpA(lpStr1, lpStr2: LPCSTR; nChar: IntPtr): Integer;
begin
  Result := StrCmpNA(lpStr1, lpStr2, nChar);
end;

function StrNCmpW(lpStr1, lpStr2: LPCWSTR; nChar: IntPtr): Integer;
begin
  Result := StrCmpNW(lpStr1, lpStr2, nChar);
end;

function StrNCmpI(lpStr1, lpStr2: LPCWSTR; nChar: Integer): Integer;
begin
  Result := StrCmpNI(lpStr1, lpStr2, nChar);
end;

function StrNCmpIA(lpStr1, lpStr2: LPCSTR; nChar: Integer): Integer;
begin
  Result := StrCmpNIA(lpStr1, lpStr2, nChar);
end;

function StrNCmpIW(lpStr1, lpStr2: LPCWSTR; nChar: Integer): Integer;
begin
  Result := StrCmpNIW(lpStr1, lpStr2, nChar);
end;

function StrNCpy(psz1, psz2: LPCWSTR; cchMax: IntPtr): LPWSTR;
begin
  Result := StrCpyN(psz1, psz2, cchMax);
end;

function StrNCpyA(psz1, psz2: LPCSTR; cchMax: IntPtr): LPSTR;
begin
  Result := StrCpyNA(psz1, psz2, cchMax);
end;

function StrNCpyW(psz1, psz2: LPCWSTR; cchMax: IntPtr): LPWSTR;
begin
  Result := StrCpyNW(psz1, psz2, cchMax);
end;

function StrCatN(psz1: LPWSTR; psz2: LPCWSTR; cchMax: Integer): LPWSTR;
begin
  Result := StrNCat(psz1, psz2, cchMax);
end;

function StrCatNA(psz1: LPSTR; psz2: LPCSTR; cchMax: Integer): LPSTR;
begin
  Result := StrNCatA(psz1, psz2, cchMax);
end;

function StrCatNW(psz1: LPWSTR; psz2: LPCWSTR; cchMax: Integer): LPWSTR;
begin
  Result := StrNCatW(psz1, psz2, cchMax);
end;

 // NO_SHLWAPI_STRFCNS

function PathAddBackslash; external shlwapi32 name 'PathAddBackslashW';
function PathAddBackslashA; external shlwapi32 name 'PathAddBackslashA';
function PathAddBackslashW; external shlwapi32 name 'PathAddBackslashW';
function PathAddExtension; external shlwapi32 name 'PathAddExtensionW';
function PathAddExtensionA; external shlwapi32 name 'PathAddExtensionA';
function PathAddExtensionW; external shlwapi32 name 'PathAddExtensionW';
function PathAppend; external shlwapi32 name 'PathAppendW';
function PathAppendA; external shlwapi32 name 'PathAppendA';
function PathAppendW; external shlwapi32 name 'PathAppendW';
function PathBuildRoot; external shlwapi32 name 'PathBuildRootW';
function PathBuildRootA; external shlwapi32 name 'PathBuildRootA';
function PathBuildRootW; external shlwapi32 name 'PathBuildRootW';
function PathCanonicalize; external shlwapi32 name 'PathCanonicalizeW';
function PathCanonicalizeA; external shlwapi32 name 'PathCanonicalizeA';
function PathCanonicalizeW; external shlwapi32 name 'PathCanonicalizeW';
function PathCombine; external shlwapi32 name 'PathCombineW';
function PathCombineA; external shlwapi32 name 'PathCombineA';
function PathCombineW; external shlwapi32 name 'PathCombineW';
function PathCompactPath; external shlwapi32 name 'PathCompactPathW';
function PathCompactPathA; external shlwapi32 name 'PathCompactPathA';
function PathCompactPathW; external shlwapi32 name 'PathCompactPathW';
function PathCompactPathEx; external shlwapi32 name 'PathCompactPathExW';
function PathCompactPathExA; external shlwapi32 name 'PathCompactPathExA';
function PathCompactPathExW; external shlwapi32 name 'PathCompactPathExW';
function PathCommonPrefix; external shlwapi32 name 'PathCommonPrefixW';
function PathCommonPrefixA; external shlwapi32 name 'PathCommonPrefixA';
function PathCommonPrefixW; external shlwapi32 name 'PathCommonPrefixW';
function PathFileExists; external shlwapi32 name 'PathFileExistsW';
function PathFileExistsA; external shlwapi32 name 'PathFileExistsA';
function PathFileExistsW; external shlwapi32 name 'PathFileExistsW';
function PathFindExtension; external shlwapi32 name 'PathFindExtensionW';
function PathFindExtensionA; external shlwapi32 name 'PathFindExtensionA';
function PathFindExtensionW; external shlwapi32 name 'PathFindExtensionW';
function PathFindFileName; external shlwapi32 name 'PathFindFileNameW';
function PathFindFileNameA; external shlwapi32 name 'PathFindFileNameA';
function PathFindFileNameW; external shlwapi32 name 'PathFindFileNameW';
function PathFindNextComponent; external shlwapi32 name 'PathFindNextComponentW';
function PathFindNextComponentA; external shlwapi32 name 'PathFindNextComponentA';
function PathFindNextComponentW; external shlwapi32 name 'PathFindNextComponentW';
function PathFindOnPath; external shlwapi32 name 'PathFindOnPathW';
function PathFindOnPathA; external shlwapi32 name 'PathFindOnPathA';
function PathFindOnPathW; external shlwapi32 name 'PathFindOnPathW';
function PathGetArgs; external shlwapi32 name 'PathGetArgsW';
function PathGetArgsA; external shlwapi32 name 'PathGetArgsA';
function PathGetArgsW; external shlwapi32 name 'PathGetArgsW';



function PathFindSuffixArray; external shlwapi32 name 'PathFindSuffixArrayW';
function PathFindSuffixArrayA; external shlwapi32 name 'PathFindSuffixArrayA';
function PathFindSuffixArrayW; external shlwapi32 name 'PathFindSuffixArrayW';
function PathIsLFNFileSpec; external shlwapi32 name 'PathIsLFNFileSpecW';
function PathIsLFNFileSpecA; external shlwapi32 name 'PathIsLFNFileSpecA';
function PathIsLFNFileSpecW; external shlwapi32 name 'PathIsLFNFileSpecW';



function PathGetCharType; external shlwapi32 name 'PathGetCharTypeW';
function PathGetCharTypeA; external shlwapi32 name 'PathGetCharTypeA';
function PathGetCharTypeW; external shlwapi32 name 'PathGetCharTypeW';

function PathGetDriveNumber; external shlwapi32 name 'PathGetDriveNumberW';
function PathGetDriveNumberA; external shlwapi32 name 'PathGetDriveNumberA';
function PathGetDriveNumberW; external shlwapi32 name 'PathGetDriveNumberW';
function PathIsDirectory; external shlwapi32 name 'PathIsDirectoryW';
function PathIsDirectoryA; external shlwapi32 name 'PathIsDirectoryA';
function PathIsDirectoryW; external shlwapi32 name 'PathIsDirectoryW';



function PathIsDirectoryEmpty; external shlwapi32 name 'PathIsDirectoryEmptyW';
function PathIsDirectoryEmptyA; external shlwapi32 name 'PathIsDirectoryEmptyA';
function PathIsDirectoryEmptyW; external shlwapi32 name 'PathIsDirectoryEmptyW';



function PathIsFileSpec; external shlwapi32 name 'PathIsFileSpecW';
function PathIsFileSpecA; external shlwapi32 name 'PathIsFileSpecA';
function PathIsFileSpecW; external shlwapi32 name 'PathIsFileSpecW';
function PathIsPrefix; external shlwapi32 name 'PathIsPrefixW';
function PathIsPrefixA; external shlwapi32 name 'PathIsPrefixA';
function PathIsPrefixW; external shlwapi32 name 'PathIsPrefixW';
function PathIsRelative; external shlwapi32 name 'PathIsRelativeW';
function PathIsRelativeA; external shlwapi32 name 'PathIsRelativeA';
function PathIsRelativeW; external shlwapi32 name 'PathIsRelativeW';
function PathIsRoot; external shlwapi32 name 'PathIsRootW';
function PathIsRootA; external shlwapi32 name 'PathIsRootA';
function PathIsRootW; external shlwapi32 name 'PathIsRootW';
function PathIsSameRoot; external shlwapi32 name 'PathIsSameRootW';
function PathIsSameRootA; external shlwapi32 name 'PathIsSameRootA';
function PathIsSameRootW; external shlwapi32 name 'PathIsSameRootW';
function PathIsUNC; external shlwapi32 name 'PathIsUNCW';
function PathIsUNCA; external shlwapi32 name 'PathIsUNCA';
function PathIsUNCW; external shlwapi32 name 'PathIsUNCW';



function PathIsNetworkPath; external shlwapi32 name 'PathIsNetworkPathW';
function PathIsNetworkPathA; external shlwapi32 name 'PathIsNetworkPathA';
function PathIsNetworkPathW; external shlwapi32 name 'PathIsNetworkPathW';



function PathIsUNCServer; external shlwapi32 name 'PathIsUNCServerW';
function PathIsUNCServerA; external shlwapi32 name 'PathIsUNCServerA';
function PathIsUNCServerW; external shlwapi32 name 'PathIsUNCServerW';
function PathIsUNCServerShare; external shlwapi32 name 'PathIsUNCServerShareW';
function PathIsUNCServerShareA; external shlwapi32 name 'PathIsUNCServerShareA';
function PathIsUNCServerShareW; external shlwapi32 name 'PathIsUNCServerShareW';
function PathIsContentType; external shlwapi32 name 'PathIsContentTypeW';
function PathIsContentTypeA; external shlwapi32 name 'PathIsContentTypeA';
function PathIsContentTypeW; external shlwapi32 name 'PathIsContentTypeW';
function PathIsURL; external shlwapi32 name 'PathIsURLW';
function PathIsURLA; external shlwapi32 name 'PathIsURLA';
function PathIsURLW; external shlwapi32 name 'PathIsURLW';
function PathMakePretty; external shlwapi32 name 'PathMakePrettyW';
function PathMakePrettyA; external shlwapi32 name 'PathMakePrettyA';
function PathMakePrettyW; external shlwapi32 name 'PathMakePrettyW';
function PathMatchSpec; external shlwapi32 name 'PathMatchSpecW';
function PathMatchSpecA; external shlwapi32 name 'PathMatchSpecA';
function PathMatchSpecW; external shlwapi32 name 'PathMatchSpecW';
function PathParseIconLocation; external shlwapi32 name 'PathParseIconLocationW';
function PathParseIconLocationA; external shlwapi32 name 'PathParseIconLocationA';
function PathParseIconLocationW; external shlwapi32 name 'PathParseIconLocationW';
procedure PathQuoteSpaces; external shlwapi32 name 'PathQuoteSpacesW';
procedure PathQuoteSpacesA; external shlwapi32 name 'PathQuoteSpacesA';
procedure PathQuoteSpacesW; external shlwapi32 name 'PathQuoteSpacesW';
function PathRelativePathTo; external shlwapi32 name 'PathRelativePathToW';
function PathRelativePathToA; external shlwapi32 name 'PathRelativePathToA';
function PathRelativePathToW; external shlwapi32 name 'PathRelativePathToW';
procedure PathRemoveArgs; external shlwapi32 name 'PathRemoveArgsW';
procedure PathRemoveArgsA; external shlwapi32 name 'PathRemoveArgsA';
procedure PathRemoveArgsW; external shlwapi32 name 'PathRemoveArgsW';
function PathRemoveBackslash; external shlwapi32 name 'PathRemoveBackslashW';
function PathRemoveBackslashA; external shlwapi32 name 'PathRemoveBackslashA';
function PathRemoveBackslashW; external shlwapi32 name 'PathRemoveBackslashW';
procedure PathRemoveBlanks; external shlwapi32 name 'PathRemoveBlanksW';
procedure PathRemoveBlanksA; external shlwapi32 name 'PathRemoveBlanksA';
procedure PathRemoveBlanksW; external shlwapi32 name 'PathRemoveBlanksW';
procedure PathRemoveExtension; external shlwapi32 name 'PathRemoveExtensionW';
procedure PathRemoveExtensionA; external shlwapi32 name 'PathRemoveExtensionA';
procedure PathRemoveExtensionW; external shlwapi32 name 'PathRemoveExtensionW';
function PathRemoveFileSpec; external shlwapi32 name 'PathRemoveFileSpecW';
function PathRemoveFileSpecA; external shlwapi32 name 'PathRemoveFileSpecA';
function PathRemoveFileSpecW; external shlwapi32 name 'PathRemoveFileSpecW';
function PathRenameExtension; external shlwapi32 name 'PathRenameExtensionW';
function PathRenameExtensionA; external shlwapi32 name 'PathRenameExtensionA';
function PathRenameExtensionW; external shlwapi32 name 'PathRenameExtensionW';
function PathSearchAndQualify; external shlwapi32 name 'PathSearchAndQualifyW';
function PathSearchAndQualifyA; external shlwapi32 name 'PathSearchAndQualifyA';
function PathSearchAndQualifyW; external shlwapi32 name 'PathSearchAndQualifyW';
procedure PathSetDlgItemPath; external shlwapi32 name 'PathSetDlgItemPathW';
procedure PathSetDlgItemPathA; external shlwapi32 name 'PathSetDlgItemPathA';
procedure PathSetDlgItemPathW; external shlwapi32 name 'PathSetDlgItemPathW';
function PathSkipRoot; external shlwapi32 name 'PathSkipRootW';
function PathSkipRootA; external shlwapi32 name 'PathSkipRootA';
function PathSkipRootW; external shlwapi32 name 'PathSkipRootW';
procedure PathStripPath; external shlwapi32 name 'PathStripPathW';
procedure PathStripPathA; external shlwapi32 name 'PathStripPathA';
procedure PathStripPathW; external shlwapi32 name 'PathStripPathW';
function PathStripToRoot; external shlwapi32 name 'PathStripToRootW';
function PathStripToRootA; external shlwapi32 name 'PathStripToRootA';
function PathStripToRootW; external shlwapi32 name 'PathStripToRootW';
procedure PathUnquoteSpaces; external shlwapi32 name 'PathUnquoteSpacesW';
procedure PathUnquoteSpacesA; external shlwapi32 name 'PathUnquoteSpacesA';
procedure PathUnquoteSpacesW; external shlwapi32 name 'PathUnquoteSpacesW';
function PathMakeSystemFolder; external shlwapi32 name 'PathMakeSystemFolderW';
function PathMakeSystemFolderA; external shlwapi32 name 'PathMakeSystemFolderA';
function PathMakeSystemFolderW; external shlwapi32 name 'PathMakeSystemFolderW';
function PathUnmakeSystemFolder; external shlwapi32 name 'PathUnmakeSystemFolderW';
function PathUnmakeSystemFolderA; external shlwapi32 name 'PathUnmakeSystemFolderA';
function PathUnmakeSystemFolderW; external shlwapi32 name 'PathUnmakeSystemFolderW';
function PathIsSystemFolder; external shlwapi32 name 'PathIsSystemFolderW';
function PathIsSystemFolderA; external shlwapi32 name 'PathIsSystemFolderA';
function PathIsSystemFolderW; external shlwapi32 name 'PathIsSystemFolderW';



procedure PathUndecorate; external shlwapi32 name 'PathUndecorateW';
procedure PathUndecorateA; external shlwapi32 name 'PathUndecorateA';
procedure PathUndecorateW; external shlwapi32 name 'PathUndecorateW';
function PathUnExpandEnvStrings; external shlwapi32 name 'PathUnExpandEnvStringsW';
function PathUnExpandEnvStringsA; external shlwapi32 name 'PathUnExpandEnvStringsA';
function PathUnExpandEnvStringsW; external shlwapi32 name 'PathUnExpandEnvStringsW';

function UrlCompare; external shlwapi32 name 'UrlCompareW';
function UrlCompareA; external shlwapi32 name 'UrlCompareA';
function UrlCompareW; external shlwapi32 name 'UrlCompareW';
function UrlCombine; external shlwapi32 name 'UrlCombineW';
function UrlCombineA; external shlwapi32 name 'UrlCombineA';
function UrlCombineW; external shlwapi32 name 'UrlCombineW';
function UrlCanonicalize; external shlwapi32 name 'UrlCanonicalizeW';
function UrlCanonicalizeA; external shlwapi32 name 'UrlCanonicalizeA';
function UrlCanonicalizeW; external shlwapi32 name 'UrlCanonicalizeW';
function UrlIsOpaque; external shlwapi32 name 'UrlIsOpaqueW';
function UrlIsOpaqueA; external shlwapi32 name 'UrlIsOpaqueA';
function UrlIsOpaqueW; external shlwapi32 name 'UrlIsOpaqueW';
function UrlIsNoHistory; external shlwapi32 name 'UrlIsNoHistoryW';
function UrlIsNoHistoryA; external shlwapi32 name 'UrlIsNoHistoryA';
function UrlIsNoHistoryW; external shlwapi32 name 'UrlIsNoHistoryW';

function UrlIsFileUrl(pszURL: LPCWSTR): BOOL;
begin
  Result := UrlIs(pszURL, URLIS_FILEURL)
end;
function UrlIsFileUrlA(pszURL: LPCSTR): BOOL;
begin
  Result := UrlIsA(pszURL, URLIS_FILEURL)
end;
function UrlIsFileUrlW(pszURL: LPCWSTR): BOOL;
begin
  Result := UrlIsW(pszURL, URLIS_FILEURL)
end;

function UrlIs; external shlwapi32 name 'UrlIsW';
function UrlIsA; external shlwapi32 name 'UrlIsA';
function UrlIsW; external shlwapi32 name 'UrlIsW';
function UrlGetLocation; external shlwapi32 name 'UrlGetLocationW';
function UrlGetLocationA; external shlwapi32 name 'UrlGetLocationA';
function UrlGetLocationW; external shlwapi32 name 'UrlGetLocationW';
function UrlUnescape; external shlwapi32 name 'UrlUnescapeW';
function UrlUnescapeA; external shlwapi32 name 'UrlUnescapeA';
function UrlUnescapeW; external shlwapi32 name 'UrlUnescapeW';
function UrlEscape; external shlwapi32 name 'UrlEscapeW';
function UrlEscapeA; external shlwapi32 name 'UrlEscapeA';
function UrlEscapeW; external shlwapi32 name 'UrlEscapeW';
function UrlCreateFromPath; external shlwapi32 name 'UrlCreateFromPathW';
function UrlCreateFromPathA; external shlwapi32 name 'UrlCreateFromPathA';
function UrlCreateFromPathW; external shlwapi32 name 'UrlCreateFromPathW';
function PathCreateFromUrl; external shlwapi32 name 'PathCreateFromUrlW';
function PathCreateFromUrlA; external shlwapi32 name 'PathCreateFromUrlA';
function PathCreateFromUrlW; external shlwapi32 name 'PathCreateFromUrlW';
function UrlHash; external shlwapi32 name 'UrlHashW';
function UrlHashA; external shlwapi32 name 'UrlHashA';
function UrlHashW; external shlwapi32 name 'UrlHashW';
function UrlGetPart; external shlwapi32 name 'UrlGetPartW';
function UrlGetPartA; external shlwapi32 name 'UrlGetPartA';
function UrlGetPartW; external shlwapi32 name 'UrlGetPartW';
function UrlApplyScheme; external shlwapi32 name 'UrlApplySchemeW';
function UrlApplySchemeA; external shlwapi32 name 'UrlApplySchemeA';
function UrlApplySchemeW; external shlwapi32 name 'UrlApplySchemeW';
function HashData; external shlwapi32 name 'HashData';


function UrlEscapeSpaces(pszUrl: LPCWSTR; pszEscaped: LPWSTR; pcchEscaped: LPDWORD): HRESULT; stdcall;
begin
  Result := UrlCanonicalize(pszUrl, pszEscaped, pcchEscaped, URL_ESCAPE_SPACES_ONLY or URL_DONT_ESCAPE_EXTRA_INFO);
end;

function UrlEscapeSpacesA(pszUrl: LPCSTR; pszEscaped: LPSTR; pcchEscaped: LPDWORD): HRESULT; stdcall;
begin
  Result := UrlCanonicalizeA(pszUrl, pszEscaped, pcchEscaped, URL_ESCAPE_SPACES_ONLY or URL_DONT_ESCAPE_EXTRA_INFO);
end;

function UrlEscapeSpacesW(pszUrl: LPCWSTR; pszEscaped: LPWSTR; pcchEscaped: LPDWORD): HRESULT; stdcall;
begin
  Result := UrlCanonicalizeW(pszUrl, pszEscaped, pcchEscaped, URL_ESCAPE_SPACES_ONLY or URL_DONT_ESCAPE_EXTRA_INFO);
end;

function UrlUnescapeInPlace(pszUrl: LPWSTR; dwFlags: DWORD): HRESULT;
begin
  Result := UrlUnescape(pszUrl, nil, nil, dwFlags or URL_UNESCAPE_INPLACE);
end;

function UrlUnescapeInPlaceA(pszUrl: LPSTR; dwFlags: DWORD): HRESULT;
begin
  Result := UrlUnescapeA(pszUrl, nil, nil, dwFlags or URL_UNESCAPE_INPLACE);
end;

function UrlUnescapeInPlaceW(pszUrl: LPWSTR; dwFlags: DWORD): HRESULT;
begin
  Result := UrlUnescapeW(pszUrl, nil, nil, dwFlags or URL_UNESCAPE_INPLACE);
end;

 //  IE 5
 //  NO_SHLWAPI_PATH


function SHDeleteEmptyKey; external shlwapi32 name 'SHDeleteEmptyKeyW';
function SHDeleteEmptyKeyA; external shlwapi32 name 'SHDeleteEmptyKeyA';
function SHDeleteEmptyKeyW; external shlwapi32 name 'SHDeleteEmptyKeyW';
function SHDeleteKey; external shlwapi32 name 'SHDeleteKeyW';
function SHDeleteKeyA; external shlwapi32 name 'SHDeleteKeyA';
function SHDeleteKeyW; external shlwapi32 name 'SHDeleteKeyW';

function SHDeleteValue; external shlwapi32 name 'SHDeleteValueW';
function SHDeleteValueA; external shlwapi32 name 'SHDeleteValueA';
function SHDeleteValueW; external shlwapi32 name 'SHDeleteValueW';
function SHGetValue; external shlwapi32 name 'SHGetValueW';
function SHGetValueA; external shlwapi32 name 'SHGetValueA';
function SHGetValueW; external shlwapi32 name 'SHGetValueW';
function SHSetValue; external shlwapi32 name 'SHSetValueW';
function SHSetValueA; external shlwapi32 name 'SHSetValueA';
function SHSetValueW; external shlwapi32 name 'SHSetValueW';

function SHQueryValueEx; external shlwapi32 name 'SHQueryValueExW';
function SHQueryValueExA; external shlwapi32 name 'SHQueryValueExA';
function SHQueryValueExW; external shlwapi32 name 'SHQueryValueExW';

function SHEnumKeyEx; external shlwapi32 name 'SHEnumKeyExW';
function SHEnumKeyExA; external shlwapi32 name 'SHEnumKeyExA';
function SHEnumKeyExW; external shlwapi32 name 'SHEnumKeyExW';
function SHEnumValue; external shlwapi32 name 'SHEnumValueW';
function SHEnumValueA; external shlwapi32 name 'SHEnumValueA';
function SHEnumValueW; external shlwapi32 name 'SHEnumValueW';
function SHQueryInfoKey; external shlwapi32 name 'SHQueryInfoKeyW';
function SHQueryInfoKeyA; external shlwapi32 name 'SHQueryInfoKeyA';
function SHQueryInfoKeyW; external shlwapi32 name 'SHQueryInfoKeyW';



function SHCopyKey; external shlwapi32 name 'SHCopyKeyW';
function SHCopyKeyA; external shlwapi32 name 'SHCopyKeyA';
function SHCopyKeyW; external shlwapi32 name 'SHCopyKeyW';

function SHRegGetPath; external shlwapi32 name 'SHRegGetPathW';
function SHRegGetPathA; external shlwapi32 name 'SHRegGetPathA';
function SHRegGetPathW; external shlwapi32 name 'SHRegGetPathW';
function SHRegSetPath; external shlwapi32 name 'SHRegSetPathW';
function SHRegSetPathA; external shlwapi32 name 'SHRegSetPathA';
function SHRegSetPathW; external shlwapi32 name 'SHRegSetPathW';



function SHRegCreateUSKey; external shlwapi32 name 'SHRegCreateUSKeyW';
function SHRegCreateUSKeyA; external shlwapi32 name 'SHRegCreateUSKeyA';
function SHRegCreateUSKeyW; external shlwapi32 name 'SHRegCreateUSKeyW';
function SHRegOpenUSKey; external shlwapi32 name 'SHRegOpenUSKeyW';
function SHRegOpenUSKeyA; external shlwapi32 name 'SHRegOpenUSKeyA';
function SHRegOpenUSKeyW; external shlwapi32 name 'SHRegOpenUSKeyW';
function SHRegQueryUSValue; external shlwapi32 name 'SHRegQueryUSValueW';
function SHRegQueryUSValueA; external shlwapi32 name 'SHRegQueryUSValueA';
function SHRegQueryUSValueW; external shlwapi32 name 'SHRegQueryUSValueW';
function SHRegWriteUSValue; external shlwapi32 name 'SHRegWriteUSValueW';
function SHRegWriteUSValueA; external shlwapi32 name 'SHRegWriteUSValueA';
function SHRegWriteUSValueW; external shlwapi32 name 'SHRegWriteUSValueW';
function SHRegDeleteUSValue; external shlwapi32 name 'SHRegDeleteUSValueW';
function SHRegDeleteUSValueA; external shlwapi32 name 'SHRegDeleteUSValueA';
function SHRegDeleteUSValueW; external shlwapi32 name 'SHRegDeleteUSValueW';
function SHRegDeleteEmptyUSKey; external shlwapi32 name 'SHRegDeleteEmptyUSKeyW';
function SHRegDeleteEmptyUSKeyA; external shlwapi32 name 'SHRegDeleteEmptyUSKeyA';
function SHRegDeleteEmptyUSKeyW; external shlwapi32 name 'SHRegDeleteEmptyUSKeyW';
function SHRegEnumUSKey; external shlwapi32 name 'SHRegEnumUSKeyW';
function SHRegEnumUSKeyA; external shlwapi32 name 'SHRegEnumUSKeyA';
function SHRegEnumUSKeyW; external shlwapi32 name 'SHRegEnumUSKeyW';
function SHRegEnumUSValue; external shlwapi32 name 'SHRegEnumUSValueW';
function SHRegEnumUSValueA; external shlwapi32 name 'SHRegEnumUSValueA';
function SHRegEnumUSValueW; external shlwapi32 name 'SHRegEnumUSValueW';
function SHRegQueryInfoUSKey; external shlwapi32 name 'SHRegQueryInfoUSKeyW';
function SHRegQueryInfoUSKeyA; external shlwapi32 name 'SHRegQueryInfoUSKeyA';
function SHRegQueryInfoUSKeyW; external shlwapi32 name 'SHRegQueryInfoUSKeyW';
function SHRegCloseUSKey; external shlwapi32 name 'SHRegCloseUSKey';

function SHRegGetUSValue; external shlwapi32 name 'SHRegGetUSValueW';
function SHRegGetUSValueA; external shlwapi32 name 'SHRegGetUSValueA';
function SHRegGetUSValueW; external shlwapi32 name 'SHRegGetUSValueW';
function SHRegSetUSValue; external shlwapi32 name 'SHRegSetUSValueW';
function SHRegSetUSValueA; external shlwapi32 name 'SHRegSetUSValueA';
function SHRegSetUSValueW; external shlwapi32 name 'SHRegSetUSValueW';

function SHRegGetBoolUSValue; external shlwapi32 name 'SHRegGetBoolUSValueW';
function SHRegGetBoolUSValueA; external shlwapi32 name 'SHRegGetBoolUSValueA';
function SHRegGetBoolUSValueW; external shlwapi32 name 'SHRegGetBoolUSValueW';



function SHRegGetIntW; external shlwapi32 name 'SHRegGetIntW';

function AssocCreate; external shlwapi32 name 'AssocCreate';

function AssocQueryString; external shlwapi32 name 'AssocQueryStringW';
function AssocQueryStringA; external shlwapi32 name 'AssocQueryStringA';
function AssocQueryStringW; external shlwapi32 name 'AssocQueryStringW';
function AssocQueryStringByKey; external shlwapi32 name 'AssocQueryStringByKeyW';
function AssocQueryStringByKeyA; external shlwapi32 name 'AssocQueryStringByKeyA';
function AssocQueryStringByKeyW; external shlwapi32 name 'AssocQueryStringByKeyW';
function AssocQueryKey; external shlwapi32 name 'AssocQueryKeyW';
function AssocQueryKeyA; external shlwapi32 name 'AssocQueryKeyA';
function AssocQueryKeyW; external shlwapi32 name 'AssocQueryKeyW';

 //  IE 5
 //  NO_SHLWAPI_REG


function SHOpenRegStream; external shlwapi32 name 'SHOpenRegStreamW';
function SHOpenRegStreamA; external shlwapi32 name 'SHOpenRegStreamA';
function SHOpenRegStreamW; external shlwapi32 name 'SHOpenRegStreamW';



function SHOpenRegStream2; external shlwapi32 name 'SHOpenRegStream2W';
function SHOpenRegStream2A; external shlwapi32 name 'SHOpenRegStream2A';
function SHOpenRegStream2W; external shlwapi32 name 'SHOpenRegStream2W';

function SHCreateStreamOnFile; external shlwapi32 name 'SHCreateStreamOnFileW';
function SHCreateStreamOnFileA; external shlwapi32 name 'SHCreateStreamOnFileA';
function SHCreateStreamOnFileW; external shlwapi32 name 'SHCreateStreamOnFileW';


 // NO_SHLWAPI_STREAM



function SHAutoComplete; external shlwapi32 name 'SHAutoComplete';

procedure SHSetThreadRef; external shlwapi32 name 'SHSetThreadRef';
procedure SHGetThreadRef; external shlwapi32 name 'SHGetThreadRef';

function SHSkipJunction; external shlwapi32 name 'SHSkipJunction';





function SHCreateThread; external shlwapi32 name 'SHCreateThread';




function SHCreateShellPalette; external shlwapi32 name 'SHCreateShellPalette';


procedure ColorRGBToHLS; external shlwapi32 name 'ColorRGBToHLS';
function ColorHLSToRGB; external shlwapi32 name 'ColorHLSToRGB';
function ColorAdjustLuma; external shlwapi32 name 'ColorAdjustLuma';
 // _WIN32_IE >= $0500
 // NO_SHLWAPI_GDI

function MAKEDLLVERULL(Major, Minor, Build, Qfe: Word): Int64;
begin
  Result := (Int64(Major) shl 48) or (Minor shl 32) or (Build shl 16) or Qfe;
end;

end.
