unit ddServerStatusRequestPrim;

// Модуль: "w:\common\components\rtl\Garant\cs\ddServerStatusRequestPrim.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TddServerStatusRequestPrim" MUID: (53B6843E03A3)

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , csRequestTask
 , k2Base
;

type
 TddServerStatusRequestPrim = class(TddRequestTask)
  public
   class function GetTaggedDataType: Tk2Type; override;
 end;//TddServerStatusRequestPrim
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 , ServerStatusRequest_Const
;

class function TddServerStatusRequestPrim.GetTaggedDataType: Tk2Type;
//#UC START# *53AC03EE01FD_53B6843E03A3_var*
//#UC END# *53AC03EE01FD_53B6843E03A3_var*
begin
//#UC START# *53AC03EE01FD_53B6843E03A3_impl*
 !!! Needs to be implemented !!!
//#UC END# *53AC03EE01FD_53B6843E03A3_impl*
end;//TddServerStatusRequestPrim.GetTaggedDataType
{$IfEnd} // NOT Defined(Nemesis)

end.
