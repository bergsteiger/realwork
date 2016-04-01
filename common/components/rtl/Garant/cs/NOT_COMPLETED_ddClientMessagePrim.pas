unit NOT_COMPLETED_ddClientMessagePrim;

// Модуль: "w:\common\components\rtl\Garant\cs\NOT_COMPLETED_ddClientMessagePrim.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TddClientMessagePrim" MUID: (53B24355031B)

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , csRequestTask
 , evdTaskTypes
 , k2Base
 , dt_Types
;

type
 TddClientMessagePrim = class(TddRequestTask)
  protected
   function pm_GetNotifyType: TCsNotificationType;
   procedure pm_SetNotifyType(aValue: TCsNotificationType);
   function pm_GetData: Integer;
   procedure pm_SetData(aValue: Integer);
   function pm_GetText: AnsiString;
   procedure pm_SetText(const aValue: AnsiString);
  public
   class function GetTaggedDataType: Tk2Type; override;
   constructor Create(aUserID: TUserID); override;
  public
   property NotifyType: TCsNotificationType
    read pm_GetNotifyType
    write pm_SetNotifyType;
   property Data: Integer
    read pm_GetData
    write pm_SetData;
   property Text: AnsiString
    read pm_GetText
    write pm_SetText;
 end;//TddClientMessagePrim
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 , ClientMessage_Const
;

function TddClientMessagePrim.pm_GetNotifyType: TCsNotificationType;
//#UC START# *D5D40492A4E1_53B24355031Bget_var*
//#UC END# *D5D40492A4E1_53B24355031Bget_var*
begin
//#UC START# *D5D40492A4E1_53B24355031Bget_impl*
 !!! Needs to be implemented !!!
//#UC END# *D5D40492A4E1_53B24355031Bget_impl*
end;//TddClientMessagePrim.pm_GetNotifyType

procedure TddClientMessagePrim.pm_SetNotifyType(aValue: TCsNotificationType);
//#UC START# *D5D40492A4E1_53B24355031Bset_var*
//#UC END# *D5D40492A4E1_53B24355031Bset_var*
begin
//#UC START# *D5D40492A4E1_53B24355031Bset_impl*
 !!! Needs to be implemented !!!
//#UC END# *D5D40492A4E1_53B24355031Bset_impl*
end;//TddClientMessagePrim.pm_SetNotifyType

function TddClientMessagePrim.pm_GetData: Integer;
//#UC START# *1457CD9A2878_53B24355031Bget_var*
//#UC END# *1457CD9A2878_53B24355031Bget_var*
begin
//#UC START# *1457CD9A2878_53B24355031Bget_impl*
 !!! Needs to be implemented !!!
//#UC END# *1457CD9A2878_53B24355031Bget_impl*
end;//TddClientMessagePrim.pm_GetData

procedure TddClientMessagePrim.pm_SetData(aValue: Integer);
//#UC START# *1457CD9A2878_53B24355031Bset_var*
//#UC END# *1457CD9A2878_53B24355031Bset_var*
begin
//#UC START# *1457CD9A2878_53B24355031Bset_impl*
 !!! Needs to be implemented !!!
//#UC END# *1457CD9A2878_53B24355031Bset_impl*
end;//TddClientMessagePrim.pm_SetData

function TddClientMessagePrim.pm_GetText: AnsiString;
//#UC START# *0D26EF9AE80B_53B24355031Bget_var*
//#UC END# *0D26EF9AE80B_53B24355031Bget_var*
begin
//#UC START# *0D26EF9AE80B_53B24355031Bget_impl*
 !!! Needs to be implemented !!!
//#UC END# *0D26EF9AE80B_53B24355031Bget_impl*
end;//TddClientMessagePrim.pm_GetText

procedure TddClientMessagePrim.pm_SetText(const aValue: AnsiString);
//#UC START# *0D26EF9AE80B_53B24355031Bset_var*
//#UC END# *0D26EF9AE80B_53B24355031Bset_var*
begin
//#UC START# *0D26EF9AE80B_53B24355031Bset_impl*
 !!! Needs to be implemented !!!
//#UC END# *0D26EF9AE80B_53B24355031Bset_impl*
end;//TddClientMessagePrim.pm_SetText

class function TddClientMessagePrim.GetTaggedDataType: Tk2Type;
//#UC START# *53AC03EE01FD_53B24355031B_var*
//#UC END# *53AC03EE01FD_53B24355031B_var*
begin
//#UC START# *53AC03EE01FD_53B24355031B_impl*
 !!! Needs to be implemented !!!
//#UC END# *53AC03EE01FD_53B24355031B_impl*
end;//TddClientMessagePrim.GetTaggedDataType

constructor TddClientMessagePrim.Create(aUserID: TUserID);
//#UC START# *53B3D8A8011F_53B24355031B_var*
//#UC END# *53B3D8A8011F_53B24355031B_var*
begin
//#UC START# *53B3D8A8011F_53B24355031B_impl*
 inherited;
 //TaskType := cs_ttClientMessage;
//#UC END# *53B3D8A8011F_53B24355031B_impl*
end;//TddClientMessagePrim.Create
{$IfEnd} // NOT Defined(Nemesis)

end.
