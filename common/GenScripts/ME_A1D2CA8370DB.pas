unit TextKeywordsPack;
 {* ����� ���� ������� ��� ������� � ����������� ��������� ����� Text }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Document\TextKeywordsPack.pas"
// ���������: "ScriptKeywordsPack"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

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
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwControlString
 {$If NOT Defined(NoVCL)}
 , kwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 , tfwScriptingInterfaces
 , tfwPropertyLike
 , tfwTypeInfo
 , TypInfo
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
  {* ����� ������� ��� �������������� ����� Text
----
*������ �������������*:
[code]
'aControl' �����::Text TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_Text

 Tkw_Text_Control_RemindersLine = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� RemindersLine
----
*������ �������������*:
[code]
�������::RemindersLine TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_Text_Control_RemindersLine

 Tkw_Text_Control_RemindersLine_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� RemindersLine
----
*������ �������������*:
[code]
�������::RemindersLine:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Text_Control_RemindersLine_Push

 Tkw_Text_Control_WarnTimeMachineException = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� WarnTimeMachineException
----
*������ �������������*:
[code]
�������::WarnTimeMachineException TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_Text_Control_WarnTimeMachineException

 Tkw_Text_Control_WarnTimeMachineException_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� WarnTimeMachineException
----
*������ �������������*:
[code]
�������::WarnTimeMachineException:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Text_Control_WarnTimeMachineException_Push

 Tkw_Text_Control_WarnIsAbolished = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� WarnIsAbolished
----
*������ �������������*:
[code]
�������::WarnIsAbolished TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_Text_Control_WarnIsAbolished

 Tkw_Text_Control_WarnIsAbolished_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� WarnIsAbolished
----
*������ �������������*:
[code]
�������::WarnIsAbolished:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Text_Control_WarnIsAbolished_Push

 Tkw_Text_Control_WarnPreActive = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� WarnPreActive
----
*������ �������������*:
[code]
�������::WarnPreActive TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_Text_Control_WarnPreActive

 Tkw_Text_Control_WarnPreActive_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� WarnPreActive
----
*������ �������������*:
[code]
�������::WarnPreActive:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Text_Control_WarnPreActive_Push

 Tkw_Text_Control_WarnTimeMachineWarning = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� WarnTimeMachineWarning
----
*������ �������������*:
[code]
�������::WarnTimeMachineWarning TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_Text_Control_WarnTimeMachineWarning

 Tkw_Text_Control_WarnTimeMachineWarning_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� WarnTimeMachineWarning
----
*������ �������������*:
[code]
�������::WarnTimeMachineWarning:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Text_Control_WarnTimeMachineWarning_Push

 Tkw_Text_Control_WarnOnControl = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� WarnOnControl
----
*������ �������������*:
[code]
�������::WarnOnControl TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_Text_Control_WarnOnControl

 Tkw_Text_Control_WarnOnControl_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� WarnOnControl
----
*������ �������������*:
[code]
�������::WarnOnControl:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Text_Control_WarnOnControl_Push

 Tkw_Text_Control_WarnJuror = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� WarnJuror
----
*������ �������������*:
[code]
�������::WarnJuror TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_Text_Control_WarnJuror

 Tkw_Text_Control_WarnJuror_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� WarnJuror
----
*������ �������������*:
[code]
�������::WarnJuror:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Text_Control_WarnJuror_Push

 Tkw_Text_Control_WarnRedaction = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� WarnRedaction
----
*������ �������������*:
[code]
�������::WarnRedaction TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_Text_Control_WarnRedaction

 Tkw_Text_Control_WarnRedaction_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� WarnRedaction
----
*������ �������������*:
[code]
�������::WarnRedaction:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Text_Control_WarnRedaction_Push

 Tkw_Text_Control_WarnInactualDocument = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� WarnInactualDocument
----
*������ �������������*:
[code]
�������::WarnInactualDocument TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_Text_Control_WarnInactualDocument

 Tkw_Text_Control_WarnInactualDocument_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� WarnInactualDocument
----
*������ �������������*:
[code]
�������::WarnInactualDocument:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Text_Control_WarnInactualDocument_Push

 Tkw_Text_Control_WarnTimeMachineOn = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� WarnTimeMachineOn
----
*������ �������������*:
[code]
�������::WarnTimeMachineOn TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_Text_Control_WarnTimeMachineOn

 Tkw_Text_Control_WarnTimeMachineOn_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� WarnTimeMachineOn
----
*������ �������������*:
[code]
�������::WarnTimeMachineOn:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Text_Control_WarnTimeMachineOn_Push

 Tkw_Text_Control_SubPanel = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� SubPanel
----
*������ �������������*:
[code]
�������::SubPanel TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_Text_Control_SubPanel

 Tkw_Text_Control_SubPanel_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� SubPanel
----
*������ �������������*:
[code]
�������::SubPanel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Text_Control_SubPanel_Push

 Tkw_Text_Control_HScroll = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� HScroll
----
*������ �������������*:
[code]
�������::HScroll TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_Text_Control_HScroll

 Tkw_Text_Control_HScroll_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� HScroll
----
*������ �������������*:
[code]
�������::HScroll:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Text_Control_HScroll_Push

 Tkw_Text_Control_Text = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� Text
----
*������ �������������*:
[code]
�������::Text TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_Text_Control_Text

 Tkw_Text_Control_Text_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� Text
----
*������ �������������*:
[code]
�������::Text:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Text_Control_Text_Push

 Tkw_Text_Component_TextSource = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� TextSource
----
*������ �������������*:
[code]
���������::TextSource TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_Text_Component_TextSource

 TkwTextFormRemindersLine = {final} class(TtfwPropertyLike)
  {* ����� ������� .TTextForm.RemindersLine
[panel]������� RemindersLine ����� TTextForm[panel]
*��� ����������:* TnscRemindersLine
*������:*
[code]
OBJECT VAR l_TnscRemindersLine
 aTextForm .TTextForm.RemindersLine >>> l_TnscRemindersLine
[code]  }
  private
   function RemindersLine(const aCtx: TtfwContext;
    aTextForm: TTextForm): TnscRemindersLine;
    {* ���������� ����� ������� .TTextForm.RemindersLine }
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
  {* ����� ������� .TTextForm.WarnTimeMachineException
[panel]������� WarnTimeMachineException ����� TTextForm[panel]
*��� ����������:* TnscReminder
*������:*
[code]
OBJECT VAR l_TnscReminder
 aTextForm .TTextForm.WarnTimeMachineException >>> l_TnscReminder
[code]  }
  private
   function WarnTimeMachineException(const aCtx: TtfwContext;
    aTextForm: TTextForm): TnscReminder;
    {* ���������� ����� ������� .TTextForm.WarnTimeMachineException }
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
  {* ����� ������� .TTextForm.WarnIsAbolished
[panel]������� WarnIsAbolished ����� TTextForm[panel]
*��� ����������:* TnscReminder
*������:*
[code]
OBJECT VAR l_TnscReminder
 aTextForm .TTextForm.WarnIsAbolished >>> l_TnscReminder
[code]  }
  private
   function WarnIsAbolished(const aCtx: TtfwContext;
    aTextForm: TTextForm): TnscReminder;
    {* ���������� ����� ������� .TTextForm.WarnIsAbolished }
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
  {* ����� ������� .TTextForm.WarnPreActive
[panel]������� WarnPreActive ����� TTextForm[panel]
*��� ����������:* TnscReminder
*������:*
[code]
OBJECT VAR l_TnscReminder
 aTextForm .TTextForm.WarnPreActive >>> l_TnscReminder
[code]  }
  private
   function WarnPreActive(const aCtx: TtfwContext;
    aTextForm: TTextForm): TnscReminder;
    {* ���������� ����� ������� .TTextForm.WarnPreActive }
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
  {* ����� ������� .TTextForm.WarnTimeMachineWarning
[panel]������� WarnTimeMachineWarning ����� TTextForm[panel]
*��� ����������:* TnscReminder
*������:*
[code]
OBJECT VAR l_TnscReminder
 aTextForm .TTextForm.WarnTimeMachineWarning >>> l_TnscReminder
[code]  }
  private
   function WarnTimeMachineWarning(const aCtx: TtfwContext;
    aTextForm: TTextForm): TnscReminder;
    {* ���������� ����� ������� .TTextForm.WarnTimeMachineWarning }
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
  {* ����� ������� .TTextForm.WarnOnControl
[panel]������� WarnOnControl ����� TTextForm[panel]
*��� ����������:* TnscReminder
*������:*
[code]
OBJECT VAR l_TnscReminder
 aTextForm .TTextForm.WarnOnControl >>> l_TnscReminder
[code]  }
  private
   function WarnOnControl(const aCtx: TtfwContext;
    aTextForm: TTextForm): TnscReminder;
    {* ���������� ����� ������� .TTextForm.WarnOnControl }
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
  {* ����� ������� .TTextForm.WarnJuror
[panel]������� WarnJuror ����� TTextForm[panel]
*��� ����������:* TnscReminder
*������:*
[code]
OBJECT VAR l_TnscReminder
 aTextForm .TTextForm.WarnJuror >>> l_TnscReminder
[code]  }
  private
   function WarnJuror(const aCtx: TtfwContext;
    aTextForm: TTextForm): TnscReminder;
    {* ���������� ����� ������� .TTextForm.WarnJuror }
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
  {* ����� ������� .TTextForm.WarnRedaction
[panel]������� WarnRedaction ����� TTextForm[panel]
*��� ����������:* TnscReminder
*������:*
[code]
OBJECT VAR l_TnscReminder
 aTextForm .TTextForm.WarnRedaction >>> l_TnscReminder
[code]  }
  private
   function WarnRedaction(const aCtx: TtfwContext;
    aTextForm: TTextForm): TnscReminder;
    {* ���������� ����� ������� .TTextForm.WarnRedaction }
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
  {* ����� ������� .TTextForm.WarnInactualDocument
[panel]������� WarnInactualDocument ����� TTextForm[panel]
*��� ����������:* TnscReminder
*������:*
[code]
OBJECT VAR l_TnscReminder
 aTextForm .TTextForm.WarnInactualDocument >>> l_TnscReminder
[code]  }
  private
   function WarnInactualDocument(const aCtx: TtfwContext;
    aTextForm: TTextForm): TnscReminder;
    {* ���������� ����� ������� .TTextForm.WarnInactualDocument }
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
  {* ����� ������� .TTextForm.WarnTimeMachineOn
[panel]������� WarnTimeMachineOn ����� TTextForm[panel]
*��� ����������:* TnscReminder
*������:*
[code]
OBJECT VAR l_TnscReminder
 aTextForm .TTextForm.WarnTimeMachineOn >>> l_TnscReminder
[code]  }
  private
   function WarnTimeMachineOn(const aCtx: TtfwContext;
    aTextForm: TTextForm): TnscReminder;
    {* ���������� ����� ������� .TTextForm.WarnTimeMachineOn }
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
  {* ����� ������� .TTextForm.SubPanel
[panel]������� SubPanel ����� TTextForm[panel]
*��� ����������:* TeeSubPanel
*������:*
[code]
OBJECT VAR l_TeeSubPanel
 aTextForm .TTextForm.SubPanel >>> l_TeeSubPanel
[code]  }
  private
   function SubPanel(const aCtx: TtfwContext;
    aTextForm: TTextForm): TeeSubPanel;
    {* ���������� ����� ������� .TTextForm.SubPanel }
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
  {* ����� ������� .TTextForm.HScroll
[panel]������� HScroll ����� TTextForm[panel]
*��� ����������:* TvtScrollBar
*������:*
[code]
OBJECT VAR l_TvtScrollBar
 aTextForm .TTextForm.HScroll >>> l_TvtScrollBar
[code]  }
  private
   function HScroll(const aCtx: TtfwContext;
    aTextForm: TTextForm): TvtScrollBar;
    {* ���������� ����� ������� .TTextForm.HScroll }
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
  {* ����� ������� .TTextForm.Text
[panel]������� Text ����� TTextForm[panel]
*��� ����������:* TnscEditor
*������:*
[code]
OBJECT VAR l_TnscEditor
 aTextForm .TTextForm.Text >>> l_TnscEditor
[code]  }
  private
   function Text(const aCtx: TtfwContext;
    aTextForm: TTextForm): TnscEditor;
    {* ���������� ����� ������� .TTextForm.Text }
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
 Result := '�����::Text';
end;//Tkw_Form_Text.GetWordNameForRegister

function Tkw_Form_Text.GetString: AnsiString;
begin
 Result := 'TextForm';
end;//Tkw_Form_Text.GetString

class function Tkw_Text_Control_RemindersLine.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::RemindersLine';
end;//Tkw_Text_Control_RemindersLine.GetWordNameForRegister

function Tkw_Text_Control_RemindersLine.GetString: AnsiString;
begin
 Result := 'RemindersLine';
end;//Tkw_Text_Control_RemindersLine.GetString

class procedure Tkw_Text_Control_RemindersLine.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscRemindersLine);
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
 Result := '�������::RemindersLine:push';
end;//Tkw_Text_Control_RemindersLine_Push.GetWordNameForRegister

class function Tkw_Text_Control_WarnTimeMachineException.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::WarnTimeMachineException';
end;//Tkw_Text_Control_WarnTimeMachineException.GetWordNameForRegister

function Tkw_Text_Control_WarnTimeMachineException.GetString: AnsiString;
begin
 Result := 'WarnTimeMachineException';
end;//Tkw_Text_Control_WarnTimeMachineException.GetString

class procedure Tkw_Text_Control_WarnTimeMachineException.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscReminder);
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
 Result := '�������::WarnTimeMachineException:push';
end;//Tkw_Text_Control_WarnTimeMachineException_Push.GetWordNameForRegister

class function Tkw_Text_Control_WarnIsAbolished.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::WarnIsAbolished';
end;//Tkw_Text_Control_WarnIsAbolished.GetWordNameForRegister

function Tkw_Text_Control_WarnIsAbolished.GetString: AnsiString;
begin
 Result := 'WarnIsAbolished';
end;//Tkw_Text_Control_WarnIsAbolished.GetString

class procedure Tkw_Text_Control_WarnIsAbolished.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscReminder);
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
 Result := '�������::WarnIsAbolished:push';
end;//Tkw_Text_Control_WarnIsAbolished_Push.GetWordNameForRegister

class function Tkw_Text_Control_WarnPreActive.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::WarnPreActive';
end;//Tkw_Text_Control_WarnPreActive.GetWordNameForRegister

function Tkw_Text_Control_WarnPreActive.GetString: AnsiString;
begin
 Result := 'WarnPreActive';
end;//Tkw_Text_Control_WarnPreActive.GetString

class procedure Tkw_Text_Control_WarnPreActive.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscReminder);
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
 Result := '�������::WarnPreActive:push';
end;//Tkw_Text_Control_WarnPreActive_Push.GetWordNameForRegister

class function Tkw_Text_Control_WarnTimeMachineWarning.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::WarnTimeMachineWarning';
end;//Tkw_Text_Control_WarnTimeMachineWarning.GetWordNameForRegister

function Tkw_Text_Control_WarnTimeMachineWarning.GetString: AnsiString;
begin
 Result := 'WarnTimeMachineWarning';
end;//Tkw_Text_Control_WarnTimeMachineWarning.GetString

class procedure Tkw_Text_Control_WarnTimeMachineWarning.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscReminder);
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
 Result := '�������::WarnTimeMachineWarning:push';
end;//Tkw_Text_Control_WarnTimeMachineWarning_Push.GetWordNameForRegister

class function Tkw_Text_Control_WarnOnControl.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::WarnOnControl';
end;//Tkw_Text_Control_WarnOnControl.GetWordNameForRegister

function Tkw_Text_Control_WarnOnControl.GetString: AnsiString;
begin
 Result := 'WarnOnControl';
end;//Tkw_Text_Control_WarnOnControl.GetString

class procedure Tkw_Text_Control_WarnOnControl.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscReminder);
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
 Result := '�������::WarnOnControl:push';
end;//Tkw_Text_Control_WarnOnControl_Push.GetWordNameForRegister

class function Tkw_Text_Control_WarnJuror.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::WarnJuror';
end;//Tkw_Text_Control_WarnJuror.GetWordNameForRegister

function Tkw_Text_Control_WarnJuror.GetString: AnsiString;
begin
 Result := 'WarnJuror';
end;//Tkw_Text_Control_WarnJuror.GetString

class procedure Tkw_Text_Control_WarnJuror.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscReminder);
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
 Result := '�������::WarnJuror:push';
end;//Tkw_Text_Control_WarnJuror_Push.GetWordNameForRegister

class function Tkw_Text_Control_WarnRedaction.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::WarnRedaction';
end;//Tkw_Text_Control_WarnRedaction.GetWordNameForRegister

function Tkw_Text_Control_WarnRedaction.GetString: AnsiString;
begin
 Result := 'WarnRedaction';
end;//Tkw_Text_Control_WarnRedaction.GetString

class procedure Tkw_Text_Control_WarnRedaction.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscReminder);
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
 Result := '�������::WarnRedaction:push';
end;//Tkw_Text_Control_WarnRedaction_Push.GetWordNameForRegister

class function Tkw_Text_Control_WarnInactualDocument.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::WarnInactualDocument';
end;//Tkw_Text_Control_WarnInactualDocument.GetWordNameForRegister

function Tkw_Text_Control_WarnInactualDocument.GetString: AnsiString;
begin
 Result := 'WarnInactualDocument';
end;//Tkw_Text_Control_WarnInactualDocument.GetString

class procedure Tkw_Text_Control_WarnInactualDocument.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscReminder);
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
 Result := '�������::WarnInactualDocument:push';
end;//Tkw_Text_Control_WarnInactualDocument_Push.GetWordNameForRegister

class function Tkw_Text_Control_WarnTimeMachineOn.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::WarnTimeMachineOn';
end;//Tkw_Text_Control_WarnTimeMachineOn.GetWordNameForRegister

function Tkw_Text_Control_WarnTimeMachineOn.GetString: AnsiString;
begin
 Result := 'WarnTimeMachineOn';
end;//Tkw_Text_Control_WarnTimeMachineOn.GetString

class procedure Tkw_Text_Control_WarnTimeMachineOn.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscReminder);
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
 Result := '�������::WarnTimeMachineOn:push';
end;//Tkw_Text_Control_WarnTimeMachineOn_Push.GetWordNameForRegister

class function Tkw_Text_Control_SubPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::SubPanel';
end;//Tkw_Text_Control_SubPanel.GetWordNameForRegister

function Tkw_Text_Control_SubPanel.GetString: AnsiString;
begin
 Result := 'SubPanel';
end;//Tkw_Text_Control_SubPanel.GetString

class procedure Tkw_Text_Control_SubPanel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TeeSubPanel);
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
 Result := '�������::SubPanel:push';
end;//Tkw_Text_Control_SubPanel_Push.GetWordNameForRegister

class function Tkw_Text_Control_HScroll.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::HScroll';
end;//Tkw_Text_Control_HScroll.GetWordNameForRegister

function Tkw_Text_Control_HScroll.GetString: AnsiString;
begin
 Result := 'HScroll';
end;//Tkw_Text_Control_HScroll.GetString

class procedure Tkw_Text_Control_HScroll.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtScrollBar);
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
 Result := '�������::HScroll:push';
end;//Tkw_Text_Control_HScroll_Push.GetWordNameForRegister

class function Tkw_Text_Control_Text.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::Text';
end;//Tkw_Text_Control_Text.GetWordNameForRegister

function Tkw_Text_Control_Text.GetString: AnsiString;
begin
 Result := 'Text';
end;//Tkw_Text_Control_Text.GetString

class procedure Tkw_Text_Control_Text.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscEditor);
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
 Result := '�������::Text:push';
end;//Tkw_Text_Control_Text_Push.GetWordNameForRegister

class function Tkw_Text_Component_TextSource.GetWordNameForRegister: AnsiString;
begin
 Result := '���������::TextSource';
end;//Tkw_Text_Component_TextSource.GetWordNameForRegister

function Tkw_Text_Component_TextSource.GetString: AnsiString;
begin
 Result := 'TextSource';
end;//Tkw_Text_Component_TextSource.GetString

class procedure Tkw_Text_Component_TextSource.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscTextSource);
end;//Tkw_Text_Component_TextSource.RegisterInEngine

function TkwTextFormRemindersLine.RemindersLine(const aCtx: TtfwContext;
 aTextForm: TTextForm): TnscRemindersLine;
 {* ���������� ����� ������� .TTextForm.RemindersLine }
begin
 Result := aTextForm.RemindersLine;
end;//TkwTextFormRemindersLine.RemindersLine

procedure TkwTextFormRemindersLine.DoDoIt(const aCtx: TtfwContext);
var l_aTextForm: TTextForm;
begin
 try
  l_aTextForm := TTextForm(aCtx.rEngine.PopObjAs(TTextForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aTextForm: TTextForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(RemindersLine(aCtx, l_aTextForm));
end;//TkwTextFormRemindersLine.DoDoIt

class function TkwTextFormRemindersLine.GetWordNameForRegister: AnsiString;
begin
 Result := '.TTextForm.RemindersLine';
end;//TkwTextFormRemindersLine.GetWordNameForRegister

procedure TkwTextFormRemindersLine.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� RemindersLine', aCtx);
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
 Result := OpenTypesToTypes([TypeInfo(TTextForm)]);
end;//TkwTextFormRemindersLine.ParamsTypes

function TkwTextFormWarnTimeMachineException.WarnTimeMachineException(const aCtx: TtfwContext;
 aTextForm: TTextForm): TnscReminder;
 {* ���������� ����� ������� .TTextForm.WarnTimeMachineException }
begin
 Result := aTextForm.WarnTimeMachineException;
end;//TkwTextFormWarnTimeMachineException.WarnTimeMachineException

procedure TkwTextFormWarnTimeMachineException.DoDoIt(const aCtx: TtfwContext);
var l_aTextForm: TTextForm;
begin
 try
  l_aTextForm := TTextForm(aCtx.rEngine.PopObjAs(TTextForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aTextForm: TTextForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(WarnTimeMachineException(aCtx, l_aTextForm));
end;//TkwTextFormWarnTimeMachineException.DoDoIt

class function TkwTextFormWarnTimeMachineException.GetWordNameForRegister: AnsiString;
begin
 Result := '.TTextForm.WarnTimeMachineException';
end;//TkwTextFormWarnTimeMachineException.GetWordNameForRegister

procedure TkwTextFormWarnTimeMachineException.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� WarnTimeMachineException', aCtx);
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
 Result := OpenTypesToTypes([TypeInfo(TTextForm)]);
end;//TkwTextFormWarnTimeMachineException.ParamsTypes

function TkwTextFormWarnIsAbolished.WarnIsAbolished(const aCtx: TtfwContext;
 aTextForm: TTextForm): TnscReminder;
 {* ���������� ����� ������� .TTextForm.WarnIsAbolished }
begin
 Result := aTextForm.WarnIsAbolished;
end;//TkwTextFormWarnIsAbolished.WarnIsAbolished

procedure TkwTextFormWarnIsAbolished.DoDoIt(const aCtx: TtfwContext);
var l_aTextForm: TTextForm;
begin
 try
  l_aTextForm := TTextForm(aCtx.rEngine.PopObjAs(TTextForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aTextForm: TTextForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(WarnIsAbolished(aCtx, l_aTextForm));
end;//TkwTextFormWarnIsAbolished.DoDoIt

class function TkwTextFormWarnIsAbolished.GetWordNameForRegister: AnsiString;
begin
 Result := '.TTextForm.WarnIsAbolished';
end;//TkwTextFormWarnIsAbolished.GetWordNameForRegister

procedure TkwTextFormWarnIsAbolished.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� WarnIsAbolished', aCtx);
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
 Result := OpenTypesToTypes([TypeInfo(TTextForm)]);
end;//TkwTextFormWarnIsAbolished.ParamsTypes

function TkwTextFormWarnPreActive.WarnPreActive(const aCtx: TtfwContext;
 aTextForm: TTextForm): TnscReminder;
 {* ���������� ����� ������� .TTextForm.WarnPreActive }
begin
 Result := aTextForm.WarnPreActive;
end;//TkwTextFormWarnPreActive.WarnPreActive

procedure TkwTextFormWarnPreActive.DoDoIt(const aCtx: TtfwContext);
var l_aTextForm: TTextForm;
begin
 try
  l_aTextForm := TTextForm(aCtx.rEngine.PopObjAs(TTextForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aTextForm: TTextForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(WarnPreActive(aCtx, l_aTextForm));
end;//TkwTextFormWarnPreActive.DoDoIt

class function TkwTextFormWarnPreActive.GetWordNameForRegister: AnsiString;
begin
 Result := '.TTextForm.WarnPreActive';
end;//TkwTextFormWarnPreActive.GetWordNameForRegister

procedure TkwTextFormWarnPreActive.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� WarnPreActive', aCtx);
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
 Result := OpenTypesToTypes([TypeInfo(TTextForm)]);
end;//TkwTextFormWarnPreActive.ParamsTypes

function TkwTextFormWarnTimeMachineWarning.WarnTimeMachineWarning(const aCtx: TtfwContext;
 aTextForm: TTextForm): TnscReminder;
 {* ���������� ����� ������� .TTextForm.WarnTimeMachineWarning }
begin
 Result := aTextForm.WarnTimeMachineWarning;
end;//TkwTextFormWarnTimeMachineWarning.WarnTimeMachineWarning

procedure TkwTextFormWarnTimeMachineWarning.DoDoIt(const aCtx: TtfwContext);
var l_aTextForm: TTextForm;
begin
 try
  l_aTextForm := TTextForm(aCtx.rEngine.PopObjAs(TTextForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aTextForm: TTextForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(WarnTimeMachineWarning(aCtx, l_aTextForm));
end;//TkwTextFormWarnTimeMachineWarning.DoDoIt

class function TkwTextFormWarnTimeMachineWarning.GetWordNameForRegister: AnsiString;
begin
 Result := '.TTextForm.WarnTimeMachineWarning';
end;//TkwTextFormWarnTimeMachineWarning.GetWordNameForRegister

procedure TkwTextFormWarnTimeMachineWarning.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� WarnTimeMachineWarning', aCtx);
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
 Result := OpenTypesToTypes([TypeInfo(TTextForm)]);
end;//TkwTextFormWarnTimeMachineWarning.ParamsTypes

function TkwTextFormWarnOnControl.WarnOnControl(const aCtx: TtfwContext;
 aTextForm: TTextForm): TnscReminder;
 {* ���������� ����� ������� .TTextForm.WarnOnControl }
begin
 Result := aTextForm.WarnOnControl;
end;//TkwTextFormWarnOnControl.WarnOnControl

procedure TkwTextFormWarnOnControl.DoDoIt(const aCtx: TtfwContext);
var l_aTextForm: TTextForm;
begin
 try
  l_aTextForm := TTextForm(aCtx.rEngine.PopObjAs(TTextForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aTextForm: TTextForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(WarnOnControl(aCtx, l_aTextForm));
end;//TkwTextFormWarnOnControl.DoDoIt

class function TkwTextFormWarnOnControl.GetWordNameForRegister: AnsiString;
begin
 Result := '.TTextForm.WarnOnControl';
end;//TkwTextFormWarnOnControl.GetWordNameForRegister

procedure TkwTextFormWarnOnControl.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� WarnOnControl', aCtx);
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
 Result := OpenTypesToTypes([TypeInfo(TTextForm)]);
end;//TkwTextFormWarnOnControl.ParamsTypes

function TkwTextFormWarnJuror.WarnJuror(const aCtx: TtfwContext;
 aTextForm: TTextForm): TnscReminder;
 {* ���������� ����� ������� .TTextForm.WarnJuror }
begin
 Result := aTextForm.WarnJuror;
end;//TkwTextFormWarnJuror.WarnJuror

procedure TkwTextFormWarnJuror.DoDoIt(const aCtx: TtfwContext);
var l_aTextForm: TTextForm;
begin
 try
  l_aTextForm := TTextForm(aCtx.rEngine.PopObjAs(TTextForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aTextForm: TTextForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(WarnJuror(aCtx, l_aTextForm));
end;//TkwTextFormWarnJuror.DoDoIt

class function TkwTextFormWarnJuror.GetWordNameForRegister: AnsiString;
begin
 Result := '.TTextForm.WarnJuror';
end;//TkwTextFormWarnJuror.GetWordNameForRegister

procedure TkwTextFormWarnJuror.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� WarnJuror', aCtx);
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
 Result := OpenTypesToTypes([TypeInfo(TTextForm)]);
end;//TkwTextFormWarnJuror.ParamsTypes

function TkwTextFormWarnRedaction.WarnRedaction(const aCtx: TtfwContext;
 aTextForm: TTextForm): TnscReminder;
 {* ���������� ����� ������� .TTextForm.WarnRedaction }
begin
 Result := aTextForm.WarnRedaction;
end;//TkwTextFormWarnRedaction.WarnRedaction

procedure TkwTextFormWarnRedaction.DoDoIt(const aCtx: TtfwContext);
var l_aTextForm: TTextForm;
begin
 try
  l_aTextForm := TTextForm(aCtx.rEngine.PopObjAs(TTextForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aTextForm: TTextForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(WarnRedaction(aCtx, l_aTextForm));
end;//TkwTextFormWarnRedaction.DoDoIt

class function TkwTextFormWarnRedaction.GetWordNameForRegister: AnsiString;
begin
 Result := '.TTextForm.WarnRedaction';
end;//TkwTextFormWarnRedaction.GetWordNameForRegister

procedure TkwTextFormWarnRedaction.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� WarnRedaction', aCtx);
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
 Result := OpenTypesToTypes([TypeInfo(TTextForm)]);
end;//TkwTextFormWarnRedaction.ParamsTypes

function TkwTextFormWarnInactualDocument.WarnInactualDocument(const aCtx: TtfwContext;
 aTextForm: TTextForm): TnscReminder;
 {* ���������� ����� ������� .TTextForm.WarnInactualDocument }
begin
 Result := aTextForm.WarnInactualDocument;
end;//TkwTextFormWarnInactualDocument.WarnInactualDocument

procedure TkwTextFormWarnInactualDocument.DoDoIt(const aCtx: TtfwContext);
var l_aTextForm: TTextForm;
begin
 try
  l_aTextForm := TTextForm(aCtx.rEngine.PopObjAs(TTextForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aTextForm: TTextForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(WarnInactualDocument(aCtx, l_aTextForm));
end;//TkwTextFormWarnInactualDocument.DoDoIt

class function TkwTextFormWarnInactualDocument.GetWordNameForRegister: AnsiString;
begin
 Result := '.TTextForm.WarnInactualDocument';
end;//TkwTextFormWarnInactualDocument.GetWordNameForRegister

procedure TkwTextFormWarnInactualDocument.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� WarnInactualDocument', aCtx);
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
 Result := OpenTypesToTypes([TypeInfo(TTextForm)]);
end;//TkwTextFormWarnInactualDocument.ParamsTypes

function TkwTextFormWarnTimeMachineOn.WarnTimeMachineOn(const aCtx: TtfwContext;
 aTextForm: TTextForm): TnscReminder;
 {* ���������� ����� ������� .TTextForm.WarnTimeMachineOn }
begin
 Result := aTextForm.WarnTimeMachineOn;
end;//TkwTextFormWarnTimeMachineOn.WarnTimeMachineOn

procedure TkwTextFormWarnTimeMachineOn.DoDoIt(const aCtx: TtfwContext);
var l_aTextForm: TTextForm;
begin
 try
  l_aTextForm := TTextForm(aCtx.rEngine.PopObjAs(TTextForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aTextForm: TTextForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(WarnTimeMachineOn(aCtx, l_aTextForm));
end;//TkwTextFormWarnTimeMachineOn.DoDoIt

class function TkwTextFormWarnTimeMachineOn.GetWordNameForRegister: AnsiString;
begin
 Result := '.TTextForm.WarnTimeMachineOn';
end;//TkwTextFormWarnTimeMachineOn.GetWordNameForRegister

procedure TkwTextFormWarnTimeMachineOn.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� WarnTimeMachineOn', aCtx);
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
 Result := OpenTypesToTypes([TypeInfo(TTextForm)]);
end;//TkwTextFormWarnTimeMachineOn.ParamsTypes

function TkwTextFormSubPanel.SubPanel(const aCtx: TtfwContext;
 aTextForm: TTextForm): TeeSubPanel;
 {* ���������� ����� ������� .TTextForm.SubPanel }
begin
 Result := aTextForm.SubPanel;
end;//TkwTextFormSubPanel.SubPanel

procedure TkwTextFormSubPanel.DoDoIt(const aCtx: TtfwContext);
var l_aTextForm: TTextForm;
begin
 try
  l_aTextForm := TTextForm(aCtx.rEngine.PopObjAs(TTextForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aTextForm: TTextForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(SubPanel(aCtx, l_aTextForm));
end;//TkwTextFormSubPanel.DoDoIt

class function TkwTextFormSubPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TTextForm.SubPanel';
end;//TkwTextFormSubPanel.GetWordNameForRegister

procedure TkwTextFormSubPanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� SubPanel', aCtx);
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
 Result := OpenTypesToTypes([TypeInfo(TTextForm)]);
end;//TkwTextFormSubPanel.ParamsTypes

function TkwTextFormHScroll.HScroll(const aCtx: TtfwContext;
 aTextForm: TTextForm): TvtScrollBar;
 {* ���������� ����� ������� .TTextForm.HScroll }
begin
 Result := aTextForm.HScroll;
end;//TkwTextFormHScroll.HScroll

procedure TkwTextFormHScroll.DoDoIt(const aCtx: TtfwContext);
var l_aTextForm: TTextForm;
begin
 try
  l_aTextForm := TTextForm(aCtx.rEngine.PopObjAs(TTextForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aTextForm: TTextForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(HScroll(aCtx, l_aTextForm));
end;//TkwTextFormHScroll.DoDoIt

class function TkwTextFormHScroll.GetWordNameForRegister: AnsiString;
begin
 Result := '.TTextForm.HScroll';
end;//TkwTextFormHScroll.GetWordNameForRegister

procedure TkwTextFormHScroll.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� HScroll', aCtx);
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
 Result := OpenTypesToTypes([TypeInfo(TTextForm)]);
end;//TkwTextFormHScroll.ParamsTypes

function TkwTextFormText.Text(const aCtx: TtfwContext;
 aTextForm: TTextForm): TnscEditor;
 {* ���������� ����� ������� .TTextForm.Text }
begin
 Result := aTextForm.Text;
end;//TkwTextFormText.Text

procedure TkwTextFormText.DoDoIt(const aCtx: TtfwContext);
var l_aTextForm: TTextForm;
begin
 try
  l_aTextForm := TTextForm(aCtx.rEngine.PopObjAs(TTextForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aTextForm: TTextForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(Text(aCtx, l_aTextForm));
end;//TkwTextFormText.DoDoIt

class function TkwTextFormText.GetWordNameForRegister: AnsiString;
begin
 Result := '.TTextForm.Text';
end;//TkwTextFormText.GetWordNameForRegister

procedure TkwTextFormText.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� Text', aCtx);
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
 Result := OpenTypesToTypes([TypeInfo(TTextForm)]);
end;//TkwTextFormText.ParamsTypes

initialization
 Tkw_Form_Text.RegisterInEngine;
 {* ����������� Tkw_Form_Text }
 Tkw_Text_Control_RemindersLine.RegisterInEngine;
 {* ����������� Tkw_Text_Control_RemindersLine }
 Tkw_Text_Control_RemindersLine_Push.RegisterInEngine;
 {* ����������� Tkw_Text_Control_RemindersLine_Push }
 Tkw_Text_Control_WarnTimeMachineException.RegisterInEngine;
 {* ����������� Tkw_Text_Control_WarnTimeMachineException }
 Tkw_Text_Control_WarnTimeMachineException_Push.RegisterInEngine;
 {* ����������� Tkw_Text_Control_WarnTimeMachineException_Push }
 Tkw_Text_Control_WarnIsAbolished.RegisterInEngine;
 {* ����������� Tkw_Text_Control_WarnIsAbolished }
 Tkw_Text_Control_WarnIsAbolished_Push.RegisterInEngine;
 {* ����������� Tkw_Text_Control_WarnIsAbolished_Push }
 Tkw_Text_Control_WarnPreActive.RegisterInEngine;
 {* ����������� Tkw_Text_Control_WarnPreActive }
 Tkw_Text_Control_WarnPreActive_Push.RegisterInEngine;
 {* ����������� Tkw_Text_Control_WarnPreActive_Push }
 Tkw_Text_Control_WarnTimeMachineWarning.RegisterInEngine;
 {* ����������� Tkw_Text_Control_WarnTimeMachineWarning }
 Tkw_Text_Control_WarnTimeMachineWarning_Push.RegisterInEngine;
 {* ����������� Tkw_Text_Control_WarnTimeMachineWarning_Push }
 Tkw_Text_Control_WarnOnControl.RegisterInEngine;
 {* ����������� Tkw_Text_Control_WarnOnControl }
 Tkw_Text_Control_WarnOnControl_Push.RegisterInEngine;
 {* ����������� Tkw_Text_Control_WarnOnControl_Push }
 Tkw_Text_Control_WarnJuror.RegisterInEngine;
 {* ����������� Tkw_Text_Control_WarnJuror }
 Tkw_Text_Control_WarnJuror_Push.RegisterInEngine;
 {* ����������� Tkw_Text_Control_WarnJuror_Push }
 Tkw_Text_Control_WarnRedaction.RegisterInEngine;
 {* ����������� Tkw_Text_Control_WarnRedaction }
 Tkw_Text_Control_WarnRedaction_Push.RegisterInEngine;
 {* ����������� Tkw_Text_Control_WarnRedaction_Push }
 Tkw_Text_Control_WarnInactualDocument.RegisterInEngine;
 {* ����������� Tkw_Text_Control_WarnInactualDocument }
 Tkw_Text_Control_WarnInactualDocument_Push.RegisterInEngine;
 {* ����������� Tkw_Text_Control_WarnInactualDocument_Push }
 Tkw_Text_Control_WarnTimeMachineOn.RegisterInEngine;
 {* ����������� Tkw_Text_Control_WarnTimeMachineOn }
 Tkw_Text_Control_WarnTimeMachineOn_Push.RegisterInEngine;
 {* ����������� Tkw_Text_Control_WarnTimeMachineOn_Push }
 Tkw_Text_Control_SubPanel.RegisterInEngine;
 {* ����������� Tkw_Text_Control_SubPanel }
 Tkw_Text_Control_SubPanel_Push.RegisterInEngine;
 {* ����������� Tkw_Text_Control_SubPanel_Push }
 Tkw_Text_Control_HScroll.RegisterInEngine;
 {* ����������� Tkw_Text_Control_HScroll }
 Tkw_Text_Control_HScroll_Push.RegisterInEngine;
 {* ����������� Tkw_Text_Control_HScroll_Push }
 Tkw_Text_Control_Text.RegisterInEngine;
 {* ����������� Tkw_Text_Control_Text }
 Tkw_Text_Control_Text_Push.RegisterInEngine;
 {* ����������� Tkw_Text_Control_Text_Push }
 Tkw_Text_Component_TextSource.RegisterInEngine;
 {* ����������� Tkw_Text_Component_TextSource }
 TkwTextFormRemindersLine.RegisterInEngine;
 {* ����������� TextForm_RemindersLine }
 TkwTextFormWarnTimeMachineException.RegisterInEngine;
 {* ����������� TextForm_WarnTimeMachineException }
 TkwTextFormWarnIsAbolished.RegisterInEngine;
 {* ����������� TextForm_WarnIsAbolished }
 TkwTextFormWarnPreActive.RegisterInEngine;
 {* ����������� TextForm_WarnPreActive }
 TkwTextFormWarnTimeMachineWarning.RegisterInEngine;
 {* ����������� TextForm_WarnTimeMachineWarning }
 TkwTextFormWarnOnControl.RegisterInEngine;
 {* ����������� TextForm_WarnOnControl }
 TkwTextFormWarnJuror.RegisterInEngine;
 {* ����������� TextForm_WarnJuror }
 TkwTextFormWarnRedaction.RegisterInEngine;
 {* ����������� TextForm_WarnRedaction }
 TkwTextFormWarnInactualDocument.RegisterInEngine;
 {* ����������� TextForm_WarnInactualDocument }
 TkwTextFormWarnTimeMachineOn.RegisterInEngine;
 {* ����������� TextForm_WarnTimeMachineOn }
 TkwTextFormSubPanel.RegisterInEngine;
 {* ����������� TextForm_SubPanel }
 TkwTextFormHScroll.RegisterInEngine;
 {* ����������� TextForm_HScroll }
 TkwTextFormText.RegisterInEngine;
 {* ����������� TextForm_Text }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* ����������� ���� TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TTextForm));
 {* ����������� ���� Text }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscRemindersLine));
 {* ����������� ���� TnscRemindersLine }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscReminder));
 {* ����������� ���� TnscReminder }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TeeSubPanel));
 {* ����������� ���� TeeSubPanel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtScrollBar));
 {* ����������� ���� TvtScrollBar }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscEditor));
 {* ����������� ���� TnscEditor }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

end.
