unit ddCaseCodeTaskPrim;

// Модуль: "w:\common\components\rtl\Garant\cs\ddCaseCodeTaskPrim.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TddCaseCodeTaskPrim" MUID: (53BA6C3000F7)

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , csExport
 , k2Base
;

type
 TddCaseCodeTaskPrim = class(TcsExport)
  public
   class function GetTaggedDataType: Tk2Type; override;
 end;//TddCaseCodeTaskPrim
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 , CaseCodeTask_Const
 //#UC START# *53BA6C3000F7impl_uses*
 //#UC END# *53BA6C3000F7impl_uses*
;

class function TddCaseCodeTaskPrim.GetTaggedDataType: Tk2Type;
begin
 Result := k2_typCaseCodeTask;
end;//TddCaseCodeTaskPrim.GetTaggedDataType
{$IfEnd} // NOT Defined(Nemesis)

end.
