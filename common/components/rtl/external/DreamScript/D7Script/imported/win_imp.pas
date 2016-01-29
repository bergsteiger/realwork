{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit win_imp;

interface
{$I dc.inc}
uses
  classes,
  dcscript,
  dcsystem,
  Windows,
  messages,
  richedit;

implementation
type

  __DC__TSendMessageA = function (hWnd : hWnd;
  Msg : UINT;
  wparam : wparam;
  lParam : lParam): LRESULT of object;
  __DC__TSendMessageW = function (hWnd : hWnd;
  Msg : UINT;
  wparam : wparam;
  lParam : lParam): LRESULT of object;
  __DC__TSendMessage = function (hWnd : hWnd;
  Msg : UINT;
  wparam : wparam;
  lParam : lParam): LRESULT of object;

__GetFontNames =  procedure(AStrings:TStrings) of object;

function _EnumFontsProc(var LogFont: TLogFont; var TextMetric: TTextMetric;
  FontType: Integer; Data: Pointer): Integer; stdcall;
begin
  TStrings(Data).Add(LogFont.lfFaceName);
  Result := 1;
end;

procedure GetFontNames(AStrings:TStrings);
var
  DC: HDC;
begin
  DC := GetDC(0);
  EnumFonts(DC, nil, @_EnumFontsProc, Pointer(AStrings));
  ReleaseDC(0, DC);
end;

initialization

  RegisterProc(nil,'SendMessageA',mtProc,TypeInfo(__DC__TSendMessageA),[
  TypeInfo(hWnd),
  TypeInfo(UINT),
  TypeInfo(wparam),
  TypeInfo(lParam),TypeInfo(LRESULT)],Addr(SendMessageA),cStdCall);
  RegisterProc(nil,'SendMessageW',mtProc,TypeInfo(__DC__TSendMessageW),[
  TypeInfo(hWnd),
  TypeInfo(UINT),
  TypeInfo(wparam),
  TypeInfo(lParam),TypeInfo(LRESULT)],Addr(SendMessageW),cStdCall);
  RegisterProc(nil,'SendMessage',mtProc,TypeInfo(__DC__TSendMessage),[
  TypeInfo(hWnd),
  TypeInfo(UINT),
  TypeInfo(wparam),
  TypeInfo(lParam),TypeInfo(LRESULT)],Addr(SendMessage),cStdCall);
  RegisterProc(nil,'GetFontNames',mtProc, TypeInfo(__GetFontNames),[
  TypeInfo(TStrings)] ,Addr(GetFontNames),CRegister);

  RegisterConst('EM_UNDO',EM_UNDO);
  RegisterConst('EM_CANUNDO',EM_CANUNDO);
  RegisterConst('EM_EXLINEFROMCHAR',EM_EXLINEFROMCHAR);
  RegisterConst('EM_LINEINDEX',EM_LINEINDEX);


  RegisterConst('HELP_CONTENTS',HELP_CONTENTS);
  RegisterConst('HELP_PARTIALKEY',HELP_PARTIALKEY);
  RegisterConst('HELP_HELPONHELP',HELP_HELPONHELP);

end.
