unit ncsGetReadyToDeliveryTasks;

// Модуль: "w:\common\components\rtl\Garant\cs\ncsGetReadyToDeliveryTasks.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , ncsMessage
 , csGetReadyToDeliveryTasks_Const
 , k2Base
;

type
 TncsGetReadyToDeliveryTasks = class(TncsMessage)
  protected
   function pm_GetUserID: Cardinal;
   procedure pm_SetUserID(aValue: Cardinal);
  public
   class function GetTaggedDataType: Tk2Type; override;
  public
   property UserID: Cardinal
    read pm_GetUserID
    write pm_SetUserID;
 end;//TncsGetReadyToDeliveryTasks
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
;

function TncsGetReadyToDeliveryTasks.pm_GetUserID: Cardinal;
//#UC START# *A01DBECFE7E7_54645DEC03E4get_var*
//#UC END# *A01DBECFE7E7_54645DEC03E4get_var*
begin
//#UC START# *A01DBECFE7E7_54645DEC03E4get_impl*
 !!! Needs to be implemented !!!
//#UC END# *A01DBECFE7E7_54645DEC03E4get_impl*
end;//TncsGetReadyToDeliveryTasks.pm_GetUserID

procedure TncsGetReadyToDeliveryTasks.pm_SetUserID(aValue: Cardinal);
//#UC START# *A01DBECFE7E7_54645DEC03E4set_var*
//#UC END# *A01DBECFE7E7_54645DEC03E4set_var*
begin
//#UC START# *A01DBECFE7E7_54645DEC03E4set_impl*
 !!! Needs to be implemented !!!
//#UC END# *A01DBECFE7E7_54645DEC03E4set_impl*
end;//TncsGetReadyToDeliveryTasks.pm_SetUserID

class function TncsGetReadyToDeliveryTasks.GetTaggedDataType: Tk2Type;
//#UC START# *53AC03EE01FD_54645DEC03E4_var*
//#UC END# *53AC03EE01FD_54645DEC03E4_var*
begin
//#UC START# *53AC03EE01FD_54645DEC03E4_impl*
 !!! Needs to be implemented !!!
//#UC END# *53AC03EE01FD_54645DEC03E4_impl*
end;//TncsGetReadyToDeliveryTasks.GetTaggedDataType
{$IfEnd} // NOT Defined(Nemesis)

end.
