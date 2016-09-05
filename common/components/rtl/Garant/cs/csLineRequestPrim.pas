unit csLineRequestPrim;

// Модуль: "w:\common\components\rtl\Garant\cs\csLineRequestPrim.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TcsLineRequestPrim" MUID: (53B683D900A9)

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , csRequestTask
 , k2Base
;

type
 TcsLineRequestPrim = class(TddRequestTask)
  public
   class function GetTaggedDataType: Tk2Type; override;
 end;//TcsLineRequestPrim
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 , LineRequest_Const
 //#UC START# *53B683D900A9impl_uses*
 //#UC END# *53B683D900A9impl_uses*
;

class function TcsLineRequestPrim.GetTaggedDataType: Tk2Type;
begin
 Result := k2_typLineRequest;
end;//TcsLineRequestPrim.GetTaggedDataType
{$IfEnd} // NOT Defined(Nemesis)

end.
