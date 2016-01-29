unit nsLanguageMap;
{* реализация мапы "строка"-"строка" }

// $Log: nsLanguageMap.pas,v $
// Revision 1.8  2013/10/25 07:21:22  morozov
// {RequestLink: 495815045}
//
// Revision 1.7  2013/10/25 07:15:34  morozov
// {RequestLink: 495815045}
//
// Revision 1.6  2013/04/25 13:21:02  morozov
// {$RequestLink:363571639}
//
// Revision 1.5  2009/02/20 12:25:12  lulin
// - <K>: 136941122.
//
// Revision 1.4  2009/02/10 15:43:25  lulin
// - <K>: 133891247. Выделяем интерфейсы локализации.
//
// Revision 1.3  2008/10/02 11:46:43  oman
// - fix: Не рисовались на 98 (К-120721126)
//
// Revision 1.2  2008/10/01 11:54:01  oman
// - fix: Меняем раскладку клавиатуры (К-120718336)
//
// Revision 1.1.2.1  2008/10/01 11:48:33  oman
// - fix: Меняем раскладку клавиатуры (К-120718336)
//
//

{$Include nsDefine.inc }

interface

uses
  Classes,

  l3Interfaces,
  l3BaseWithID,
  l3ValueMap,
  l3Types,
  l3Tree_TLB,
  l3TreeInterfaces,

  vcmExternalInterfaces,
  vcmInterfaces,

  L10nInterfaces
  ;

type
 TnsLanguageMap = class(Tl3ValueMap,
                        InsStringValueMap,
                        InsStringsSource)
 private
  // Il3IntegerValueMap
  function DisplayNameToValue(const aDisplayName: Il3CString): Il3CString;
  function ValueToDisplayName(const aValue: Il3CString): Il3CString;
  // InsStringsSource
  procedure FillStrings(const aStrings: IvcmStrings);
 protected
  procedure DoGetDisplayNames(const aList: Il3StringsEx);
   override;
  function GetMapSize: Integer;
   override;
 public
  class function Make(const aID: TnsValueMapID): InsStringValueMap;
 end;//TnsLanguageMap

implementation

uses
  SysUtils,
  Windows,

  l3Base,
  l3String,
  l3Nodes,

  afwFacade,

  vcmBase,

  nsValueMapsIDs,
  nsValueMaps,
  SystemStr
  ;

{ TnsStringValueMap }

function TnsLanguageMap.DisplayNameToValue(const aDisplayName: Il3CString): Il3CString;
  {-}
begin
 Result := l3CStr(li_il_Russian);
end;

procedure TnsLanguageMap.FillStrings(const aStrings: IvcmStrings);
begin
 aStrings.Clear;
 aStrings.Add(ValueToDisplayName(nil));
end;

procedure TnsLanguageMap.DoGetDisplayNames(const aList: Il3StringsEx);
begin
 aList.Clear;
 aList.Add(ValueToDisplayName(nil));
end;

function TnsLanguageMap.GetMapSize: Integer;
begin
 Result := 1;
end;

function TnsLanguageMap.ValueToDisplayName(const aValue: Il3CString): Il3CString;

 function lp_FiltrateStr(const aString: WideString): WideString;
 const
  cTerminatingZeroCharW : WideChar = #0;
 var
  l_Index: Integer;
 begin
  l_Index := 1;
  for l_Index := 1 to Length(aString) do
   if (aString[l_Index] <> cTerminatingZeroCharW) then
    Result := Result + aString[l_Index]
   else
    Exit;
 end;//lp_FiltrateStr

const
 // Константа для Vista+ вместо LOCALE_SLANGUAGE
 LC_LOCALE_SLOCALIZEDLANGUAGENAME = $0000006f;
 // Константа для W7+ вместо LOCALE_SNATIVELANGNAME
 LC_LOCALE_SNATIVELANGUAGENAME = $00000004;
var
 l_Size: Cardinal;
 l_Locale: LCID;
 l_UnicodeText: WideString;
 l_Text: String;
 l_FlagLangFullLocalized,
 l_FlagLangNative: LCTYPE;
 l_WindowsVersion: DWORD;
 l_AnsiText : String;
begin
 l_Locale := afw.Application.LocaleInfo.ID;
 if Win32Platform = VER_PLATFORM_WIN32_WINDOWS then
 begin
  l_Size := GetLocaleInfoA(l_Locale, LOCALE_SLANGUAGE, nil, 0);
 SetLength(l_Text, l_Size + 1);
  GetLocaleInfoA(l_Locale, LOCALE_SNATIVELANGNAME , PAnsiChar(l_Text), l_Size);
 Result := l3CStr(l_Text);
 end
 else
 begin
  // В W7 GetLocaleInfoW с флагом LOCALE_SLANGUAGE возвращает неверное
  // число символов для названия языка (в 2 раза больше) - K363571639
  // LOCALE_SLANGUAGE - deprecated в Vista и выше
  l_WindowsVersion := GetVersion;

  l_FlagLangNative := LOCALE_SNATIVELANGNAME;
  if (LOBYTE(LOWORD(l_WindowsVersion)) >= 6) then
  begin
   l_FlagLangFullLocalized := LC_LOCALE_SLOCALIZEDLANGUAGENAME;
   // В W7 и выше LOCALE_SNATIVELANGNAME - deprecated
   if (HIBYTE(LOWORD(l_WindowsVersion)) >= 1) then
    l_FlagLangNative := LC_LOCALE_SNATIVELANGUAGENAME;
  end
  else
   l_FlagLangFullLocalized := LOCALE_SLANGUAGE;

  l_Size := GetLocaleInfoW(l_Locale, l_FlagLangFullLocalized, nil, 0);
  SetLength(l_UnicodeText, l_Size);
  GetLocaleInfoW(l_Locale, l_FlagLangNative, PWideChar(l_UnicodeText), l_Size);
  // MSDN: If the function succeeds and the value of cchData is 0,
  // the return value is the required size, in characters including a null
  // character, for the locale data buffer.
  // - а вот и нет. Возвращает GetLocaleInfo на W7 упорно размер в байтах, на XP -
  // в символах.
  // http://mdp.garant.ru/pages/viewpage.action?pageId=495815045
  l_AnsiText := lp_FiltrateStr(l_UnicodeText);
  Result := l3CStr(l_AnsiText);
 end;
end;

class function TnsLanguageMap.Make(const aID: TnsValueMapID): InsStringValueMap;
var
 l_Map: TnsLanguageMap;
begin
 l_Map := Create(aID);
 try
  Result := l_Map;
 finally
  vcmFree(l_Map);
 end;
end;

end.

