unit ddTaskResultRequestPrim;

// Модуль: "w:\common\components\rtl\Garant\cs\ddTaskResultRequestPrim.pas"
// Стереотип: "SimpleClass"

{$Include CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , askRequest
 , TaskResultRequest_Const
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
