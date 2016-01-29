unit F1_Without_Usecases_System_Controls;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/F1_Without_Usecases_System_Controls.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMControls::Category>> F1 Оболочка Без Прецедентов::F1 Without Usecases::View::System
//
// "Системные"
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
  vcmExternalInterfaces {a}
  ;

(* System = operations
  {* Система }
   ['{B114DA5E-F2EC-40C9-A291-9C4CAAA27C3A}']
   operation CantReceiveLegalServiceAnswer; has states;
     {* Статус связи с ППО }
      On = state
       { Произошла ошибка связи при получении ответов службы Правовой поддержки онлайн. ' + 'В связи с этим ответы на ранее заданные Вами вопросы не могут быть доставлены.' + #13#10#13#10 + 'Для решения технических вопросов обратитесь, к Вашему системному администратору. ' + 'Если проблемы с интернет-соединением возникают только для системы ГАРАНТ, обратитесь в обслуживающую Вас организацию:' + #13#10 + '<текст из dealer.inf> }
      end;//On
      Off = state
       { Связь восстановлена }
      end;//Off
      Disabled = state
      end;//Disabled
 end;//System*)

(* Fonts = operations
   ['{C73B8471-4974-4B88-B2DC-93DDCBC811C5}']
   operation IncreaseFont;
   operation DecreaseFont;
 end;//Fonts*)

(* Help = operations
   ['{F2996D11-93B0-45B2-8122-E48530EAC0D5}']
   operation HotInformation;
   query HelpShortCuts;
   query HelpNewFeatures;
   query ContactInformation;
   query ReplyBook;
   operation GarantInternet;
   query About;
 end;//Help*)

(* System = operations
   ['{69ACA76C-00B3-49C6-8745-E3070458A5C7}']
   query BookmarkList;
 end;//System*)

(* WarnOnControl = operations
   ['{9CD2578F-69AF-4621-A604-C3A8FDE46C45}']
   query BuildControlledList;
     {* Построить список изменившихся документов на контроле }
   query OpenUnderControlTree;
     {* Открыть вкладку "Документы на контроле" }
   query HideReminder;
     {* Скрыть предупреждающий знак }
 end;//WarnOnControl*)

(* Reminder = operations
   ['{EE1B479C-466B-4926-BB80-A00E0B94AC88}']
   operation RemMWControlledChangingWarning;
   operation RemMWOldBaseWarning;
   operation RemMWTrialModeWarning;
   operation RemNewChatMessages;
   operation RemOnlineDead;
   operation remUnreadConsultations;
 end;//Reminder*)

(* Common = operations
   ['{7075BCC1-D217-4AA8-B336-94EAA01272AB}']
   query MemUsage;
 end;//Common*)
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
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

// Состояния операций:
var st_user_System_CantReceiveLegalServiceAnswer_On : TvcmOperationStateIndex = (rID : -1);
  // Система -> Статус связи с ППО <-> On
var st_user_System_CantReceiveLegalServiceAnswer_Off : TvcmOperationStateIndex = (rID : -1);
  // Система -> Статус связи с ППО <-> Связь восстановлена
var st_user_System_CantReceiveLegalServiceAnswer_Disabled : TvcmOperationStateIndex = (rID : -1);
  // Система -> Статус связи с ППО <-> Disabled
{$IfEnd} //not Admin AND not Monitorings

implementation

end.