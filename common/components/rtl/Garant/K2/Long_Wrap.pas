unit Long_Wrap;
 {* WLong }

// Модуль: "w:\common\components\rtl\Garant\K2\Long_Wrap.pas"
// Стереотип: "Wrapper"
// Элемент модели: "WLong" MUID: (4849423C0299)

{$Include w:\common\components\rtl\Garant\K2\k2Define.inc}

interface

uses
 l3IntfUses
 , k2Base
 , l3Variant
;

type
 WLong = class(Wk2Atom)
  {* WLong }
  protected
   function AsString(A: Tl3Variant): AnsiString; override;
 end;//WLong

implementation

uses
 l3ImplUses
 , SysUtils
 , l3Const
 //#UC START# *4849423C0299impl_uses*
 //#UC END# *4849423C0299impl_uses*
;

function WLong.AsString(A: Tl3Variant): AnsiString;
//#UC START# *484CCE970073_4849423C0299_var*
//#UC END# *484CCE970073_4849423C0299_var*
begin
//#UC START# *484CCE970073_4849423C0299_impl*
 if A.IsNull then
  Result := ''
 else
  Result := IntToStr(A.AsLong);
//#UC END# *484CCE970073_4849423C0299_impl*
end;//WLong.AsString

end.
