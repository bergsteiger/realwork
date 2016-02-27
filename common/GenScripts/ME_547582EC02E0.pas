unit ncsDeliveryResult;

// Модуль: "w:\common\components\rtl\Garant\cs\ncsDeliveryResult.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , ncsMessage
 , evdNcsTypes
 , k2Base
;

type
 TncsDeliveryResult = class(TncsMessage)
  protected
   function pm_GetTaskID: AnsiString;
   procedure pm_SetTaskID(const aValue: AnsiString);
   function pm_GetResultKind: TncsResultKind;
   procedure pm_SetResultKind(aValue: TncsResultKind);
  public
   class function GetTaggedDataType: Tk2Type; override;
  public
   property TaskID: AnsiString
    read pm_GetTaskID
    write pm_SetTaskID;
   property ResultKind: TncsResultKind
    read pm_GetResultKind
    write pm_SetResultKind;
 end;//TncsDeliveryResult
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 , csDeliveryResult_Const
;

function TncsDeliveryResult.pm_GetTaskID: AnsiString;
//#UC START# *AD27C71E2468_547582EC02E0get_var*
//#UC END# *AD27C71E2468_547582EC02E0get_var*
begin
//#UC START# *AD27C71E2468_547582EC02E0get_impl*
 !!! Needs to be implemented !!!
//#UC END# *AD27C71E2468_547582EC02E0get_impl*
end;//TncsDeliveryResult.pm_GetTaskID

procedure TncsDeliveryResult.pm_SetTaskID(const aValue: AnsiString);
//#UC START# *AD27C71E2468_547582EC02E0set_var*
//#UC END# *AD27C71E2468_547582EC02E0set_var*
begin
//#UC START# *AD27C71E2468_547582EC02E0set_impl*
 !!! Needs to be implemented !!!
//#UC END# *AD27C71E2468_547582EC02E0set_impl*
end;//TncsDeliveryResult.pm_SetTaskID

function TncsDeliveryResult.pm_GetResultKind: TncsResultKind;
//#UC START# *D70695E16D88_547582EC02E0get_var*
//#UC END# *D70695E16D88_547582EC02E0get_var*
begin
//#UC START# *D70695E16D88_547582EC02E0get_impl*
 !!! Needs to be implemented !!!
//#UC END# *D70695E16D88_547582EC02E0get_impl*
end;//TncsDeliveryResult.pm_GetResultKind

procedure TncsDeliveryResult.pm_SetResultKind(aValue: TncsResultKind);
//#UC START# *D70695E16D88_547582EC02E0set_var*
//#UC END# *D70695E16D88_547582EC02E0set_var*
begin
//#UC START# *D70695E16D88_547582EC02E0set_impl*
 !!! Needs to be implemented !!!
//#UC END# *D70695E16D88_547582EC02E0set_impl*
end;//TncsDeliveryResult.pm_SetResultKind

class function TncsDeliveryResult.GetTaggedDataType: Tk2Type;
//#UC START# *53AC03EE01FD_547582EC02E0_var*
//#UC END# *53AC03EE01FD_547582EC02E0_var*
begin
//#UC START# *53AC03EE01FD_547582EC02E0_impl*
 !!! Needs to be implemented !!!
//#UC END# *53AC03EE01FD_547582EC02E0_impl*
end;//TncsDeliveryResult.GetTaggedDataType
{$IfEnd} // NOT Defined(Nemesis)

end.
