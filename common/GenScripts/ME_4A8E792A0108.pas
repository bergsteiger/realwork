unit F1_Without_Usecases_System_Controls;
 {* "Системные" }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\F1_Without_Usecases_System_Controls.pas"
// Стереотип: "VCMControls"
// Элемент модели: "System" MUID: (4A8E792A0108)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 en_System = 'System';
 en_capSystem = 'Система';
 op_CantReceiveLegalServiceAnswer = 'CantReceiveLegalServiceAnswer';
 op_capCantReceiveLegalServiceAnswer = 'Статус связи с ППО';
 en_Fonts = 'Fonts';
 en_capFonts = '';
 op_IncreaseFont = 'IncreaseFont';
 op_capIncreaseFont = '';
 op_DecreaseFont = 'DecreaseFont';
 op_capDecreaseFont = '';
 en_Help = 'Help';
 en_capHelp = '';
 op_HotInformation = 'HotInformation';
 op_capHotInformation = '';
 op_HelpShortCuts = 'HelpShortCuts';
 op_capHelpShortCuts = '';
 op_HelpNewFeatures = 'HelpNewFeatures';
 op_capHelpNewFeatures = '';
 op_ContactInformation = 'ContactInformation';
 op_capContactInformation = '';
 op_ReplyBook = 'ReplyBook';
 op_capReplyBook = '';
 op_GarantInternet = 'GarantInternet';
 op_capGarantInternet = '';
 op_About = 'About';
 op_capAbout = '';
 op_BookmarkList = 'BookmarkList';
 op_capBookmarkList = '';
 en_WarnOnControl = 'WarnOnControl';
 en_capWarnOnControl = '';
 op_BuildControlledList = 'BuildControlledList';
 op_capBuildControlledList = 'Построить список изменившихся документов на контроле';
 op_OpenUnderControlTree = 'OpenUnderControlTree';
 op_capOpenUnderControlTree = 'Открыть вкладку "Документы на контроле"';
 op_HideReminder = 'HideReminder';
 op_capHideReminder = 'Скрыть предупреждающий знак';
 en_Reminder = 'Reminder';
 en_capReminder = '';
 op_RemMWControlledChangingWarning = 'RemMWControlledChangingWarning';
 op_capRemMWControlledChangingWarning = '';
 op_RemMWOldBaseWarning = 'RemMWOldBaseWarning';
 op_capRemMWOldBaseWarning = '';
 op_RemMWTrialModeWarning = 'RemMWTrialModeWarning';
 op_capRemMWTrialModeWarning = '';
 op_RemNewChatMessages = 'RemNewChatMessages';
 op_capRemNewChatMessages = '';
 op_RemOnlineDead = 'RemOnlineDead';
 op_capRemOnlineDead = '';
 op_remUnreadConsultations = 'remUnreadConsultations';
 op_capremUnreadConsultations = '';
 en_Common = 'Common';
 en_capCommon = '';
 op_MemUsage = 'MemUsage';
 op_capMemUsage = '';

var opcode_System_CantReceiveLegalServiceAnswer: TvcmOPID = (rEnID : -1; rOpID : -1);
var st_user_System_CantReceiveLegalServiceAnswer_On: TvcmOperationStateIndex = (rID : -1);
 {* Система -> Статус связи с ППО <->  }
var st_user_System_CantReceiveLegalServiceAnswer_Off: TvcmOperationStateIndex = (rID : -1);
 {* Система -> Статус связи с ППО <-> Связь восстановлена }
var st_user_System_CantReceiveLegalServiceAnswer_Disabled: TvcmOperationStateIndex = (rID : -1);
 {* Система -> Статус связи с ППО <->  }
var opcode_Fonts_IncreaseFont: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Fonts_DecreaseFont: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Help_HotInformation: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Help_HelpShortCuts: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Help_HelpNewFeatures: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Help_ContactInformation: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Help_ReplyBook: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Help_GarantInternet: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Help_About: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_System_BookmarkList: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_WarnOnControl_BuildControlledList: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_WarnOnControl_OpenUnderControlTree: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_WarnOnControl_HideReminder: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Reminder_RemMWControlledChangingWarning: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Reminder_RemMWOldBaseWarning: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Reminder_RemMWTrialModeWarning: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Reminder_RemNewChatMessages: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Reminder_RemOnlineDead: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Reminder_remUnreadConsultations: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Common_MemUsage: TvcmOPID = (rEnID : -1; rOpID : -1);
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoVCM)}
 , vcmOperationsForRegister
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmOperationStatesForRegister
 {$IfEnd} // NOT Defined(NoVCM)
;

initialization
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_System, op_CantReceiveLegalServiceAnswer, en_capSystem, op_capCantReceiveLegalServiceAnswer, False, False, opcode_System_CantReceiveLegalServiceAnswer)) do
 begin
  with AddState(TvcmOperationStateForRegister_C('On', st_user_System_CantReceiveLegalServiceAnswer_On))^ do
  begin
   rHint := 'Произошла ошибка связи при получении ответов службы Правовой поддержки онлайн. ' + 'В связи с этим ответы на ранее заданные Вами вопросы не могут быть доставлены.' + #13#10#13#10 + 'Для решения технических вопросов обратитесь, к Вашему системному администратору. ' + 'Если проблемы с интернет-соединением возникают только для системы ГАРАНТ, обратитесь в обслуживающую Вас организацию:' + #13#10 + '<текст из dealer.inf>';
   rImageIndex := 185;
  end;
  with AddState(TvcmOperationStateForRegister_C('Off', st_user_System_CantReceiveLegalServiceAnswer_Off))^ do
  begin
   rCaption := 'Связь восстановлена';
   rImageIndex := 186;
  end;
  with AddState(TvcmOperationStateForRegister_C('Disabled', st_user_System_CantReceiveLegalServiceAnswer_Disabled))^ do
  begin
   rEnabled := vcm_osfFalse;
  end;
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Fonts, op_IncreaseFont, en_capFonts, op_capIncreaseFont, False, False, opcode_Fonts_IncreaseFont)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Fonts, op_DecreaseFont, en_capFonts, op_capDecreaseFont, False, False, opcode_Fonts_DecreaseFont)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Help, op_HotInformation, en_capHelp, op_capHotInformation, False, False, opcode_Help_HotInformation)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Help, op_HelpShortCuts, en_capHelp, op_capHelpShortCuts, False, False, opcode_Help_HelpShortCuts)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Help, op_HelpNewFeatures, en_capHelp, op_capHelpNewFeatures, False, False, opcode_Help_HelpNewFeatures)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Help, op_ContactInformation, en_capHelp, op_capContactInformation, False, False, opcode_Help_ContactInformation)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Help, op_ReplyBook, en_capHelp, op_capReplyBook, False, False, opcode_Help_ReplyBook)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Help, op_GarantInternet, en_capHelp, op_capGarantInternet, False, False, opcode_Help_GarantInternet)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Help, op_About, en_capHelp, op_capAbout, False, False, opcode_Help_About)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_System, op_BookmarkList, en_capSystem, op_capBookmarkList, False, False, opcode_System_BookmarkList)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_WarnOnControl, op_BuildControlledList, en_capWarnOnControl, op_capBuildControlledList, False, False, opcode_WarnOnControl_BuildControlledList)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_WarnOnControl, op_OpenUnderControlTree, en_capWarnOnControl, op_capOpenUnderControlTree, False, False, opcode_WarnOnControl_OpenUnderControlTree)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_WarnOnControl, op_HideReminder, en_capWarnOnControl, op_capHideReminder, False, False, opcode_WarnOnControl_HideReminder)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Reminder, op_RemMWControlledChangingWarning, en_capReminder, op_capRemMWControlledChangingWarning, False, False, opcode_Reminder_RemMWControlledChangingWarning)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Reminder, op_RemMWOldBaseWarning, en_capReminder, op_capRemMWOldBaseWarning, False, False, opcode_Reminder_RemMWOldBaseWarning)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Reminder, op_RemMWTrialModeWarning, en_capReminder, op_capRemMWTrialModeWarning, False, False, opcode_Reminder_RemMWTrialModeWarning)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Reminder, op_RemNewChatMessages, en_capReminder, op_capRemNewChatMessages, False, False, opcode_Reminder_RemNewChatMessages)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Reminder, op_RemOnlineDead, en_capReminder, op_capRemOnlineDead, False, False, opcode_Reminder_RemOnlineDead)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Reminder, op_remUnreadConsultations, en_capReminder, op_capremUnreadConsultations, False, False, opcode_Reminder_remUnreadConsultations)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Common, op_MemUsage, en_capCommon, op_capMemUsage, False, False, opcode_Common_MemUsage)) do
 begin
 end;

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
