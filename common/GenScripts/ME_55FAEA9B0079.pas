unit bsConsultationManager;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Consultation\bsConsultationManager.pas"
// Стереотип: "UtilityPack"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , bsInterfaces
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , bsTypes
 , l3Interfaces
 , l3NotifyPtrList
;

type
 _l3Notifier_Parent_ = TvcmBase;
 {$Include l3Notifier.imp.pas}
 TbsConsultationManager = {final} class(_l3Notifier_, IbsConsultationManager, Il3ChangeNotifier)
  private
   f_Unread: Integer;
   f_CurrentStatus: TbsConsultationOperations;
  private
   procedure UpdateUnread;
  protected
   function As_Il3ChangeNotifier: Il3ChangeNotifier;
    {* Метод приведения нашего интерфейса к Il3ChangeNotifier }
   procedure UnreadChanged;
    {* изменилось количество не прочтенных }
   procedure NoConnection;
    {* нет доступа к серверу консультаций }
   procedure NoSubscription;
    {* у пользователя нет доступа к сервису консультаций }
   procedure InternetConnected;
   function pm_GetHasUnread: Boolean;
   procedure InternetDisConnected;
   function pm_GetCurrentStatus: TbsConsultationOperations;
  public
   constructor Create; reintroduce;
   class function Make: IbsConsultationManager; reintroduce;
 end;//TbsConsultationManager

function g__ConsultationManager: IbsConsultationManager;
function IsConsultationManagerAssigned: Boolean;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , DataAdapter
 , l3Base
 , SysUtils
;

var gv_ConsultationManager: IbsConsultationManager = nil;

function g__ConsultationManager: IbsConsultationManager;
//#UC START# *55FAEB22015B_55FAEA9B0079_var*
//#UC END# *55FAEB22015B_55FAEA9B0079_var*
begin
//#UC START# *55FAEB22015B_55FAEA9B0079_impl*
 if not Assigned(gv_ConsultationManager) then
  gv_ConsultationManager := TbsConsultationManager.Make;
 Result := gv_ConsultationManager;
//#UC END# *55FAEB22015B_55FAEA9B0079_impl*
end;//g__ConsultationManager

function IsConsultationManagerAssigned: Boolean;
//#UC START# *55FBE42C03DF_55FAEA9B0079_var*
//#UC END# *55FBE42C03DF_55FAEA9B0079_var*
begin
//#UC START# *55FBE42C03DF_55FAEA9B0079_impl*
 Result := Assigned(gv_ConsultationManager);
//#UC END# *55FBE42C03DF_55FAEA9B0079_impl*
end;//IsConsultationManagerAssigned

{$Include l3Notifier.imp.pas}

procedure TbsConsultationManager.UpdateUnread;
//#UC START# *55FACCF500B4_492FFDF7011A_var*
//#UC END# *55FACCF500B4_492FFDF7011A_var*
begin
//#UC START# *55FACCF500B4_492FFDF7011A_impl*
 f_Unread := DefDataAdapter.ConsultationManager.UpdateNotReadedConsultations;
//#UC END# *55FACCF500B4_492FFDF7011A_impl*
end;//TbsConsultationManager.UpdateUnread

constructor TbsConsultationManager.Create;
//#UC START# *55FACD130143_492FFDF7011A_var*
//#UC END# *55FACD130143_492FFDF7011A_var*
begin
//#UC START# *55FACD130143_492FFDF7011A_impl*
 inherited;
 f_Unread := -1;
//#UC END# *55FACD130143_492FFDF7011A_impl*
end;//TbsConsultationManager.Create

class function TbsConsultationManager.Make: IbsConsultationManager;
var
 l_Inst : TbsConsultationManager;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TbsConsultationManager.Make

function TbsConsultationManager.As_Il3ChangeNotifier: Il3ChangeNotifier;
 {* Метод приведения нашего интерфейса к Il3ChangeNotifier }
begin
 Result := Self;
end;//TbsConsultationManager.As_Il3ChangeNotifier

procedure TbsConsultationManager.UnreadChanged;
 {* изменилось количество не прочтенных }
//#UC START# *495279E501CB_492FFDF7011A_var*
//#UC END# *495279E501CB_492FFDF7011A_var*
begin
//#UC START# *495279E501CB_492FFDF7011A_impl*
 UpdateUnread;
 f_CurrentStatus := f_CurrentStatus + [coUnreadChanged];
 CallNotify(Ord(nConsultation), Ord(coUnreadChanged));
//#UC END# *495279E501CB_492FFDF7011A_impl*
end;//TbsConsultationManager.UnreadChanged

procedure TbsConsultationManager.NoConnection;
 {* нет доступа к серверу консультаций }
//#UC START# *495279F20005_492FFDF7011A_var*
//#UC END# *495279F20005_492FFDF7011A_var*
begin
//#UC START# *495279F20005_492FFDF7011A_impl*
 f_CurrentStatus := f_CurrentStatus + [coNoConnection];
 CallNotify(Ord(nConsultation), Ord(coNoConnection));
 // нотификация одноразовая, поэтому удалим из статуса флаг
 f_CurrentStatus := f_CurrentStatus - [coNoConnection];
//#UC END# *495279F20005_492FFDF7011A_impl*
end;//TbsConsultationManager.NoConnection

procedure TbsConsultationManager.NoSubscription;
 {* у пользователя нет доступа к сервису консультаций }
//#UC START# *495279FD039E_492FFDF7011A_var*
//#UC END# *495279FD039E_492FFDF7011A_var*
begin
//#UC START# *495279FD039E_492FFDF7011A_impl*
 f_CurrentStatus := f_CurrentStatus + [coNoSubscription];
 CallNotify(Ord(nConsultation), Ord(coNoSubscription));
//#UC END# *495279FD039E_492FFDF7011A_impl*
end;//TbsConsultationManager.NoSubscription

procedure TbsConsultationManager.InternetConnected;
//#UC START# *49527A1B0162_492FFDF7011A_var*
//#UC END# *49527A1B0162_492FFDF7011A_var*
begin
//#UC START# *49527A1B0162_492FFDF7011A_impl*
 f_CurrentStatus := f_CurrentStatus - [coInternetDisconnected] + [coInternetConnected];
 CallNotify(Ord(nConsultation), Ord(coInternetConnected));
//#UC END# *49527A1B0162_492FFDF7011A_impl*
end;//TbsConsultationManager.InternetConnected

function TbsConsultationManager.pm_GetHasUnread: Boolean;
//#UC START# *49527A2702F4_492FFDF7011Aget_var*
//#UC END# *49527A2702F4_492FFDF7011Aget_var*
begin
//#UC START# *49527A2702F4_492FFDF7011Aget_impl*
 if f_Unread = -1 then
  UpdateUnread;
 Result := f_Unread > 0;
//#UC END# *49527A2702F4_492FFDF7011Aget_impl*
end;//TbsConsultationManager.pm_GetHasUnread

procedure TbsConsultationManager.InternetDisConnected;
//#UC START# *4BCD8E0B00AE_492FFDF7011A_var*
//#UC END# *4BCD8E0B00AE_492FFDF7011A_var*
begin
//#UC START# *4BCD8E0B00AE_492FFDF7011A_impl*
 f_CurrentStatus := f_CurrentStatus - [coInternetConnected] + [coInternetDisconnected];
 CallNotify(Ord(nConsultation), Ord(coInternetDisconnected));
//#UC END# *4BCD8E0B00AE_492FFDF7011A_impl*
end;//TbsConsultationManager.InternetDisConnected

function TbsConsultationManager.pm_GetCurrentStatus: TbsConsultationOperations;
//#UC START# *5501366003A9_492FFDF7011Aget_var*
//#UC END# *5501366003A9_492FFDF7011Aget_var*
begin
//#UC START# *5501366003A9_492FFDF7011Aget_impl*
 Result := f_CurrentStatus;
//#UC END# *5501366003A9_492FFDF7011Aget_impl*
end;//TbsConsultationManager.pm_GetCurrentStatus

initialization
//#UC START# *55FAFF0C0027*
//#UC END# *55FAFF0C0027*

finalization
//#UC START# *55FAEB6B0372*
 gv_ConsultationManager := nil;
//#UC END# *55FAEB6B0372*
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
