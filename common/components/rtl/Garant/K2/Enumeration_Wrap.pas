unit Enumeration_Wrap;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "K2"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/K2/Enumeration_Wrap.pas"
// Начат: 07.09.1998 12:46
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Wrapper::Class>> Shared Delphi::K2::Standard::WEnumeration
//
// WEnumeration
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\K2\k2Define.inc}

interface

uses
  Long_Wrap,
  l3Variant
  ;

type
 WEnumeration = class(WLong)
  {* WEnumeration }
 protected
 // overridden protected methods
   function AsString(A: Tl3Variant): AnsiString; override;
   function StrToTag(const aValue: AnsiString): Tl3Tag; override;
 end;//WEnumeration

implementation

uses
  TypInfo,
  k2Base,
  SysUtils
  ;

// start class WEnumeration

function WEnumeration.AsString(A: Tl3Variant): AnsiString;
//#UC START# *484CCE970073_484944E301AF_var*
var
 l_AT : PTypeInfo;
 l_V  : Integer;
//#UC END# *484CCE970073_484944E301AF_var*
begin
//#UC START# *484CCE970073_484944E301AF_impl*
 if A.IsNull then
  Result := ''
 else
 begin
  l_AT := AtomType.AtomType;
  l_V := A.AsLong;
  with GetTypeData(l_AT)^ do
   if (l_V >= MinValue) AND (l_V <= MaxValue) then
    Result := GetEnumName(l_AT, l_V)
   else
    Result := IntToStr(l_V);
 end;//A.IsNull
//#UC END# *484CCE970073_484944E301AF_impl*
end;//WEnumeration.AsString

function WEnumeration.StrToTag(const aValue: AnsiString): Tl3Tag;
//#UC START# *484CCEBC00DC_484944E301AF_var*
var
 L : Integer;
//#UC END# *484CCEBC00DC_484944E301AF_var*
begin
//#UC START# *484CCEBC00DC_484944E301AF_impl*
 if (aValue = '') then
  Result := k2NullTag
 else
 begin
  L := GetEnumValue(AtomType.AtomType, aValue);
  if (L >= 0) then
   Result := AtomType.MakeTag(L).AsObject
  else
   Result := inherited StrToTag(aValue);
 end;//aValue = ''
//#UC END# *484CCEBC00DC_484944E301AF_impl*
end;//WEnumeration.StrToTag

end.