unit Color_Wrap;
 {* WColor }

// Модуль: "w:\common\components\rtl\Garant\K2\Color_Wrap.pas"
// Стереотип: "Wrapper"

{$Include k2Define.inc}

interface

uses
 l3IntfUses
 , Long_Wrap
 , k2Color_Const
 , l3Variant
;

type
 WColor = class(WLong)
  {* WColor }
  protected
   function AsString(A: Tl3Variant): AnsiString; override;
   function StrToTag(const aValue: AnsiString): Tl3Tag; override;
 end;//WColor

implementation

uses
 l3ImplUses
 , Graphics
 , k2Base
 , SysUtils
;

function WColor.AsString(A: Tl3Variant): AnsiString;
//#UC START# *484CCE970073_4849457201A4_var*
//#UC END# *484CCE970073_4849457201A4_var*
begin
//#UC START# *484CCE970073_4849457201A4_impl*
 if A.IsNull then
  Result := ''
 else
  Result := ColorToString(A.AsLong);
//#UC END# *484CCE970073_4849457201A4_impl*
end;//WColor.AsString

function WColor.StrToTag(const aValue: AnsiString): Tl3Tag;
//#UC START# *484CCEBC00DC_4849457201A4_var*

 function StringToColor(const S: string): TColor;
 begin//StringToColor
  if not IdentToColor(S, Longint(Result)) then
   if not IdentToColor('cl' + S, Longint(Result)) then
    Result := TColor(StrToInt(S));
 end;//StringToColor

//#UC END# *484CCEBC00DC_4849457201A4_var*
begin
//#UC START# *484CCEBC00DC_4849457201A4_impl*
 if (aValue = '') then
  Result := k2NullTag
 else
  Result := AtomType.MakeTag(StringToColor(aValue)).AsObject;
//#UC END# *484CCEBC00DC_4849457201A4_impl*
end;//WColor.StrToTag

end.
