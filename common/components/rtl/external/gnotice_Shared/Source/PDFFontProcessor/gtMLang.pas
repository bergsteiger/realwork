unit gtMLang;

interface

uses
 Classes, Windows, ComObj, ActiveX;

const
  CLASS_CMultiLanguage :TGUID = '{275c23e2-3747-11d0-9fea-00aa003f8646}';

type

  tagUNICODERANGE = record
   wcFrom: WChar;
   wcTo: WChar;
  end;

  UNICODERANGE = tagUNICODERANGE;

  PUNICODERANGE = ^UNICODERANGE;

  tagSCRIPFONTINFO = record
    scripts: Int64;
    wszFont: array[0..31] of WChar;
  end;

  SCRIPTFONTINFO = tagSCRIPFONTINFO;
  PSCRIPTFONTINFO = ^SCRIPTFONTINFO;

  PHFONT = ^HFONT;

  IMLangCodePages = interface
    ['{359F3443-BD4A-11D0-B188-00AA0038C969}']
    function GetCharCodePages(chSrc: WCHAR; pdwCodePages: PDWORD): HRESULT;stdcall;

    function GetStrCodePages(const pszSrc: PWCHAR; cchSrc: LongInt;
      dwPriorityCodePages: DWORD; pdwCodePages: PDWORD;
      pcchCodePages: PLongint): HRESULT; stdcall;

    function CodePageToCodePages(uCodePage: UInt; pdwCodePages: PDWord):
      HRESULT; stdcall;

    function CodePagesToCodePage(dwCodePages: DWord;
      uDefaultCodePage: UInt; puCodePage: PUint): HRESULT; stdcall;
  end;

  IMLangFontLink2 = interface(IMLangCodePages)
    ['{DCCFC162-2B38-11d2-B7EC-00C04F8F5D9A}']
    function GetFontCodePages(hDC: HDC; pFont: HFONT;
      pdwCodePages: PDWord): HRESULT; stdcall;

    function ReleaseFont(pFont: HFONT): HRESULT; stdcall;

    function ResetFontMapping: HRESULT; stdcall;

    function MapFont(hDC: HDC; dwCodePages: DWord; chSrc: WCHAR;
      pFont: PHFONT): HRESULT ; stdcall;

    function GetFontUnicodeRanges(hDC: HDC;
            puiRanges: PUINT;
            pUranges: PUNICODERANGE): HRESULT; stdcall;

    function GetScriptFontInfo(
             sid: Byte;
             dwFlags: DWord;
             puiFonts: PUINT;
             pScriptFont: PSCRIPTFONTINFO): HRESULT; stdcall;

    function CodePageToScriptID(uiCodePage: UINT;
      pSid: PByte): HRESULT; stdcall;
  end;

  CoMLangCodePages = class
    class function Create: IMLangCodePages;
  end;

  CoMLangFontLink2 = class
    class function Create: IMLangFontLink2;
  end;



implementation


{ CoMLangCodePages }

class function CoMLangCodePages.Create: IMLangCodePages;
begin
  Result := CreateComObject(CLASS_CMultiLanguage) as IMLangCodePages;
end;

{ CoMLangFontLink2 }

class function CoMLangFontLink2.Create: IMLangFontLink2;
begin
  Result := CreateComObject(CLASS_CMultiLanguage) as IMLangFontLink2;

end;

initialization
  CoInitialize(nil);

finalization
  CoUninitialize;

end.
