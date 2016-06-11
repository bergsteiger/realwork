{*******************************************************}
{                                                       }
{                Delphi Runtime Library                 }
{                                                       }
{          File: MLang.h                                }
{          Copyright (c) Microsoft Corporation          }
{          All Rights Reserved.                         }
{                                                       }
{       Translator: Embarcadero Technologies, Inc.      }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Winapi.MLang;

{$ALIGN 4}

{$HPPEMIT ''}
{$HPPEMIT '#include <MLang.h>' }
{$HPPEMIT ''}

interface

uses Winapi.Windows, Winapi.ActiveX;

const
  SID_IMLangStringBufW       = '{D24ACD21-BA72-11D0-B188-00AA0038C969}';
  SID_IMLangStringBufA       = '{D24ACD23-BA72-11D0-B188-00AA0038C969}';
  SID_IMLangString           = '{C04D65CE-B70D-11D0-B188-00AA0038C969}';
  SID_IMLangStringWStr       = '{C04D65D0-B70D-11D0-B188-00AA0038C969}';
  SID_IMLangStringAStr       = '{C04D65D2-B70D-11D0-B188-00AA0038C969}';
  SID_IMLangLineBreakConsole = '{F5BE2EE1-BFD7-11D0-B188-00AA0038C969}';
  SID_IEnumCodePage          = '{275c23e3-3747-11d0-9fea-00aa003f8646}';
  SID_IEnumRfc1766           = '{3dc39d1d-c030-11d0-b81b-00c04fc9b31f}';
  SID_IEnumScript            = '{AE5F1430-388B-11d2-8380-00C04F8F5DA1}';
  SID_IMLangConvertCharset   = '{d66d6f98-cdaa-11d0-b822-00c04fc9b31f}';
  SID_IMultiLanguage         = '{275c23e1-3747-11d0-9fea-00aa003f8646}';
  SID_IMultiLanguage2        = '{DCCFC164-2B38-11d2-B7EC-00C04F8F5D9A}';
  SID_IMLangCodePages        = '{359F3443-BD4A-11D0-B188-00AA0038C969}';
  SID_IMLangFontLink         = '{359F3441-BD4A-11D0-B188-00AA0038C969}';
  SID_IMLangFontLink2        = '{DCCFC162-2B38-11d2-B7EC-00C04F8F5D9A}';
  SID_IMultiLanguage3        = '{4e5868ab-b157-4623-9acc-6a1d9caebe04}';

  IID_IMLangStringBufW: TGUID = '{D24ACD21-BA72-11D0-B188-00AA0038C969}';
  IID_IMLangStringBufA: TGUID = '{D24ACD23-BA72-11D0-B188-00AA0038C969}';
  IID_IMLangString: TGUID     = '{C04D65CE-B70D-11D0-B188-00AA0038C969}';
  IID_IMLangStringWStr: TGUID = '{C04D65D0-B70D-11D0-B188-00AA0038C969}';
  IID_IMLangStringAStr: TGUID = '{C04D65D2-B70D-11D0-B188-00AA0038C969}';
  IID_IMLangLineBreakConsole: TGUID = '{F5BE2EE1-BFD7-11D0-B188-00AA0038C969}';
  IID_IEnumCodePage: TGUID    = '{275C23E3-3747-11D0-9FEA-00AA003F8646}';
  IID_IEnumRfc1766: TGUID     = '{3DC39D1D-C030-11D0-B81B-00C04FC9B31F}';
  IID_IEnumScript: TGUID      = '{AE5F1430-388B-11D2-8380-00C04F8F5DA1}';
  IID_IMLangConvertCharset: TGUID = '{D66D6F98-CDAA-11D0-B822-00C04FC9B31F}';
  IID_IMultiLanguage: TGUID   = '{275C23E1-3747-11D0-9FEA-00AA003F8646}';
  IID_IMultiLanguage2: TGUID  = '{DCCFC164-2B38-11D2-B7EC-00C04F8F5D9A}';
  IID_IMLangCodePages: TGUID  = '{359F3443-BD4A-11D0-B188-00AA0038C969}';
  IID_IMLangFontLink: TGUID   = '{359F3441-BD4A-11D0-B188-00AA0038C969}';
  IID_IMLangFontLink2: TGUID  = '{DCCFC162-2B38-11D2-B7EC-00C04F8F5D9A}';
  IID_IMultiLanguage3: TGUID  = '{4E5868AB-B157-4623-9ACC-6A1D9CAEBE04}';

type
  // *********************************************************************//
  // Interface: IMLangStringBufW
  // Flags:     (0)
  // GUID:      {D24ACD21-BA72-11D0-B188-00AA0038C969}
  // *********************************************************************//
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IMLangStringBufW);'}
  IMLangStringBufW = interface(IUnknown)
    [SID_IMLangStringBufW]
    function GetStatus(out plFlags: Integer; out pcchBuf: Integer): HResult; stdcall;
    function LockBuf(cchOffset: Integer; cchMaxLock: Integer; out ppszBuf: PWideChar;
      out pcchBuf: Integer): HResult; stdcall;                                                       
    function UnlockBuf(pszBuf: PWord; cchOffset: Integer; cchWrite: Integer): HResult; stdcall;
    function Insert(cchOffset: Integer; cchMaxInsert: Integer; out pcchActual: Integer)
      : HResult; stdcall;
    function Delete(cchOffset: Integer; cchDelete: Integer): HResult; stdcall;
  end;

  // *********************************************************************//
  // Interface: IMLangStringBufA
  // Flags:     (0)
  // GUID:      {D24ACD23-BA72-11D0-B188-00AA0038C969}
  // *********************************************************************//
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IMLangStringBufA);'}
  IMLangStringBufA = interface(IUnknown)
    [SID_IMLangStringBufA]
    function GetStatus(out plFlags: Integer; out pcchBuf: Integer): HResult; stdcall;
    function LockBuf(cchOffset: Integer; cchMaxLock: Integer; out ppszBuf: PAnsiChar;
      out pcchBuf: Integer): HResult; stdcall;                                                       
    function UnlockBuf(pszBuf: PByte; cchOffset: Integer; cchWrite: Integer)
      : HResult; stdcall;
    function Insert(cchOffset: Integer; cchMaxInsert: Integer; out pcchActual: Integer)
      : HResult; stdcall;
    function Delete(cchOffset: Integer; cchDelete: Integer): HResult; stdcall;
  end;

  // *********************************************************************//
  // Interface: IMLangString
  // Flags:     (0)
  // GUID:      {C04D65CE-B70D-11D0-B188-00AA0038C969}
  // *********************************************************************//
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IMLangString);'}
  IMLangString = interface(IUnknown)
    [SID_IMLangString]
    function Sync(fNoAccess: Integer): HResult; stdcall;
    function GetLength(out plLen: Integer): HResult; stdcall;
    function SetMLStr(lDestPos: Integer; lDestLen: Integer; const pSrcMLStr: IUnknown;
      lSrcPos: Integer; lSrcLen: Integer): HResult; stdcall;
    function GetMLStr(lSrcPos: Integer; lSrcLen: Integer; const pUnkOuter: IUnknown;
      dwClsContext: LongWord; var piid: TGUID; out ppDestMLStr: IUnknown; out plDestPos: Integer;
      out plDestLen: Integer): HResult; stdcall;
  end;

  // *********************************************************************//
  // Interface: IMLangStringWStr
  // Flags:     (0)
  // GUID:      {C04D65D0-B70D-11D0-B188-00AA0038C969}
  // *********************************************************************//
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IMLangStringWStr);'}
  IMLangStringWStr = interface(IMLangString)
    [SID_IMLangStringWStr]
    function SetWStr(lDestPos: Integer; lDestLen: Integer; pszSrc: PWideChar; cchSrc: Integer;
      out pcchActual: Integer; out plActualLen: Integer): HResult; stdcall;
    function SetStrBufW(lDestPos: Integer; lDestLen: Integer; const pSrcBuf: IMLangStringBufW;
      out pcchActual: Integer; out plActualLen: Integer): HResult; stdcall;
    function GetWStr(lSrcPos: Integer; lSrcLen: Integer; pszDest: PWideChar; cchDest: Integer;
      out pcchActual: Integer; out plActualLen: Integer): HResult; stdcall;
    function GetStrBufW(lSrcPos: Integer; lSrcMaxLen: Integer; out ppDestBuf: IMLangStringBufW;
      out plDestLen: Integer): HResult; stdcall;
    function LockWStr(lSrcPos: Integer; lSrcLen: Integer; lFlags: Integer; cchRequest: Integer;
      out ppszDest: PWideChar; out pcchDest: Integer; out plDestLen: Integer): HResult; stdcall;
    function UnlockWStr(pszSrc: PWideChar; cchSrc: Integer; out pcchActual: Integer;
      out plActualLen: Integer): HResult; stdcall;
    function SetLocale(lDestPos: Integer; lDestLen: Integer; locale: LongWord): HResult; stdcall;
    function GetLocale(lSrcPos: Integer; lSrcMaxLen: Integer; out plocale: LongWord;
      out plLocalePos: Integer; out plLocaleLen: Integer): HResult; stdcall;
  end;

  // *********************************************************************//
  // Interface: IMLangStringAStr
  // Flags:     (0)
  // GUID:      {C04D65D2-B70D-11D0-B188-00AA0038C969}
  // *********************************************************************//
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IMLangStringAStr);'}
  IMLangStringAStr = interface(IMLangString)
    [SID_IMLangStringAStr]
    function SetAStr(lDestPos: Integer; lDestLen: Integer; uCodePage: UINT; pszSrc: PAnsiChar;
      cchSrc: Integer; out pcchActual: Integer; out plActualLen: Integer): HResult; stdcall;
    function SetStrBufA(lDestPos: Integer; lDestLen: Integer; uCodePage: UINT;
      const pSrcBuf: IMLangStringBufA; out pcchActual: Integer; out plActualLen: Integer)
      : HResult; stdcall;
    function GetAStr(lSrcPos: Integer; lSrcLen: Integer; uCodePageIn: UINT;
      out puCodePageOut: UINT; pszDest: PAnsiChar; cchDest: Integer; out pcchActual: Integer;
      out plActualLen: Integer): HResult; stdcall;
    function GetStrBufA(lSrcPos: Integer; lSrcMaxLen: Integer; out puDestCodePage: UINT;
      out ppDestBuf: IMLangStringBufA; out plDestLen: Integer): HResult; stdcall;
    function LockAStr(lSrcPos: Integer; lSrcLen: Integer; lFlags: Integer; uCodePageIn: UINT;
      cchRequest: Integer; out puCodePageOut: UINT; out ppszDest: PAnsiChar;
      out pcchDest: Integer; out plDestLen: Integer): HResult; stdcall;
    function UnlockAStr(pszSrc: PAnsiChar; cchSrc: Integer; out pcchActual: Integer;
      out plActualLen: Integer): HResult; stdcall;
    function SetLocale(lDestPos: Integer; lDestLen: Integer; locale: LongWord): HResult; stdcall;
    function GetLocale(lSrcPos: Integer; lSrcMaxLen: Integer; out plocale: LongWord;
      out plLocalePos: Integer; out plLocaleLen: Integer): HResult; stdcall;
  end;

  // *********************************************************************//
  // Interface: IMLangLineBreakConsole
  // Flags:     (0)
  // GUID:      {F5BE2EE1-BFD7-11D0-B188-00AA0038C969}
  // *********************************************************************//
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IMLangLineBreakConsole);'}
  IMLangLineBreakConsole = interface(IUnknown)
    [SID_IMLangLineBreakConsole]
    function BreakLineML(const pSrcMLStr: IMLangString; lSrcPos: Integer; lSrcLen: Integer;
      cMinColumns: Integer; cMaxColumns: Integer; out plLineLen: Integer; out plSkipLen: Integer)
      : HResult; stdcall;
    function BreakLineW(locale: LongWord; pszSrc: PWideChar; cchSrc: Integer; cMaxColumns: Integer;
      out pcchLine: Integer; out pcchSkip: Integer): HResult; stdcall;
    function BreakLineA(locale: LongWord; uCodePage: UINT; pszSrc: PAnsiChar; cchSrc: Integer;
      cMaxColumns: Integer; out pcchLine: Integer; out pcchSkip: Integer): HResult; stdcall;
  end;


const
  MAX_MIMECP_NAME =  64 ;
  {$EXTERNALSYM MAX_MIMECP_NAME}
  MAX_MIMECSET_NAME =  50 ;
  {$EXTERNALSYM MAX_MIMECSET_NAME}
  MAX_MIMEFACE_NAME =  32 ;
  {$EXTERNALSYM MAX_MIMEFACE_NAME}

  MIMECONTF_MAILNEWS         = $00000001;
  {$EXTERNALSYM MIMECONTF_MAILNEWS}
  MIMECONTF_BROWSER          = $00000002;
  {$EXTERNALSYM MIMECONTF_BROWSER}
  MIMECONTF_MINIMAL          = $00000004;
  {$EXTERNALSYM MIMECONTF_MINIMAL}
  MIMECONTF_IMPORT           = $00000008;
  {$EXTERNALSYM MIMECONTF_IMPORT}
  MIMECONTF_SAVABLE_MAILNEWS = $00000100;
  {$EXTERNALSYM MIMECONTF_SAVABLE_MAILNEWS}
  MIMECONTF_SAVABLE_BROWSER  = $00000200;
  {$EXTERNALSYM MIMECONTF_SAVABLE_BROWSER}
  MIMECONTF_EXPORT           = $00000400;
  {$EXTERNALSYM MIMECONTF_EXPORT}
  MIMECONTF_PRIVCONVERTER    = $00010000;
  {$EXTERNALSYM MIMECONTF_PRIVCONVERTER}
  MIMECONTF_VALID            = $00020000;
  {$EXTERNALSYM MIMECONTF_VALID}
  MIMECONTF_VALID_NLS        = $00040000;
  {$EXTERNALSYM MIMECONTF_VALID_NLS}
  MIMECONTF_MIME_IE4         = $10000000;
  {$EXTERNALSYM MIMECONTF_MIME_IE4}
  MIMECONTF_MIME_LATEST      = $20000000;
  {$EXTERNALSYM MIMECONTF_MIME_LATEST}
  MIMECONTF_MIME_REGISTRY    = $40000000;
  {$EXTERNALSYM MIMECONTF_MIME_REGISTRY}

type
  PMimeCPInfo = ^TMimeCPInfo;
  tagMIMECPINFO = record
    dwFlags: DWORD;
    uiCodePage: UINT;
    uiFamilyCodePage: UINT;
    wszDescription: packed array[0..MAX_MIMECP_NAME-1] of WCHAR;
    wszWebCharset: packed array[0..MAX_MIMECSET_NAME-1] of WCHAR;
    wszHeaderCharset: packed array[0..MAX_MIMECSET_NAME-1] of WCHAR;
    wszBodyCharset: packed array[0..MAX_MIMECSET_NAME-1] of WCHAR;
    wszFixedWidthFont: packed array[0..MAX_MIMEFACE_NAME-1] of WCHAR;
    wszProportionalFont: packed array[0..MAX_MIMEFACE_NAME-1] of WCHAR;
    bGDICharset: BYTE;
  end;
  {$EXTERNALSYM tagMIMECPINFO}
  TMimeCPInfo = tagMIMECPINFO;
  MIMECPINFO = tagMIMECPINFO;
  {$EXTERNALSYM MIMECPINFO}

  PMimeCsetInfo = ^TMimeCsetInfo;
  tagMIMECSETINFO = record
    uiCodePage: UINT;
    uiInternetEncoding: UINT;
    wszCharset: packed array[0..49] of WCHAR;
  end;
  {$EXTERNALSYM MIMECSETINFO}
  TMimeCsetInfo = tagMIMECSETINFO;
  MIMECSETINFO = tagMIMECSETINFO;
  {$EXTERNALSYM tagMIMECSETINFO}

  // *********************************************************************//
  // Interface: IEnumCodePage
  // Flags:     (0)
  // GUID:      {275C23E3-3747-11D0-9FEA-00AA003F8646}
  // *********************************************************************//
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IEnumCodePage);'}
  IEnumCodePage = interface(IUnknown)
    [SID_IEnumCodePage]
    function Clone(out ppEnum: IEnumCodePage): HResult; stdcall;
    function Next(celt: LongWord; out rgelt: tagMIMECPINFO; out pceltFetched: LongWord)
      : HResult; stdcall;
    function Reset: HResult; stdcall;
    function Skip(celt: LongWord): HResult; stdcall;
  end;

const
  MAX_RFC1766_NAME =  6 ;
  {$EXTERNALSYM MAX_RFC1766_NAME}
  MAX_LOCALE_NAME =  32 ;
  {$EXTERNALSYM MAX_LOCALE_NAME}

type
  PRFC1766Info = ^TRFC1766Info;
  tagRFC1766INFO = record
    lcid: LCID;
    wszRfc1766: packed array[0..MAX_RFC1766_NAME-1] of WCHAR;
    wszLocaleName: packed array[0..MAX_LOCALE_NAME-1] of WCHAR;
  end;
  {$EXTERNALSYM tagRFC1766INFO}
  TRFC1766Info = tagRFC1766INFO;
  RFC1766INFO = tagRFC1766INFO;
  {$EXTERNALSYM RFC1766INFO}

  // *********************************************************************//
  // Interface: IEnumRfc1766
  // Flags:     (0)
  // GUID:      {3DC39D1D-C030-11D0-B81B-00C04FC9B31F}
  // *********************************************************************//
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IEnumRfc1766);'}
  IEnumRfc1766 = interface(IUnknown)
    [SID_IEnumRfc1766]
    function Clone(out ppEnum: IEnumRfc1766): HResult; stdcall;
    function Next(celt: LongWord; out rgelt: tagRFC1766INFO; out pceltFetched: LongWord)
      : HResult; stdcall;
    function Reset: HResult; stdcall;
    function Skip(celt: LongWord): HResult; stdcall;
  end;

const
  MAX_SCRIPT_NAME =  48 ;
  {$EXTERNALSYM MAX_SCRIPT_NAME}

type
  SCRIPT_ID = BYTE;
  {$EXTERNALSYM SCRIPT_ID}
  TScriptID = SCRIPT_ID;

  SCRIPT_IDS = int64;
  {$EXTERNALSYM SCRIPT_IDS}
  TScriptIDs = SCRIPT_IDS;

const
  sidDefault     = 0;
  sidMerge       = SIDDEFAULT + 1;
  sidAsciiSym    = SIDMERGE + 1;
  sidAsciiLatin  = SIDASCIISYM + 1;
  sidLatin       = SIDASCIILATIN + 1;
  sidGreek       = SIDLATIN + 1;
  sidCyrillic    = SIDGREEK + 1;
  sidArmenian    = SIDCYRILLIC + 1;
  sidHebrew      = SIDARMENIAN + 1;
  sidArabic      = SIDHEBREW + 1;
  sidDevanagari  = SIDARABIC + 1;
  sidBengali     = SIDDEVANAGARI + 1;
  sidGurmukhi    = SIDBENGALI + 1;
  sidGujarati    = SIDGURMUKHI + 1;
  sidOriya       = SIDGUJARATI + 1;
  sidTamil       = SIDORIYA + 1;
  sidTelugu      = SIDTAMIL + 1;
  sidKannada     = SIDTELUGU + 1;
  sidMalayalam   = SIDKANNADA + 1;
  sidThai        = SIDMALAYALAM + 1;
  sidLao         = SIDTHAI + 1;
  sidTibetan     = SIDLAO + 1;
  sidGeorgian    = SIDTIBETAN + 1;
  sidHangul      = SIDGEORGIAN + 1;
  sidKana        = SIDHANGUL + 1;
  sidBopomofo    = SIDKANA + 1;
  sidHan         = SIDBOPOMOFO + 1;
  sidEthiopic    = SIDHAN + 1;
  sidCanSyllabic = SIDETHIOPIC + 1;
  sidCherokee    = SIDCANSYLLABIC + 1;
  sidYi          = SIDCHEROKEE + 1;
  sidBraille     = SIDYI + 1;
  sidRunic       = SIDBRAILLE + 1;
  sidOgham       = SIDRUNIC + 1;
  sidSinhala     = SIDOGHAM + 1;
  sidSyriac      = SIDSINHALA + 1;
  sidBurmese     = SIDSYRIAC + 1;
  sidKhmer       = SIDBURMESE + 1;
  sidThaana      = SIDKHMER + 1;
  sidMongolian   = SIDTHAANA + 1;
  sidUserDefined = SIDMONGOLIAN + 1;
  sidLim         = SIDUSERDEFINED + 1;
  sidFEFirst     = SIDHANGUL;
  sidFELast      = SIDHAN;

type
  tagSCRIPTINFO = record
    ScriptId: TScriptID;
    uiCodePage: UINT;
    wszDescription: packed array[0..MAX_SCRIPT_NAME-1] of WCHAR;
    wszFixedWidthFont: packed array[0..MAX_MIMEFACE_NAME-1] of WCHAR;
    wszProportionalFont: packed array[0..MAX_MIMEFACE_NAME-1] of WCHAR;
  end;
  {$EXTERNALSYM tagSCRIPTINFO}
  TScriptInfo = tagSCRIPTINFO;
  SCRIPTINFO = tagSCRIPTINFO;
  {$EXTERNALSYM SCRIPTINFO}

  // *********************************************************************//
  // Interface: IEnumScript
  // Flags:     (0)
  // GUID:      {AE5F1430-388B-11D2-8380-00C04F8F5DA1}
  // *********************************************************************//
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IEnumScript);'}
  IEnumScript = interface(IUnknown)
    [SID_IEnumScript]
    function Clone(out ppEnum: IEnumScript): HResult; stdcall;
    function Next(celt: LongWord; out rgelt: tagSCRIPTINFO; out pceltFetched: LongWord)
      : HResult; stdcall;
    function Reset: HResult; stdcall;
    function Skip(celt: LongWord): HResult; stdcall;
  end;

const
  MLCONVCHARF_AUTODETECT     = 1;
  MLCONVCHARF_ENTITIZE       = 2;
  MLCONVCHARF_NCR_ENTITIZE   = 2;
  MLCONVCHARF_NAME_ENTITIZE  = 4;
  MLCONVCHARF_USEDEFCHAR     = 8;
  MLCONVCHARF_NOBESTFITCHARS = 16;
  MLCONVCHARF_DETECTJPN      = 32;

  MLDETECTF_MAILNEWS           = $1;
  MLDETECTF_BROWSER            = $2;
  MLDETECTF_VALID              = $4;
  MLDETECTF_VALID_NLS          = $8;
  MLDETECTF_PRESERVE_ORDER     = $10;
  MLDETECTF_PREFERRED_ONLY     = $20;
  MLDETECTF_FILTER_SPECIALCHAR = $40;
  MLDETECTF_EURO_UTF8          = $80;

type
  // *********************************************************************//
  // Interface: IMLangConvertCharset
  // Flags:     (0)
  // GUID:      {D66D6F98-CDAA-11D0-B822-00C04FC9B31F}
  // *********************************************************************//
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IMLangConvertCharset);'}
  IMLangConvertCharset = interface(IUnknown)
    [SID_IMLangConvertCharset]
    function Initialize(uiSrcCodePage: UINT; uiDstCodePage: UINT; dwProperty: LongWord)
      : HResult; stdcall;
    function GetSourceCodePage(out puiSrcCodePage: UINT): HResult; stdcall;
    function GetDestinationCodePage(out puiDstCodePage: UINT): HResult; stdcall;
    function GetProperty(out pdwProperty: LongWord): HResult; stdcall;
    function DoConversion(pSrcStr: Pointer; pcSrcSize: PUINT; pDstStr: Pointer;
      var pcDstSize: UINT): HResult; stdcall;
    function DoConversionToUnicode(pSrcStr: Pointer; pcSrcSize: PUINT; pDstStr: PWideChar;
      var pcDstSize: UINT): HResult; stdcall;
    function DoConversionFromUnicode(pSrcStr: PWideChar; pcSrcSize: PUINT;
      pDstStr: Pointer; var pcDstSize: UINT): HResult; stdcall;
  end;

  // *********************************************************************//
  // Interface: IMultiLanguage
  // Flags:     (0)
  // GUID:      {275C23E1-3747-11D0-9FEA-00AA003F8646}
  // *********************************************************************//
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IMultiLanguage);'}
  IMultiLanguage = interface(IUnknown)
    [SID_IMultiLanguage]
    function GetNumberOfCodePageInfo(out pcCodePage: UINT): HResult; stdcall;
    function GetCodePageInfo(uiCodePage: UINT; out pCodePageInfo: tagMIMECPINFO)
      : HResult; stdcall;
    function GetFamilyCodePage(uiCodePage: UINT; out puiFamilyCodePage: UINT)
      : HResult; stdcall;
    function EnumCodePages(grfFlags: LongWord; out ppEnumCodePage: IEnumCodePage): HResult; stdcall;
    function GetCharsetInfo(const Charset: WideString; out pCharsetInfo: tagMIMECSETINFO)
      : HResult; stdcall;
    function IsConvertible(dwSrcEncoding: LongWord; dwDstEncoding: LongWord): HResult; stdcall;
    function ConvertString(var pdwMode: LongWord; dwSrcEncoding: LongWord; dwDstEncoding: LongWord;
      pSrcStr: Pointer; pcSrcSize: PUINT; pDstStr: Pointer; var pcDstSize: UINT)
      : HResult; stdcall;
    function ConvertStringToUnicode(var pdwMode: LongWord; dwEncoding: LongWord;
      pSrcStr: Pointer; pcSrcSize: PUINT; pDstStr: PWideChar; var pcDstSize: UINT)
      : HResult; stdcall;
    function ConvertStringFromUnicode(var pdwMode: LongWord; dwEncoding: LongWord;
      pSrcStr: PWideChar; pcSrcSize: PUINT; pDstStr: Pointer; var pcDstSize: UINT)
      : HResult; stdcall;
    function ConvertStringReset: HResult; stdcall;
    function GetRfc1766FromLcid(locale: LongWord; out pbstrRfc1766: WideString): HResult; stdcall;
    function GetLcidFromRfc1766(out plocale: LongWord; const bstrRfc1766: WideString)
      : HResult; stdcall;
    function EnumRfc1766(out ppEnumRfc1766: IEnumRfc1766): HResult; stdcall;
    function GetRfc1766Info(locale: LongWord; out pRfc1766Info: tagRFC1766INFO): HResult; stdcall;
    function CreateConvertCharset(uiSrcCodePage: UINT; uiDstCodePage: UINT;
      dwProperty: LongWord; out ppMLangConvertCharset: IMLangConvertCharset): HResult; stdcall;
  end;

{ dwfIODControl definitions for ValidateCodePageEx() }
const
  CPIOD_PEEK = $40000000;
  {$EXTERNALSYM CPIOD_PEEK}
  CPIOD_FORCE_PROMPT = $80000000;
  {$EXTERNALSYM CPIOD_FORCE_PROMPT}

  MLDETECTCP_NONE   = 0;
  MLDETECTCP_7BIT   = 1;
  MLDETECTCP_8BIT   = 2;
  MLDETECTCP_DBCS   = 4;
  MLDETECTCP_HTML   = 8;
  MLDETECTCP_NUMBER = 16;

type
  PDetectEncodingInfo = ^TDetectEncodingInfo;
  tagDetectEncodingInfo = record
    nLangID: UInt32;
    nCodePage: UInt32;
    nDocPercent: Int32;
    nConfidence: Int32
  end;
  {$EXTERNALSYM tagDetectEncodingInfo}
  TDetectEncodingInfo = tagDetectEncodingInfo;
  DetectEncodingInfo = tagDetectEncodingInfo;
  {$EXTERNALSYM DetectEncodingInfo}

const
  SCRIPTCONTF_FIXED_FONT        = $1;
  SCRIPTCONTF_PROPORTIONAL_FONT = $2;
  SCRIPTCONTF_SCRIPT_USER       = $10000;
  SCRIPTCONTF_SCRIPT_HIDE       = $20000;
  SCRIPTCONTF_SCRIPT_SYSTEM     = $40000;

type
  PScriptFontInfo = ^TScriptFontInfo;
  tagSCRIPFONTINFO = record                                                           
    scripts: TScriptIDs;
    wszFont: packed array[0..31] of WCHAR;
  end;
  {$EXTERNALSYM tagSCRIPFONTINFO}
  TScriptFontInfo = tagSCRIPFONTINFO;
  SCRIPTFONTINFO = tagSCRIPFONTINFO;
  {$EXTERNALSYM SCRIPTFONTINFO}

  // *********************************************************************//
  // Interface: IMultiLanguage2
  // Flags:     (0)
  // GUID:      {DCCFC164-2B38-11D2-B7EC-00C04F8F5D9A}
  // *********************************************************************//
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IMultiLanguage2);'}
  IMultiLanguage2 = interface(IUnknown)
    [SID_IMultiLanguage2]
    function GetNumberOfCodePageInfo(out pcCodePage: UINT): HResult; stdcall;
    function GetCodePageInfo(uiCodePage: UINT; LangId: Word; out pCodePageInfo: tagMIMECPINFO)
      : HResult; stdcall;
    function GetFamilyCodePage(uiCodePage: UINT; out puiFamilyCodePage: UINT)
      : HResult; stdcall;
    function EnumCodePages(grfFlags: LongWord; LangId: Word; out ppEnumCodePage: IEnumCodePage)
      : HResult; stdcall;
    function GetCharsetInfo(const Charset: WideString; out pCharsetInfo: tagMIMECSETINFO)
      : HResult; stdcall;
    function IsConvertible(dwSrcEncoding: LongWord; dwDstEncoding: LongWord): HResult; stdcall;
    function ConvertString(var pdwMode: LongWord; dwSrcEncoding: LongWord; dwDstEncoding: LongWord;
      pSrcStr: Pointer; pcSrcSize: PUINT; pDstStr: Pointer; var pcDstSize: UINT)
      : HResult; stdcall;
    function ConvertStringToUnicode(var pdwMode: LongWord; dwEncoding: LongWord;
      pSrcStr: Pointer; pcSrcSize: PUINT; pDstStr: PWideChar; var pcDstSize: UINT)
      : HResult; stdcall;
    function ConvertStringFromUnicode(var pdwMode: LongWord; dwEncoding: LongWord;
      pSrcStr: PWideChar; pcSrcSize: PUINT; pDstStr: Pointer; var pcDstSize: UINT)
      : HResult; stdcall;
    function ConvertStringReset: HResult; stdcall;
    function GetRfc1766FromLcid(locale: LongWord; out pbstrRfc1766: WideString): HResult; stdcall;
    function GetLcidFromRfc1766(out plocale: LongWord; const bstrRfc1766: WideString)
      : HResult; stdcall;
    function EnumRfc1766(LangId: Word; out ppEnumRfc1766: IEnumRfc1766): HResult; stdcall;
    function GetRfc1766Info(locale: LongWord; LangId: Word; out pRfc1766Info: tagRFC1766INFO)
      : HResult; stdcall;
    function CreateConvertCharset(uiSrcCodePage: UINT; uiDstCodePage: UINT;
      dwProperty: LongWord; out ppMLangConvertCharset: IMLangConvertCharset): HResult; stdcall;
    function ConvertStringInIStream(var pdwMode: LongWord; dwFlag: LongWord; lpFallBack: PWideChar;
      dwSrcEncoding: LongWord; dwDstEncoding: LongWord; const [ref] pstmIn: IStream;
      const [ref] pstmOut: IStream): HResult; stdcall;
    function ConvertStringToUnicodeEx(var pdwMode: LongWord; dwEncoding: LongWord;
      pSrcStr: Pointer; pcSrcSize: PUINT; pDstStr: PWideChar; var pcDstSize: UINT;
      dwFlag: LongWord; lpFallBack: PWideChar): HResult; stdcall;
    function ConvertStringFromUnicodeEx(var pdwMode: LongWord; dwEncoding: LongWord;
      pSrcStr: PWideChar; pcSrcSize: PUINT; pDstStr: Pointer; var pcDstSize: UINT;
      dwFlag: LongWord; lpFallBack: PWideChar): HResult; stdcall;
    function DetectCodepageInIStream(dwFlag: LongWord; dwPrefWinCodePage: LongWord;
      const [ref] pstmIn: IStream; lpEncoding: PDetectEncodingInfo; var pnScores: Integer)
      : HResult; stdcall;
   function DetectInputCodepage(dwFlag: LongWord; dwPrefWinCodePage: LongWord;
      pSrcStr: Pointer; var pcSrcSize: Integer; lpEncoding: PDetectEncodingInfo;
      var pnScores: Integer): HResult; stdcall;
    function ValidateCodePage(uiCodePage: UINT; hwnd: HWND): HResult; stdcall;
    function GetCodePageDescription(uiCodePage: UINT; lcid: LongWord; lpWideCharStr: PWideChar;
      cchWideChar: Integer): HResult; stdcall;
    function IsCodePageInstallable(uiCodePage: UINT): HResult; stdcall;
    function SetMimeDBSource(dwSource: UINT): HResult; stdcall;
    function GetNumberOfScripts(out pnScripts: UINT): HResult; stdcall;
    function EnumScripts(dwFlags: LongWord; LangId: Word; out ppEnumScript: IEnumScript)
      : HResult; stdcall;
    function ValidateCodePageEx(uiCodePage: UINT; hwnd: HWND;
      dwfIODControl: LongWord): HResult; stdcall;
  end;


  // *********************************************************************//
  // Interface: IMLangCodePages
  // Flags:     (0)
  // GUID:      {359F3443-BD4A-11D0-B188-00AA0038C969}
  // *********************************************************************//
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IMLangCodePages);'}
  IMLangCodePages = interface(IUnknown)
    [SID_IMLangCodePages]
    function GetCharCodePages(chSrc: WideChar; out pdwCodePages: LongWord): HResult; stdcall;
    function GetStrCodePages(pszSrc: PWideChar; cchSrc: Integer; dwPriorityCodePages: LongWord;
      out pdwCodePages: LongWord; out pcchCodePages: Integer): HResult; stdcall;
    function CodePageToCodePages(uCodePage: UINT; out pdwCodePages: LongWord): HResult; stdcall;
    function CodePagesToCodePage(dwCodePages: LongWord; uDefaultCodePage: UINT;
      out puCodePage: UINT): HResult; stdcall;
  end;

  // *********************************************************************//
  // Interface: IMLangFontLink
  // Flags:     (0)
  // GUID:      {359F3441-BD4A-11D0-B188-00AA0038C969}
  // *********************************************************************//
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IMLangFontLink);'}
  IMLangFontLink = interface(IMLangCodePages)
    [SID_IMLangFontLink]
    function GetFontCodePages(hDC: HDC; hFont: HFONT;
      out pdwCodePages: LongWord): HResult; stdcall;
    function MapFont(hDC: HDC; dwCodePages: LongWord;
      hSrcFont: HFONT; out phDestFont: HFONT): HResult; stdcall;                                                        
    function ReleaseFont(hFont: HFONT): HResult; stdcall;
    function ResetFontMapping: HResult; stdcall;
  end;

  PUnicodeRange = ^TUnicodeRange;
  tagUNICODERANGE = record
    wcFrom: WCHAR;
    wcTo: WCHAR;
  end;
  {$EXTERNALSYM tagUNICODERANGE}
  TUnicodeRange = tagUNICODERANGE;
  UNICODERANGE = tagUNICODERANGE;
  {$EXTERNALSYM UNICODERANGE}

  // *********************************************************************//
  // Interface: IMLangFontLink2
  // Flags:     (0)
  // GUID:      {DCCFC162-2B38-11D2-B7EC-00C04F8F5D9A}
  // *********************************************************************//
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IMLangFontLink2);'}
  IMLangFontLink2 = interface(IMLangCodePages)
    [SID_IMLangFontLink2]
    function GetFontCodePages(hDC: HDC; hFont: HFONT;
      out pdwCodePages: LongWord): HResult; stdcall;
    function ReleaseFont(hFont: HFONT): HResult; stdcall;
    function ResetFontMapping: HResult; stdcall;
    function MapFont(hDC: HDC; dwCodePages: LongWord; chSrc: WideChar;
      out pFont: HFONT): HResult; stdcall;                                                   
    function GetFontUnicodeRanges(hDC: HDC; var puiRanges: UINT;
      pUranges: PUnicodeRange): HResult; stdcall;
    function GetScriptFontInfo(sid: Byte; dwFlags: LongWord; var puiFonts: UINT;
      pScriptFont: PScriptFontInfo): HResult; stdcall;
    function CodePageToScriptID(uiCodePage: UINT; out pSid: Byte): HResult; stdcall;
  end;

  // *********************************************************************//
  // Interface: IMultiLanguage3
  // Flags:     (0)
  // GUID:      {4E5868AB-B157-4623-9ACC-6A1D9CAEBE04}
  // *********************************************************************//
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IMultiLanguage3);'}
  IMultiLanguage3 = interface(IMultiLanguage2)
    [SID_IMultiLanguage3]
    function DetectOutboundCodePage(dwFlags: LongWord; lpWideCharStr: PWideChar;
      cchWideChar: UINT; puiPreferredCodePages: PUINT; nPreferredCodePages: UINT;
      puiDetectedCodePages: PUINT; var pnDetectedCodePages: UINT; lpSpecialChar: PWideChar)
      : HResult; stdcall;
    function DetectOutboundCodePageInIStream(dwFlags: LongWord; const [ref] pStrIn: IStream;
      puiPreferredCodePages: PUINT; nPreferredCodePages: UINT;
      puiDetectedCodePages: PUINT; var pnDetectedCodePages: UINT; lpSpecialChar: PWideChar)
      : HResult; stdcall;
  end;

const
  MLSTR_READ  = 1;
  MLSTR_WRITE = 2;

  CLSID_CMLangString: TGUID = '{C04D65CF-B70D-11D0-B188-00AA0038C969}';
  {$EXTERNALSYM CLSID_CMLangString}
  CLSID_CMLangConvertCharset: TGUID = '{d66d6f99-cdaa-11d0-b822-00c04fc9b31f}';
  {$EXTERNALSYM CLSID_CMLangConvertCharset}
  CLSID_CMultiLanguage: TGUID = '{275c23e2-3747-11d0-9fea-00aa003f8646}';
  {$EXTERNALSYM CLSID_CMultiLanguage}


{ APIs prototypes                                                            }
function LcidToRfc1766(Local: LCID; ptszRfc1766: LPWSTR; iMaxLength: integer):LongInt; stdcall;
{$EXTERNALSYM LcidToRfc1766}
function LcidToRfc1766A(Local: LCID; ptszRfc1766: LPSTR; iMaxLength: integer):LongInt; stdcall;
{$EXTERNALSYM LcidToRfc1766A}
function LcidToRfc1766W(Local: LCID; ptszRfc1766: LPWSTR; iMaxLength: integer):LongInt; stdcall;
{$EXTERNALSYM LcidToRfc1766W}
function Rfc1766ToLcid(out pLocale:LCID; ptszRfc1766: LPCWSTR):LongInt; stdcall;
{$EXTERNALSYM Rfc1766ToLcid}
function Rfc1766ToLcidA(out pLocale:LCID; ptszRfc1766: LPCSTR):LongInt; stdcall;
{$EXTERNALSYM Rfc1766ToLcidA}
function Rfc1766ToLcidW(out pLocale:LCID; ptszRfc1766: LPCWSTR):LongInt; stdcall;
{$EXTERNALSYM Rfc1766ToLcidW}

function IsConvertINetStringAvailable(dwSrcEncoding: DWORD;
  dwDstEncoding: DWORD):LongInt; stdcall;
{$EXTERNALSYM IsConvertINetStringAvailable}

function ConvertINetString(lpdwMode: LPDWORD; dwSrcEncoding: DWORD;
  dwDstEncoding: DWORD; lpSrcStr: LPCSTR; lpnSrcSize: PINT; lpDstStr: LPSTR;
  lpnDstSize: PINT):LongInt; stdcall;
{$EXTERNALSYM ConvertINetString}

function ConvertINetMultiByteToUnicode( lpdwMode: LPDWORD; dwEncoding: DWORD;
  lpSrcStr: LPCSTR; lpnMultiCharCount: PINT; lpDstStr: LPWSTR;
  lpnWideCharCount: PINT):LongInt; stdcall;
{$EXTERNALSYM ConvertINetMultiByteToUnicode}

function ConvertINetUnicodeToMultiByte(lpdwMode: LPDWORD; dwEncoding: DWORD;
  lpSrcStr: LPCWSTR; lpnWideCharCount: PINT; lpDstStr: LPSTR;
  lpnMultiCharCount: PINT):LongInt; stdcall;
{$EXTERNALSYM ConvertINetUnicodeToMultiByte}

type
  // *********************************************************************//
  // Declaration of CoClasses defined in Type Library
  // (NOTE: Here we map each CoClass to its Default Interface)
  // *********************************************************************//
  CMLangString = IMLangString;
  CMLangConvertCharset = IMLangConvertCharset;
  CMultiLanguage = IMultiLanguage;

  // *********************************************************************//
  // The Class CoCMLangString provides a Create and CreateRemote method to
  // create instances of the default interface IMLangString exposed by
  // the CoClass CMLangString. The functions are intended to be used by
  // clients wishing to automate the CoClass objects exposed by the
  // server of this typelibrary.
  // *********************************************************************//
  CoCMLangString = class
    class function Create: IMLangString;
    class function CreateRemote(const MachineName: string): IMLangString;
  end;

  // *********************************************************************//
  // The Class CoCMLangConvertCharset provides a Create and CreateRemote method to
  // create instances of the default interface IMLangConvertCharset exposed by
  // the CoClass CMLangConvertCharset. The functions are intended to be used by
  // clients wishing to automate the CoClass objects exposed by the
  // server of this typelibrary.
  // *********************************************************************//
  CoCMLangConvertCharset = class
    class function Create: IMLangConvertCharset;
    class function CreateRemote(const MachineName: string): IMLangConvertCharset;
  end;

  // *********************************************************************//
  // The Class CoCMultiLanguage provides a Create and CreateRemote method to
  // create instances of the default interface IMultiLanguage exposed by
  // the CoClass CMultiLanguage. The functions are intended to be used by
  // clients wishing to automate the CoClass objects exposed by the
  // server of this typelibrary.
  // *********************************************************************//
  CoCMultiLanguage = class
    class function Create: IMultiLanguage;
    class function CreateRemote(const MachineName: string): IMultiLanguage;
  end;

  CoCMultiLanguage2 = class
    class function Create: IMultiLanguage2;
    class function CreateRemote(const MachineName: string): IMultiLanguage2;
  end;

  CoCMultiLanguage3 = class
    class function Create: IMultiLanguage3;
    class function CreateRemote(const MachineName: string): IMultiLanguage3;
  end;

implementation

uses System.Win.ComObj;

const
  ModName = 'MLANG.DLL';

function ConvertINetMultiByteToUnicode; external ModName name 'ConvertINetMultiByteToUnicode';
function ConvertINetString; external ModName name 'ConvertINetString';
function ConvertINetUnicodeToMultiByte; external ModName name 'ConvertINetUnicodeToMultiByte';
function IsConvertINetStringAvailable; external ModName name 'IsConvertINetStringAvailable';

function LcidToRfc1766; external ModName name 'LcidToRfc1766W';
function LcidToRfc1766A; external ModName name 'LcidToRfc1766A';
function LcidToRfc1766W; external ModName name 'LcidToRfc1766W';
function Rfc1766ToLcid; external ModName name 'Rfc1766ToLcidW';
function Rfc1766ToLcidA; external ModName name 'Rfc1766ToLcidA';
function Rfc1766ToLcidW; external ModName name 'Rfc1766ToLcidW';

class function CoCMLangString.Create: IMLangString;
begin
  Result := CreateComObject(CLSID_CMLangString) as IMLangString;
end;

class function CoCMLangString.CreateRemote(const MachineName: string): IMLangString;
begin
  Result := CreateRemoteComObject(MachineName, CLSID_CMLangString) as IMLangString;
end;

class function CoCMLangConvertCharset.Create: IMLangConvertCharset;
begin
  Result := CreateComObject(CLSID_CMLangConvertCharset) as IMLangConvertCharset;
end;

class function CoCMLangConvertCharset.CreateRemote(const MachineName: string): IMLangConvertCharset;
begin
  Result := CreateRemoteComObject(MachineName, CLSID_CMLangConvertCharset) as IMLangConvertCharset;
end;

class function CoCMultiLanguage.Create: IMultiLanguage;
begin
  Result := CreateComObject(CLSID_CMultiLanguage) as IMultiLanguage;
end;

class function CoCMultiLanguage.CreateRemote(const MachineName: string): IMultiLanguage;
begin
  Result := CreateRemoteComObject(MachineName, CLSID_CMultiLanguage) as IMultiLanguage;
end;

class function CoCMultiLanguage2.Create: IMultiLanguage2;
begin
  Result := CreateComObject(CLSID_CMultiLanguage) as IMultiLanguage2;
end;

class function CoCMultiLanguage2.CreateRemote(const MachineName: string): IMultiLanguage2;
begin
  Result := CreateRemoteComObject(MachineName, CLSID_CMultiLanguage) as IMultiLanguage2;
end;

class function CoCMultiLanguage3.Create: IMultiLanguage3;
begin
  Result := CreateComObject(CLSID_CMultiLanguage) as IMultiLanguage3;
end;

class function CoCMultiLanguage3.CreateRemote(const MachineName: string): IMultiLanguage3;
begin
  Result := CreateRemoteComObject(MachineName, CLSID_CMultiLanguage) as IMultiLanguage3;
end;

end.
