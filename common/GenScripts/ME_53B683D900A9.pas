unit csLineRequestPrim;

// Модуль: "w:\common\components\rtl\Garant\cs\csLineRequestPrim.pas"
// Стереотип: "SimpleClass"

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
;

class function TcsLineRequestPrim.GetTaggedDataType: Tk2Type;
//#UC START# *53AC03EE01FD_53B683D900A9_var*
//#UC END# *53AC03EE01FD_53B683D900A9_var*
begin
//#UC START# *53AC03EE01FD_53B683D900A9_impl*
 !!! Needs to be implemented !!!
//#UC END# *53AC03EE01FD_53B683D900A9_impl*
end;//TcsLineRequestPrim.GetTaggedDataType
{$IfEnd} // NOT Defined(Nemesis)

end.
