unit MainWindowKeywordsPack;
 {* Набор слов словаря для доступа к экземплярам контролов формы MainWindow }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\MainWindowKeywordsPack.pas"
// Стереотип: "ScriptKeywordsPack"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , PrimNemesisRes
 {$If Defined(Nemesis)}
 , nscReminder
 {$IfEnd} // Defined(Nemesis)
 {$If Defined(Nemesis)}
 , nscRemindersLine
 {$IfEnd} // Defined(Nemesis)
 {$If Defined(Nemesis)}
 , nscStatusBar
 {$IfEnd} // Defined(Nemesis)
 , vtPanel
 , vtProportionalPanel
 , vtSizeablePanel
 {$If Defined(Nemesis)}
 , nscNavigator
 {$IfEnd} // Defined(Nemesis)
 , tfwControlString
 {$If NOT Defined(NoVCL)}
 , kwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 , tfwScriptingInterfaces
 , tfwPropertyLike
 , tfwTypeInfo
 , TypInfo
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , TtfwClassRef_Proxy
 , SysUtils
;

type
 Tkw_Form_MainWindow = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора формы MainWindow
----
*Пример использования*:
[code]
'aControl' форма::MainWindow TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_MainWindow

 Tkw_MainWindow_Control_remOnlineDead = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола remOnlineDead
----
*Пример использования*:
[code]
контрол::remOnlineDead TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_MainWindow_Control_remOnlineDead

 Tkw_MainWindow_Control_remOnlineDead_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола remOnlineDead
----
*Пример использования*:
[code]
контрол::remOnlineDead:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainWindow_Control_remOnlineDead_Push

 Tkw_MainWindow_Control_remNewChatMessages = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола remNewChatMessages
----
*Пример использования*:
[code]
контрол::remNewChatMessages TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_MainWindow_Control_remNewChatMessages

 Tkw_MainWindow_Control_remNewChatMessages_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола remNewChatMessages
----
*Пример использования*:
[code]
контрол::remNewChatMessages:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainWindow_Control_remNewChatMessages_Push

 Tkw_MainWindow_Control_TrialModeWarning = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола TrialModeWarning
----
*Пример использования*:
[code]
контрол::TrialModeWarning TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_MainWindow_Control_TrialModeWarning

 Tkw_MainWindow_Control_TrialModeWarning_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола TrialModeWarning
----
*Пример использования*:
[code]
контрол::TrialModeWarning:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainWindow_Control_TrialModeWarning_Push

 Tkw_MainWindow_Control_OldBaseWarning = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола OldBaseWarning
----
*Пример использования*:
[code]
контрол::OldBaseWarning TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_MainWindow_Control_OldBaseWarning

 Tkw_MainWindow_Control_OldBaseWarning_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола OldBaseWarning
----
*Пример использования*:
[code]
контрол::OldBaseWarning:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainWindow_Control_OldBaseWarning_Push

 Tkw_MainWindow_Control_RemindersLine = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола RemindersLine
----
*Пример использования*:
[code]
контрол::RemindersLine TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_MainWindow_Control_RemindersLine

 Tkw_MainWindow_Control_RemindersLine_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола RemindersLine
----
*Пример использования*:
[code]
контрол::RemindersLine:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainWindow_Control_RemindersLine_Push

 Tkw_MainWindow_Control_ControlledChangingWarning = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола ControlledChangingWarning
----
*Пример использования*:
[code]
контрол::ControlledChangingWarning TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_MainWindow_Control_ControlledChangingWarning

 Tkw_MainWindow_Control_ControlledChangingWarning_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола ControlledChangingWarning
----
*Пример использования*:
[code]
контрол::ControlledChangingWarning:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainWindow_Control_ControlledChangingWarning_Push

 Tkw_MainWindow_Control_remUnreadConsultations = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола remUnreadConsultations
----
*Пример использования*:
[code]
контрол::remUnreadConsultations TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_MainWindow_Control_remUnreadConsultations

 Tkw_MainWindow_Control_remUnreadConsultations_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола remUnreadConsultations
----
*Пример использования*:
[code]
контрол::remUnreadConsultations:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainWindow_Control_remUnreadConsultations_Push

 Tkw_MainWindow_Control_StatusBar = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола StatusBar
----
*Пример использования*:
[code]
контрол::StatusBar TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_MainWindow_Control_StatusBar

 Tkw_MainWindow_Control_StatusBar_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола StatusBar
----
*Пример использования*:
[code]
контрол::StatusBar:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainWindow_Control_StatusBar_Push

 Tkw_MainWindow_Control_ClientZone = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола ClientZone
----
*Пример использования*:
[code]
контрол::ClientZone TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_MainWindow_Control_ClientZone

 Tkw_MainWindow_Control_ClientZone_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола ClientZone
----
*Пример использования*:
[code]
контрол::ClientZone:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainWindow_Control_ClientZone_Push

 Tkw_MainWindow_Control_MainZone = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола MainZone
----
*Пример использования*:
[code]
контрол::MainZone TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_MainWindow_Control_MainZone

 Tkw_MainWindow_Control_MainZone_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола MainZone
----
*Пример использования*:
[code]
контрол::MainZone:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainWindow_Control_MainZone_Push

 Tkw_MainWindow_Control_ParentZonePanel = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола ParentZonePanel
----
*Пример использования*:
[code]
контрол::ParentZonePanel TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_MainWindow_Control_ParentZonePanel

 Tkw_MainWindow_Control_ParentZonePanel_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола ParentZonePanel
----
*Пример использования*:
[code]
контрол::ParentZonePanel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainWindow_Control_ParentZonePanel_Push

 Tkw_MainWindow_Control_ChildZonePanel = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола ChildZonePanel
----
*Пример использования*:
[code]
контрол::ChildZonePanel TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_MainWindow_Control_ChildZonePanel

 Tkw_MainWindow_Control_ChildZonePanel_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола ChildZonePanel
----
*Пример использования*:
[code]
контрол::ChildZonePanel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainWindow_Control_ChildZonePanel_Push

 Tkw_MainWindow_Control_BaseSearchPanel = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола BaseSearchPanel
----
*Пример использования*:
[code]
контрол::BaseSearchPanel TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_MainWindow_Control_BaseSearchPanel

 Tkw_MainWindow_Control_BaseSearchPanel_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола BaseSearchPanel
----
*Пример использования*:
[code]
контрол::BaseSearchPanel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainWindow_Control_BaseSearchPanel_Push

 Tkw_MainWindow_Control_LeftNavigator = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола LeftNavigator
----
*Пример использования*:
[code]
контрол::LeftNavigator TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_MainWindow_Control_LeftNavigator

 Tkw_MainWindow_Control_LeftNavigator_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола LeftNavigator
----
*Пример использования*:
[code]
контрол::LeftNavigator:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainWindow_Control_LeftNavigator_Push

 {$If Defined(HasRightNavigator)}
 Tkw_MainWindow_Control_RightNavigator = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола RightNavigator
----
*Пример использования*:
[code]
контрол::RightNavigator TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_MainWindow_Control_RightNavigator
 {$IfEnd} // Defined(HasRightNavigator)

 {$If Defined(HasRightNavigator)}
 Tkw_MainWindow_Control_RightNavigator_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола RightNavigator
----
*Пример использования*:
[code]
контрол::RightNavigator:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainWindow_Control_RightNavigator_Push
 {$IfEnd} // Defined(HasRightNavigator)

 TkwMainWindowRemOnlineDead = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TnsMainWindow.remOnlineDead
[panel]Контрол remOnlineDead формы TnsMainWindow[panel]
*Тип результата:* TnscReminder
*Пример:*
[code]
OBJECT VAR l_TnscReminder
 aMainWindow .TnsMainWindow.remOnlineDead >>> l_TnscReminder
[code]  }
  private
   function remOnlineDead(const aCtx: TtfwContext;
    aMainWindow: TnsMainWindow): TnscReminder;
    {* Реализация слова скрипта .TnsMainWindow.remOnlineDead }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwMainWindowRemOnlineDead

 TkwMainWindowRemNewChatMessages = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TnsMainWindow.remNewChatMessages
[panel]Контрол remNewChatMessages формы TnsMainWindow[panel]
*Тип результата:* TnscReminder
*Пример:*
[code]
OBJECT VAR l_TnscReminder
 aMainWindow .TnsMainWindow.remNewChatMessages >>> l_TnscReminder
[code]  }
  private
   function remNewChatMessages(const aCtx: TtfwContext;
    aMainWindow: TnsMainWindow): TnscReminder;
    {* Реализация слова скрипта .TnsMainWindow.remNewChatMessages }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwMainWindowRemNewChatMessages

 TkwMainWindowTrialModeWarning = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TnsMainWindow.TrialModeWarning
[panel]Контрол TrialModeWarning формы TnsMainWindow[panel]
*Тип результата:* TnscReminder
*Пример:*
[code]
OBJECT VAR l_TnscReminder
 aMainWindow .TnsMainWindow.TrialModeWarning >>> l_TnscReminder
[code]  }
  private
   function TrialModeWarning(const aCtx: TtfwContext;
    aMainWindow: TnsMainWindow): TnscReminder;
    {* Реализация слова скрипта .TnsMainWindow.TrialModeWarning }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwMainWindowTrialModeWarning

 TkwMainWindowOldBaseWarning = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TnsMainWindow.OldBaseWarning
[panel]Контрол OldBaseWarning формы TnsMainWindow[panel]
*Тип результата:* TnscReminder
*Пример:*
[code]
OBJECT VAR l_TnscReminder
 aMainWindow .TnsMainWindow.OldBaseWarning >>> l_TnscReminder
[code]  }
  private
   function OldBaseWarning(const aCtx: TtfwContext;
    aMainWindow: TnsMainWindow): TnscReminder;
    {* Реализация слова скрипта .TnsMainWindow.OldBaseWarning }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwMainWindowOldBaseWarning

 TkwMainWindowRemindersLine = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TnsMainWindow.RemindersLine
[panel]Контрол RemindersLine формы TnsMainWindow[panel]
*Тип результата:* TnscRemindersLine
*Пример:*
[code]
OBJECT VAR l_TnscRemindersLine
 aMainWindow .TnsMainWindow.RemindersLine >>> l_TnscRemindersLine
[code]  }
  private
   function RemindersLine(const aCtx: TtfwContext;
    aMainWindow: TnsMainWindow): TnscRemindersLine;
    {* Реализация слова скрипта .TnsMainWindow.RemindersLine }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwMainWindowRemindersLine

 TkwMainWindowControlledChangingWarning = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TnsMainWindow.ControlledChangingWarning
[panel]Контрол ControlledChangingWarning формы TnsMainWindow[panel]
*Тип результата:* TnscReminder
*Пример:*
[code]
OBJECT VAR l_TnscReminder
 aMainWindow .TnsMainWindow.ControlledChangingWarning >>> l_TnscReminder
[code]  }
  private
   function ControlledChangingWarning(const aCtx: TtfwContext;
    aMainWindow: TnsMainWindow): TnscReminder;
    {* Реализация слова скрипта .TnsMainWindow.ControlledChangingWarning }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwMainWindowControlledChangingWarning

 TkwMainWindowRemUnreadConsultations = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TnsMainWindow.remUnreadConsultations
[panel]Контрол remUnreadConsultations формы TnsMainWindow[panel]
*Тип результата:* TnscReminder
*Пример:*
[code]
OBJECT VAR l_TnscReminder
 aMainWindow .TnsMainWindow.remUnreadConsultations >>> l_TnscReminder
[code]  }
  private
   function remUnreadConsultations(const aCtx: TtfwContext;
    aMainWindow: TnsMainWindow): TnscReminder;
    {* Реализация слова скрипта .TnsMainWindow.remUnreadConsultations }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwMainWindowRemUnreadConsultations

 TkwMainWindowStatusBar = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TnsMainWindow.StatusBar
[panel]Контрол StatusBar формы TnsMainWindow[panel]
*Тип результата:* TnscStatusBar
*Пример:*
[code]
OBJECT VAR l_TnscStatusBar
 aMainWindow .TnsMainWindow.StatusBar >>> l_TnscStatusBar
[code]  }
  private
   function StatusBar(const aCtx: TtfwContext;
    aMainWindow: TnsMainWindow): TnscStatusBar;
    {* Реализация слова скрипта .TnsMainWindow.StatusBar }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwMainWindowStatusBar

 TkwMainWindowClientZone = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TnsMainWindow.ClientZone
[panel]Контрол ClientZone формы TnsMainWindow[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aMainWindow .TnsMainWindow.ClientZone >>> l_TvtPanel
[code]  }
  private
   function ClientZone(const aCtx: TtfwContext;
    aMainWindow: TnsMainWindow): TvtPanel;
    {* Реализация слова скрипта .TnsMainWindow.ClientZone }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwMainWindowClientZone

 TkwMainWindowMainZone = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TnsMainWindow.MainZone
[panel]Контрол MainZone формы TnsMainWindow[panel]
*Тип результата:* TvtProportionalPanel
*Пример:*
[code]
OBJECT VAR l_TvtProportionalPanel
 aMainWindow .TnsMainWindow.MainZone >>> l_TvtProportionalPanel
[code]  }
  private
   function MainZone(const aCtx: TtfwContext;
    aMainWindow: TnsMainWindow): TvtProportionalPanel;
    {* Реализация слова скрипта .TnsMainWindow.MainZone }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwMainWindowMainZone

 TkwMainWindowParentZonePanel = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TnsMainWindow.ParentZonePanel
[panel]Контрол ParentZonePanel формы TnsMainWindow[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aMainWindow .TnsMainWindow.ParentZonePanel >>> l_TvtPanel
[code]  }
  private
   function ParentZonePanel(const aCtx: TtfwContext;
    aMainWindow: TnsMainWindow): TvtPanel;
    {* Реализация слова скрипта .TnsMainWindow.ParentZonePanel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwMainWindowParentZonePanel

 TkwMainWindowChildZonePanel = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TnsMainWindow.ChildZonePanel
[panel]Контрол ChildZonePanel формы TnsMainWindow[panel]
*Тип результата:* TvtSizeablePanel
*Пример:*
[code]
OBJECT VAR l_TvtSizeablePanel
 aMainWindow .TnsMainWindow.ChildZonePanel >>> l_TvtSizeablePanel
[code]  }
  private
   function ChildZonePanel(const aCtx: TtfwContext;
    aMainWindow: TnsMainWindow): TvtSizeablePanel;
    {* Реализация слова скрипта .TnsMainWindow.ChildZonePanel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwMainWindowChildZonePanel

 TkwMainWindowBaseSearchPanel = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TnsMainWindow.BaseSearchPanel
[panel]Контрол BaseSearchPanel формы TnsMainWindow[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aMainWindow .TnsMainWindow.BaseSearchPanel >>> l_TvtPanel
[code]  }
  private
   function BaseSearchPanel(const aCtx: TtfwContext;
    aMainWindow: TnsMainWindow): TvtPanel;
    {* Реализация слова скрипта .TnsMainWindow.BaseSearchPanel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwMainWindowBaseSearchPanel

 TkwMainWindowLeftNavigator = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TnsMainWindow.LeftNavigator
[panel]Контрол LeftNavigator формы TnsMainWindow[panel]
*Тип результата:* TnscNavigator
*Пример:*
[code]
OBJECT VAR l_TnscNavigator
 aMainWindow .TnsMainWindow.LeftNavigator >>> l_TnscNavigator
[code]  }
  private
   function LeftNavigator(const aCtx: TtfwContext;
    aMainWindow: TnsMainWindow): TnscNavigator;
    {* Реализация слова скрипта .TnsMainWindow.LeftNavigator }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwMainWindowLeftNavigator

 {$If Defined(HasRightNavigator)}
 TkwMainWindowRightNavigator = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TnsMainWindow.RightNavigator
[panel]Контрол RightNavigator формы TnsMainWindow[panel]
*Тип результата:* TnscNavigator
*Пример:*
[code]
OBJECT VAR l_TnscNavigator
 aMainWindow .TnsMainWindow.RightNavigator >>> l_TnscNavigator
[code]  }
  private
   function RightNavigator(const aCtx: TtfwContext;
    aMainWindow: TnsMainWindow): TnscNavigator;
    {* Реализация слова скрипта .TnsMainWindow.RightNavigator }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwMainWindowRightNavigator
 {$IfEnd} // Defined(HasRightNavigator)

class function Tkw_Form_MainWindow.GetWordNameForRegister: AnsiString;
begin
 Result := 'форма::MainWindow';
end;//Tkw_Form_MainWindow.GetWordNameForRegister

function Tkw_Form_MainWindow.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_72FE1DC0EE59_var*
//#UC END# *4DDFD2EA0116_72FE1DC0EE59_var*
begin
//#UC START# *4DDFD2EA0116_72FE1DC0EE59_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_72FE1DC0EE59_impl*
end;//Tkw_Form_MainWindow.GetString

class function Tkw_MainWindow_Control_remOnlineDead.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::remOnlineDead';
end;//Tkw_MainWindow_Control_remOnlineDead.GetWordNameForRegister

function Tkw_MainWindow_Control_remOnlineDead.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_AB4A15F921A5_var*
//#UC END# *4DDFD2EA0116_AB4A15F921A5_var*
begin
//#UC START# *4DDFD2EA0116_AB4A15F921A5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_AB4A15F921A5_impl*
end;//Tkw_MainWindow_Control_remOnlineDead.GetString

class procedure Tkw_MainWindow_Control_remOnlineDead.RegisterInEngine;
//#UC START# *52A086150180_AB4A15F921A5_var*
//#UC END# *52A086150180_AB4A15F921A5_var*
begin
//#UC START# *52A086150180_AB4A15F921A5_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_AB4A15F921A5_impl*
end;//Tkw_MainWindow_Control_remOnlineDead.RegisterInEngine

procedure Tkw_MainWindow_Control_remOnlineDead_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4E63B3135977_var*
//#UC END# *4DAEEDE10285_4E63B3135977_var*
begin
//#UC START# *4DAEEDE10285_4E63B3135977_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_4E63B3135977_impl*
end;//Tkw_MainWindow_Control_remOnlineDead_Push.DoDoIt

class function Tkw_MainWindow_Control_remOnlineDead_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::remOnlineDead:push';
end;//Tkw_MainWindow_Control_remOnlineDead_Push.GetWordNameForRegister

class function Tkw_MainWindow_Control_remNewChatMessages.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::remNewChatMessages';
end;//Tkw_MainWindow_Control_remNewChatMessages.GetWordNameForRegister

function Tkw_MainWindow_Control_remNewChatMessages.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_AFC7A7C4233D_var*
//#UC END# *4DDFD2EA0116_AFC7A7C4233D_var*
begin
//#UC START# *4DDFD2EA0116_AFC7A7C4233D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_AFC7A7C4233D_impl*
end;//Tkw_MainWindow_Control_remNewChatMessages.GetString

class procedure Tkw_MainWindow_Control_remNewChatMessages.RegisterInEngine;
//#UC START# *52A086150180_AFC7A7C4233D_var*
//#UC END# *52A086150180_AFC7A7C4233D_var*
begin
//#UC START# *52A086150180_AFC7A7C4233D_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_AFC7A7C4233D_impl*
end;//Tkw_MainWindow_Control_remNewChatMessages.RegisterInEngine

procedure Tkw_MainWindow_Control_remNewChatMessages_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_DB49A40311F8_var*
//#UC END# *4DAEEDE10285_DB49A40311F8_var*
begin
//#UC START# *4DAEEDE10285_DB49A40311F8_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_DB49A40311F8_impl*
end;//Tkw_MainWindow_Control_remNewChatMessages_Push.DoDoIt

class function Tkw_MainWindow_Control_remNewChatMessages_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::remNewChatMessages:push';
end;//Tkw_MainWindow_Control_remNewChatMessages_Push.GetWordNameForRegister

class function Tkw_MainWindow_Control_TrialModeWarning.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::TrialModeWarning';
end;//Tkw_MainWindow_Control_TrialModeWarning.GetWordNameForRegister

function Tkw_MainWindow_Control_TrialModeWarning.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_B1737C5744CF_var*
//#UC END# *4DDFD2EA0116_B1737C5744CF_var*
begin
//#UC START# *4DDFD2EA0116_B1737C5744CF_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_B1737C5744CF_impl*
end;//Tkw_MainWindow_Control_TrialModeWarning.GetString

class procedure Tkw_MainWindow_Control_TrialModeWarning.RegisterInEngine;
//#UC START# *52A086150180_B1737C5744CF_var*
//#UC END# *52A086150180_B1737C5744CF_var*
begin
//#UC START# *52A086150180_B1737C5744CF_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_B1737C5744CF_impl*
end;//Tkw_MainWindow_Control_TrialModeWarning.RegisterInEngine

procedure Tkw_MainWindow_Control_TrialModeWarning_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4120D270D0BD_var*
//#UC END# *4DAEEDE10285_4120D270D0BD_var*
begin
//#UC START# *4DAEEDE10285_4120D270D0BD_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_4120D270D0BD_impl*
end;//Tkw_MainWindow_Control_TrialModeWarning_Push.DoDoIt

class function Tkw_MainWindow_Control_TrialModeWarning_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::TrialModeWarning:push';
end;//Tkw_MainWindow_Control_TrialModeWarning_Push.GetWordNameForRegister

class function Tkw_MainWindow_Control_OldBaseWarning.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::OldBaseWarning';
end;//Tkw_MainWindow_Control_OldBaseWarning.GetWordNameForRegister

function Tkw_MainWindow_Control_OldBaseWarning.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_1A8910E8C94E_var*
//#UC END# *4DDFD2EA0116_1A8910E8C94E_var*
begin
//#UC START# *4DDFD2EA0116_1A8910E8C94E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_1A8910E8C94E_impl*
end;//Tkw_MainWindow_Control_OldBaseWarning.GetString

class procedure Tkw_MainWindow_Control_OldBaseWarning.RegisterInEngine;
//#UC START# *52A086150180_1A8910E8C94E_var*
//#UC END# *52A086150180_1A8910E8C94E_var*
begin
//#UC START# *52A086150180_1A8910E8C94E_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_1A8910E8C94E_impl*
end;//Tkw_MainWindow_Control_OldBaseWarning.RegisterInEngine

procedure Tkw_MainWindow_Control_OldBaseWarning_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_C3153D515BC1_var*
//#UC END# *4DAEEDE10285_C3153D515BC1_var*
begin
//#UC START# *4DAEEDE10285_C3153D515BC1_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_C3153D515BC1_impl*
end;//Tkw_MainWindow_Control_OldBaseWarning_Push.DoDoIt

class function Tkw_MainWindow_Control_OldBaseWarning_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::OldBaseWarning:push';
end;//Tkw_MainWindow_Control_OldBaseWarning_Push.GetWordNameForRegister

class function Tkw_MainWindow_Control_RemindersLine.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::RemindersLine';
end;//Tkw_MainWindow_Control_RemindersLine.GetWordNameForRegister

function Tkw_MainWindow_Control_RemindersLine.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_B9F3FE698E1F_var*
//#UC END# *4DDFD2EA0116_B9F3FE698E1F_var*
begin
//#UC START# *4DDFD2EA0116_B9F3FE698E1F_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_B9F3FE698E1F_impl*
end;//Tkw_MainWindow_Control_RemindersLine.GetString

class procedure Tkw_MainWindow_Control_RemindersLine.RegisterInEngine;
//#UC START# *52A086150180_B9F3FE698E1F_var*
//#UC END# *52A086150180_B9F3FE698E1F_var*
begin
//#UC START# *52A086150180_B9F3FE698E1F_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_B9F3FE698E1F_impl*
end;//Tkw_MainWindow_Control_RemindersLine.RegisterInEngine

procedure Tkw_MainWindow_Control_RemindersLine_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_B71018F2B69F_var*
//#UC END# *4DAEEDE10285_B71018F2B69F_var*
begin
//#UC START# *4DAEEDE10285_B71018F2B69F_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_B71018F2B69F_impl*
end;//Tkw_MainWindow_Control_RemindersLine_Push.DoDoIt

class function Tkw_MainWindow_Control_RemindersLine_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::RemindersLine:push';
end;//Tkw_MainWindow_Control_RemindersLine_Push.GetWordNameForRegister

class function Tkw_MainWindow_Control_ControlledChangingWarning.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ControlledChangingWarning';
end;//Tkw_MainWindow_Control_ControlledChangingWarning.GetWordNameForRegister

function Tkw_MainWindow_Control_ControlledChangingWarning.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_8F0A49D2D240_var*
//#UC END# *4DDFD2EA0116_8F0A49D2D240_var*
begin
//#UC START# *4DDFD2EA0116_8F0A49D2D240_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_8F0A49D2D240_impl*
end;//Tkw_MainWindow_Control_ControlledChangingWarning.GetString

class procedure Tkw_MainWindow_Control_ControlledChangingWarning.RegisterInEngine;
//#UC START# *52A086150180_8F0A49D2D240_var*
//#UC END# *52A086150180_8F0A49D2D240_var*
begin
//#UC START# *52A086150180_8F0A49D2D240_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_8F0A49D2D240_impl*
end;//Tkw_MainWindow_Control_ControlledChangingWarning.RegisterInEngine

procedure Tkw_MainWindow_Control_ControlledChangingWarning_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_AA323CFBD8F6_var*
//#UC END# *4DAEEDE10285_AA323CFBD8F6_var*
begin
//#UC START# *4DAEEDE10285_AA323CFBD8F6_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_AA323CFBD8F6_impl*
end;//Tkw_MainWindow_Control_ControlledChangingWarning_Push.DoDoIt

class function Tkw_MainWindow_Control_ControlledChangingWarning_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ControlledChangingWarning:push';
end;//Tkw_MainWindow_Control_ControlledChangingWarning_Push.GetWordNameForRegister

class function Tkw_MainWindow_Control_remUnreadConsultations.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::remUnreadConsultations';
end;//Tkw_MainWindow_Control_remUnreadConsultations.GetWordNameForRegister

function Tkw_MainWindow_Control_remUnreadConsultations.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_21221F006E08_var*
//#UC END# *4DDFD2EA0116_21221F006E08_var*
begin
//#UC START# *4DDFD2EA0116_21221F006E08_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_21221F006E08_impl*
end;//Tkw_MainWindow_Control_remUnreadConsultations.GetString

class procedure Tkw_MainWindow_Control_remUnreadConsultations.RegisterInEngine;
//#UC START# *52A086150180_21221F006E08_var*
//#UC END# *52A086150180_21221F006E08_var*
begin
//#UC START# *52A086150180_21221F006E08_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_21221F006E08_impl*
end;//Tkw_MainWindow_Control_remUnreadConsultations.RegisterInEngine

procedure Tkw_MainWindow_Control_remUnreadConsultations_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_C64E5121DF64_var*
//#UC END# *4DAEEDE10285_C64E5121DF64_var*
begin
//#UC START# *4DAEEDE10285_C64E5121DF64_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_C64E5121DF64_impl*
end;//Tkw_MainWindow_Control_remUnreadConsultations_Push.DoDoIt

class function Tkw_MainWindow_Control_remUnreadConsultations_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::remUnreadConsultations:push';
end;//Tkw_MainWindow_Control_remUnreadConsultations_Push.GetWordNameForRegister

class function Tkw_MainWindow_Control_StatusBar.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::StatusBar';
end;//Tkw_MainWindow_Control_StatusBar.GetWordNameForRegister

function Tkw_MainWindow_Control_StatusBar.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_7C7A033423DC_var*
//#UC END# *4DDFD2EA0116_7C7A033423DC_var*
begin
//#UC START# *4DDFD2EA0116_7C7A033423DC_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_7C7A033423DC_impl*
end;//Tkw_MainWindow_Control_StatusBar.GetString

class procedure Tkw_MainWindow_Control_StatusBar.RegisterInEngine;
//#UC START# *52A086150180_7C7A033423DC_var*
//#UC END# *52A086150180_7C7A033423DC_var*
begin
//#UC START# *52A086150180_7C7A033423DC_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_7C7A033423DC_impl*
end;//Tkw_MainWindow_Control_StatusBar.RegisterInEngine

procedure Tkw_MainWindow_Control_StatusBar_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_B079F69E067C_var*
//#UC END# *4DAEEDE10285_B079F69E067C_var*
begin
//#UC START# *4DAEEDE10285_B079F69E067C_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_B079F69E067C_impl*
end;//Tkw_MainWindow_Control_StatusBar_Push.DoDoIt

class function Tkw_MainWindow_Control_StatusBar_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::StatusBar:push';
end;//Tkw_MainWindow_Control_StatusBar_Push.GetWordNameForRegister

class function Tkw_MainWindow_Control_ClientZone.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ClientZone';
end;//Tkw_MainWindow_Control_ClientZone.GetWordNameForRegister

function Tkw_MainWindow_Control_ClientZone.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_0B37DDF00B84_var*
//#UC END# *4DDFD2EA0116_0B37DDF00B84_var*
begin
//#UC START# *4DDFD2EA0116_0B37DDF00B84_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_0B37DDF00B84_impl*
end;//Tkw_MainWindow_Control_ClientZone.GetString

class procedure Tkw_MainWindow_Control_ClientZone.RegisterInEngine;
//#UC START# *52A086150180_0B37DDF00B84_var*
//#UC END# *52A086150180_0B37DDF00B84_var*
begin
//#UC START# *52A086150180_0B37DDF00B84_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_0B37DDF00B84_impl*
end;//Tkw_MainWindow_Control_ClientZone.RegisterInEngine

procedure Tkw_MainWindow_Control_ClientZone_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_B0FF44E4117C_var*
//#UC END# *4DAEEDE10285_B0FF44E4117C_var*
begin
//#UC START# *4DAEEDE10285_B0FF44E4117C_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_B0FF44E4117C_impl*
end;//Tkw_MainWindow_Control_ClientZone_Push.DoDoIt

class function Tkw_MainWindow_Control_ClientZone_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ClientZone:push';
end;//Tkw_MainWindow_Control_ClientZone_Push.GetWordNameForRegister

class function Tkw_MainWindow_Control_MainZone.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::MainZone';
end;//Tkw_MainWindow_Control_MainZone.GetWordNameForRegister

function Tkw_MainWindow_Control_MainZone.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_7D1BC65DEA30_var*
//#UC END# *4DDFD2EA0116_7D1BC65DEA30_var*
begin
//#UC START# *4DDFD2EA0116_7D1BC65DEA30_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_7D1BC65DEA30_impl*
end;//Tkw_MainWindow_Control_MainZone.GetString

class procedure Tkw_MainWindow_Control_MainZone.RegisterInEngine;
//#UC START# *52A086150180_7D1BC65DEA30_var*
//#UC END# *52A086150180_7D1BC65DEA30_var*
begin
//#UC START# *52A086150180_7D1BC65DEA30_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_7D1BC65DEA30_impl*
end;//Tkw_MainWindow_Control_MainZone.RegisterInEngine

procedure Tkw_MainWindow_Control_MainZone_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_EB04F361D359_var*
//#UC END# *4DAEEDE10285_EB04F361D359_var*
begin
//#UC START# *4DAEEDE10285_EB04F361D359_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_EB04F361D359_impl*
end;//Tkw_MainWindow_Control_MainZone_Push.DoDoIt

class function Tkw_MainWindow_Control_MainZone_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::MainZone:push';
end;//Tkw_MainWindow_Control_MainZone_Push.GetWordNameForRegister

class function Tkw_MainWindow_Control_ParentZonePanel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ParentZonePanel';
end;//Tkw_MainWindow_Control_ParentZonePanel.GetWordNameForRegister

function Tkw_MainWindow_Control_ParentZonePanel.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_CA8695A16AEE_var*
//#UC END# *4DDFD2EA0116_CA8695A16AEE_var*
begin
//#UC START# *4DDFD2EA0116_CA8695A16AEE_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_CA8695A16AEE_impl*
end;//Tkw_MainWindow_Control_ParentZonePanel.GetString

class procedure Tkw_MainWindow_Control_ParentZonePanel.RegisterInEngine;
//#UC START# *52A086150180_CA8695A16AEE_var*
//#UC END# *52A086150180_CA8695A16AEE_var*
begin
//#UC START# *52A086150180_CA8695A16AEE_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_CA8695A16AEE_impl*
end;//Tkw_MainWindow_Control_ParentZonePanel.RegisterInEngine

procedure Tkw_MainWindow_Control_ParentZonePanel_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_8F3B829CF950_var*
//#UC END# *4DAEEDE10285_8F3B829CF950_var*
begin
//#UC START# *4DAEEDE10285_8F3B829CF950_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_8F3B829CF950_impl*
end;//Tkw_MainWindow_Control_ParentZonePanel_Push.DoDoIt

class function Tkw_MainWindow_Control_ParentZonePanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ParentZonePanel:push';
end;//Tkw_MainWindow_Control_ParentZonePanel_Push.GetWordNameForRegister

class function Tkw_MainWindow_Control_ChildZonePanel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ChildZonePanel';
end;//Tkw_MainWindow_Control_ChildZonePanel.GetWordNameForRegister

function Tkw_MainWindow_Control_ChildZonePanel.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_BA7D0C360FE3_var*
//#UC END# *4DDFD2EA0116_BA7D0C360FE3_var*
begin
//#UC START# *4DDFD2EA0116_BA7D0C360FE3_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_BA7D0C360FE3_impl*
end;//Tkw_MainWindow_Control_ChildZonePanel.GetString

class procedure Tkw_MainWindow_Control_ChildZonePanel.RegisterInEngine;
//#UC START# *52A086150180_BA7D0C360FE3_var*
//#UC END# *52A086150180_BA7D0C360FE3_var*
begin
//#UC START# *52A086150180_BA7D0C360FE3_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_BA7D0C360FE3_impl*
end;//Tkw_MainWindow_Control_ChildZonePanel.RegisterInEngine

procedure Tkw_MainWindow_Control_ChildZonePanel_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_E7483D80701D_var*
//#UC END# *4DAEEDE10285_E7483D80701D_var*
begin
//#UC START# *4DAEEDE10285_E7483D80701D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_E7483D80701D_impl*
end;//Tkw_MainWindow_Control_ChildZonePanel_Push.DoDoIt

class function Tkw_MainWindow_Control_ChildZonePanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ChildZonePanel:push';
end;//Tkw_MainWindow_Control_ChildZonePanel_Push.GetWordNameForRegister

class function Tkw_MainWindow_Control_BaseSearchPanel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::BaseSearchPanel';
end;//Tkw_MainWindow_Control_BaseSearchPanel.GetWordNameForRegister

function Tkw_MainWindow_Control_BaseSearchPanel.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_6B745C2439A7_var*
//#UC END# *4DDFD2EA0116_6B745C2439A7_var*
begin
//#UC START# *4DDFD2EA0116_6B745C2439A7_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_6B745C2439A7_impl*
end;//Tkw_MainWindow_Control_BaseSearchPanel.GetString

class procedure Tkw_MainWindow_Control_BaseSearchPanel.RegisterInEngine;
//#UC START# *52A086150180_6B745C2439A7_var*
//#UC END# *52A086150180_6B745C2439A7_var*
begin
//#UC START# *52A086150180_6B745C2439A7_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_6B745C2439A7_impl*
end;//Tkw_MainWindow_Control_BaseSearchPanel.RegisterInEngine

procedure Tkw_MainWindow_Control_BaseSearchPanel_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_DBFA41D8454E_var*
//#UC END# *4DAEEDE10285_DBFA41D8454E_var*
begin
//#UC START# *4DAEEDE10285_DBFA41D8454E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_DBFA41D8454E_impl*
end;//Tkw_MainWindow_Control_BaseSearchPanel_Push.DoDoIt

class function Tkw_MainWindow_Control_BaseSearchPanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::BaseSearchPanel:push';
end;//Tkw_MainWindow_Control_BaseSearchPanel_Push.GetWordNameForRegister

class function Tkw_MainWindow_Control_LeftNavigator.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::LeftNavigator';
end;//Tkw_MainWindow_Control_LeftNavigator.GetWordNameForRegister

function Tkw_MainWindow_Control_LeftNavigator.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_54302734B5CA_var*
//#UC END# *4DDFD2EA0116_54302734B5CA_var*
begin
//#UC START# *4DDFD2EA0116_54302734B5CA_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_54302734B5CA_impl*
end;//Tkw_MainWindow_Control_LeftNavigator.GetString

class procedure Tkw_MainWindow_Control_LeftNavigator.RegisterInEngine;
//#UC START# *52A086150180_54302734B5CA_var*
//#UC END# *52A086150180_54302734B5CA_var*
begin
//#UC START# *52A086150180_54302734B5CA_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_54302734B5CA_impl*
end;//Tkw_MainWindow_Control_LeftNavigator.RegisterInEngine

procedure Tkw_MainWindow_Control_LeftNavigator_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_49F076E7C957_var*
//#UC END# *4DAEEDE10285_49F076E7C957_var*
begin
//#UC START# *4DAEEDE10285_49F076E7C957_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_49F076E7C957_impl*
end;//Tkw_MainWindow_Control_LeftNavigator_Push.DoDoIt

class function Tkw_MainWindow_Control_LeftNavigator_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::LeftNavigator:push';
end;//Tkw_MainWindow_Control_LeftNavigator_Push.GetWordNameForRegister

class function Tkw_MainWindow_Control_RightNavigator.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::RightNavigator';
end;//Tkw_MainWindow_Control_RightNavigator.GetWordNameForRegister

function Tkw_MainWindow_Control_RightNavigator.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_9A4C6C4DD8BB_var*
//#UC END# *4DDFD2EA0116_9A4C6C4DD8BB_var*
begin
//#UC START# *4DDFD2EA0116_9A4C6C4DD8BB_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_9A4C6C4DD8BB_impl*
end;//Tkw_MainWindow_Control_RightNavigator.GetString

class procedure Tkw_MainWindow_Control_RightNavigator.RegisterInEngine;
//#UC START# *52A086150180_9A4C6C4DD8BB_var*
//#UC END# *52A086150180_9A4C6C4DD8BB_var*
begin
//#UC START# *52A086150180_9A4C6C4DD8BB_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_9A4C6C4DD8BB_impl*
end;//Tkw_MainWindow_Control_RightNavigator.RegisterInEngine

procedure Tkw_MainWindow_Control_RightNavigator_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_32A188482973_var*
//#UC END# *4DAEEDE10285_32A188482973_var*
begin
//#UC START# *4DAEEDE10285_32A188482973_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_32A188482973_impl*
end;//Tkw_MainWindow_Control_RightNavigator_Push.DoDoIt

class function Tkw_MainWindow_Control_RightNavigator_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::RightNavigator:push';
end;//Tkw_MainWindow_Control_RightNavigator_Push.GetWordNameForRegister

function TkwMainWindowRemOnlineDead.remOnlineDead(const aCtx: TtfwContext;
 aMainWindow: TnsMainWindow): TnscReminder;
 {* Реализация слова скрипта .TnsMainWindow.remOnlineDead }
//#UC START# *1C5A33F09604_82B2BCF3102B_var*
//#UC END# *1C5A33F09604_82B2BCF3102B_var*
begin
//#UC START# *1C5A33F09604_82B2BCF3102B_impl*
 !!! Needs to be implemented !!!
//#UC END# *1C5A33F09604_82B2BCF3102B_impl*
end;//TkwMainWindowRemOnlineDead.remOnlineDead

procedure TkwMainWindowRemOnlineDead.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_82B2BCF3102B_var*
//#UC END# *4DAEEDE10285_82B2BCF3102B_var*
begin
//#UC START# *4DAEEDE10285_82B2BCF3102B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_82B2BCF3102B_impl*
end;//TkwMainWindowRemOnlineDead.DoDoIt

class function TkwMainWindowRemOnlineDead.GetWordNameForRegister: AnsiString;
begin
 Result := '.TnsMainWindow.remOnlineDead';
end;//TkwMainWindowRemOnlineDead.GetWordNameForRegister

procedure TkwMainWindowRemOnlineDead.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_82B2BCF3102B_var*
//#UC END# *52D00B00031A_82B2BCF3102B_var*
begin
//#UC START# *52D00B00031A_82B2BCF3102B_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_82B2BCF3102B_impl*
end;//TkwMainWindowRemOnlineDead.SetValuePrim

function TkwMainWindowRemOnlineDead.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_82B2BCF3102B_var*
//#UC END# *551544E2001A_82B2BCF3102B_var*
begin
//#UC START# *551544E2001A_82B2BCF3102B_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_82B2BCF3102B_impl*
end;//TkwMainWindowRemOnlineDead.GetResultTypeInfo

function TkwMainWindowRemOnlineDead.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_82B2BCF3102B_var*
//#UC END# *559687E6025A_82B2BCF3102B_var*
begin
//#UC START# *559687E6025A_82B2BCF3102B_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_82B2BCF3102B_impl*
end;//TkwMainWindowRemOnlineDead.GetAllParamsCount

function TkwMainWindowRemOnlineDead.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_82B2BCF3102B_var*
//#UC END# *5617F4D00243_82B2BCF3102B_var*
begin
//#UC START# *5617F4D00243_82B2BCF3102B_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_82B2BCF3102B_impl*
end;//TkwMainWindowRemOnlineDead.ParamsTypes

function TkwMainWindowRemNewChatMessages.remNewChatMessages(const aCtx: TtfwContext;
 aMainWindow: TnsMainWindow): TnscReminder;
 {* Реализация слова скрипта .TnsMainWindow.remNewChatMessages }
//#UC START# *F6B99AF78964_F316F76D2AFC_var*
//#UC END# *F6B99AF78964_F316F76D2AFC_var*
begin
//#UC START# *F6B99AF78964_F316F76D2AFC_impl*
 !!! Needs to be implemented !!!
//#UC END# *F6B99AF78964_F316F76D2AFC_impl*
end;//TkwMainWindowRemNewChatMessages.remNewChatMessages

procedure TkwMainWindowRemNewChatMessages.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_F316F76D2AFC_var*
//#UC END# *4DAEEDE10285_F316F76D2AFC_var*
begin
//#UC START# *4DAEEDE10285_F316F76D2AFC_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_F316F76D2AFC_impl*
end;//TkwMainWindowRemNewChatMessages.DoDoIt

class function TkwMainWindowRemNewChatMessages.GetWordNameForRegister: AnsiString;
begin
 Result := '.TnsMainWindow.remNewChatMessages';
end;//TkwMainWindowRemNewChatMessages.GetWordNameForRegister

procedure TkwMainWindowRemNewChatMessages.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_F316F76D2AFC_var*
//#UC END# *52D00B00031A_F316F76D2AFC_var*
begin
//#UC START# *52D00B00031A_F316F76D2AFC_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_F316F76D2AFC_impl*
end;//TkwMainWindowRemNewChatMessages.SetValuePrim

function TkwMainWindowRemNewChatMessages.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_F316F76D2AFC_var*
//#UC END# *551544E2001A_F316F76D2AFC_var*
begin
//#UC START# *551544E2001A_F316F76D2AFC_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_F316F76D2AFC_impl*
end;//TkwMainWindowRemNewChatMessages.GetResultTypeInfo

function TkwMainWindowRemNewChatMessages.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_F316F76D2AFC_var*
//#UC END# *559687E6025A_F316F76D2AFC_var*
begin
//#UC START# *559687E6025A_F316F76D2AFC_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_F316F76D2AFC_impl*
end;//TkwMainWindowRemNewChatMessages.GetAllParamsCount

function TkwMainWindowRemNewChatMessages.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_F316F76D2AFC_var*
//#UC END# *5617F4D00243_F316F76D2AFC_var*
begin
//#UC START# *5617F4D00243_F316F76D2AFC_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_F316F76D2AFC_impl*
end;//TkwMainWindowRemNewChatMessages.ParamsTypes

function TkwMainWindowTrialModeWarning.TrialModeWarning(const aCtx: TtfwContext;
 aMainWindow: TnsMainWindow): TnscReminder;
 {* Реализация слова скрипта .TnsMainWindow.TrialModeWarning }
//#UC START# *0B1B7A5F10C8_116178A120B3_var*
//#UC END# *0B1B7A5F10C8_116178A120B3_var*
begin
//#UC START# *0B1B7A5F10C8_116178A120B3_impl*
 !!! Needs to be implemented !!!
//#UC END# *0B1B7A5F10C8_116178A120B3_impl*
end;//TkwMainWindowTrialModeWarning.TrialModeWarning

procedure TkwMainWindowTrialModeWarning.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_116178A120B3_var*
//#UC END# *4DAEEDE10285_116178A120B3_var*
begin
//#UC START# *4DAEEDE10285_116178A120B3_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_116178A120B3_impl*
end;//TkwMainWindowTrialModeWarning.DoDoIt

class function TkwMainWindowTrialModeWarning.GetWordNameForRegister: AnsiString;
begin
 Result := '.TnsMainWindow.TrialModeWarning';
end;//TkwMainWindowTrialModeWarning.GetWordNameForRegister

procedure TkwMainWindowTrialModeWarning.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_116178A120B3_var*
//#UC END# *52D00B00031A_116178A120B3_var*
begin
//#UC START# *52D00B00031A_116178A120B3_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_116178A120B3_impl*
end;//TkwMainWindowTrialModeWarning.SetValuePrim

function TkwMainWindowTrialModeWarning.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_116178A120B3_var*
//#UC END# *551544E2001A_116178A120B3_var*
begin
//#UC START# *551544E2001A_116178A120B3_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_116178A120B3_impl*
end;//TkwMainWindowTrialModeWarning.GetResultTypeInfo

function TkwMainWindowTrialModeWarning.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_116178A120B3_var*
//#UC END# *559687E6025A_116178A120B3_var*
begin
//#UC START# *559687E6025A_116178A120B3_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_116178A120B3_impl*
end;//TkwMainWindowTrialModeWarning.GetAllParamsCount

function TkwMainWindowTrialModeWarning.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_116178A120B3_var*
//#UC END# *5617F4D00243_116178A120B3_var*
begin
//#UC START# *5617F4D00243_116178A120B3_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_116178A120B3_impl*
end;//TkwMainWindowTrialModeWarning.ParamsTypes

function TkwMainWindowOldBaseWarning.OldBaseWarning(const aCtx: TtfwContext;
 aMainWindow: TnsMainWindow): TnscReminder;
 {* Реализация слова скрипта .TnsMainWindow.OldBaseWarning }
//#UC START# *482F7F78FAC4_59D50D49582B_var*
//#UC END# *482F7F78FAC4_59D50D49582B_var*
begin
//#UC START# *482F7F78FAC4_59D50D49582B_impl*
 !!! Needs to be implemented !!!
//#UC END# *482F7F78FAC4_59D50D49582B_impl*
end;//TkwMainWindowOldBaseWarning.OldBaseWarning

procedure TkwMainWindowOldBaseWarning.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_59D50D49582B_var*
//#UC END# *4DAEEDE10285_59D50D49582B_var*
begin
//#UC START# *4DAEEDE10285_59D50D49582B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_59D50D49582B_impl*
end;//TkwMainWindowOldBaseWarning.DoDoIt

class function TkwMainWindowOldBaseWarning.GetWordNameForRegister: AnsiString;
begin
 Result := '.TnsMainWindow.OldBaseWarning';
end;//TkwMainWindowOldBaseWarning.GetWordNameForRegister

procedure TkwMainWindowOldBaseWarning.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_59D50D49582B_var*
//#UC END# *52D00B00031A_59D50D49582B_var*
begin
//#UC START# *52D00B00031A_59D50D49582B_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_59D50D49582B_impl*
end;//TkwMainWindowOldBaseWarning.SetValuePrim

function TkwMainWindowOldBaseWarning.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_59D50D49582B_var*
//#UC END# *551544E2001A_59D50D49582B_var*
begin
//#UC START# *551544E2001A_59D50D49582B_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_59D50D49582B_impl*
end;//TkwMainWindowOldBaseWarning.GetResultTypeInfo

function TkwMainWindowOldBaseWarning.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_59D50D49582B_var*
//#UC END# *559687E6025A_59D50D49582B_var*
begin
//#UC START# *559687E6025A_59D50D49582B_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_59D50D49582B_impl*
end;//TkwMainWindowOldBaseWarning.GetAllParamsCount

function TkwMainWindowOldBaseWarning.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_59D50D49582B_var*
//#UC END# *5617F4D00243_59D50D49582B_var*
begin
//#UC START# *5617F4D00243_59D50D49582B_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_59D50D49582B_impl*
end;//TkwMainWindowOldBaseWarning.ParamsTypes

function TkwMainWindowRemindersLine.RemindersLine(const aCtx: TtfwContext;
 aMainWindow: TnsMainWindow): TnscRemindersLine;
 {* Реализация слова скрипта .TnsMainWindow.RemindersLine }
//#UC START# *F8AED6F6CFD7_3F3A50436E8F_var*
//#UC END# *F8AED6F6CFD7_3F3A50436E8F_var*
begin
//#UC START# *F8AED6F6CFD7_3F3A50436E8F_impl*
 !!! Needs to be implemented !!!
//#UC END# *F8AED6F6CFD7_3F3A50436E8F_impl*
end;//TkwMainWindowRemindersLine.RemindersLine

procedure TkwMainWindowRemindersLine.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_3F3A50436E8F_var*
//#UC END# *4DAEEDE10285_3F3A50436E8F_var*
begin
//#UC START# *4DAEEDE10285_3F3A50436E8F_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_3F3A50436E8F_impl*
end;//TkwMainWindowRemindersLine.DoDoIt

class function TkwMainWindowRemindersLine.GetWordNameForRegister: AnsiString;
begin
 Result := '.TnsMainWindow.RemindersLine';
end;//TkwMainWindowRemindersLine.GetWordNameForRegister

procedure TkwMainWindowRemindersLine.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_3F3A50436E8F_var*
//#UC END# *52D00B00031A_3F3A50436E8F_var*
begin
//#UC START# *52D00B00031A_3F3A50436E8F_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_3F3A50436E8F_impl*
end;//TkwMainWindowRemindersLine.SetValuePrim

function TkwMainWindowRemindersLine.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_3F3A50436E8F_var*
//#UC END# *551544E2001A_3F3A50436E8F_var*
begin
//#UC START# *551544E2001A_3F3A50436E8F_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_3F3A50436E8F_impl*
end;//TkwMainWindowRemindersLine.GetResultTypeInfo

function TkwMainWindowRemindersLine.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_3F3A50436E8F_var*
//#UC END# *559687E6025A_3F3A50436E8F_var*
begin
//#UC START# *559687E6025A_3F3A50436E8F_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_3F3A50436E8F_impl*
end;//TkwMainWindowRemindersLine.GetAllParamsCount

function TkwMainWindowRemindersLine.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_3F3A50436E8F_var*
//#UC END# *5617F4D00243_3F3A50436E8F_var*
begin
//#UC START# *5617F4D00243_3F3A50436E8F_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_3F3A50436E8F_impl*
end;//TkwMainWindowRemindersLine.ParamsTypes

function TkwMainWindowControlledChangingWarning.ControlledChangingWarning(const aCtx: TtfwContext;
 aMainWindow: TnsMainWindow): TnscReminder;
 {* Реализация слова скрипта .TnsMainWindow.ControlledChangingWarning }
//#UC START# *5A562B6AB425_FCB9DBB9A96D_var*
//#UC END# *5A562B6AB425_FCB9DBB9A96D_var*
begin
//#UC START# *5A562B6AB425_FCB9DBB9A96D_impl*
 !!! Needs to be implemented !!!
//#UC END# *5A562B6AB425_FCB9DBB9A96D_impl*
end;//TkwMainWindowControlledChangingWarning.ControlledChangingWarning

procedure TkwMainWindowControlledChangingWarning.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_FCB9DBB9A96D_var*
//#UC END# *4DAEEDE10285_FCB9DBB9A96D_var*
begin
//#UC START# *4DAEEDE10285_FCB9DBB9A96D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_FCB9DBB9A96D_impl*
end;//TkwMainWindowControlledChangingWarning.DoDoIt

class function TkwMainWindowControlledChangingWarning.GetWordNameForRegister: AnsiString;
begin
 Result := '.TnsMainWindow.ControlledChangingWarning';
end;//TkwMainWindowControlledChangingWarning.GetWordNameForRegister

procedure TkwMainWindowControlledChangingWarning.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_FCB9DBB9A96D_var*
//#UC END# *52D00B00031A_FCB9DBB9A96D_var*
begin
//#UC START# *52D00B00031A_FCB9DBB9A96D_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_FCB9DBB9A96D_impl*
end;//TkwMainWindowControlledChangingWarning.SetValuePrim

function TkwMainWindowControlledChangingWarning.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_FCB9DBB9A96D_var*
//#UC END# *551544E2001A_FCB9DBB9A96D_var*
begin
//#UC START# *551544E2001A_FCB9DBB9A96D_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_FCB9DBB9A96D_impl*
end;//TkwMainWindowControlledChangingWarning.GetResultTypeInfo

function TkwMainWindowControlledChangingWarning.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_FCB9DBB9A96D_var*
//#UC END# *559687E6025A_FCB9DBB9A96D_var*
begin
//#UC START# *559687E6025A_FCB9DBB9A96D_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_FCB9DBB9A96D_impl*
end;//TkwMainWindowControlledChangingWarning.GetAllParamsCount

function TkwMainWindowControlledChangingWarning.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_FCB9DBB9A96D_var*
//#UC END# *5617F4D00243_FCB9DBB9A96D_var*
begin
//#UC START# *5617F4D00243_FCB9DBB9A96D_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_FCB9DBB9A96D_impl*
end;//TkwMainWindowControlledChangingWarning.ParamsTypes

function TkwMainWindowRemUnreadConsultations.remUnreadConsultations(const aCtx: TtfwContext;
 aMainWindow: TnsMainWindow): TnscReminder;
 {* Реализация слова скрипта .TnsMainWindow.remUnreadConsultations }
//#UC START# *5AC6608233EB_797CD35061B7_var*
//#UC END# *5AC6608233EB_797CD35061B7_var*
begin
//#UC START# *5AC6608233EB_797CD35061B7_impl*
 !!! Needs to be implemented !!!
//#UC END# *5AC6608233EB_797CD35061B7_impl*
end;//TkwMainWindowRemUnreadConsultations.remUnreadConsultations

procedure TkwMainWindowRemUnreadConsultations.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_797CD35061B7_var*
//#UC END# *4DAEEDE10285_797CD35061B7_var*
begin
//#UC START# *4DAEEDE10285_797CD35061B7_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_797CD35061B7_impl*
end;//TkwMainWindowRemUnreadConsultations.DoDoIt

class function TkwMainWindowRemUnreadConsultations.GetWordNameForRegister: AnsiString;
begin
 Result := '.TnsMainWindow.remUnreadConsultations';
end;//TkwMainWindowRemUnreadConsultations.GetWordNameForRegister

procedure TkwMainWindowRemUnreadConsultations.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_797CD35061B7_var*
//#UC END# *52D00B00031A_797CD35061B7_var*
begin
//#UC START# *52D00B00031A_797CD35061B7_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_797CD35061B7_impl*
end;//TkwMainWindowRemUnreadConsultations.SetValuePrim

function TkwMainWindowRemUnreadConsultations.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_797CD35061B7_var*
//#UC END# *551544E2001A_797CD35061B7_var*
begin
//#UC START# *551544E2001A_797CD35061B7_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_797CD35061B7_impl*
end;//TkwMainWindowRemUnreadConsultations.GetResultTypeInfo

function TkwMainWindowRemUnreadConsultations.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_797CD35061B7_var*
//#UC END# *559687E6025A_797CD35061B7_var*
begin
//#UC START# *559687E6025A_797CD35061B7_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_797CD35061B7_impl*
end;//TkwMainWindowRemUnreadConsultations.GetAllParamsCount

function TkwMainWindowRemUnreadConsultations.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_797CD35061B7_var*
//#UC END# *5617F4D00243_797CD35061B7_var*
begin
//#UC START# *5617F4D00243_797CD35061B7_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_797CD35061B7_impl*
end;//TkwMainWindowRemUnreadConsultations.ParamsTypes

function TkwMainWindowStatusBar.StatusBar(const aCtx: TtfwContext;
 aMainWindow: TnsMainWindow): TnscStatusBar;
 {* Реализация слова скрипта .TnsMainWindow.StatusBar }
//#UC START# *7D34C7D8B1E6_CE0BB644ECC0_var*
//#UC END# *7D34C7D8B1E6_CE0BB644ECC0_var*
begin
//#UC START# *7D34C7D8B1E6_CE0BB644ECC0_impl*
 !!! Needs to be implemented !!!
//#UC END# *7D34C7D8B1E6_CE0BB644ECC0_impl*
end;//TkwMainWindowStatusBar.StatusBar

procedure TkwMainWindowStatusBar.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_CE0BB644ECC0_var*
//#UC END# *4DAEEDE10285_CE0BB644ECC0_var*
begin
//#UC START# *4DAEEDE10285_CE0BB644ECC0_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_CE0BB644ECC0_impl*
end;//TkwMainWindowStatusBar.DoDoIt

class function TkwMainWindowStatusBar.GetWordNameForRegister: AnsiString;
begin
 Result := '.TnsMainWindow.StatusBar';
end;//TkwMainWindowStatusBar.GetWordNameForRegister

procedure TkwMainWindowStatusBar.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_CE0BB644ECC0_var*
//#UC END# *52D00B00031A_CE0BB644ECC0_var*
begin
//#UC START# *52D00B00031A_CE0BB644ECC0_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_CE0BB644ECC0_impl*
end;//TkwMainWindowStatusBar.SetValuePrim

function TkwMainWindowStatusBar.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_CE0BB644ECC0_var*
//#UC END# *551544E2001A_CE0BB644ECC0_var*
begin
//#UC START# *551544E2001A_CE0BB644ECC0_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_CE0BB644ECC0_impl*
end;//TkwMainWindowStatusBar.GetResultTypeInfo

function TkwMainWindowStatusBar.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_CE0BB644ECC0_var*
//#UC END# *559687E6025A_CE0BB644ECC0_var*
begin
//#UC START# *559687E6025A_CE0BB644ECC0_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_CE0BB644ECC0_impl*
end;//TkwMainWindowStatusBar.GetAllParamsCount

function TkwMainWindowStatusBar.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_CE0BB644ECC0_var*
//#UC END# *5617F4D00243_CE0BB644ECC0_var*
begin
//#UC START# *5617F4D00243_CE0BB644ECC0_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_CE0BB644ECC0_impl*
end;//TkwMainWindowStatusBar.ParamsTypes

function TkwMainWindowClientZone.ClientZone(const aCtx: TtfwContext;
 aMainWindow: TnsMainWindow): TvtPanel;
 {* Реализация слова скрипта .TnsMainWindow.ClientZone }
//#UC START# *94BE93BDD48E_FE6607BEAD6E_var*
//#UC END# *94BE93BDD48E_FE6607BEAD6E_var*
begin
//#UC START# *94BE93BDD48E_FE6607BEAD6E_impl*
 !!! Needs to be implemented !!!
//#UC END# *94BE93BDD48E_FE6607BEAD6E_impl*
end;//TkwMainWindowClientZone.ClientZone

procedure TkwMainWindowClientZone.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_FE6607BEAD6E_var*
//#UC END# *4DAEEDE10285_FE6607BEAD6E_var*
begin
//#UC START# *4DAEEDE10285_FE6607BEAD6E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_FE6607BEAD6E_impl*
end;//TkwMainWindowClientZone.DoDoIt

class function TkwMainWindowClientZone.GetWordNameForRegister: AnsiString;
begin
 Result := '.TnsMainWindow.ClientZone';
end;//TkwMainWindowClientZone.GetWordNameForRegister

procedure TkwMainWindowClientZone.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_FE6607BEAD6E_var*
//#UC END# *52D00B00031A_FE6607BEAD6E_var*
begin
//#UC START# *52D00B00031A_FE6607BEAD6E_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_FE6607BEAD6E_impl*
end;//TkwMainWindowClientZone.SetValuePrim

function TkwMainWindowClientZone.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_FE6607BEAD6E_var*
//#UC END# *551544E2001A_FE6607BEAD6E_var*
begin
//#UC START# *551544E2001A_FE6607BEAD6E_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_FE6607BEAD6E_impl*
end;//TkwMainWindowClientZone.GetResultTypeInfo

function TkwMainWindowClientZone.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_FE6607BEAD6E_var*
//#UC END# *559687E6025A_FE6607BEAD6E_var*
begin
//#UC START# *559687E6025A_FE6607BEAD6E_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_FE6607BEAD6E_impl*
end;//TkwMainWindowClientZone.GetAllParamsCount

function TkwMainWindowClientZone.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_FE6607BEAD6E_var*
//#UC END# *5617F4D00243_FE6607BEAD6E_var*
begin
//#UC START# *5617F4D00243_FE6607BEAD6E_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_FE6607BEAD6E_impl*
end;//TkwMainWindowClientZone.ParamsTypes

function TkwMainWindowMainZone.MainZone(const aCtx: TtfwContext;
 aMainWindow: TnsMainWindow): TvtProportionalPanel;
 {* Реализация слова скрипта .TnsMainWindow.MainZone }
//#UC START# *ABD85089DCD3_A864C41E05F1_var*
//#UC END# *ABD85089DCD3_A864C41E05F1_var*
begin
//#UC START# *ABD85089DCD3_A864C41E05F1_impl*
 !!! Needs to be implemented !!!
//#UC END# *ABD85089DCD3_A864C41E05F1_impl*
end;//TkwMainWindowMainZone.MainZone

procedure TkwMainWindowMainZone.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_A864C41E05F1_var*
//#UC END# *4DAEEDE10285_A864C41E05F1_var*
begin
//#UC START# *4DAEEDE10285_A864C41E05F1_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_A864C41E05F1_impl*
end;//TkwMainWindowMainZone.DoDoIt

class function TkwMainWindowMainZone.GetWordNameForRegister: AnsiString;
begin
 Result := '.TnsMainWindow.MainZone';
end;//TkwMainWindowMainZone.GetWordNameForRegister

procedure TkwMainWindowMainZone.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_A864C41E05F1_var*
//#UC END# *52D00B00031A_A864C41E05F1_var*
begin
//#UC START# *52D00B00031A_A864C41E05F1_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_A864C41E05F1_impl*
end;//TkwMainWindowMainZone.SetValuePrim

function TkwMainWindowMainZone.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_A864C41E05F1_var*
//#UC END# *551544E2001A_A864C41E05F1_var*
begin
//#UC START# *551544E2001A_A864C41E05F1_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_A864C41E05F1_impl*
end;//TkwMainWindowMainZone.GetResultTypeInfo

function TkwMainWindowMainZone.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_A864C41E05F1_var*
//#UC END# *559687E6025A_A864C41E05F1_var*
begin
//#UC START# *559687E6025A_A864C41E05F1_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_A864C41E05F1_impl*
end;//TkwMainWindowMainZone.GetAllParamsCount

function TkwMainWindowMainZone.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_A864C41E05F1_var*
//#UC END# *5617F4D00243_A864C41E05F1_var*
begin
//#UC START# *5617F4D00243_A864C41E05F1_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_A864C41E05F1_impl*
end;//TkwMainWindowMainZone.ParamsTypes

function TkwMainWindowParentZonePanel.ParentZonePanel(const aCtx: TtfwContext;
 aMainWindow: TnsMainWindow): TvtPanel;
 {* Реализация слова скрипта .TnsMainWindow.ParentZonePanel }
//#UC START# *7FBB821426B4_42983EB4E606_var*
//#UC END# *7FBB821426B4_42983EB4E606_var*
begin
//#UC START# *7FBB821426B4_42983EB4E606_impl*
 !!! Needs to be implemented !!!
//#UC END# *7FBB821426B4_42983EB4E606_impl*
end;//TkwMainWindowParentZonePanel.ParentZonePanel

procedure TkwMainWindowParentZonePanel.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_42983EB4E606_var*
//#UC END# *4DAEEDE10285_42983EB4E606_var*
begin
//#UC START# *4DAEEDE10285_42983EB4E606_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_42983EB4E606_impl*
end;//TkwMainWindowParentZonePanel.DoDoIt

class function TkwMainWindowParentZonePanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TnsMainWindow.ParentZonePanel';
end;//TkwMainWindowParentZonePanel.GetWordNameForRegister

procedure TkwMainWindowParentZonePanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_42983EB4E606_var*
//#UC END# *52D00B00031A_42983EB4E606_var*
begin
//#UC START# *52D00B00031A_42983EB4E606_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_42983EB4E606_impl*
end;//TkwMainWindowParentZonePanel.SetValuePrim

function TkwMainWindowParentZonePanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_42983EB4E606_var*
//#UC END# *551544E2001A_42983EB4E606_var*
begin
//#UC START# *551544E2001A_42983EB4E606_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_42983EB4E606_impl*
end;//TkwMainWindowParentZonePanel.GetResultTypeInfo

function TkwMainWindowParentZonePanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_42983EB4E606_var*
//#UC END# *559687E6025A_42983EB4E606_var*
begin
//#UC START# *559687E6025A_42983EB4E606_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_42983EB4E606_impl*
end;//TkwMainWindowParentZonePanel.GetAllParamsCount

function TkwMainWindowParentZonePanel.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_42983EB4E606_var*
//#UC END# *5617F4D00243_42983EB4E606_var*
begin
//#UC START# *5617F4D00243_42983EB4E606_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_42983EB4E606_impl*
end;//TkwMainWindowParentZonePanel.ParamsTypes

function TkwMainWindowChildZonePanel.ChildZonePanel(const aCtx: TtfwContext;
 aMainWindow: TnsMainWindow): TvtSizeablePanel;
 {* Реализация слова скрипта .TnsMainWindow.ChildZonePanel }
//#UC START# *35D0EA46C2E7_815BB0E77000_var*
//#UC END# *35D0EA46C2E7_815BB0E77000_var*
begin
//#UC START# *35D0EA46C2E7_815BB0E77000_impl*
 !!! Needs to be implemented !!!
//#UC END# *35D0EA46C2E7_815BB0E77000_impl*
end;//TkwMainWindowChildZonePanel.ChildZonePanel

procedure TkwMainWindowChildZonePanel.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_815BB0E77000_var*
//#UC END# *4DAEEDE10285_815BB0E77000_var*
begin
//#UC START# *4DAEEDE10285_815BB0E77000_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_815BB0E77000_impl*
end;//TkwMainWindowChildZonePanel.DoDoIt

class function TkwMainWindowChildZonePanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TnsMainWindow.ChildZonePanel';
end;//TkwMainWindowChildZonePanel.GetWordNameForRegister

procedure TkwMainWindowChildZonePanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_815BB0E77000_var*
//#UC END# *52D00B00031A_815BB0E77000_var*
begin
//#UC START# *52D00B00031A_815BB0E77000_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_815BB0E77000_impl*
end;//TkwMainWindowChildZonePanel.SetValuePrim

function TkwMainWindowChildZonePanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_815BB0E77000_var*
//#UC END# *551544E2001A_815BB0E77000_var*
begin
//#UC START# *551544E2001A_815BB0E77000_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_815BB0E77000_impl*
end;//TkwMainWindowChildZonePanel.GetResultTypeInfo

function TkwMainWindowChildZonePanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_815BB0E77000_var*
//#UC END# *559687E6025A_815BB0E77000_var*
begin
//#UC START# *559687E6025A_815BB0E77000_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_815BB0E77000_impl*
end;//TkwMainWindowChildZonePanel.GetAllParamsCount

function TkwMainWindowChildZonePanel.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_815BB0E77000_var*
//#UC END# *5617F4D00243_815BB0E77000_var*
begin
//#UC START# *5617F4D00243_815BB0E77000_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_815BB0E77000_impl*
end;//TkwMainWindowChildZonePanel.ParamsTypes

function TkwMainWindowBaseSearchPanel.BaseSearchPanel(const aCtx: TtfwContext;
 aMainWindow: TnsMainWindow): TvtPanel;
 {* Реализация слова скрипта .TnsMainWindow.BaseSearchPanel }
//#UC START# *6C03BAF08409_0BBD18013246_var*
//#UC END# *6C03BAF08409_0BBD18013246_var*
begin
//#UC START# *6C03BAF08409_0BBD18013246_impl*
 !!! Needs to be implemented !!!
//#UC END# *6C03BAF08409_0BBD18013246_impl*
end;//TkwMainWindowBaseSearchPanel.BaseSearchPanel

procedure TkwMainWindowBaseSearchPanel.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_0BBD18013246_var*
//#UC END# *4DAEEDE10285_0BBD18013246_var*
begin
//#UC START# *4DAEEDE10285_0BBD18013246_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_0BBD18013246_impl*
end;//TkwMainWindowBaseSearchPanel.DoDoIt

class function TkwMainWindowBaseSearchPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TnsMainWindow.BaseSearchPanel';
end;//TkwMainWindowBaseSearchPanel.GetWordNameForRegister

procedure TkwMainWindowBaseSearchPanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_0BBD18013246_var*
//#UC END# *52D00B00031A_0BBD18013246_var*
begin
//#UC START# *52D00B00031A_0BBD18013246_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_0BBD18013246_impl*
end;//TkwMainWindowBaseSearchPanel.SetValuePrim

function TkwMainWindowBaseSearchPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_0BBD18013246_var*
//#UC END# *551544E2001A_0BBD18013246_var*
begin
//#UC START# *551544E2001A_0BBD18013246_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_0BBD18013246_impl*
end;//TkwMainWindowBaseSearchPanel.GetResultTypeInfo

function TkwMainWindowBaseSearchPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_0BBD18013246_var*
//#UC END# *559687E6025A_0BBD18013246_var*
begin
//#UC START# *559687E6025A_0BBD18013246_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_0BBD18013246_impl*
end;//TkwMainWindowBaseSearchPanel.GetAllParamsCount

function TkwMainWindowBaseSearchPanel.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_0BBD18013246_var*
//#UC END# *5617F4D00243_0BBD18013246_var*
begin
//#UC START# *5617F4D00243_0BBD18013246_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_0BBD18013246_impl*
end;//TkwMainWindowBaseSearchPanel.ParamsTypes

function TkwMainWindowLeftNavigator.LeftNavigator(const aCtx: TtfwContext;
 aMainWindow: TnsMainWindow): TnscNavigator;
 {* Реализация слова скрипта .TnsMainWindow.LeftNavigator }
//#UC START# *44132250FA6E_BDCC906B453B_var*
//#UC END# *44132250FA6E_BDCC906B453B_var*
begin
//#UC START# *44132250FA6E_BDCC906B453B_impl*
 !!! Needs to be implemented !!!
//#UC END# *44132250FA6E_BDCC906B453B_impl*
end;//TkwMainWindowLeftNavigator.LeftNavigator

procedure TkwMainWindowLeftNavigator.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_BDCC906B453B_var*
//#UC END# *4DAEEDE10285_BDCC906B453B_var*
begin
//#UC START# *4DAEEDE10285_BDCC906B453B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_BDCC906B453B_impl*
end;//TkwMainWindowLeftNavigator.DoDoIt

class function TkwMainWindowLeftNavigator.GetWordNameForRegister: AnsiString;
begin
 Result := '.TnsMainWindow.LeftNavigator';
end;//TkwMainWindowLeftNavigator.GetWordNameForRegister

procedure TkwMainWindowLeftNavigator.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_BDCC906B453B_var*
//#UC END# *52D00B00031A_BDCC906B453B_var*
begin
//#UC START# *52D00B00031A_BDCC906B453B_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_BDCC906B453B_impl*
end;//TkwMainWindowLeftNavigator.SetValuePrim

function TkwMainWindowLeftNavigator.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_BDCC906B453B_var*
//#UC END# *551544E2001A_BDCC906B453B_var*
begin
//#UC START# *551544E2001A_BDCC906B453B_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_BDCC906B453B_impl*
end;//TkwMainWindowLeftNavigator.GetResultTypeInfo

function TkwMainWindowLeftNavigator.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_BDCC906B453B_var*
//#UC END# *559687E6025A_BDCC906B453B_var*
begin
//#UC START# *559687E6025A_BDCC906B453B_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_BDCC906B453B_impl*
end;//TkwMainWindowLeftNavigator.GetAllParamsCount

function TkwMainWindowLeftNavigator.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_BDCC906B453B_var*
//#UC END# *5617F4D00243_BDCC906B453B_var*
begin
//#UC START# *5617F4D00243_BDCC906B453B_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_BDCC906B453B_impl*
end;//TkwMainWindowLeftNavigator.ParamsTypes

{$If Defined(HasRightNavigator)}
function TkwMainWindowRightNavigator.RightNavigator(const aCtx: TtfwContext;
 aMainWindow: TnsMainWindow): TnscNavigator;
 {* Реализация слова скрипта .TnsMainWindow.RightNavigator }
//#UC START# *A3B067FF2276_E38152ED8F57_var*
//#UC END# *A3B067FF2276_E38152ED8F57_var*
begin
//#UC START# *A3B067FF2276_E38152ED8F57_impl*
 !!! Needs to be implemented !!!
//#UC END# *A3B067FF2276_E38152ED8F57_impl*
end;//TkwMainWindowRightNavigator.RightNavigator
{$IfEnd} // Defined(HasRightNavigator)

procedure TkwMainWindowRightNavigator.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_E38152ED8F57_var*
//#UC END# *4DAEEDE10285_E38152ED8F57_var*
begin
//#UC START# *4DAEEDE10285_E38152ED8F57_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_E38152ED8F57_impl*
end;//TkwMainWindowRightNavigator.DoDoIt

class function TkwMainWindowRightNavigator.GetWordNameForRegister: AnsiString;
begin
 Result := '.TnsMainWindow.RightNavigator';
end;//TkwMainWindowRightNavigator.GetWordNameForRegister

procedure TkwMainWindowRightNavigator.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_E38152ED8F57_var*
//#UC END# *52D00B00031A_E38152ED8F57_var*
begin
//#UC START# *52D00B00031A_E38152ED8F57_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_E38152ED8F57_impl*
end;//TkwMainWindowRightNavigator.SetValuePrim

function TkwMainWindowRightNavigator.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_E38152ED8F57_var*
//#UC END# *551544E2001A_E38152ED8F57_var*
begin
//#UC START# *551544E2001A_E38152ED8F57_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_E38152ED8F57_impl*
end;//TkwMainWindowRightNavigator.GetResultTypeInfo

function TkwMainWindowRightNavigator.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_E38152ED8F57_var*
//#UC END# *559687E6025A_E38152ED8F57_var*
begin
//#UC START# *559687E6025A_E38152ED8F57_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_E38152ED8F57_impl*
end;//TkwMainWindowRightNavigator.GetAllParamsCount

function TkwMainWindowRightNavigator.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_E38152ED8F57_var*
//#UC END# *5617F4D00243_E38152ED8F57_var*
begin
//#UC START# *5617F4D00243_E38152ED8F57_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_E38152ED8F57_impl*
end;//TkwMainWindowRightNavigator.ParamsTypes

initialization
 Tkw_Form_MainWindow.RegisterInEngine;
 {* Регистрация Tkw_Form_MainWindow }
 Tkw_MainWindow_Control_remOnlineDead.RegisterInEngine;
 {* Регистрация Tkw_MainWindow_Control_remOnlineDead }
 Tkw_MainWindow_Control_remOnlineDead_Push.RegisterInEngine;
 {* Регистрация Tkw_MainWindow_Control_remOnlineDead_Push }
 Tkw_MainWindow_Control_remNewChatMessages.RegisterInEngine;
 {* Регистрация Tkw_MainWindow_Control_remNewChatMessages }
 Tkw_MainWindow_Control_remNewChatMessages_Push.RegisterInEngine;
 {* Регистрация Tkw_MainWindow_Control_remNewChatMessages_Push }
 Tkw_MainWindow_Control_TrialModeWarning.RegisterInEngine;
 {* Регистрация Tkw_MainWindow_Control_TrialModeWarning }
 Tkw_MainWindow_Control_TrialModeWarning_Push.RegisterInEngine;
 {* Регистрация Tkw_MainWindow_Control_TrialModeWarning_Push }
 Tkw_MainWindow_Control_OldBaseWarning.RegisterInEngine;
 {* Регистрация Tkw_MainWindow_Control_OldBaseWarning }
 Tkw_MainWindow_Control_OldBaseWarning_Push.RegisterInEngine;
 {* Регистрация Tkw_MainWindow_Control_OldBaseWarning_Push }
 Tkw_MainWindow_Control_RemindersLine.RegisterInEngine;
 {* Регистрация Tkw_MainWindow_Control_RemindersLine }
 Tkw_MainWindow_Control_RemindersLine_Push.RegisterInEngine;
 {* Регистрация Tkw_MainWindow_Control_RemindersLine_Push }
 Tkw_MainWindow_Control_ControlledChangingWarning.RegisterInEngine;
 {* Регистрация Tkw_MainWindow_Control_ControlledChangingWarning }
 Tkw_MainWindow_Control_ControlledChangingWarning_Push.RegisterInEngine;
 {* Регистрация Tkw_MainWindow_Control_ControlledChangingWarning_Push }
 Tkw_MainWindow_Control_remUnreadConsultations.RegisterInEngine;
 {* Регистрация Tkw_MainWindow_Control_remUnreadConsultations }
 Tkw_MainWindow_Control_remUnreadConsultations_Push.RegisterInEngine;
 {* Регистрация Tkw_MainWindow_Control_remUnreadConsultations_Push }
 Tkw_MainWindow_Control_StatusBar.RegisterInEngine;
 {* Регистрация Tkw_MainWindow_Control_StatusBar }
 Tkw_MainWindow_Control_StatusBar_Push.RegisterInEngine;
 {* Регистрация Tkw_MainWindow_Control_StatusBar_Push }
 Tkw_MainWindow_Control_ClientZone.RegisterInEngine;
 {* Регистрация Tkw_MainWindow_Control_ClientZone }
 Tkw_MainWindow_Control_ClientZone_Push.RegisterInEngine;
 {* Регистрация Tkw_MainWindow_Control_ClientZone_Push }
 Tkw_MainWindow_Control_MainZone.RegisterInEngine;
 {* Регистрация Tkw_MainWindow_Control_MainZone }
 Tkw_MainWindow_Control_MainZone_Push.RegisterInEngine;
 {* Регистрация Tkw_MainWindow_Control_MainZone_Push }
 Tkw_MainWindow_Control_ParentZonePanel.RegisterInEngine;
 {* Регистрация Tkw_MainWindow_Control_ParentZonePanel }
 Tkw_MainWindow_Control_ParentZonePanel_Push.RegisterInEngine;
 {* Регистрация Tkw_MainWindow_Control_ParentZonePanel_Push }
 Tkw_MainWindow_Control_ChildZonePanel.RegisterInEngine;
 {* Регистрация Tkw_MainWindow_Control_ChildZonePanel }
 Tkw_MainWindow_Control_ChildZonePanel_Push.RegisterInEngine;
 {* Регистрация Tkw_MainWindow_Control_ChildZonePanel_Push }
 Tkw_MainWindow_Control_BaseSearchPanel.RegisterInEngine;
 {* Регистрация Tkw_MainWindow_Control_BaseSearchPanel }
 Tkw_MainWindow_Control_BaseSearchPanel_Push.RegisterInEngine;
 {* Регистрация Tkw_MainWindow_Control_BaseSearchPanel_Push }
 Tkw_MainWindow_Control_LeftNavigator.RegisterInEngine;
 {* Регистрация Tkw_MainWindow_Control_LeftNavigator }
 Tkw_MainWindow_Control_LeftNavigator_Push.RegisterInEngine;
 {* Регистрация Tkw_MainWindow_Control_LeftNavigator_Push }
{$If Defined(HasRightNavigator)}
 Tkw_MainWindow_Control_RightNavigator.RegisterInEngine;
 {* Регистрация Tkw_MainWindow_Control_RightNavigator }
{$IfEnd} // Defined(HasRightNavigator)
{$If Defined(HasRightNavigator)}
 Tkw_MainWindow_Control_RightNavigator_Push.RegisterInEngine;
 {* Регистрация Tkw_MainWindow_Control_RightNavigator_Push }
{$IfEnd} // Defined(HasRightNavigator)
 TkwMainWindowRemOnlineDead.RegisterInEngine;
 {* Регистрация MainWindow_remOnlineDead }
 TkwMainWindowRemNewChatMessages.RegisterInEngine;
 {* Регистрация MainWindow_remNewChatMessages }
 TkwMainWindowTrialModeWarning.RegisterInEngine;
 {* Регистрация MainWindow_TrialModeWarning }
 TkwMainWindowOldBaseWarning.RegisterInEngine;
 {* Регистрация MainWindow_OldBaseWarning }
 TkwMainWindowRemindersLine.RegisterInEngine;
 {* Регистрация MainWindow_RemindersLine }
 TkwMainWindowControlledChangingWarning.RegisterInEngine;
 {* Регистрация MainWindow_ControlledChangingWarning }
 TkwMainWindowRemUnreadConsultations.RegisterInEngine;
 {* Регистрация MainWindow_remUnreadConsultations }
 TkwMainWindowStatusBar.RegisterInEngine;
 {* Регистрация MainWindow_StatusBar }
 TkwMainWindowClientZone.RegisterInEngine;
 {* Регистрация MainWindow_ClientZone }
 TkwMainWindowMainZone.RegisterInEngine;
 {* Регистрация MainWindow_MainZone }
 TkwMainWindowParentZonePanel.RegisterInEngine;
 {* Регистрация MainWindow_ParentZonePanel }
 TkwMainWindowChildZonePanel.RegisterInEngine;
 {* Регистрация MainWindow_ChildZonePanel }
 TkwMainWindowBaseSearchPanel.RegisterInEngine;
 {* Регистрация MainWindow_BaseSearchPanel }
 TkwMainWindowLeftNavigator.RegisterInEngine;
 {* Регистрация MainWindow_LeftNavigator }
{$If Defined(HasRightNavigator)}
 TkwMainWindowRightNavigator.RegisterInEngine;
 {* Регистрация MainWindow_RightNavigator }
{$IfEnd} // Defined(HasRightNavigator)
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnsMainWindow));
 {* Регистрация типа MainWindow }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscReminder));
 {* Регистрация типа TnscReminder }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscRemindersLine));
 {* Регистрация типа TnscRemindersLine }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscStatusBar));
 {* Регистрация типа TnscStatusBar }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
 {* Регистрация типа TvtPanel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtProportionalPanel));
 {* Регистрация типа TvtProportionalPanel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtSizeablePanel));
 {* Регистрация типа TvtSizeablePanel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscNavigator));
 {* Регистрация типа TnscNavigator }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

end.
