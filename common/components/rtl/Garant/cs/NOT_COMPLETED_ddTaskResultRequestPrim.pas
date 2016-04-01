unit NOT_COMPLETED_ddTaskResultRequestPrim;

// Модуль: "w:\common\components\rtl\Garant\cs\NOT_COMPLETED_ddTaskResultRequestPrim.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TddTaskResultRequestPrim" MUID: (53B6855302D9)

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , askRequest
 , k2Base
;

type
 TddTaskResultRequestPrim = class(TaskRequest)
  public
   class function GetTaggedDataType: Tk2Type; override;
 end;//TddTaskResultRequestPrim
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 , TaskResultRequest_Const
;

class function TddTaskResultRequestPrim.GetTaggedDataType: Tk2Type;
//#UC START# *53AC03EE01FD_53B6855302D9_var*
//#UC END# *53AC03EE01FD_53B6855302D9_var*
begin
//#UC START# *53AC03EE01FD_53B6855302D9_impl*
 !!! Needs to be implemented !!!
//#UC END# *53AC03EE01FD_53B6855302D9_impl*
end;//TddTaskResultRequestPrim.GetTaggedDataType
{$IfEnd} // NOT Defined(Nemesis)

end.
