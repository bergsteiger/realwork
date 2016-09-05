unit Enumeration_Wrap;
 {* WEnumeration }

// Модуль: "w:\common\components\rtl\Garant\K2\Enumeration_Wrap.pas"
// Стереотип: "Wrapper"
// Элемент модели: "WEnumeration" MUID: (484944E301AF)

{$Include w:\common\components\rtl\Garant\K2\k2Define.inc}

interface

uses
 l3IntfUses
 , Long_Wrap
 , l3Variant
;

type
 WEnumeration = class(WLong)
  {* WEnumeration }
  protected
   function AsString(A: Tl3Variant): AnsiString; override;
   function StrToTag(const aValue: AnsiString): Tl3Tag; override;
 end;//WEnumeration

implementation

uses
 l3ImplUses
 , TypInfo
 , k2Base
 , SysUtils
 //#UC START# *484944E301AFimpl_uses*
 //#UC END# *484944E301AFimpl_uses*
;

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
