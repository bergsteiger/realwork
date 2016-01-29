unit Langs;

interface

uses
  Windows, SysUtils, Graphics, Classes;

type
  TLanguage = 0..$FFFF;

  TLangOption = (loLocalized, loEnglish, loNative, loAbbrev);

function LanguageName(Language: TLanguage): String;
function CharSetFromLocale(Language: TLanguage): TFontCharSet;
function CodePageFromLocale(Language: TLanguage): Integer;

{$IfDef DisignTime}
procedure Register;
{$EndIf DisignTime}

implementation

{$IfDef DisignTime}

uses
  DsgnIntf;

type
  TLanguageProperty = class(TIntegerProperty)
  public
    function GetAttributes: TPropertyAttributes; override;
    function GetValue: string; override;
    procedure GetValues(Proc: TGetStrProc); override;
    procedure SetValue(const Value: string); override;
  end;

procedure Register;
begin
  RegisterPropertyEditor(TypeInfo(TLanguage), nil, '', TLanguageProperty);
end;

{$EndIf DisignTime}

function LanguageName(Language: TLanguage): String;
var
  Buf: array[0..255] of Char;
begin
  GetLocaleInfo(Language, LOCALE_SLanguage, Buf, 255);
  Result:= StrPas(Buf);
end;

function CodePageFromLocale(Language: TLanguage): Integer;
var
  Buf: array[0..6] of Char;
begin
  GetLocaleInfo(Language, LOCALE_IDefaultAnsiCodePage, Buf, 6);
  Result:= StrToIntDef(Buf, GetACP);
end;

function CharSetFromLocale(Language: TLanguage): TFontCharSet;
var
  CP: Integer;
begin
  CP:= CodePageFromLocale(Language);
{ The proper solution is to use TranslateCharsetInfo. This function
  is described to be exported from user32.dll, but this works
  only in Windows NT. In Windows 95 this function is absent. So...
}
  case CP of
  1250:
    Result:= EastEurope_CharSet;
  1251:
    Result:= Russian_CharSet;
  1252:
    Result:= Ansi_CharSet;
  1253:
    Result:= Turkish_CharSet;
  1254:
    Result:= Greek_CharSet;
  1255:
    Result:= Hebrew_CharSet;
  1256:
    Result:= Arabic_CharSet;
  1257:
    Result:= Baltic_CharSet;
  1258:
    Result:= Vietnamese_CharSet;
  end;
end;

function LanguageToIdent(Language: Longint; var Ident: string): Boolean;
var
  Buf: array[0..255]of Char;
begin
  Result:= IsValidLocale(Language, LCID_INSTALLED);
  if Result then
    begin
      GetLocaleInfo(Language, LOCALE_SLANGUAGE, Buf, 255);
      SetString(Ident, Buf, StrLen(Buf));
    end;
end;

var
  SearchId: String;
  SearchLang: Integer;
  LCType: Integer;

function EnumGetLang(LocaleStr: LPSTR): Integer;
stdcall;
var
  Buf: array[0..255]of Char;
  Locale: LCID;
  Z: Integer;
begin
  Val('$'+StrPas(LocaleStr), Locale, Z);
  Result:= 1;
  GetLocaleInfo(Locale, LCType, Buf, 255);
  if AnsiCompareText(SearchId, Buf)=0 then
    begin
      SearchLang:= Locale;
      Result:= 0;
    end;
end;

function IdentToLanguage(const Ident: string; var Language: Longint): Boolean;
begin
  SearchId:= Ident;
  SearchLang:= -1;
  LCType:= LOCALE_SLANGUAGE;
  EnumSystemLocales(@EnumGetLang, LCID_INSTALLED);
  if SearchLang<0 then
    begin
      LCType:= LOCALE_SENGLANGUAGE;
      EnumSystemLocales(@EnumGetLang, LCID_INSTALLED);
    end;
  if SearchLang<0 then
    begin
      LCType:= LOCALE_SABBREVLANGNAME;
      EnumSystemLocales(@EnumGetLang, LCID_INSTALLED);
    end;
  Result:= SearchLang>-1;
  if Result then
    Language:= SearchLang;
end;

{$IfDef DisignTime}

function TLanguageProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paMultiSelect, paSortList, paValueList];
end;

function TLanguageProperty.GetValue: string;
begin
  if not LanguageToIdent(TLanguage(GetOrdValue), Result) then
    FmtStr(Result, '%d', [GetOrdValue]);
end;

var
  GetStrProc: TGetStrProc;

function EnumGetValues(LocaleStr: LPSTR): Integer;
stdcall;
var
  Buf: array[0..255]of Char;
  Locale: LCID;
  Z: Integer;
begin
  Val('$'+StrPas(LocaleStr), Locale, Z);
  GetLocaleInfo(Locale, LOCALE_SLANGUAGE, Buf, 255);
  GetStrProc(Buf);
  Result:= 1;
end;

procedure TLanguageProperty.GetValues(Proc: TGetStrProc);
begin
  GetStrProc:= Proc;
  EnumSystemLocales(@EnumGetValues, LCID_INSTALLED);
end;

procedure TLanguageProperty.SetValue(const Value: string);
var
  NewValue: Longint;
begin
  if IdentToLanguage(Value, NewValue) then
    SetOrdValue(NewValue)
  else inherited SetValue(Value);
end;

{$EndIf DisignTime}

end.
