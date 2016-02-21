unit ncsSendTask;

// Модуль: "w:\common\components\rtl\Garant\cs\ncsSendTask.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , ncsMessage
 , csSendTask_Const
 , k2SizedMemoryPool
 , k2Base
;

type
 TncsSendTask = class(TncsMessage)
  protected
   function pm_GetData: Tk2RawData;
   procedure pm_SetData(aValue: Tk2RawData);
  public
   class function GetTaggedDataType: Tk2Type; override;
  public
   property Data: Tk2RawData
    read pm_GetData
    write pm_SetData;
 end;//TncsSendTask
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
;

function TncsSendTask.pm_GetData: Tk2RawData;
//#UC START# *8E4295A820EB_54855C2F0088get_var*
//#UC END# *8E4295A820EB_54855C2F0088get_var*
begin
//#UC START# *8E4295A820EB_54855C2F0088get_impl*
 !!! Needs to be implemented !!!
//#UC END# *8E4295A820EB_54855C2F0088get_impl*
end;//TncsSendTask.pm_GetData

procedure TncsSendTask.pm_SetData(aValue: Tk2RawData);
//#UC START# *8E4295A820EB_54855C2F0088set_var*
//#UC END# *8E4295A820EB_54855C2F0088set_var*
begin
//#UC START# *8E4295A820EB_54855C2F0088set_impl*
 !!! Needs to be implemented !!!
//#UC END# *8E4295A820EB_54855C2F0088set_impl*
end;//TncsSendTask.pm_SetData

class function TncsSendTask.GetTaggedDataType: Tk2Type;
//#UC START# *53AC03EE01FD_54855C2F0088_var*
//#UC END# *53AC03EE01FD_54855C2F0088_var*
begin
//#UC START# *53AC03EE01FD_54855C2F0088_impl*
 !!! Needs to be implemented !!!
//#UC END# *53AC03EE01FD_54855C2F0088_impl*
end;//TncsSendTask.GetTaggedDataType
{$IfEnd} // NOT Defined(Nemesis)

end.
