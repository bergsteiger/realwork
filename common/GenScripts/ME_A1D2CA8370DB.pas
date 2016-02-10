unit TextKeywordsPack;
 {* Набор слов словаря для доступа к экземплярам контролов формы Text }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Document\TextKeywordsPack.pas"
// Стереотип: "ScriptKeywordsPack"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , Document_Module
 {$If Defined(Nemesis)}
 , nscRemindersLine
 {$IfEnd} // Defined(Nemesis)
 {$If Defined(Nemesis)}
 , nscReminder
 {$IfEnd} // Defined(Nemesis)
 , eeSubPanel
 , vtScrollBar
 {$If Defined(Nemesis)}
 , nscEditor
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
 {$If Defined(Nemesis)}
 , nscTextSource
 {$IfEnd} // Defined(Nemesis)
 , SysUtils
;

type
 Tkw_Form_Text = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора формы Text
----
*Пример использования*:
[code]
'aControl' форма::Text TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_Text

 Tkw_Text_Control_RemindersLine = {final} class(TtfwControlString)
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
 end;//Tkw_Text_Control_RemindersLine

 Tkw_Text_Control_RemindersLine_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола RemindersLine
----
*Пример использования*:
[code]
контрол::RemindersLine:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Text_Control_RemindersLine_Push

 Tkw_Text_Control_WarnTimeMachineException = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола WarnTimeMachineException
----
*Пример использования*:
[code]
контрол::WarnTimeMachineException TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_Text_Control_WarnTimeMachineException

 Tkw_Text_Control_WarnTimeMachineException_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола WarnTimeMachineException
----
*Пример использования*:
[code]
контрол::WarnTimeMachineException:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Text_Control_WarnTimeMachineException_Push

 Tkw_Text_Control_WarnIsAbolished = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола WarnIsAbolished
----
*Пример использования*:
[code]
контрол::WarnIsAbolished TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_Text_Control_WarnIsAbolished

 Tkw_Text_Control_WarnIsAbolished_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола WarnIsAbolished
----
*Пример использования*:
[code]
контрол::WarnIsAbolished:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Text_Control_WarnIsAbolished_Push

 Tkw_Text_Control_WarnPreActive = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола WarnPreActive
----
*Пример использования*:
[code]
контрол::WarnPreActive TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_Text_Control_WarnPreActive

 Tkw_Text_Control_WarnPreActive_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола WarnPreActive
----
*Пример использования*:
[code]
контрол::WarnPreActive:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Text_Control_WarnPreActive_Push

 Tkw_Text_Control_WarnTimeMachineWarning = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола WarnTimeMachineWarning
----
*Пример использования*:
[code]
контрол::WarnTimeMachineWarning TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_Text_Control_WarnTimeMachineWarning

 Tkw_Text_Control_WarnTimeMachineWarning_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола WarnTimeMachineWarning
----
*Пример использования*:
[code]
контрол::WarnTimeMachineWarning:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Text_Control_WarnTimeMachineWarning_Push

 Tkw_Text_Control_WarnOnControl = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола WarnOnControl
----
*Пример использования*:
[code]
контрол::WarnOnControl TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_Text_Control_WarnOnControl

 Tkw_Text_Control_WarnOnControl_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола WarnOnControl
----
*Пример использования*:
[code]
контрол::WarnOnControl:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Text_Control_WarnOnControl_Push

 Tkw_Text_Control_WarnJuror = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола WarnJuror
----
*Пример использования*:
[code]
контрол::WarnJuror TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_Text_Control_WarnJuror

 Tkw_Text_Control_WarnJuror_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола WarnJuror
----
*Пример использования*:
[code]
контрол::WarnJuror:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Text_Control_WarnJuror_Push

 Tkw_Text_Control_WarnRedaction = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола WarnRedaction
----
*Пример использования*:
[code]
контрол::WarnRedaction TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_Text_Control_WarnRedaction

 Tkw_Text_Control_WarnRedaction_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола WarnRedaction
----
*Пример использования*:
[code]
контрол::WarnRedaction:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Text_Control_WarnRedaction_Push

 Tkw_Text_Control_WarnInactualDocument = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола WarnInactualDocument
----
*Пример использования*:
[code]
контрол::WarnInactualDocument TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_Text_Control_WarnInactualDocument

 Tkw_Text_Control_WarnInactualDocument_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола WarnInactualDocument
----
*Пример использования*:
[code]
контрол::WarnInactualDocument:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Text_Control_WarnInactualDocument_Push

 Tkw_Text_Control_WarnTimeMachineOn = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола WarnTimeMachineOn
----
*Пример использования*:
[code]
контрол::WarnTimeMachineOn TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_Text_Control_WarnTimeMachineOn

 Tkw_Text_Control_WarnTimeMachineOn_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола WarnTimeMachineOn
----
*Пример использования*:
[code]
контрол::WarnTimeMachineOn:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Text_Control_WarnTimeMachineOn_Push

 Tkw_Text_Control_SubPanel = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола SubPanel
----
*Пример использования*:
[code]
контрол::SubPanel TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_Text_Control_SubPanel

 Tkw_Text_Control_SubPanel_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола SubPanel
----
*Пример использования*:
[code]
контрол::SubPanel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Text_Control_SubPanel_Push

 Tkw_Text_Control_HScroll = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола HScroll
----
*Пример использования*:
[code]
контрол::HScroll TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_Text_Control_HScroll

 Tkw_Text_Control_HScroll_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола HScroll
----
*Пример использования*:
[code]
контрол::HScroll:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Text_Control_HScroll_Push

 Tkw_Text_Control_Text = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола Text
----
*Пример использования*:
[code]
контрол::Text TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_Text_Control_Text

 Tkw_Text_Control_Text_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола Text
----
*Пример использования*:
[code]
контрол::Text:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Text_Control_Text_Push

 Tkw_Text_Component_TextSource = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола TextSource
----
*Пример использования*:
[code]
компонент::TextSource TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_Text_Component_TextSource

 TkwTextFormRemindersLine = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TTextForm.RemindersLine
[panel]Контрол RemindersLine формы TTextForm[panel]
*Тип результата:* TnscRemindersLine
*Пример:*
[code]
OBJECT VAR l_TnscRemindersLine
 aTextForm .TTextForm.RemindersLine >>> l_TnscRemindersLine
[code]  }
  private
   function RemindersLine(const aCtx: TtfwContext;
    aTextForm: TTextForm): TnscRemindersLine;
    {* Реализация слова скрипта .TTextForm.RemindersLine }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwTextFormRemindersLine

 TkwTextFormWarnTimeMachineException = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TTextForm.WarnTimeMachineException
[panel]Контрол WarnTimeMachineException формы TTextForm[panel]
*Тип результата:* TnscReminder
*Пример:*
[code]
OBJECT VAR l_TnscReminder
 aTextForm .TTextForm.WarnTimeMachineException >>> l_TnscReminder
[code]  }
  private
   function WarnTimeMachineException(const aCtx: TtfwContext;
    aTextForm: TTextForm): TnscReminder;
    {* Реализация слова скрипта .TTextForm.WarnTimeMachineException }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwTextFormWarnTimeMachineException

 TkwTextFormWarnIsAbolished = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TTextForm.WarnIsAbolished
[panel]Контрол WarnIsAbolished формы TTextForm[panel]
*Тип результата:* TnscReminder
*Пример:*
[code]
OBJECT VAR l_TnscReminder
 aTextForm .TTextForm.WarnIsAbolished >>> l_TnscReminder
[code]  }
  private
   function WarnIsAbolished(const aCtx: TtfwContext;
    aTextForm: TTextForm): TnscReminder;
    {* Реализация слова скрипта .TTextForm.WarnIsAbolished }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwTextFormWarnIsAbolished

 TkwTextFormWarnPreActive = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TTextForm.WarnPreActive
[panel]Контрол WarnPreActive формы TTextForm[panel]
*Тип результата:* TnscReminder
*Пример:*
[code]
OBJECT VAR l_TnscReminder
 aTextForm .TTextForm.WarnPreActive >>> l_TnscReminder
[code]  }
  private
   function WarnPreActive(const aCtx: TtfwContext;
    aTextForm: TTextForm): TnscReminder;
    {* Реализация слова скрипта .TTextForm.WarnPreActive }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwTextFormWarnPreActive

 TkwTextFormWarnTimeMachineWarning = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TTextForm.WarnTimeMachineWarning
[panel]Контрол WarnTimeMachineWarning формы TTextForm[panel]
*Тип результата:* TnscReminder
*Пример:*
[code]
OBJECT VAR l_TnscReminder
 aTextForm .TTextForm.WarnTimeMachineWarning >>> l_TnscReminder
[code]  }
  private
   function WarnTimeMachineWarning(const aCtx: TtfwContext;
    aTextForm: TTextForm): TnscReminder;
    {* Реализация слова скрипта .TTextForm.WarnTimeMachineWarning }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwTextFormWarnTimeMachineWarning

 TkwTextFormWarnOnControl = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TTextForm.WarnOnControl
[panel]Контрол WarnOnControl формы TTextForm[panel]
*Тип результата:* TnscReminder
*Пример:*
[code]
OBJECT VAR l_TnscReminder
 aTextForm .TTextForm.WarnOnControl >>> l_TnscReminder
[code]  }
  private
   function WarnOnControl(const aCtx: TtfwContext;
    aTextForm: TTextForm): TnscReminder;
    {* Реализация слова скрипта .TTextForm.WarnOnControl }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwTextFormWarnOnControl

 TkwTextFormWarnJuror = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TTextForm.WarnJuror
[panel]Контрол WarnJuror формы TTextForm[panel]
*Тип результата:* TnscReminder
*Пример:*
[code]
OBJECT VAR l_TnscReminder
 aTextForm .TTextForm.WarnJuror >>> l_TnscReminder
[code]  }
  private
   function WarnJuror(const aCtx: TtfwContext;
    aTextForm: TTextForm): TnscReminder;
    {* Реализация слова скрипта .TTextForm.WarnJuror }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwTextFormWarnJuror

 TkwTextFormWarnRedaction = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TTextForm.WarnRedaction
[panel]Контрол WarnRedaction формы TTextForm[panel]
*Тип результата:* TnscReminder
*Пример:*
[code]
OBJECT VAR l_TnscReminder
 aTextForm .TTextForm.WarnRedaction >>> l_TnscReminder
[code]  }
  private
   function WarnRedaction(const aCtx: TtfwContext;
    aTextForm: TTextForm): TnscReminder;
    {* Реализация слова скрипта .TTextForm.WarnRedaction }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwTextFormWarnRedaction

 TkwTextFormWarnInactualDocument = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TTextForm.WarnInactualDocument
[panel]Контрол WarnInactualDocument формы TTextForm[panel]
*Тип результата:* TnscReminder
*Пример:*
[code]
OBJECT VAR l_TnscReminder
 aTextForm .TTextForm.WarnInactualDocument >>> l_TnscReminder
[code]  }
  private
   function WarnInactualDocument(const aCtx: TtfwContext;
    aTextForm: TTextForm): TnscReminder;
    {* Реализация слова скрипта .TTextForm.WarnInactualDocument }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwTextFormWarnInactualDocument

 TkwTextFormWarnTimeMachineOn = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TTextForm.WarnTimeMachineOn
[panel]Контрол WarnTimeMachineOn формы TTextForm[panel]
*Тип результата:* TnscReminder
*Пример:*
[code]
OBJECT VAR l_TnscReminder
 aTextForm .TTextForm.WarnTimeMachineOn >>> l_TnscReminder
[code]  }
  private
   function WarnTimeMachineOn(const aCtx: TtfwContext;
    aTextForm: TTextForm): TnscReminder;
    {* Реализация слова скрипта .TTextForm.WarnTimeMachineOn }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwTextFormWarnTimeMachineOn

 TkwTextFormSubPanel = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TTextForm.SubPanel
[panel]Контрол SubPanel формы TTextForm[panel]
*Тип результата:* TeeSubPanel
*Пример:*
[code]
OBJECT VAR l_TeeSubPanel
 aTextForm .TTextForm.SubPanel >>> l_TeeSubPanel
[code]  }
  private
   function SubPanel(const aCtx: TtfwContext;
    aTextForm: TTextForm): TeeSubPanel;
    {* Реализация слова скрипта .TTextForm.SubPanel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwTextFormSubPanel

 TkwTextFormHScroll = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TTextForm.HScroll
[panel]Контрол HScroll формы TTextForm[panel]
*Тип результата:* TvtScrollBar
*Пример:*
[code]
OBJECT VAR l_TvtScrollBar
 aTextForm .TTextForm.HScroll >>> l_TvtScrollBar
[code]  }
  private
   function HScroll(const aCtx: TtfwContext;
    aTextForm: TTextForm): TvtScrollBar;
    {* Реализация слова скрипта .TTextForm.HScroll }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwTextFormHScroll

 TkwTextFormText = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TTextForm.Text
[panel]Контрол Text формы TTextForm[panel]
*Тип результата:* TnscEditor
*Пример:*
[code]
OBJECT VAR l_TnscEditor
 aTextForm .TTextForm.Text >>> l_TnscEditor
[code]  }
  private
   function Text(const aCtx: TtfwContext;
    aTextForm: TTextForm): TnscEditor;
    {* Реализация слова скрипта .TTextForm.Text }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwTextFormText

class function Tkw_Form_Text.GetWordNameForRegister: AnsiString;
begin
 Result := 'форма::Text';
end;//Tkw_Form_Text.GetWordNameForRegister

function Tkw_Form_Text.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_54668E91A87D_var*
//#UC END# *4DDFD2EA0116_54668E91A87D_var*
begin
//#UC START# *4DDFD2EA0116_54668E91A87D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_54668E91A87D_impl*
end;//Tkw_Form_Text.GetString

class function Tkw_Text_Control_RemindersLine.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::RemindersLine';
end;//Tkw_Text_Control_RemindersLine.GetWordNameForRegister

function Tkw_Text_Control_RemindersLine.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_052115F90E31_var*
//#UC END# *4DDFD2EA0116_052115F90E31_var*
begin
//#UC START# *4DDFD2EA0116_052115F90E31_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_052115F90E31_impl*
end;//Tkw_Text_Control_RemindersLine.GetString

class procedure Tkw_Text_Control_RemindersLine.RegisterInEngine;
//#UC START# *52A086150180_052115F90E31_var*
//#UC END# *52A086150180_052115F90E31_var*
begin
//#UC START# *52A086150180_052115F90E31_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_052115F90E31_impl*
end;//Tkw_Text_Control_RemindersLine.RegisterInEngine

procedure Tkw_Text_Control_RemindersLine_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_705F38EF6FAD_var*
//#UC END# *4DAEEDE10285_705F38EF6FAD_var*
begin
//#UC START# *4DAEEDE10285_705F38EF6FAD_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_705F38EF6FAD_impl*
end;//Tkw_Text_Control_RemindersLine_Push.DoDoIt

class function Tkw_Text_Control_RemindersLine_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::RemindersLine:push';
end;//Tkw_Text_Control_RemindersLine_Push.GetWordNameForRegister

class function Tkw_Text_Control_WarnTimeMachineException.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::WarnTimeMachineException';
end;//Tkw_Text_Control_WarnTimeMachineException.GetWordNameForRegister

function Tkw_Text_Control_WarnTimeMachineException.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_DEF6126800AA_var*
//#UC END# *4DDFD2EA0116_DEF6126800AA_var*
begin
//#UC START# *4DDFD2EA0116_DEF6126800AA_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_DEF6126800AA_impl*
end;//Tkw_Text_Control_WarnTimeMachineException.GetString

class procedure Tkw_Text_Control_WarnTimeMachineException.RegisterInEngine;
//#UC START# *52A086150180_DEF6126800AA_var*
//#UC END# *52A086150180_DEF6126800AA_var*
begin
//#UC START# *52A086150180_DEF6126800AA_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_DEF6126800AA_impl*
end;//Tkw_Text_Control_WarnTimeMachineException.RegisterInEngine

procedure Tkw_Text_Control_WarnTimeMachineException_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_7382CA7FCA93_var*
//#UC END# *4DAEEDE10285_7382CA7FCA93_var*
begin
//#UC START# *4DAEEDE10285_7382CA7FCA93_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_7382CA7FCA93_impl*
end;//Tkw_Text_Control_WarnTimeMachineException_Push.DoDoIt

class function Tkw_Text_Control_WarnTimeMachineException_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::WarnTimeMachineException:push';
end;//Tkw_Text_Control_WarnTimeMachineException_Push.GetWordNameForRegister

class function Tkw_Text_Control_WarnIsAbolished.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::WarnIsAbolished';
end;//Tkw_Text_Control_WarnIsAbolished.GetWordNameForRegister

function Tkw_Text_Control_WarnIsAbolished.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_4B4C395CA1D9_var*
//#UC END# *4DDFD2EA0116_4B4C395CA1D9_var*
begin
//#UC START# *4DDFD2EA0116_4B4C395CA1D9_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_4B4C395CA1D9_impl*
end;//Tkw_Text_Control_WarnIsAbolished.GetString

class procedure Tkw_Text_Control_WarnIsAbolished.RegisterInEngine;
//#UC START# *52A086150180_4B4C395CA1D9_var*
//#UC END# *52A086150180_4B4C395CA1D9_var*
begin
//#UC START# *52A086150180_4B4C395CA1D9_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_4B4C395CA1D9_impl*
end;//Tkw_Text_Control_WarnIsAbolished.RegisterInEngine

procedure Tkw_Text_Control_WarnIsAbolished_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_9B6B2BD92876_var*
//#UC END# *4DAEEDE10285_9B6B2BD92876_var*
begin
//#UC START# *4DAEEDE10285_9B6B2BD92876_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_9B6B2BD92876_impl*
end;//Tkw_Text_Control_WarnIsAbolished_Push.DoDoIt

class function Tkw_Text_Control_WarnIsAbolished_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::WarnIsAbolished:push';
end;//Tkw_Text_Control_WarnIsAbolished_Push.GetWordNameForRegister

class function Tkw_Text_Control_WarnPreActive.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::WarnPreActive';
end;//Tkw_Text_Control_WarnPreActive.GetWordNameForRegister

function Tkw_Text_Control_WarnPreActive.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_19ABCBDFCC03_var*
//#UC END# *4DDFD2EA0116_19ABCBDFCC03_var*
begin
//#UC START# *4DDFD2EA0116_19ABCBDFCC03_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_19ABCBDFCC03_impl*
end;//Tkw_Text_Control_WarnPreActive.GetString

class procedure Tkw_Text_Control_WarnPreActive.RegisterInEngine;
//#UC START# *52A086150180_19ABCBDFCC03_var*
//#UC END# *52A086150180_19ABCBDFCC03_var*
begin
//#UC START# *52A086150180_19ABCBDFCC03_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_19ABCBDFCC03_impl*
end;//Tkw_Text_Control_WarnPreActive.RegisterInEngine

procedure Tkw_Text_Control_WarnPreActive_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_1A8F30B167E1_var*
//#UC END# *4DAEEDE10285_1A8F30B167E1_var*
begin
//#UC START# *4DAEEDE10285_1A8F30B167E1_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_1A8F30B167E1_impl*
end;//Tkw_Text_Control_WarnPreActive_Push.DoDoIt

class function Tkw_Text_Control_WarnPreActive_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::WarnPreActive:push';
end;//Tkw_Text_Control_WarnPreActive_Push.GetWordNameForRegister

class function Tkw_Text_Control_WarnTimeMachineWarning.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::WarnTimeMachineWarning';
end;//Tkw_Text_Control_WarnTimeMachineWarning.GetWordNameForRegister

function Tkw_Text_Control_WarnTimeMachineWarning.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_E8BFFCCDECA5_var*
//#UC END# *4DDFD2EA0116_E8BFFCCDECA5_var*
begin
//#UC START# *4DDFD2EA0116_E8BFFCCDECA5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_E8BFFCCDECA5_impl*
end;//Tkw_Text_Control_WarnTimeMachineWarning.GetString

class procedure Tkw_Text_Control_WarnTimeMachineWarning.RegisterInEngine;
//#UC START# *52A086150180_E8BFFCCDECA5_var*
//#UC END# *52A086150180_E8BFFCCDECA5_var*
begin
//#UC START# *52A086150180_E8BFFCCDECA5_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_E8BFFCCDECA5_impl*
end;//Tkw_Text_Control_WarnTimeMachineWarning.RegisterInEngine

procedure Tkw_Text_Control_WarnTimeMachineWarning_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_9AAF4745079D_var*
//#UC END# *4DAEEDE10285_9AAF4745079D_var*
begin
//#UC START# *4DAEEDE10285_9AAF4745079D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_9AAF4745079D_impl*
end;//Tkw_Text_Control_WarnTimeMachineWarning_Push.DoDoIt

class function Tkw_Text_Control_WarnTimeMachineWarning_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::WarnTimeMachineWarning:push';
end;//Tkw_Text_Control_WarnTimeMachineWarning_Push.GetWordNameForRegister

class function Tkw_Text_Control_WarnOnControl.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::WarnOnControl';
end;//Tkw_Text_Control_WarnOnControl.GetWordNameForRegister

function Tkw_Text_Control_WarnOnControl.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_675AF2C45E1D_var*
//#UC END# *4DDFD2EA0116_675AF2C45E1D_var*
begin
//#UC START# *4DDFD2EA0116_675AF2C45E1D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_675AF2C45E1D_impl*
end;//Tkw_Text_Control_WarnOnControl.GetString

class procedure Tkw_Text_Control_WarnOnControl.RegisterInEngine;
//#UC START# *52A086150180_675AF2C45E1D_var*
//#UC END# *52A086150180_675AF2C45E1D_var*
begin
//#UC START# *52A086150180_675AF2C45E1D_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_675AF2C45E1D_impl*
end;//Tkw_Text_Control_WarnOnControl.RegisterInEngine

procedure Tkw_Text_Control_WarnOnControl_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_DACA7322E9D7_var*
//#UC END# *4DAEEDE10285_DACA7322E9D7_var*
begin
//#UC START# *4DAEEDE10285_DACA7322E9D7_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_DACA7322E9D7_impl*
end;//Tkw_Text_Control_WarnOnControl_Push.DoDoIt

class function Tkw_Text_Control_WarnOnControl_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::WarnOnControl:push';
end;//Tkw_Text_Control_WarnOnControl_Push.GetWordNameForRegister

class function Tkw_Text_Control_WarnJuror.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::WarnJuror';
end;//Tkw_Text_Control_WarnJuror.GetWordNameForRegister

function Tkw_Text_Control_WarnJuror.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_023CC16EEAB5_var*
//#UC END# *4DDFD2EA0116_023CC16EEAB5_var*
begin
//#UC START# *4DDFD2EA0116_023CC16EEAB5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_023CC16EEAB5_impl*
end;//Tkw_Text_Control_WarnJuror.GetString

class procedure Tkw_Text_Control_WarnJuror.RegisterInEngine;
//#UC START# *52A086150180_023CC16EEAB5_var*
//#UC END# *52A086150180_023CC16EEAB5_var*
begin
//#UC START# *52A086150180_023CC16EEAB5_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_023CC16EEAB5_impl*
end;//Tkw_Text_Control_WarnJuror.RegisterInEngine

procedure Tkw_Text_Control_WarnJuror_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_827B012777A0_var*
//#UC END# *4DAEEDE10285_827B012777A0_var*
begin
//#UC START# *4DAEEDE10285_827B012777A0_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_827B012777A0_impl*
end;//Tkw_Text_Control_WarnJuror_Push.DoDoIt

class function Tkw_Text_Control_WarnJuror_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::WarnJuror:push';
end;//Tkw_Text_Control_WarnJuror_Push.GetWordNameForRegister

class function Tkw_Text_Control_WarnRedaction.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::WarnRedaction';
end;//Tkw_Text_Control_WarnRedaction.GetWordNameForRegister

function Tkw_Text_Control_WarnRedaction.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_9FA2347EEFA1_var*
//#UC END# *4DDFD2EA0116_9FA2347EEFA1_var*
begin
//#UC START# *4DDFD2EA0116_9FA2347EEFA1_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_9FA2347EEFA1_impl*
end;//Tkw_Text_Control_WarnRedaction.GetString

class procedure Tkw_Text_Control_WarnRedaction.RegisterInEngine;
//#UC START# *52A086150180_9FA2347EEFA1_var*
//#UC END# *52A086150180_9FA2347EEFA1_var*
begin
//#UC START# *52A086150180_9FA2347EEFA1_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_9FA2347EEFA1_impl*
end;//Tkw_Text_Control_WarnRedaction.RegisterInEngine

procedure Tkw_Text_Control_WarnRedaction_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_85711541F333_var*
//#UC END# *4DAEEDE10285_85711541F333_var*
begin
//#UC START# *4DAEEDE10285_85711541F333_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_85711541F333_impl*
end;//Tkw_Text_Control_WarnRedaction_Push.DoDoIt

class function Tkw_Text_Control_WarnRedaction_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::WarnRedaction:push';
end;//Tkw_Text_Control_WarnRedaction_Push.GetWordNameForRegister

class function Tkw_Text_Control_WarnInactualDocument.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::WarnInactualDocument';
end;//Tkw_Text_Control_WarnInactualDocument.GetWordNameForRegister

function Tkw_Text_Control_WarnInactualDocument.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_24364DDE0BA9_var*
//#UC END# *4DDFD2EA0116_24364DDE0BA9_var*
begin
//#UC START# *4DDFD2EA0116_24364DDE0BA9_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_24364DDE0BA9_impl*
end;//Tkw_Text_Control_WarnInactualDocument.GetString

class procedure Tkw_Text_Control_WarnInactualDocument.RegisterInEngine;
//#UC START# *52A086150180_24364DDE0BA9_var*
//#UC END# *52A086150180_24364DDE0BA9_var*
begin
//#UC START# *52A086150180_24364DDE0BA9_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_24364DDE0BA9_impl*
end;//Tkw_Text_Control_WarnInactualDocument.RegisterInEngine

procedure Tkw_Text_Control_WarnInactualDocument_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_B463B41ABC32_var*
//#UC END# *4DAEEDE10285_B463B41ABC32_var*
begin
//#UC START# *4DAEEDE10285_B463B41ABC32_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_B463B41ABC32_impl*
end;//Tkw_Text_Control_WarnInactualDocument_Push.DoDoIt

class function Tkw_Text_Control_WarnInactualDocument_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::WarnInactualDocument:push';
end;//Tkw_Text_Control_WarnInactualDocument_Push.GetWordNameForRegister

class function Tkw_Text_Control_WarnTimeMachineOn.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::WarnTimeMachineOn';
end;//Tkw_Text_Control_WarnTimeMachineOn.GetWordNameForRegister

function Tkw_Text_Control_WarnTimeMachineOn.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_58E81681C256_var*
//#UC END# *4DDFD2EA0116_58E81681C256_var*
begin
//#UC START# *4DDFD2EA0116_58E81681C256_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_58E81681C256_impl*
end;//Tkw_Text_Control_WarnTimeMachineOn.GetString

class procedure Tkw_Text_Control_WarnTimeMachineOn.RegisterInEngine;
//#UC START# *52A086150180_58E81681C256_var*
//#UC END# *52A086150180_58E81681C256_var*
begin
//#UC START# *52A086150180_58E81681C256_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_58E81681C256_impl*
end;//Tkw_Text_Control_WarnTimeMachineOn.RegisterInEngine

procedure Tkw_Text_Control_WarnTimeMachineOn_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_A5FA5EA83009_var*
//#UC END# *4DAEEDE10285_A5FA5EA83009_var*
begin
//#UC START# *4DAEEDE10285_A5FA5EA83009_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_A5FA5EA83009_impl*
end;//Tkw_Text_Control_WarnTimeMachineOn_Push.DoDoIt

class function Tkw_Text_Control_WarnTimeMachineOn_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::WarnTimeMachineOn:push';
end;//Tkw_Text_Control_WarnTimeMachineOn_Push.GetWordNameForRegister

class function Tkw_Text_Control_SubPanel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::SubPanel';
end;//Tkw_Text_Control_SubPanel.GetWordNameForRegister

function Tkw_Text_Control_SubPanel.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_CD43667354E1_var*
//#UC END# *4DDFD2EA0116_CD43667354E1_var*
begin
//#UC START# *4DDFD2EA0116_CD43667354E1_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_CD43667354E1_impl*
end;//Tkw_Text_Control_SubPanel.GetString

class procedure Tkw_Text_Control_SubPanel.RegisterInEngine;
//#UC START# *52A086150180_CD43667354E1_var*
//#UC END# *52A086150180_CD43667354E1_var*
begin
//#UC START# *52A086150180_CD43667354E1_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_CD43667354E1_impl*
end;//Tkw_Text_Control_SubPanel.RegisterInEngine

procedure Tkw_Text_Control_SubPanel_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_7120B4F0E306_var*
//#UC END# *4DAEEDE10285_7120B4F0E306_var*
begin
//#UC START# *4DAEEDE10285_7120B4F0E306_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_7120B4F0E306_impl*
end;//Tkw_Text_Control_SubPanel_Push.DoDoIt

class function Tkw_Text_Control_SubPanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::SubPanel:push';
end;//Tkw_Text_Control_SubPanel_Push.GetWordNameForRegister

class function Tkw_Text_Control_HScroll.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::HScroll';
end;//Tkw_Text_Control_HScroll.GetWordNameForRegister

function Tkw_Text_Control_HScroll.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_16902FCE5398_var*
//#UC END# *4DDFD2EA0116_16902FCE5398_var*
begin
//#UC START# *4DDFD2EA0116_16902FCE5398_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_16902FCE5398_impl*
end;//Tkw_Text_Control_HScroll.GetString

class procedure Tkw_Text_Control_HScroll.RegisterInEngine;
//#UC START# *52A086150180_16902FCE5398_var*
//#UC END# *52A086150180_16902FCE5398_var*
begin
//#UC START# *52A086150180_16902FCE5398_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_16902FCE5398_impl*
end;//Tkw_Text_Control_HScroll.RegisterInEngine

procedure Tkw_Text_Control_HScroll_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_A6BC0890EC0E_var*
//#UC END# *4DAEEDE10285_A6BC0890EC0E_var*
begin
//#UC START# *4DAEEDE10285_A6BC0890EC0E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_A6BC0890EC0E_impl*
end;//Tkw_Text_Control_HScroll_Push.DoDoIt

class function Tkw_Text_Control_HScroll_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::HScroll:push';
end;//Tkw_Text_Control_HScroll_Push.GetWordNameForRegister

class function Tkw_Text_Control_Text.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::Text';
end;//Tkw_Text_Control_Text.GetWordNameForRegister

function Tkw_Text_Control_Text.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_8F6A8A39D5FF_var*
//#UC END# *4DDFD2EA0116_8F6A8A39D5FF_var*
begin
//#UC START# *4DDFD2EA0116_8F6A8A39D5FF_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_8F6A8A39D5FF_impl*
end;//Tkw_Text_Control_Text.GetString

class procedure Tkw_Text_Control_Text.RegisterInEngine;
//#UC START# *52A086150180_8F6A8A39D5FF_var*
//#UC END# *52A086150180_8F6A8A39D5FF_var*
begin
//#UC START# *52A086150180_8F6A8A39D5FF_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_8F6A8A39D5FF_impl*
end;//Tkw_Text_Control_Text.RegisterInEngine

procedure Tkw_Text_Control_Text_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_6F8D09395591_var*
//#UC END# *4DAEEDE10285_6F8D09395591_var*
begin
//#UC START# *4DAEEDE10285_6F8D09395591_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_6F8D09395591_impl*
end;//Tkw_Text_Control_Text_Push.DoDoIt

class function Tkw_Text_Control_Text_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::Text:push';
end;//Tkw_Text_Control_Text_Push.GetWordNameForRegister

class function Tkw_Text_Component_TextSource.GetWordNameForRegister: AnsiString;
begin
 Result := 'компонент::TextSource';
end;//Tkw_Text_Component_TextSource.GetWordNameForRegister

function Tkw_Text_Component_TextSource.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_571A9A0C7CA4_var*
//#UC END# *4DDFD2EA0116_571A9A0C7CA4_var*
begin
//#UC START# *4DDFD2EA0116_571A9A0C7CA4_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_571A9A0C7CA4_impl*
end;//Tkw_Text_Component_TextSource.GetString

class procedure Tkw_Text_Component_TextSource.RegisterInEngine;
//#UC START# *52A086150180_571A9A0C7CA4_var*
//#UC END# *52A086150180_571A9A0C7CA4_var*
begin
//#UC START# *52A086150180_571A9A0C7CA4_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_571A9A0C7CA4_impl*
end;//Tkw_Text_Component_TextSource.RegisterInEngine

function TkwTextFormRemindersLine.RemindersLine(const aCtx: TtfwContext;
 aTextForm: TTextForm): TnscRemindersLine;
 {* Реализация слова скрипта .TTextForm.RemindersLine }
//#UC START# *5C1B18ECBF63_90150A717339_var*
//#UC END# *5C1B18ECBF63_90150A717339_var*
begin
//#UC START# *5C1B18ECBF63_90150A717339_impl*
 !!! Needs to be implemented !!!
//#UC END# *5C1B18ECBF63_90150A717339_impl*
end;//TkwTextFormRemindersLine.RemindersLine

procedure TkwTextFormRemindersLine.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_90150A717339_var*
//#UC END# *4DAEEDE10285_90150A717339_var*
begin
//#UC START# *4DAEEDE10285_90150A717339_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_90150A717339_impl*
end;//TkwTextFormRemindersLine.DoDoIt

class function TkwTextFormRemindersLine.GetWordNameForRegister: AnsiString;
begin
 Result := '.TTextForm.RemindersLine';
end;//TkwTextFormRemindersLine.GetWordNameForRegister

procedure TkwTextFormRemindersLine.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
var l_: ;
begin
end;//TkwTextFormRemindersLine.SetValuePrim

function TkwTextFormRemindersLine.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscRemindersLine);
end;//TkwTextFormRemindersLine.GetResultTypeInfo

function TkwTextFormRemindersLine.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwTextFormRemindersLine.GetAllParamsCount

function TkwTextFormRemindersLine.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwTextFormRemindersLine.ParamsTypes

function TkwTextFormWarnTimeMachineException.WarnTimeMachineException(const aCtx: TtfwContext;
 aTextForm: TTextForm): TnscReminder;
 {* Реализация слова скрипта .TTextForm.WarnTimeMachineException }
//#UC START# *7204E1977248_727D705B6FA2_var*
//#UC END# *7204E1977248_727D705B6FA2_var*
begin
//#UC START# *7204E1977248_727D705B6FA2_impl*
 !!! Needs to be implemented !!!
//#UC END# *7204E1977248_727D705B6FA2_impl*
end;//TkwTextFormWarnTimeMachineException.WarnTimeMachineException

procedure TkwTextFormWarnTimeMachineException.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_727D705B6FA2_var*
//#UC END# *4DAEEDE10285_727D705B6FA2_var*
begin
//#UC START# *4DAEEDE10285_727D705B6FA2_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_727D705B6FA2_impl*
end;//TkwTextFormWarnTimeMachineException.DoDoIt

class function TkwTextFormWarnTimeMachineException.GetWordNameForRegister: AnsiString;
begin
 Result := '.TTextForm.WarnTimeMachineException';
end;//TkwTextFormWarnTimeMachineException.GetWordNameForRegister

procedure TkwTextFormWarnTimeMachineException.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
var l_: ;
begin
end;//TkwTextFormWarnTimeMachineException.SetValuePrim

function TkwTextFormWarnTimeMachineException.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscReminder);
end;//TkwTextFormWarnTimeMachineException.GetResultTypeInfo

function TkwTextFormWarnTimeMachineException.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwTextFormWarnTimeMachineException.GetAllParamsCount

function TkwTextFormWarnTimeMachineException.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwTextFormWarnTimeMachineException.ParamsTypes

function TkwTextFormWarnIsAbolished.WarnIsAbolished(const aCtx: TtfwContext;
 aTextForm: TTextForm): TnscReminder;
 {* Реализация слова скрипта .TTextForm.WarnIsAbolished }
//#UC START# *62D1EC129E50_0289BC4D5C98_var*
//#UC END# *62D1EC129E50_0289BC4D5C98_var*
begin
//#UC START# *62D1EC129E50_0289BC4D5C98_impl*
 !!! Needs to be implemented !!!
//#UC END# *62D1EC129E50_0289BC4D5C98_impl*
end;//TkwTextFormWarnIsAbolished.WarnIsAbolished

procedure TkwTextFormWarnIsAbolished.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_0289BC4D5C98_var*
//#UC END# *4DAEEDE10285_0289BC4D5C98_var*
begin
//#UC START# *4DAEEDE10285_0289BC4D5C98_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_0289BC4D5C98_impl*
end;//TkwTextFormWarnIsAbolished.DoDoIt

class function TkwTextFormWarnIsAbolished.GetWordNameForRegister: AnsiString;
begin
 Result := '.TTextForm.WarnIsAbolished';
end;//TkwTextFormWarnIsAbolished.GetWordNameForRegister

procedure TkwTextFormWarnIsAbolished.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
var l_: ;
begin
end;//TkwTextFormWarnIsAbolished.SetValuePrim

function TkwTextFormWarnIsAbolished.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscReminder);
end;//TkwTextFormWarnIsAbolished.GetResultTypeInfo

function TkwTextFormWarnIsAbolished.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwTextFormWarnIsAbolished.GetAllParamsCount

function TkwTextFormWarnIsAbolished.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwTextFormWarnIsAbolished.ParamsTypes

function TkwTextFormWarnPreActive.WarnPreActive(const aCtx: TtfwContext;
 aTextForm: TTextForm): TnscReminder;
 {* Реализация слова скрипта .TTextForm.WarnPreActive }
//#UC START# *90B5AAE8958B_ACA021C09FCA_var*
//#UC END# *90B5AAE8958B_ACA021C09FCA_var*
begin
//#UC START# *90B5AAE8958B_ACA021C09FCA_impl*
 !!! Needs to be implemented !!!
//#UC END# *90B5AAE8958B_ACA021C09FCA_impl*
end;//TkwTextFormWarnPreActive.WarnPreActive

procedure TkwTextFormWarnPreActive.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_ACA021C09FCA_var*
//#UC END# *4DAEEDE10285_ACA021C09FCA_var*
begin
//#UC START# *4DAEEDE10285_ACA021C09FCA_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_ACA021C09FCA_impl*
end;//TkwTextFormWarnPreActive.DoDoIt

class function TkwTextFormWarnPreActive.GetWordNameForRegister: AnsiString;
begin
 Result := '.TTextForm.WarnPreActive';
end;//TkwTextFormWarnPreActive.GetWordNameForRegister

procedure TkwTextFormWarnPreActive.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
var l_: ;
begin
end;//TkwTextFormWarnPreActive.SetValuePrim

function TkwTextFormWarnPreActive.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscReminder);
end;//TkwTextFormWarnPreActive.GetResultTypeInfo

function TkwTextFormWarnPreActive.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwTextFormWarnPreActive.GetAllParamsCount

function TkwTextFormWarnPreActive.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwTextFormWarnPreActive.ParamsTypes

function TkwTextFormWarnTimeMachineWarning.WarnTimeMachineWarning(const aCtx: TtfwContext;
 aTextForm: TTextForm): TnscReminder;
 {* Реализация слова скрипта .TTextForm.WarnTimeMachineWarning }
//#UC START# *CEECA0E17A15_E6CBDC26628D_var*
//#UC END# *CEECA0E17A15_E6CBDC26628D_var*
begin
//#UC START# *CEECA0E17A15_E6CBDC26628D_impl*
 !!! Needs to be implemented !!!
//#UC END# *CEECA0E17A15_E6CBDC26628D_impl*
end;//TkwTextFormWarnTimeMachineWarning.WarnTimeMachineWarning

procedure TkwTextFormWarnTimeMachineWarning.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_E6CBDC26628D_var*
//#UC END# *4DAEEDE10285_E6CBDC26628D_var*
begin
//#UC START# *4DAEEDE10285_E6CBDC26628D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_E6CBDC26628D_impl*
end;//TkwTextFormWarnTimeMachineWarning.DoDoIt

class function TkwTextFormWarnTimeMachineWarning.GetWordNameForRegister: AnsiString;
begin
 Result := '.TTextForm.WarnTimeMachineWarning';
end;//TkwTextFormWarnTimeMachineWarning.GetWordNameForRegister

procedure TkwTextFormWarnTimeMachineWarning.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
var l_: ;
begin
end;//TkwTextFormWarnTimeMachineWarning.SetValuePrim

function TkwTextFormWarnTimeMachineWarning.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscReminder);
end;//TkwTextFormWarnTimeMachineWarning.GetResultTypeInfo

function TkwTextFormWarnTimeMachineWarning.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwTextFormWarnTimeMachineWarning.GetAllParamsCount

function TkwTextFormWarnTimeMachineWarning.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwTextFormWarnTimeMachineWarning.ParamsTypes

function TkwTextFormWarnOnControl.WarnOnControl(const aCtx: TtfwContext;
 aTextForm: TTextForm): TnscReminder;
 {* Реализация слова скрипта .TTextForm.WarnOnControl }
//#UC START# *D7453CC0AD49_9EC0F704660C_var*
//#UC END# *D7453CC0AD49_9EC0F704660C_var*
begin
//#UC START# *D7453CC0AD49_9EC0F704660C_impl*
 !!! Needs to be implemented !!!
//#UC END# *D7453CC0AD49_9EC0F704660C_impl*
end;//TkwTextFormWarnOnControl.WarnOnControl

procedure TkwTextFormWarnOnControl.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_9EC0F704660C_var*
//#UC END# *4DAEEDE10285_9EC0F704660C_var*
begin
//#UC START# *4DAEEDE10285_9EC0F704660C_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_9EC0F704660C_impl*
end;//TkwTextFormWarnOnControl.DoDoIt

class function TkwTextFormWarnOnControl.GetWordNameForRegister: AnsiString;
begin
 Result := '.TTextForm.WarnOnControl';
end;//TkwTextFormWarnOnControl.GetWordNameForRegister

procedure TkwTextFormWarnOnControl.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
var l_: ;
begin
end;//TkwTextFormWarnOnControl.SetValuePrim

function TkwTextFormWarnOnControl.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscReminder);
end;//TkwTextFormWarnOnControl.GetResultTypeInfo

function TkwTextFormWarnOnControl.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwTextFormWarnOnControl.GetAllParamsCount

function TkwTextFormWarnOnControl.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwTextFormWarnOnControl.ParamsTypes

function TkwTextFormWarnJuror.WarnJuror(const aCtx: TtfwContext;
 aTextForm: TTextForm): TnscReminder;
 {* Реализация слова скрипта .TTextForm.WarnJuror }
//#UC START# *8E2BB46865BA_FF3DC6808151_var*
//#UC END# *8E2BB46865BA_FF3DC6808151_var*
begin
//#UC START# *8E2BB46865BA_FF3DC6808151_impl*
 !!! Needs to be implemented !!!
//#UC END# *8E2BB46865BA_FF3DC6808151_impl*
end;//TkwTextFormWarnJuror.WarnJuror

procedure TkwTextFormWarnJuror.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_FF3DC6808151_var*
//#UC END# *4DAEEDE10285_FF3DC6808151_var*
begin
//#UC START# *4DAEEDE10285_FF3DC6808151_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_FF3DC6808151_impl*
end;//TkwTextFormWarnJuror.DoDoIt

class function TkwTextFormWarnJuror.GetWordNameForRegister: AnsiString;
begin
 Result := '.TTextForm.WarnJuror';
end;//TkwTextFormWarnJuror.GetWordNameForRegister

procedure TkwTextFormWarnJuror.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
var l_: ;
begin
end;//TkwTextFormWarnJuror.SetValuePrim

function TkwTextFormWarnJuror.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscReminder);
end;//TkwTextFormWarnJuror.GetResultTypeInfo

function TkwTextFormWarnJuror.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwTextFormWarnJuror.GetAllParamsCount

function TkwTextFormWarnJuror.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwTextFormWarnJuror.ParamsTypes

function TkwTextFormWarnRedaction.WarnRedaction(const aCtx: TtfwContext;
 aTextForm: TTextForm): TnscReminder;
 {* Реализация слова скрипта .TTextForm.WarnRedaction }
//#UC START# *5F6752825CB9_C6F656F5F519_var*
//#UC END# *5F6752825CB9_C6F656F5F519_var*
begin
//#UC START# *5F6752825CB9_C6F656F5F519_impl*
 !!! Needs to be implemented !!!
//#UC END# *5F6752825CB9_C6F656F5F519_impl*
end;//TkwTextFormWarnRedaction.WarnRedaction

procedure TkwTextFormWarnRedaction.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_C6F656F5F519_var*
//#UC END# *4DAEEDE10285_C6F656F5F519_var*
begin
//#UC START# *4DAEEDE10285_C6F656F5F519_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_C6F656F5F519_impl*
end;//TkwTextFormWarnRedaction.DoDoIt

class function TkwTextFormWarnRedaction.GetWordNameForRegister: AnsiString;
begin
 Result := '.TTextForm.WarnRedaction';
end;//TkwTextFormWarnRedaction.GetWordNameForRegister

procedure TkwTextFormWarnRedaction.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
var l_: ;
begin
end;//TkwTextFormWarnRedaction.SetValuePrim

function TkwTextFormWarnRedaction.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscReminder);
end;//TkwTextFormWarnRedaction.GetResultTypeInfo

function TkwTextFormWarnRedaction.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwTextFormWarnRedaction.GetAllParamsCount

function TkwTextFormWarnRedaction.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwTextFormWarnRedaction.ParamsTypes

function TkwTextFormWarnInactualDocument.WarnInactualDocument(const aCtx: TtfwContext;
 aTextForm: TTextForm): TnscReminder;
 {* Реализация слова скрипта .TTextForm.WarnInactualDocument }
//#UC START# *8C366D3E7DC7_DFD5690970AB_var*
//#UC END# *8C366D3E7DC7_DFD5690970AB_var*
begin
//#UC START# *8C366D3E7DC7_DFD5690970AB_impl*
 !!! Needs to be implemented !!!
//#UC END# *8C366D3E7DC7_DFD5690970AB_impl*
end;//TkwTextFormWarnInactualDocument.WarnInactualDocument

procedure TkwTextFormWarnInactualDocument.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_DFD5690970AB_var*
//#UC END# *4DAEEDE10285_DFD5690970AB_var*
begin
//#UC START# *4DAEEDE10285_DFD5690970AB_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_DFD5690970AB_impl*
end;//TkwTextFormWarnInactualDocument.DoDoIt

class function TkwTextFormWarnInactualDocument.GetWordNameForRegister: AnsiString;
begin
 Result := '.TTextForm.WarnInactualDocument';
end;//TkwTextFormWarnInactualDocument.GetWordNameForRegister

procedure TkwTextFormWarnInactualDocument.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
var l_: ;
begin
end;//TkwTextFormWarnInactualDocument.SetValuePrim

function TkwTextFormWarnInactualDocument.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscReminder);
end;//TkwTextFormWarnInactualDocument.GetResultTypeInfo

function TkwTextFormWarnInactualDocument.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwTextFormWarnInactualDocument.GetAllParamsCount

function TkwTextFormWarnInactualDocument.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwTextFormWarnInactualDocument.ParamsTypes

function TkwTextFormWarnTimeMachineOn.WarnTimeMachineOn(const aCtx: TtfwContext;
 aTextForm: TTextForm): TnscReminder;
 {* Реализация слова скрипта .TTextForm.WarnTimeMachineOn }
//#UC START# *D936833CFC11_3F2343F5CBC9_var*
//#UC END# *D936833CFC11_3F2343F5CBC9_var*
begin
//#UC START# *D936833CFC11_3F2343F5CBC9_impl*
 !!! Needs to be implemented !!!
//#UC END# *D936833CFC11_3F2343F5CBC9_impl*
end;//TkwTextFormWarnTimeMachineOn.WarnTimeMachineOn

procedure TkwTextFormWarnTimeMachineOn.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_3F2343F5CBC9_var*
//#UC END# *4DAEEDE10285_3F2343F5CBC9_var*
begin
//#UC START# *4DAEEDE10285_3F2343F5CBC9_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_3F2343F5CBC9_impl*
end;//TkwTextFormWarnTimeMachineOn.DoDoIt

class function TkwTextFormWarnTimeMachineOn.GetWordNameForRegister: AnsiString;
begin
 Result := '.TTextForm.WarnTimeMachineOn';
end;//TkwTextFormWarnTimeMachineOn.GetWordNameForRegister

procedure TkwTextFormWarnTimeMachineOn.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
var l_: ;
begin
end;//TkwTextFormWarnTimeMachineOn.SetValuePrim

function TkwTextFormWarnTimeMachineOn.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscReminder);
end;//TkwTextFormWarnTimeMachineOn.GetResultTypeInfo

function TkwTextFormWarnTimeMachineOn.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwTextFormWarnTimeMachineOn.GetAllParamsCount

function TkwTextFormWarnTimeMachineOn.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwTextFormWarnTimeMachineOn.ParamsTypes

function TkwTextFormSubPanel.SubPanel(const aCtx: TtfwContext;
 aTextForm: TTextForm): TeeSubPanel;
 {* Реализация слова скрипта .TTextForm.SubPanel }
//#UC START# *E71980FD0EA4_F953CE4B1F89_var*
//#UC END# *E71980FD0EA4_F953CE4B1F89_var*
begin
//#UC START# *E71980FD0EA4_F953CE4B1F89_impl*
 !!! Needs to be implemented !!!
//#UC END# *E71980FD0EA4_F953CE4B1F89_impl*
end;//TkwTextFormSubPanel.SubPanel

procedure TkwTextFormSubPanel.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_F953CE4B1F89_var*
//#UC END# *4DAEEDE10285_F953CE4B1F89_var*
begin
//#UC START# *4DAEEDE10285_F953CE4B1F89_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_F953CE4B1F89_impl*
end;//TkwTextFormSubPanel.DoDoIt

class function TkwTextFormSubPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TTextForm.SubPanel';
end;//TkwTextFormSubPanel.GetWordNameForRegister

procedure TkwTextFormSubPanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
var l_: ;
begin
end;//TkwTextFormSubPanel.SetValuePrim

function TkwTextFormSubPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TeeSubPanel);
end;//TkwTextFormSubPanel.GetResultTypeInfo

function TkwTextFormSubPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwTextFormSubPanel.GetAllParamsCount

function TkwTextFormSubPanel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwTextFormSubPanel.ParamsTypes

function TkwTextFormHScroll.HScroll(const aCtx: TtfwContext;
 aTextForm: TTextForm): TvtScrollBar;
 {* Реализация слова скрипта .TTextForm.HScroll }
//#UC START# *96D869DFC10A_61746557FDD0_var*
//#UC END# *96D869DFC10A_61746557FDD0_var*
begin
//#UC START# *96D869DFC10A_61746557FDD0_impl*
 !!! Needs to be implemented !!!
//#UC END# *96D869DFC10A_61746557FDD0_impl*
end;//TkwTextFormHScroll.HScroll

procedure TkwTextFormHScroll.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_61746557FDD0_var*
//#UC END# *4DAEEDE10285_61746557FDD0_var*
begin
//#UC START# *4DAEEDE10285_61746557FDD0_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_61746557FDD0_impl*
end;//TkwTextFormHScroll.DoDoIt

class function TkwTextFormHScroll.GetWordNameForRegister: AnsiString;
begin
 Result := '.TTextForm.HScroll';
end;//TkwTextFormHScroll.GetWordNameForRegister

procedure TkwTextFormHScroll.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
var l_: ;
begin
end;//TkwTextFormHScroll.SetValuePrim

function TkwTextFormHScroll.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtScrollBar);
end;//TkwTextFormHScroll.GetResultTypeInfo

function TkwTextFormHScroll.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwTextFormHScroll.GetAllParamsCount

function TkwTextFormHScroll.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwTextFormHScroll.ParamsTypes

function TkwTextFormText.Text(const aCtx: TtfwContext;
 aTextForm: TTextForm): TnscEditor;
 {* Реализация слова скрипта .TTextForm.Text }
//#UC START# *49D5A37A19A6_AFA1F527A874_var*
//#UC END# *49D5A37A19A6_AFA1F527A874_var*
begin
//#UC START# *49D5A37A19A6_AFA1F527A874_impl*
 !!! Needs to be implemented !!!
//#UC END# *49D5A37A19A6_AFA1F527A874_impl*
end;//TkwTextFormText.Text

procedure TkwTextFormText.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_AFA1F527A874_var*
//#UC END# *4DAEEDE10285_AFA1F527A874_var*
begin
//#UC START# *4DAEEDE10285_AFA1F527A874_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_AFA1F527A874_impl*
end;//TkwTextFormText.DoDoIt

class function TkwTextFormText.GetWordNameForRegister: AnsiString;
begin
 Result := '.TTextForm.Text';
end;//TkwTextFormText.GetWordNameForRegister

procedure TkwTextFormText.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
var l_: ;
begin
end;//TkwTextFormText.SetValuePrim

function TkwTextFormText.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscEditor);
end;//TkwTextFormText.GetResultTypeInfo

function TkwTextFormText.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwTextFormText.GetAllParamsCount

function TkwTextFormText.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwTextFormText.ParamsTypes

initialization
 Tkw_Form_Text.RegisterInEngine;
 {* Регистрация Tkw_Form_Text }
 Tkw_Text_Control_RemindersLine.RegisterInEngine;
 {* Регистрация Tkw_Text_Control_RemindersLine }
 Tkw_Text_Control_RemindersLine_Push.RegisterInEngine;
 {* Регистрация Tkw_Text_Control_RemindersLine_Push }
 Tkw_Text_Control_WarnTimeMachineException.RegisterInEngine;
 {* Регистрация Tkw_Text_Control_WarnTimeMachineException }
 Tkw_Text_Control_WarnTimeMachineException_Push.RegisterInEngine;
 {* Регистрация Tkw_Text_Control_WarnTimeMachineException_Push }
 Tkw_Text_Control_WarnIsAbolished.RegisterInEngine;
 {* Регистрация Tkw_Text_Control_WarnIsAbolished }
 Tkw_Text_Control_WarnIsAbolished_Push.RegisterInEngine;
 {* Регистрация Tkw_Text_Control_WarnIsAbolished_Push }
 Tkw_Text_Control_WarnPreActive.RegisterInEngine;
 {* Регистрация Tkw_Text_Control_WarnPreActive }
 Tkw_Text_Control_WarnPreActive_Push.RegisterInEngine;
 {* Регистрация Tkw_Text_Control_WarnPreActive_Push }
 Tkw_Text_Control_WarnTimeMachineWarning.RegisterInEngine;
 {* Регистрация Tkw_Text_Control_WarnTimeMachineWarning }
 Tkw_Text_Control_WarnTimeMachineWarning_Push.RegisterInEngine;
 {* Регистрация Tkw_Text_Control_WarnTimeMachineWarning_Push }
 Tkw_Text_Control_WarnOnControl.RegisterInEngine;
 {* Регистрация Tkw_Text_Control_WarnOnControl }
 Tkw_Text_Control_WarnOnControl_Push.RegisterInEngine;
 {* Регистрация Tkw_Text_Control_WarnOnControl_Push }
 Tkw_Text_Control_WarnJuror.RegisterInEngine;
 {* Регистрация Tkw_Text_Control_WarnJuror }
 Tkw_Text_Control_WarnJuror_Push.RegisterInEngine;
 {* Регистрация Tkw_Text_Control_WarnJuror_Push }
 Tkw_Text_Control_WarnRedaction.RegisterInEngine;
 {* Регистрация Tkw_Text_Control_WarnRedaction }
 Tkw_Text_Control_WarnRedaction_Push.RegisterInEngine;
 {* Регистрация Tkw_Text_Control_WarnRedaction_Push }
 Tkw_Text_Control_WarnInactualDocument.RegisterInEngine;
 {* Регистрация Tkw_Text_Control_WarnInactualDocument }
 Tkw_Text_Control_WarnInactualDocument_Push.RegisterInEngine;
 {* Регистрация Tkw_Text_Control_WarnInactualDocument_Push }
 Tkw_Text_Control_WarnTimeMachineOn.RegisterInEngine;
 {* Регистрация Tkw_Text_Control_WarnTimeMachineOn }
 Tkw_Text_Control_WarnTimeMachineOn_Push.RegisterInEngine;
 {* Регистрация Tkw_Text_Control_WarnTimeMachineOn_Push }
 Tkw_Text_Control_SubPanel.RegisterInEngine;
 {* Регистрация Tkw_Text_Control_SubPanel }
 Tkw_Text_Control_SubPanel_Push.RegisterInEngine;
 {* Регистрация Tkw_Text_Control_SubPanel_Push }
 Tkw_Text_Control_HScroll.RegisterInEngine;
 {* Регистрация Tkw_Text_Control_HScroll }
 Tkw_Text_Control_HScroll_Push.RegisterInEngine;
 {* Регистрация Tkw_Text_Control_HScroll_Push }
 Tkw_Text_Control_Text.RegisterInEngine;
 {* Регистрация Tkw_Text_Control_Text }
 Tkw_Text_Control_Text_Push.RegisterInEngine;
 {* Регистрация Tkw_Text_Control_Text_Push }
 Tkw_Text_Component_TextSource.RegisterInEngine;
 {* Регистрация Tkw_Text_Component_TextSource }
 TkwTextFormRemindersLine.RegisterInEngine;
 {* Регистрация TextForm_RemindersLine }
 TkwTextFormWarnTimeMachineException.RegisterInEngine;
 {* Регистрация TextForm_WarnTimeMachineException }
 TkwTextFormWarnIsAbolished.RegisterInEngine;
 {* Регистрация TextForm_WarnIsAbolished }
 TkwTextFormWarnPreActive.RegisterInEngine;
 {* Регистрация TextForm_WarnPreActive }
 TkwTextFormWarnTimeMachineWarning.RegisterInEngine;
 {* Регистрация TextForm_WarnTimeMachineWarning }
 TkwTextFormWarnOnControl.RegisterInEngine;
 {* Регистрация TextForm_WarnOnControl }
 TkwTextFormWarnJuror.RegisterInEngine;
 {* Регистрация TextForm_WarnJuror }
 TkwTextFormWarnRedaction.RegisterInEngine;
 {* Регистрация TextForm_WarnRedaction }
 TkwTextFormWarnInactualDocument.RegisterInEngine;
 {* Регистрация TextForm_WarnInactualDocument }
 TkwTextFormWarnTimeMachineOn.RegisterInEngine;
 {* Регистрация TextForm_WarnTimeMachineOn }
 TkwTextFormSubPanel.RegisterInEngine;
 {* Регистрация TextForm_SubPanel }
 TkwTextFormHScroll.RegisterInEngine;
 {* Регистрация TextForm_HScroll }
 TkwTextFormText.RegisterInEngine;
 {* Регистрация TextForm_Text }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TTextForm));
 {* Регистрация типа Text }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscRemindersLine));
 {* Регистрация типа TnscRemindersLine }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscReminder));
 {* Регистрация типа TnscReminder }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TeeSubPanel));
 {* Регистрация типа TeeSubPanel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtScrollBar));
 {* Регистрация типа TvtScrollBar }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscEditor));
 {* Регистрация типа TnscEditor }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

end.
