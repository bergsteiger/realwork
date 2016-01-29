unit MainWithReminders_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/MainWithReminders_Form.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMMainForm::Class>> F1 Оболочка Без Прецедентов::F1 Without Usecases::View::PrimNemesis::MainWithReminders
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  l3Interfaces
  {$If not defined(NoVCM)}
  ,
  vcmExternalInterfaces
  {$IfEnd} //not NoVCM
  ,
  F1_Without_Usecases_System_Controls,
  Main_Form,
  l3StringIDEx,
  MainOptions_Form
  {$If defined(Nemesis)}
  ,
  nscReminder
  {$IfEnd} //Nemesis
  ,
  vcmInterfaces {a},
  vcmEntityForm {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
var
  { Локализуемые строки Reminders' Hints }
 str_ControlledChangingWarningHint : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ControlledChangingWarningHint'; rValue : 'Внимание! Документы на контроле изменились');
  { 'Внимание! Документы на контроле изменились' }
 str_OldBaseWarningHint : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'OldBaseWarningHint'; rValue : 'Внимание! Информационный банк устарел');
  { 'Внимание! Информационный банк устарел' }
 str_TrialModeWarningHint : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TrialModeWarningHint'; rValue : 'Вы работаете с ознакомительной версией системы ГАРАНТ');
  { 'Вы работаете с ознакомительной версией системы ГАРАНТ' }
 str_remUnreadConsultationsHint : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'remUnreadConsultationsHint'; rValue : 'Получены ответы или уведомления от службы Правовой поддержки онлайн');
  { 'Получены ответы или уведомления от службы Правовой поддержки онлайн' }
 str_remOnlineDeadHint : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'remOnlineDeadHint'; rValue : 'С момента последнего обновления Вашего информационного банка прошло более 6 месяцев. Онлайн-проверка актуальности документов будет отключена.');
  { 'С момента последнего обновления Вашего информационного банка прошло более 6 месяцев. Онлайн-проверка актуальности документов будет отключена.' }

type
 TMainWithRemindersForm = {form} class(TMainForm {$If defined(Nemesis) AND not defined(NoVCM)}, IvcmFlashingWindow{$IfEnd} //Nemesis AND not NoVCM
 )
 private
 // private fields
   f_Flashing : Boolean;
   f_remOnlineDead : TnscReminder;
    {* Поле для свойства remOnlineDead}
   f_remNewChatMessages : TnscReminder;
    {* Поле для свойства remNewChatMessages}
   f_TrialModeWarning : TnscReminder;
    {* Поле для свойства TrialModeWarning}
   f_OldBaseWarning : TnscReminder;
    {* Поле для свойства OldBaseWarning}
 protected
  procedure InitEntities; override;
  procedure MakeControls; override;
 private
 // private methods
   procedure ControlledChangingWarningBecomeVisible(Sender: TObject);
   procedure ControlledChangingWarningAfterBaloonShowed(Sender: TObject);
   procedure ControlledChangingWarningAfterBaloonHidden(Sender: TObject);
   procedure RemOnlineDeadAfterBaloonHidden(Sender: TObject);
 protected
 // realized methods
    {$If defined(Nemesis) AND not defined(NoVCM)}
   procedure StartFlashing;
    {$IfEnd} //Nemesis AND not NoVCM
    {$If defined(Nemesis) AND not defined(NoVCM)}
   procedure StopFlashing;
    {$IfEnd} //Nemesis AND not NoVCM
   procedure Reminder_RemMWControlledChangingWarning_Test(const aParams: IvcmTestParamsPrim);
   procedure Reminder_RemMWControlledChangingWarning_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure Reminder_RemMWOldBaseWarning_Test(const aParams: IvcmTestParamsPrim);
   procedure Reminder_RemMWOldBaseWarning_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure Reminder_RemMWTrialModeWarning_Test(const aParams: IvcmTestParamsPrim);
   procedure Reminder_RemMWTrialModeWarning_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure Reminder_RemNewChatMessages_Test(const aParams: IvcmTestParamsPrim);
   procedure Reminder_RemNewChatMessages_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure Reminder_RemOnlineDead_Test(const aParams: IvcmTestParamsPrim);
   procedure Reminder_RemOnlineDead_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure FillOldBaseWarning; override;
   procedure Reminder_remUnreadConsultations_Test(const aParams: IvcmTestParamsPrim);
   procedure Reminder_remUnreadConsultations_Execute(const aParams: IvcmExecuteParamsPrim);
 protected
 // overridden protected methods
   {$If not defined(NoVCM)}
   procedure InitControls; override;
     {* Процедура инициализации контролов. Для перекрытия в потомках }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure EntitiesInited; override;
     {* Вызывается после того как все операции зарегистрированы }
   {$IfEnd} //not NoVCM
    {$If not defined(NoVCM)}
   procedure BecomeVisible; override;
    {$IfEnd} //not NoVCM
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
    {$If not defined(NoVCM)}
   procedure BecomeInvisible; override;
     {* Сигнатура метода BecomeInvisible }
    {$IfEnd} //not NoVCM
 protected
 // protected fields
   f_remOnlineDeadHidden : Boolean;
   f_OldBaseWarningString : Il3CString;
 public
 // public properties

   property remOnlineDead: TnscReminder
     read f_remOnlineDead;
   property remNewChatMessages: TnscReminder
     read f_remNewChatMessages;
   property TrialModeWarning: TnscReminder
     read f_TrialModeWarning;
   property OldBaseWarning: TnscReminder
     read f_OldBaseWarning;
 end;//TMainWithRemindersForm

 TvcmMainFormRef = TMainWithRemindersForm;
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  resWarnImages,
  Windows
  {$If not defined(NoVCL)}
  ,
  Controls
  {$IfEnd} //not NoVCL
  
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  ,
  SysUtils,
  l3Base,
  DataAdapter,
  l3String,
  l3Chars,
  BaloonWarningUserTypes_ControlledChangingWarning_UserType,
  BaloonWarningUserTypes_OldBaseWarning_UserType,
  BaloonWarningUserTypes_TrialModeWarning_UserType,
  BaloonWarningUserTypes_remUnreadConsultations_UserType,
  BaloonWarningUserTypes_remOnlineDead_UserType
  {$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
  ,
  vcmTabbedContainerFormDispatcher
  {$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene
  ,
  l3MessageID
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  ,
  StdRes {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TMainWithRemindersForm

procedure TMainWithRemindersForm.ControlledChangingWarningBecomeVisible(Sender: TObject);
//#UC START# *4F7DCAFE028B_4F7DAC14027A_var*
var
 l_Flash: IvcmFlashingWindow;
 l_IDX: Integer;
//#UC END# *4F7DCAFE028B_4F7DAC14027A_var*
begin
//#UC START# *4F7DCAFE028B_4F7DAC14027A_impl*
 if (FindControl(GetForegroundWindow) = nil) then
 begin
  for l_IDX := 0 to Dispatcher.FormDispatcher.MainFormsCount - 1 do
   if Supports(Dispatcher.FormDispatcher.MainForm[l_IDX], IvcmFlashingWindow, l_Flash) then
   begin
    l_Flash.StartFlashing;
    Break;
   end;// Supports(Dispatcher.FormDispatcher.MainForm[l_IDX], IvcmFlashingWindow, l_Flash)
  TvcmTabbedContainerFormDispatcher.Instance.StartFlashing;
 end;//FindControl(GetForegroundWindow) = nil
//#UC END# *4F7DCAFE028B_4F7DAC14027A_impl*
end;//TMainWithRemindersForm.ControlledChangingWarningBecomeVisible

procedure TMainWithRemindersForm.ControlledChangingWarningAfterBaloonShowed(Sender: TObject);
//#UC START# *4F7DCB4E032C_4F7DAC14027A_var*
//#UC END# *4F7DCB4E032C_4F7DAC14027A_var*
begin
//#UC START# *4F7DCB4E032C_4F7DAC14027A_impl*
 TdmStdRes.OpenUnderControl(Self);
//#UC END# *4F7DCB4E032C_4F7DAC14027A_impl*
end;//TMainWithRemindersForm.ControlledChangingWarningAfterBaloonShowed

procedure TMainWithRemindersForm.ControlledChangingWarningAfterBaloonHidden(Sender: TObject);
//#UC START# *4F7DCB68009E_4F7DAC14027A_var*
//#UC END# *4F7DCB68009E_4F7DAC14027A_var*
begin
//#UC START# *4F7DCB68009E_4F7DAC14027A_impl*
 // Убираем значок предупреждения
 ResetControlledObjectsChanging; 
//#UC END# *4F7DCB68009E_4F7DAC14027A_impl*
end;//TMainWithRemindersForm.ControlledChangingWarningAfterBaloonHidden

procedure TMainWithRemindersForm.RemOnlineDeadAfterBaloonHidden(Sender: TObject);
//#UC START# *4F7DCB83012B_4F7DAC14027A_var*
//#UC END# *4F7DCB83012B_4F7DAC14027A_var*
begin
//#UC START# *4F7DCB83012B_4F7DAC14027A_impl*
 f_remOnlineDeadHidden := true;
//#UC END# *4F7DCB83012B_4F7DAC14027A_impl*
end;//TMainWithRemindersForm.RemOnlineDeadAfterBaloonHidden

{$If defined(Nemesis) AND not defined(NoVCM)}
procedure TMainWithRemindersForm.StartFlashing;
//#UC START# *4F7DCF74032D_4F7DAC14027A_var*
var
 l_Info: TFlashWInfo;
//#UC END# *4F7DCF74032D_4F7DAC14027A_var*
begin
//#UC START# *4F7DCF74032D_4F7DAC14027A_impl*
 if not f_Flashing then
 begin
  l3FillChar(l_Info, SizeOf(l_Info), 0);
  l_Info.cbSize := SizeOf(l_Info);
  l_Info.hwnd := Handle;
  l_Info.dwFlags := FLASHW_ALL or FLASHW_TIMER;
  FlashWindowEx(l_Info);
  f_Flashing := True;
 end;//not f_Flashing
//#UC END# *4F7DCF74032D_4F7DAC14027A_impl*
end;//TMainWithRemindersForm.StartFlashing
{$IfEnd} //Nemesis AND not NoVCM

{$If defined(Nemesis) AND not defined(NoVCM)}
procedure TMainWithRemindersForm.StopFlashing;
//#UC START# *4F7DCF8D03CC_4F7DAC14027A_var*
var
 l_Info: TFlashWInfo;
//#UC END# *4F7DCF8D03CC_4F7DAC14027A_var*
begin
//#UC START# *4F7DCF8D03CC_4F7DAC14027A_impl*
 if f_Flashing then
 begin
  l3FillChar(l_Info, SizeOf(l_Info), 0);
  l_Info.cbSize := SizeOf(l_Info);
  l_Info.hwnd := Handle;
  l_Info.dwFlags := FLASHW_STOP;
  FlashWindowEx(l_Info);
  f_Flashing := False;
 end;//f_Flashing
//#UC END# *4F7DCF8D03CC_4F7DAC14027A_impl*
end;//TMainWithRemindersForm.StopFlashing
{$IfEnd} //Nemesis AND not NoVCM

procedure TMainWithRemindersForm.Reminder_RemMWControlledChangingWarning_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4F86AAF903B5_4F7DAC14027Atest_var*
//#UC END# *4F86AAF903B5_4F7DAC14027Atest_var*
begin
//#UC START# *4F86AAF903B5_4F7DAC14027Atest_impl*
 aParams.Op.Flag[vcm_ofVisible] := f_IsControlledObjectsChanging;
//#UC END# *4F86AAF903B5_4F7DAC14027Atest_impl*
end;//TMainWithRemindersForm.Reminder_RemMWControlledChangingWarning_Test

procedure TMainWithRemindersForm.Reminder_RemMWControlledChangingWarning_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4F86AAF903B5_4F7DAC14027Aexec_var*
//#UC END# *4F86AAF903B5_4F7DAC14027Aexec_var*
begin
//#UC START# *4F86AAF903B5_4F7DAC14027Aexec_impl*
 OpenUnderControl;
//#UC END# *4F86AAF903B5_4F7DAC14027Aexec_impl*
end;//TMainWithRemindersForm.Reminder_RemMWControlledChangingWarning_Execute

procedure TMainWithRemindersForm.Reminder_RemMWOldBaseWarning_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4F86AB3A03E4_4F7DAC14027Atest_var*
//#UC END# *4F86AB3A03E4_4F7DAC14027Atest_var*
begin
//#UC START# *4F86AB3A03E4_4F7DAC14027Atest_impl*
 aParams.Op.Flag[vcm_ofVisible] := l3Len(f_OldBaseWarningString) > 0;
//#UC END# *4F86AB3A03E4_4F7DAC14027Atest_impl*
end;//TMainWithRemindersForm.Reminder_RemMWOldBaseWarning_Test

procedure TMainWithRemindersForm.Reminder_RemMWOldBaseWarning_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4F86AB3A03E4_4F7DAC14027Aexec_var*
//#UC END# *4F86AB3A03E4_4F7DAC14027Aexec_var*
begin
//#UC START# *4F86AB3A03E4_4F7DAC14027Aexec_impl*
 Say(inf_AnyInformation, [f_OldBaseWarningString]);
//#UC END# *4F86AB3A03E4_4F7DAC14027Aexec_impl*
end;//TMainWithRemindersForm.Reminder_RemMWOldBaseWarning_Execute

procedure TMainWithRemindersForm.Reminder_RemMWTrialModeWarning_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4F86AB490283_4F7DAC14027Atest_var*
//#UC END# *4F86AB490283_4F7DAC14027Atest_var*
begin
//#UC START# *4F86AB490283_4F7DAC14027Atest_impl*
 aParams.Op.Flag[vcm_ofVisible] := defDataAdapter.IsTrialMode;
//#UC END# *4F86AB490283_4F7DAC14027Atest_impl*
end;//TMainWithRemindersForm.Reminder_RemMWTrialModeWarning_Test

procedure TMainWithRemindersForm.Reminder_RemMWTrialModeWarning_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4F86AB490283_4F7DAC14027Aexec_var*
//#UC END# *4F86AB490283_4F7DAC14027Aexec_var*
begin
//#UC START# *4F86AB490283_4F7DAC14027Aexec_impl*
 with DefDataAdapter do
  Say(inf_TrialModeWarning, [TrialDaysLeft, GetDealerInfo]);
//#UC END# *4F86AB490283_4F7DAC14027Aexec_impl*
end;//TMainWithRemindersForm.Reminder_RemMWTrialModeWarning_Execute

procedure TMainWithRemindersForm.Reminder_RemNewChatMessages_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4F86AB5600B9_4F7DAC14027Atest_var*
//#UC END# *4F86AB5600B9_4F7DAC14027Atest_var*
begin
//#UC START# *4F86AB5600B9_4F7DAC14027Atest_impl*
 aParams.Op.Flag[vcm_ofVisible] := TdmStdRes.MakeChatDispatcher.HasUnreadedMessages;
//#UC END# *4F86AB5600B9_4F7DAC14027Atest_impl*
end;//TMainWithRemindersForm.Reminder_RemNewChatMessages_Test

procedure TMainWithRemindersForm.Reminder_RemNewChatMessages_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4F86AB5600B9_4F7DAC14027Aexec_var*
//#UC END# *4F86AB5600B9_4F7DAC14027Aexec_var*
begin
//#UC START# *4F86AB5600B9_4F7DAC14027Aexec_impl*
 TdmStdRes.MakeChatDispatcher.OpenAllUnreaded;
//#UC END# *4F86AB5600B9_4F7DAC14027Aexec_impl*
end;//TMainWithRemindersForm.Reminder_RemNewChatMessages_Execute

procedure TMainWithRemindersForm.Reminder_RemOnlineDead_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4F86AB6502AA_4F7DAC14027Atest_var*
//#UC END# *4F86AB6502AA_4F7DAC14027Atest_var*
begin
//#UC START# *4F86AB6502AA_4F7DAC14027Atest_impl*
 aParams.Op.Flag[vcm_ofVisible] := not f_remOnlineDeadHidden AND
                                   DefDataAdapter.NativeAdapter.MakeInternetSupport.ShowWarning;
//#UC END# *4F86AB6502AA_4F7DAC14027Atest_impl*
end;//TMainWithRemindersForm.Reminder_RemOnlineDead_Test

procedure TMainWithRemindersForm.Reminder_RemOnlineDead_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4F86AB6502AA_4F7DAC14027Aexec_var*
//#UC END# *4F86AB6502AA_4F7DAC14027Aexec_var*
begin
//#UC START# *4F86AB6502AA_4F7DAC14027Aexec_impl*
 defDataAdapter.ShowMessageWithDealerInfo(war_OnlineDead);
 f_remOnlineDeadHidden := true;
//#UC END# *4F86AB6502AA_4F7DAC14027Aexec_impl*
end;//TMainWithRemindersForm.Reminder_RemOnlineDead_Execute

procedure TMainWithRemindersForm.FillOldBaseWarning;
//#UC START# *4F8BED97037A_4F7DAC14027A_var*
//#UC END# *4F8BED97037A_4F7DAC14027A_var*
begin
//#UC START# *4F8BED97037A_4F7DAC14027A_impl*
 f_OldBaseWarningString := l3CStr(l3RTrim(defDataAdapter.GetOldBaseWarning.AsWStr, cc_NonReadable));
//#UC END# *4F8BED97037A_4F7DAC14027A_impl*
end;//TMainWithRemindersForm.FillOldBaseWarning

procedure TMainWithRemindersForm.Reminder_remUnreadConsultations_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *542D70330042_4F7DAC14027Atest_var*
//#UC END# *542D70330042_4F7DAC14027Atest_var*
begin
//#UC START# *542D70330042_4F7DAC14027Atest_impl*
 aParams.Op.Flag[vcm_ofVisible] := IsRemUnreadConsultationsVisible;
//#UC END# *542D70330042_4F7DAC14027Atest_impl*
end;//TMainWithRemindersForm.Reminder_remUnreadConsultations_Test

procedure TMainWithRemindersForm.Reminder_remUnreadConsultations_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *542D70330042_4F7DAC14027Aexec_var*
//#UC END# *542D70330042_4F7DAC14027Aexec_var*
begin
//#UC START# *542D70330042_4F7DAC14027Aexec_impl*
 if Ask(qr_TryOpenConsultationAnswer) then
  TdmStdRes.TryOpenConsultationAnswer(Self);
//#UC END# *542D70330042_4F7DAC14027Aexec_impl*
end;//TMainWithRemindersForm.Reminder_remUnreadConsultations_Execute

{$If not defined(NoVCM)}
procedure TMainWithRemindersForm.InitControls;
//#UC START# *4A8E8F2E0195_4F7DAC14027A_var*
//#UC END# *4A8E8F2E0195_4F7DAC14027A_var*
begin
//#UC START# *4A8E8F2E0195_4F7DAC14027A_impl*
 inherited;

 RemindersLine.Visible := False;
 RemindersLine.BeginUpdate;
 try
  RemindersLine.Images := resWarnImages.nsWarnImages.WarnImages;

  with ControlledChangingWarning do
  begin
   Hint := str_ControlledChangingWarningHint.AsCStr;
   ImageIndex := 2;
   Flash := True;
   Visible := False;
   OnPopupFormShow := ControlledChangingWarningAfterBaloonShowed;
   OnPopupFormHide := ControlledChangingWarningAfterBaloonHidden;
   OnShow := ControlledChangingWarningBecomeVisible;
   UserType := BaloonWarningUserTypes_ControlledChangingWarning_UserType.ControlledChangingWarning;
   SortIndex := 0;
  end;
  with OldBaseWarning do
  begin
   Hint := str_OldBaseWarningHint.AsCStr;
   ImageIndex := 11;
   Visible := False;
   OnShow := ControlledChangingWarningBecomeVisible;
   OldBaseWarning.UserType := BaloonWarningUserTypes_OldBaseWarning_UserType.OldBaseWarning;
   SortIndex := 1;
  end;
  with TrialModeWarning do
  begin
   Hint := str_TrialModeWarningHint.AsCStr;
   ImageIndex := 1;
   Visible := False;
   OnShow := ControlledChangingWarningBecomeVisible;
   TrialModeWarning.UserType := BaloonWarningUserTypes_TrialModeWarning_UserType.TrialModeWarning;
   SortIndex := 2;
  end;
  with remUnreadConsultations do
  begin
   Hint := str_remUnreadConsultationsHint.AsCStr;
   ImageIndex := 14;
   Flash := True;
   Visible := False;
   OnShow := ControlledChangingWarningBecomeVisible;
   UserType := BaloonWarningUserTypes_remUnreadConsultations_UserType.remUnreadConsultations;
   SortIndex := 3;
  end;
  with remNewChatMessages do
  begin
   ImageIndex := 15;
   Flash := True;
   Visible := False;
   OnShow := ControlledChangingWarningBecomeVisible;
   SortIndex := 4;
  end;
  with remOnlineDead do
  begin
   Hint := str_remOnlineDeadHint.AsCStr;
   ImageIndex := 17;
   Visible := False;
   OnPopupFormHide := remOnlineDeadAfterBaloonHidden;
   OnShow := ControlledChangingWarningBecomeVisible;
   remOnlineDead.UserType := BaloonWarningUserTypes_remOnlineDead_UserType.remOnlineDead;
   SortIndex := 5;
  end;
  RemindersLine.Sorted := True;
 finally
  RemindersLine.EndUpdate;
 end;
//#UC END# *4A8E8F2E0195_4F7DAC14027A_impl*
end;//TMainWithRemindersForm.InitControls
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TMainWithRemindersForm.EntitiesInited;
//#UC START# *4AE1948900DE_4F7DAC14027A_var*
//#UC END# *4AE1948900DE_4F7DAC14027A_var*
begin
//#UC START# *4AE1948900DE_4F7DAC14027A_impl*
 inherited;
 with ControlledChangingWarning do
 begin
  EntityName := en_Reminder;
  OperationName := op_RemMWControlledChangingWarning;
 end;
 with OldBaseWarning do
 begin
  EntityName := en_Reminder;
  OperationName := op_RemMWOldBaseWarning;
 end;
 with TrialModeWarning do
 begin
  EntityName := en_Reminder;
  OperationName := op_RemMWTrialModeWarning;
 end;
 with remNewChatMessages do
 begin
  EntityName := en_Reminder;
  OperationName := op_RemNewChatMessages;
 end;
 with remOnlineDead do
 begin
  EntityName := en_Reminder;
  OperationName := op_RemOnlineDead;
 end;
 with remUnreadConsultations do
 begin
  EntityName := en_Reminder;
  OperationName := op_remUnreadConsultations;
 end;
//#UC END# *4AE1948900DE_4F7DAC14027A_impl*
end;//TMainWithRemindersForm.EntitiesInited
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TMainWithRemindersForm.BecomeVisible;
//#UC START# *4F7C808A0349_4F7DAC14027A_var*
//#UC END# *4F7C808A0349_4F7DAC14027A_var*
begin
//#UC START# *4F7C808A0349_4F7DAC14027A_impl*
 inherited;
 RemindersLine.LockActivateProcessing;
 try
  RemindersLine.Visible := Visible;
 finally
  RemindersLine.UnlockActivateProcessing;
 end;
//#UC END# *4F7C808A0349_4F7DAC14027A_impl*
end;//TMainWithRemindersForm.BecomeVisible
{$IfEnd} //not NoVCM

procedure TMainWithRemindersForm.ClearFields;
 {-}
begin
 {$If not defined(Admin) AND not defined(Monitorings)}
 f_OldBaseWarningString := nil;
 {$IfEnd} //not Admin AND not Monitorings
 inherited;
end;//TMainWithRemindersForm.ClearFields

{$If not defined(NoVCM)}
procedure TMainWithRemindersForm.BecomeInvisible;
//#UC START# *537C9007038A_4F7DAC14027A_var*
//#UC END# *537C9007038A_4F7DAC14027A_var*
begin
//#UC START# *537C9007038A_4F7DAC14027A_impl*
 inherited;
 if Assigned(RemindersLine) then
  RemindersLine.Visible := Visible;
//#UC END# *537C9007038A_4F7DAC14027A_impl*
end;//TMainWithRemindersForm.BecomeInvisible
{$IfEnd} //not NoVCM

procedure TMainWithRemindersForm.InitEntities;
begin
 inherited;
 with Entities.Entities do
 begin
  PublishFormEntity(en_Reminder, nil);
  PublishOp(en_Reminder, op_RemMWControlledChangingWarning, Reminder_RemMWControlledChangingWarning_Execute, Reminder_RemMWControlledChangingWarning_Test, nil);
  PublishOp(en_Reminder, op_RemMWOldBaseWarning, Reminder_RemMWOldBaseWarning_Execute, Reminder_RemMWOldBaseWarning_Test, nil);
  PublishOp(en_Reminder, op_RemMWTrialModeWarning, Reminder_RemMWTrialModeWarning_Execute, Reminder_RemMWTrialModeWarning_Test, nil);
  PublishOp(en_Reminder, op_RemNewChatMessages, Reminder_RemNewChatMessages_Execute, Reminder_RemNewChatMessages_Test, nil);
  PublishOp(en_Reminder, op_RemOnlineDead, Reminder_RemOnlineDead_Execute, Reminder_RemOnlineDead_Test, nil);
  PublishOp(en_Reminder, op_remUnreadConsultations, Reminder_remUnreadConsultations_Execute, Reminder_remUnreadConsultations_Test, nil);
  ShowInContextMenu(en_Reminder, op_remUnreadConsultations, false);
 end;//with Entities.Entities
end;

procedure TMainWithRemindersForm.MakeControls;
begin
 inherited;
 RemindersLine.Parent := Self;
 with DefineZone(vcm_ztReminder, RemindersLine) do
 begin
 end;//with DefineZone(vcm_ztReminder, RemindersLine)
 f_remOnlineDead := TnscReminder.Create(RemindersLine);
 f_remOnlineDead.Name := 'remOnlineDead';
 f_remNewChatMessages := TnscReminder.Create(RemindersLine);
 f_remNewChatMessages.Name := 'remNewChatMessages';
 f_TrialModeWarning := TnscReminder.Create(RemindersLine);
 f_TrialModeWarning.Name := 'TrialModeWarning';
 f_OldBaseWarning := TnscReminder.Create(RemindersLine);
 f_OldBaseWarning.Name := 'OldBaseWarning';
end;

{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings)}
// Инициализация str_ControlledChangingWarningHint
 str_ControlledChangingWarningHint.Init;
{$IfEnd} //not Admin AND not Monitorings
{$If not defined(Admin) AND not defined(Monitorings)}
// Инициализация str_OldBaseWarningHint
 str_OldBaseWarningHint.Init;
{$IfEnd} //not Admin AND not Monitorings
{$If not defined(Admin) AND not defined(Monitorings)}
// Инициализация str_TrialModeWarningHint
 str_TrialModeWarningHint.Init;
{$IfEnd} //not Admin AND not Monitorings
{$If not defined(Admin) AND not defined(Monitorings)}
// Инициализация str_remUnreadConsultationsHint
 str_remUnreadConsultationsHint.Init;
{$IfEnd} //not Admin AND not Monitorings
{$If not defined(Admin) AND not defined(Monitorings)}
// Инициализация str_remOnlineDeadHint
 str_remOnlineDeadHint.Init;
{$IfEnd} //not Admin AND not Monitorings
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация MainWithReminders
 TtfwClassRef.Register(TMainWithRemindersForm);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.