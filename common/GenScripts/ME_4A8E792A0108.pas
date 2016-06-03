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

var st_user_System_CantReceiveLegalServiceAnswer_On: TvcmOperationStateIndex = (rID : -1);
 {* Система -> Статус связи с ППО <->  }
var st_user_System_CantReceiveLegalServiceAnswer_Off: TvcmOperationStateIndex = (rID : -1);
 {* Система -> Статус связи с ППО <-> Связь восстановлена }
var st_user_System_CantReceiveLegalServiceAnswer_Disabled: TvcmOperationStateIndex = (rID : -1);
 {* Система -> Статус связи с ППО <->  }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
