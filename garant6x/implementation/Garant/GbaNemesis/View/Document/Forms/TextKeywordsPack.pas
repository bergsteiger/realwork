unit TextKeywordsPack;
 {* ����� ���� ������� ��� ������� � ����������� ��������� ����� Text }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Document\Forms\TextKeywordsPack.pas"
// ���������: "ScriptKeywordsPack"
// ������� ������: "TextKeywordsPack" MUID: (4A7709C70002_Pack)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3IntfUses
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3ImplUses
 , Text_Form
 , tfwPropertyLike
 {$If Defined(Nemesis)}
 , nscRemindersLine
 {$IfEnd} // Defined(Nemesis)
 , tfwScriptingInterfaces
 , TypInfo
 , tfwTypeInfo
 {$If Defined(Nemesis)}
 , nscReminder
 {$IfEnd} // Defined(Nemesis)
 , eeSubPanel
 , vtScrollBar
 {$If Defined(Nemesis)}
 , nscEditor
 {$IfEnd} // Defined(Nemesis)
 , tfwControlString
 , kwBynameControlPush
 {$If Defined(Nemesis)}
 , nscTextSource
 {$IfEnd} // Defined(Nemesis)
 , TtfwClassRef_Proxy
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
;

type
 TkwTextFormRemindersLine = {final} class(TtfwPropertyLike)
  {* ����� ������� .TTextForm.RemindersLine }
  private
   function RemindersLine(const aCtx: TtfwContext;
    aTextForm: TTextForm): TnscRemindersLine;
    {* ���������� ����� ������� .TTextForm.RemindersLine }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwTextFormRemindersLine

 TkwTextFormWarnTimeMachineException = {final} class(TtfwPropertyLike)
  {* ����� ������� .TTextForm.WarnTimeMachineException }
  private
   function WarnTimeMachineException(const aCtx: TtfwContext;
    aTextForm: TTextForm): TnscReminder;
    {* ���������� ����� ������� .TTextForm.WarnTimeMachineException }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwTextFormWarnTimeMachineException

 TkwTextFormWarnIsAbolished = {final} class(TtfwPropertyLike)
  {* ����� ������� .TTextForm.WarnIsAbolished }
  private
   function WarnIsAbolished(const aCtx: TtfwContext;
    aTextForm: TTextForm): TnscReminder;
    {* ���������� ����� ������� .TTextForm.WarnIsAbolished }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwTextFormWarnIsAbolished

 TkwTextFormWarnPreActive = {final} class(TtfwPropertyLike)
  {* ����� ������� .TTextForm.WarnPreActive }
  private
   function WarnPreActive(const aCtx: TtfwContext;
    aTextForm: TTextForm): TnscReminder;
    {* ���������� ����� ������� .TTextForm.WarnPreActive }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwTextFormWarnPreActive

 TkwTextFormWarnTimeMachineWarning = {final} class(TtfwPropertyLike)
  {* ����� ������� .TTextForm.WarnTimeMachineWarning }
  private
   function WarnTimeMachineWarning(const aCtx: TtfwContext;
    aTextForm: TTextForm): TnscReminder;
    {* ���������� ����� ������� .TTextForm.WarnTimeMachineWarning }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwTextFormWarnTimeMachineWarning

 TkwTextFormWarnOnControl = {final} class(TtfwPropertyLike)
  {* ����� ������� .TTextForm.WarnOnControl }
  private
   function WarnOnControl(const aCtx: TtfwContext;
    aTextForm: TTextForm): TnscReminder;
    {* ���������� ����� ������� .TTextForm.WarnOnControl }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwTextFormWarnOnControl

 TkwTextFormWarnJuror = {final} class(TtfwPropertyLike)
  {* ����� ������� .TTextForm.WarnJuror }
  private
   function WarnJuror(const aCtx: TtfwContext;
    aTextForm: TTextForm): TnscReminder;
    {* ���������� ����� ������� .TTextForm.WarnJuror }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwTextFormWarnJuror

 TkwTextFormWarnRedaction = {final} class(TtfwPropertyLike)
  {* ����� ������� .TTextForm.WarnRedaction }
  private
   function WarnRedaction(const aCtx: TtfwContext;
    aTextForm: TTextForm): TnscReminder;
    {* ���������� ����� ������� .TTextForm.WarnRedaction }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwTextFormWarnRedaction

 TkwTextFormWarnInactualDocument = {final} class(TtfwPropertyLike)
  {* ����� ������� .TTextForm.WarnInactualDocument }
  private
   function WarnInactualDocument(const aCtx: TtfwContext;
    aTextForm: TTextForm): TnscReminder;
    {* ���������� ����� ������� .TTextForm.WarnInactualDocument }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwTextFormWarnInactualDocument

 TkwTextFormWarnTimeMachineOn = {final} class(TtfwPropertyLike)
  {* ����� ������� .TTextForm.WarnTimeMachineOn }
  private
   function WarnTimeMachineOn(const aCtx: TtfwContext;
    aTextForm: TTextForm): TnscReminder;
    {* ���������� ����� ������� .TTextForm.WarnTimeMachineOn }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwTextFormWarnTimeMachineOn

 TkwTextFormSubPanel = {final} class(TtfwPropertyLike)
  {* ����� ������� .TTextForm.SubPanel }
  private
   function SubPanel(const aCtx: TtfwContext;
    aTextForm: TTextForm): TeeSubPanel;
    {* ���������� ����� ������� .TTextForm.SubPanel }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwTextFormSubPanel

 TkwTextFormHScroll = {final} class(TtfwPropertyLike)
  {* ����� ������� .TTextForm.HScroll }
  private
   function HScroll(const aCtx: TtfwContext;
    aTextForm: TTextForm): TvtScrollBar;
    {* ���������� ����� ������� .TTextForm.HScroll }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwTextFormHScroll

 TkwTextFormText = {final} class(TtfwPropertyLike)
  {* ����� ������� .TTextForm.Text }
  private
   function Text(const aCtx: TtfwContext;
    aTextForm: TTextForm): TnscEditor;
    {* ���������� ����� ������� .TTextForm.Text }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwTextFormText

 Tkw_Form_Text = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� ����� Text
----
*������ �������������*:
[code]�����::Text TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Form_Text

 Tkw_Text_Control_RemindersLine = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� RemindersLine
----
*������ �������������*:
[code]�������::RemindersLine TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Text_Control_RemindersLine

 Tkw_Text_Control_RemindersLine_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� RemindersLine
----
*������ �������������*:
[code]�������::RemindersLine:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Text_Control_RemindersLine_Push

 Tkw_Text_Control_WarnTimeMachineException = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� WarnTimeMachineException
----
*������ �������������*:
[code]�������::WarnTimeMachineException TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Text_Control_WarnTimeMachineException

 Tkw_Text_Control_WarnTimeMachineException_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� WarnTimeMachineException
----
*������ �������������*:
[code]�������::WarnTimeMachineException:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Text_Control_WarnTimeMachineException_Push

 Tkw_Text_Control_WarnIsAbolished = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� WarnIsAbolished
----
*������ �������������*:
[code]�������::WarnIsAbolished TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Text_Control_WarnIsAbolished

 Tkw_Text_Control_WarnIsAbolished_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� WarnIsAbolished
----
*������ �������������*:
[code]�������::WarnIsAbolished:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Text_Control_WarnIsAbolished_Push

 Tkw_Text_Control_WarnPreActive = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� WarnPreActive
----
*������ �������������*:
[code]�������::WarnPreActive TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Text_Control_WarnPreActive

 Tkw_Text_Control_WarnPreActive_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� WarnPreActive
----
*������ �������������*:
[code]�������::WarnPreActive:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Text_Control_WarnPreActive_Push

 Tkw_Text_Control_WarnTimeMachineWarning = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� WarnTimeMachineWarning
----
*������ �������������*:
[code]�������::WarnTimeMachineWarning TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Text_Control_WarnTimeMachineWarning

 Tkw_Text_Control_WarnTimeMachineWarning_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� WarnTimeMachineWarning
----
*������ �������������*:
[code]�������::WarnTimeMachineWarning:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Text_Control_WarnTimeMachineWarning_Push

 Tkw_Text_Control_WarnOnControl = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� WarnOnControl
----
*������ �������������*:
[code]�������::WarnOnControl TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Text_Control_WarnOnControl

 Tkw_Text_Control_WarnOnControl_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� WarnOnControl
----
*������ �������������*:
[code]�������::WarnOnControl:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Text_Control_WarnOnControl_Push

 Tkw_Text_Control_WarnJuror = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� WarnJuror
----
*������ �������������*:
[code]�������::WarnJuror TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Text_Control_WarnJuror

 Tkw_Text_Control_WarnJuror_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� WarnJuror
----
*������ �������������*:
[code]�������::WarnJuror:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Text_Control_WarnJuror_Push

 Tkw_Text_Control_WarnRedaction = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� WarnRedaction
----
*������ �������������*:
[code]�������::WarnRedaction TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Text_Control_WarnRedaction

 Tkw_Text_Control_WarnRedaction_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� WarnRedaction
----
*������ �������������*:
[code]�������::WarnRedaction:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Text_Control_WarnRedaction_Push

 Tkw_Text_Control_WarnInactualDocument = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� WarnInactualDocument
----
*������ �������������*:
[code]�������::WarnInactualDocument TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Text_Control_WarnInactualDocument

 Tkw_Text_Control_WarnInactualDocument_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� WarnInactualDocument
----
*������ �������������*:
[code]�������::WarnInactualDocument:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Text_Control_WarnInactualDocument_Push

 Tkw_Text_Control_WarnTimeMachineOn = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� WarnTimeMachineOn
----
*������ �������������*:
[code]�������::WarnTimeMachineOn TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Text_Control_WarnTimeMachineOn

 Tkw_Text_Control_WarnTimeMachineOn_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� WarnTimeMachineOn
----
*������ �������������*:
[code]�������::WarnTimeMachineOn:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Text_Control_WarnTimeMachineOn_Push

 Tkw_Text_Control_SubPanel = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� SubPanel
----
*������ �������������*:
[code]�������::SubPanel TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Text_Control_SubPanel

 Tkw_Text_Control_SubPanel_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� SubPanel
----
*������ �������������*:
[code]�������::SubPanel:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Text_Control_SubPanel_Push

 Tkw_Text_Control_HScroll = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� HScroll
----
*������ �������������*:
[code]�������::HScroll TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Text_Control_HScroll

 Tkw_Text_Control_HScroll_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� HScroll
----
*������ �������������*:
[code]�������::HScroll:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Text_Control_HScroll_Push

 Tkw_Text_Control_Text = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� Text
----
*������ �������������*:
[code]�������::Text TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Text_Control_Text

 Tkw_Text_Control_Text_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� Text
----
*������ �������������*:
[code]�������::Text:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Text_Control_Text_Push

 Tkw_Text_Component_TextSource = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� TextSource
----
*������ �������������*:
[code]���������::TextSource TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Text_Component_TextSource

function TkwTextFormRemindersLine.RemindersLine(const aCtx: TtfwContext;
 aTextForm: TTextForm): TnscRemindersLine;
 {* ���������� ����� ������� .TTextForm.RemindersLine }
begin
 Result := aTextForm.RemindersLine;
end;//TkwTextFormRemindersLine.RemindersLine

class function TkwTextFormRemindersLine.GetWordNameForRegister: AnsiString;
begin
 Result := '.TTextForm.RemindersLine';
end;//TkwTextFormRemindersLine.GetWordNameForRegister

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

procedure TkwTextFormRemindersLine.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� RemindersLine', aCtx);
end;//TkwTextFormRemindersLine.SetValuePrim

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

function TkwTextFormWarnTimeMachineException.WarnTimeMachineException(const aCtx: TtfwContext;
 aTextForm: TTextForm): TnscReminder;
 {* ���������� ����� ������� .TTextForm.WarnTimeMachineException }
begin
 Result := aTextForm.WarnTimeMachineException;
end;//TkwTextFormWarnTimeMachineException.WarnTimeMachineException

class function TkwTextFormWarnTimeMachineException.GetWordNameForRegister: AnsiString;
begin
 Result := '.TTextForm.WarnTimeMachineException';
end;//TkwTextFormWarnTimeMachineException.GetWordNameForRegister

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

procedure TkwTextFormWarnTimeMachineException.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� WarnTimeMachineException', aCtx);
end;//TkwTextFormWarnTimeMachineException.SetValuePrim

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

function TkwTextFormWarnIsAbolished.WarnIsAbolished(const aCtx: TtfwContext;
 aTextForm: TTextForm): TnscReminder;
 {* ���������� ����� ������� .TTextForm.WarnIsAbolished }
begin
 Result := aTextForm.WarnIsAbolished;
end;//TkwTextFormWarnIsAbolished.WarnIsAbolished

class function TkwTextFormWarnIsAbolished.GetWordNameForRegister: AnsiString;
begin
 Result := '.TTextForm.WarnIsAbolished';
end;//TkwTextFormWarnIsAbolished.GetWordNameForRegister

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

procedure TkwTextFormWarnIsAbolished.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� WarnIsAbolished', aCtx);
end;//TkwTextFormWarnIsAbolished.SetValuePrim

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

function TkwTextFormWarnPreActive.WarnPreActive(const aCtx: TtfwContext;
 aTextForm: TTextForm): TnscReminder;
 {* ���������� ����� ������� .TTextForm.WarnPreActive }
begin
 Result := aTextForm.WarnPreActive;
end;//TkwTextFormWarnPreActive.WarnPreActive

class function TkwTextFormWarnPreActive.GetWordNameForRegister: AnsiString;
begin
 Result := '.TTextForm.WarnPreActive';
end;//TkwTextFormWarnPreActive.GetWordNameForRegister

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

procedure TkwTextFormWarnPreActive.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� WarnPreActive', aCtx);
end;//TkwTextFormWarnPreActive.SetValuePrim

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

function TkwTextFormWarnTimeMachineWarning.WarnTimeMachineWarning(const aCtx: TtfwContext;
 aTextForm: TTextForm): TnscReminder;
 {* ���������� ����� ������� .TTextForm.WarnTimeMachineWarning }
begin
 Result := aTextForm.WarnTimeMachineWarning;
end;//TkwTextFormWarnTimeMachineWarning.WarnTimeMachineWarning

class function TkwTextFormWarnTimeMachineWarning.GetWordNameForRegister: AnsiString;
begin
 Result := '.TTextForm.WarnTimeMachineWarning';
end;//TkwTextFormWarnTimeMachineWarning.GetWordNameForRegister

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

procedure TkwTextFormWarnTimeMachineWarning.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� WarnTimeMachineWarning', aCtx);
end;//TkwTextFormWarnTimeMachineWarning.SetValuePrim

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

function TkwTextFormWarnOnControl.WarnOnControl(const aCtx: TtfwContext;
 aTextForm: TTextForm): TnscReminder;
 {* ���������� ����� ������� .TTextForm.WarnOnControl }
begin
 Result := aTextForm.WarnOnControl;
end;//TkwTextFormWarnOnControl.WarnOnControl

class function TkwTextFormWarnOnControl.GetWordNameForRegister: AnsiString;
begin
 Result := '.TTextForm.WarnOnControl';
end;//TkwTextFormWarnOnControl.GetWordNameForRegister

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

procedure TkwTextFormWarnOnControl.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� WarnOnControl', aCtx);
end;//TkwTextFormWarnOnControl.SetValuePrim

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

function TkwTextFormWarnJuror.WarnJuror(const aCtx: TtfwContext;
 aTextForm: TTextForm): TnscReminder;
 {* ���������� ����� ������� .TTextForm.WarnJuror }
begin
 Result := aTextForm.WarnJuror;
end;//TkwTextFormWarnJuror.WarnJuror

class function TkwTextFormWarnJuror.GetWordNameForRegister: AnsiString;
begin
 Result := '.TTextForm.WarnJuror';
end;//TkwTextFormWarnJuror.GetWordNameForRegister

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

procedure TkwTextFormWarnJuror.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� WarnJuror', aCtx);
end;//TkwTextFormWarnJuror.SetValuePrim

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

function TkwTextFormWarnRedaction.WarnRedaction(const aCtx: TtfwContext;
 aTextForm: TTextForm): TnscReminder;
 {* ���������� ����� ������� .TTextForm.WarnRedaction }
begin
 Result := aTextForm.WarnRedaction;
end;//TkwTextFormWarnRedaction.WarnRedaction

class function TkwTextFormWarnRedaction.GetWordNameForRegister: AnsiString;
begin
 Result := '.TTextForm.WarnRedaction';
end;//TkwTextFormWarnRedaction.GetWordNameForRegister

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

procedure TkwTextFormWarnRedaction.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� WarnRedaction', aCtx);
end;//TkwTextFormWarnRedaction.SetValuePrim

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

function TkwTextFormWarnInactualDocument.WarnInactualDocument(const aCtx: TtfwContext;
 aTextForm: TTextForm): TnscReminder;
 {* ���������� ����� ������� .TTextForm.WarnInactualDocument }
begin
 Result := aTextForm.WarnInactualDocument;
end;//TkwTextFormWarnInactualDocument.WarnInactualDocument

class function TkwTextFormWarnInactualDocument.GetWordNameForRegister: AnsiString;
begin
 Result := '.TTextForm.WarnInactualDocument';
end;//TkwTextFormWarnInactualDocument.GetWordNameForRegister

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

procedure TkwTextFormWarnInactualDocument.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� WarnInactualDocument', aCtx);
end;//TkwTextFormWarnInactualDocument.SetValuePrim

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

function TkwTextFormWarnTimeMachineOn.WarnTimeMachineOn(const aCtx: TtfwContext;
 aTextForm: TTextForm): TnscReminder;
 {* ���������� ����� ������� .TTextForm.WarnTimeMachineOn }
begin
 Result := aTextForm.WarnTimeMachineOn;
end;//TkwTextFormWarnTimeMachineOn.WarnTimeMachineOn

class function TkwTextFormWarnTimeMachineOn.GetWordNameForRegister: AnsiString;
begin
 Result := '.TTextForm.WarnTimeMachineOn';
end;//TkwTextFormWarnTimeMachineOn.GetWordNameForRegister

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

procedure TkwTextFormWarnTimeMachineOn.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� WarnTimeMachineOn', aCtx);
end;//TkwTextFormWarnTimeMachineOn.SetValuePrim

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

function TkwTextFormSubPanel.SubPanel(const aCtx: TtfwContext;
 aTextForm: TTextForm): TeeSubPanel;
 {* ���������� ����� ������� .TTextForm.SubPanel }
begin
 Result := aTextForm.SubPanel;
end;//TkwTextFormSubPanel.SubPanel

class function TkwTextFormSubPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TTextForm.SubPanel';
end;//TkwTextFormSubPanel.GetWordNameForRegister

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

procedure TkwTextFormSubPanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� SubPanel', aCtx);
end;//TkwTextFormSubPanel.SetValuePrim

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

function TkwTextFormHScroll.HScroll(const aCtx: TtfwContext;
 aTextForm: TTextForm): TvtScrollBar;
 {* ���������� ����� ������� .TTextForm.HScroll }
begin
 Result := aTextForm.HScroll;
end;//TkwTextFormHScroll.HScroll

class function TkwTextFormHScroll.GetWordNameForRegister: AnsiString;
begin
 Result := '.TTextForm.HScroll';
end;//TkwTextFormHScroll.GetWordNameForRegister

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

procedure TkwTextFormHScroll.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� HScroll', aCtx);
end;//TkwTextFormHScroll.SetValuePrim

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

function TkwTextFormText.Text(const aCtx: TtfwContext;
 aTextForm: TTextForm): TnscEditor;
 {* ���������� ����� ������� .TTextForm.Text }
begin
 Result := aTextForm.Text;
end;//TkwTextFormText.Text

class function TkwTextFormText.GetWordNameForRegister: AnsiString;
begin
 Result := '.TTextForm.Text';
end;//TkwTextFormText.GetWordNameForRegister

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

procedure TkwTextFormText.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� Text', aCtx);
end;//TkwTextFormText.SetValuePrim

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

function Tkw_Form_Text.GetString: AnsiString;
begin
 Result := 'TextForm';
end;//Tkw_Form_Text.GetString

class procedure Tkw_Form_Text.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TTextForm);
end;//Tkw_Form_Text.RegisterInEngine

class function Tkw_Form_Text.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::Text';
end;//Tkw_Form_Text.GetWordNameForRegister

function Tkw_Text_Control_RemindersLine.GetString: AnsiString;
begin
 Result := 'RemindersLine';
end;//Tkw_Text_Control_RemindersLine.GetString

class procedure Tkw_Text_Control_RemindersLine.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscRemindersLine);
end;//Tkw_Text_Control_RemindersLine.RegisterInEngine

class function Tkw_Text_Control_RemindersLine.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::RemindersLine';
end;//Tkw_Text_Control_RemindersLine.GetWordNameForRegister

procedure Tkw_Text_Control_RemindersLine_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('RemindersLine');
 inherited;
end;//Tkw_Text_Control_RemindersLine_Push.DoDoIt

class function Tkw_Text_Control_RemindersLine_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::RemindersLine:push';
end;//Tkw_Text_Control_RemindersLine_Push.GetWordNameForRegister

function Tkw_Text_Control_WarnTimeMachineException.GetString: AnsiString;
begin
 Result := 'WarnTimeMachineException';
end;//Tkw_Text_Control_WarnTimeMachineException.GetString

class procedure Tkw_Text_Control_WarnTimeMachineException.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscReminder);
end;//Tkw_Text_Control_WarnTimeMachineException.RegisterInEngine

class function Tkw_Text_Control_WarnTimeMachineException.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::WarnTimeMachineException';
end;//Tkw_Text_Control_WarnTimeMachineException.GetWordNameForRegister

procedure Tkw_Text_Control_WarnTimeMachineException_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('WarnTimeMachineException');
 inherited;
end;//Tkw_Text_Control_WarnTimeMachineException_Push.DoDoIt

class function Tkw_Text_Control_WarnTimeMachineException_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::WarnTimeMachineException:push';
end;//Tkw_Text_Control_WarnTimeMachineException_Push.GetWordNameForRegister

function Tkw_Text_Control_WarnIsAbolished.GetString: AnsiString;
begin
 Result := 'WarnIsAbolished';
end;//Tkw_Text_Control_WarnIsAbolished.GetString

class procedure Tkw_Text_Control_WarnIsAbolished.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscReminder);
end;//Tkw_Text_Control_WarnIsAbolished.RegisterInEngine

class function Tkw_Text_Control_WarnIsAbolished.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::WarnIsAbolished';
end;//Tkw_Text_Control_WarnIsAbolished.GetWordNameForRegister

procedure Tkw_Text_Control_WarnIsAbolished_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('WarnIsAbolished');
 inherited;
end;//Tkw_Text_Control_WarnIsAbolished_Push.DoDoIt

class function Tkw_Text_Control_WarnIsAbolished_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::WarnIsAbolished:push';
end;//Tkw_Text_Control_WarnIsAbolished_Push.GetWordNameForRegister

function Tkw_Text_Control_WarnPreActive.GetString: AnsiString;
begin
 Result := 'WarnPreActive';
end;//Tkw_Text_Control_WarnPreActive.GetString

class procedure Tkw_Text_Control_WarnPreActive.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscReminder);
end;//Tkw_Text_Control_WarnPreActive.RegisterInEngine

class function Tkw_Text_Control_WarnPreActive.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::WarnPreActive';
end;//Tkw_Text_Control_WarnPreActive.GetWordNameForRegister

procedure Tkw_Text_Control_WarnPreActive_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('WarnPreActive');
 inherited;
end;//Tkw_Text_Control_WarnPreActive_Push.DoDoIt

class function Tkw_Text_Control_WarnPreActive_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::WarnPreActive:push';
end;//Tkw_Text_Control_WarnPreActive_Push.GetWordNameForRegister

function Tkw_Text_Control_WarnTimeMachineWarning.GetString: AnsiString;
begin
 Result := 'WarnTimeMachineWarning';
end;//Tkw_Text_Control_WarnTimeMachineWarning.GetString

class procedure Tkw_Text_Control_WarnTimeMachineWarning.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscReminder);
end;//Tkw_Text_Control_WarnTimeMachineWarning.RegisterInEngine

class function Tkw_Text_Control_WarnTimeMachineWarning.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::WarnTimeMachineWarning';
end;//Tkw_Text_Control_WarnTimeMachineWarning.GetWordNameForRegister

procedure Tkw_Text_Control_WarnTimeMachineWarning_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('WarnTimeMachineWarning');
 inherited;
end;//Tkw_Text_Control_WarnTimeMachineWarning_Push.DoDoIt

class function Tkw_Text_Control_WarnTimeMachineWarning_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::WarnTimeMachineWarning:push';
end;//Tkw_Text_Control_WarnTimeMachineWarning_Push.GetWordNameForRegister

function Tkw_Text_Control_WarnOnControl.GetString: AnsiString;
begin
 Result := 'WarnOnControl';
end;//Tkw_Text_Control_WarnOnControl.GetString

class procedure Tkw_Text_Control_WarnOnControl.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscReminder);
end;//Tkw_Text_Control_WarnOnControl.RegisterInEngine

class function Tkw_Text_Control_WarnOnControl.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::WarnOnControl';
end;//Tkw_Text_Control_WarnOnControl.GetWordNameForRegister

procedure Tkw_Text_Control_WarnOnControl_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('WarnOnControl');
 inherited;
end;//Tkw_Text_Control_WarnOnControl_Push.DoDoIt

class function Tkw_Text_Control_WarnOnControl_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::WarnOnControl:push';
end;//Tkw_Text_Control_WarnOnControl_Push.GetWordNameForRegister

function Tkw_Text_Control_WarnJuror.GetString: AnsiString;
begin
 Result := 'WarnJuror';
end;//Tkw_Text_Control_WarnJuror.GetString

class procedure Tkw_Text_Control_WarnJuror.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscReminder);
end;//Tkw_Text_Control_WarnJuror.RegisterInEngine

class function Tkw_Text_Control_WarnJuror.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::WarnJuror';
end;//Tkw_Text_Control_WarnJuror.GetWordNameForRegister

procedure Tkw_Text_Control_WarnJuror_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('WarnJuror');
 inherited;
end;//Tkw_Text_Control_WarnJuror_Push.DoDoIt

class function Tkw_Text_Control_WarnJuror_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::WarnJuror:push';
end;//Tkw_Text_Control_WarnJuror_Push.GetWordNameForRegister

function Tkw_Text_Control_WarnRedaction.GetString: AnsiString;
begin
 Result := 'WarnRedaction';
end;//Tkw_Text_Control_WarnRedaction.GetString

class procedure Tkw_Text_Control_WarnRedaction.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscReminder);
end;//Tkw_Text_Control_WarnRedaction.RegisterInEngine

class function Tkw_Text_Control_WarnRedaction.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::WarnRedaction';
end;//Tkw_Text_Control_WarnRedaction.GetWordNameForRegister

procedure Tkw_Text_Control_WarnRedaction_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('WarnRedaction');
 inherited;
end;//Tkw_Text_Control_WarnRedaction_Push.DoDoIt

class function Tkw_Text_Control_WarnRedaction_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::WarnRedaction:push';
end;//Tkw_Text_Control_WarnRedaction_Push.GetWordNameForRegister

function Tkw_Text_Control_WarnInactualDocument.GetString: AnsiString;
begin
 Result := 'WarnInactualDocument';
end;//Tkw_Text_Control_WarnInactualDocument.GetString

class procedure Tkw_Text_Control_WarnInactualDocument.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscReminder);
end;//Tkw_Text_Control_WarnInactualDocument.RegisterInEngine

class function Tkw_Text_Control_WarnInactualDocument.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::WarnInactualDocument';
end;//Tkw_Text_Control_WarnInactualDocument.GetWordNameForRegister

procedure Tkw_Text_Control_WarnInactualDocument_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('WarnInactualDocument');
 inherited;
end;//Tkw_Text_Control_WarnInactualDocument_Push.DoDoIt

class function Tkw_Text_Control_WarnInactualDocument_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::WarnInactualDocument:push';
end;//Tkw_Text_Control_WarnInactualDocument_Push.GetWordNameForRegister

function Tkw_Text_Control_WarnTimeMachineOn.GetString: AnsiString;
begin
 Result := 'WarnTimeMachineOn';
end;//Tkw_Text_Control_WarnTimeMachineOn.GetString

class procedure Tkw_Text_Control_WarnTimeMachineOn.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscReminder);
end;//Tkw_Text_Control_WarnTimeMachineOn.RegisterInEngine

class function Tkw_Text_Control_WarnTimeMachineOn.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::WarnTimeMachineOn';
end;//Tkw_Text_Control_WarnTimeMachineOn.GetWordNameForRegister

procedure Tkw_Text_Control_WarnTimeMachineOn_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('WarnTimeMachineOn');
 inherited;
end;//Tkw_Text_Control_WarnTimeMachineOn_Push.DoDoIt

class function Tkw_Text_Control_WarnTimeMachineOn_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::WarnTimeMachineOn:push';
end;//Tkw_Text_Control_WarnTimeMachineOn_Push.GetWordNameForRegister

function Tkw_Text_Control_SubPanel.GetString: AnsiString;
begin
 Result := 'SubPanel';
end;//Tkw_Text_Control_SubPanel.GetString

class procedure Tkw_Text_Control_SubPanel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TeeSubPanel);
end;//Tkw_Text_Control_SubPanel.RegisterInEngine

class function Tkw_Text_Control_SubPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::SubPanel';
end;//Tkw_Text_Control_SubPanel.GetWordNameForRegister

procedure Tkw_Text_Control_SubPanel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('SubPanel');
 inherited;
end;//Tkw_Text_Control_SubPanel_Push.DoDoIt

class function Tkw_Text_Control_SubPanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::SubPanel:push';
end;//Tkw_Text_Control_SubPanel_Push.GetWordNameForRegister

function Tkw_Text_Control_HScroll.GetString: AnsiString;
begin
 Result := 'HScroll';
end;//Tkw_Text_Control_HScroll.GetString

class procedure Tkw_Text_Control_HScroll.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtScrollBar);
end;//Tkw_Text_Control_HScroll.RegisterInEngine

class function Tkw_Text_Control_HScroll.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::HScroll';
end;//Tkw_Text_Control_HScroll.GetWordNameForRegister

procedure Tkw_Text_Control_HScroll_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('HScroll');
 inherited;
end;//Tkw_Text_Control_HScroll_Push.DoDoIt

class function Tkw_Text_Control_HScroll_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::HScroll:push';
end;//Tkw_Text_Control_HScroll_Push.GetWordNameForRegister

function Tkw_Text_Control_Text.GetString: AnsiString;
begin
 Result := 'Text';
end;//Tkw_Text_Control_Text.GetString

class procedure Tkw_Text_Control_Text.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscEditor);
end;//Tkw_Text_Control_Text.RegisterInEngine

class function Tkw_Text_Control_Text.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::Text';
end;//Tkw_Text_Control_Text.GetWordNameForRegister

procedure Tkw_Text_Control_Text_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('Text');
 inherited;
end;//Tkw_Text_Control_Text_Push.DoDoIt

class function Tkw_Text_Control_Text_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::Text:push';
end;//Tkw_Text_Control_Text_Push.GetWordNameForRegister

function Tkw_Text_Component_TextSource.GetString: AnsiString;
begin
 Result := 'TextSource';
end;//Tkw_Text_Component_TextSource.GetString

class procedure Tkw_Text_Component_TextSource.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscTextSource);
end;//Tkw_Text_Component_TextSource.RegisterInEngine

class function Tkw_Text_Component_TextSource.GetWordNameForRegister: AnsiString;
begin
 Result := '���������::TextSource';
end;//Tkw_Text_Component_TextSource.GetWordNameForRegister

initialization
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
 TtfwTypeRegistrator.RegisterType(TypeInfo(TTextForm));
 {* ����������� ���� TTextForm }
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
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)

end.
