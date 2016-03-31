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
;

class function TddCaseCodeTaskPrim.GetTaggedDataType: Tk2Type;
//#UC START# *53AC03EE01FD_53BA6C3000F7_var*
//#UC END# *53AC03EE01FD_53BA6C3000F7_var*
begin
//#UC START# *53AC03EE01FD_53BA6C3000F7_impl*
 !!! Needs to be implemented !!!
//#UC END# *53AC03EE01FD_53BA6C3000F7_impl*
end;//TddCaseCodeTaskPrim.GetTaggedDataType
{$IfEnd} // NOT Defined(Nemesis)

end.
