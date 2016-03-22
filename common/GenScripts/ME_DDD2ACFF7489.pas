unit TurnOffTimeMachineKeywordsPack;
 {* ����� ���� ������� ��� ������� � ����������� ��������� ����� TurnOffTimeMachine }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Common\TurnOffTimeMachineKeywordsPack.pas"
// ���������: "ScriptKeywordsPack"
// ������� ������: "TurnOffTimeMachineKeywordsPack" MUID: (DDD2ACFF7489)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , vtRadioButton
 , vtDblClickDateEdit
 {$If NOT Defined(NoVCL)}
 , ExtCtrls
 {$IfEnd} // NOT Defined(NoVCL)
 , vtLabel
 , vtButton
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TurnOffTimeMachine_Form
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
 , SysUtils
;

type
 Tkw_Form_TurnOffTimeMachine = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� ����� TurnOffTimeMachine
----
*������ �������������*:
[code]
'aControl' �����::TurnOffTimeMachine TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Form_TurnOffTimeMachine

 Tkw_TurnOffTimeMachine_Control_rb_totmChangeDate = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� rb_totmChangeDate
----
*������ �������������*:
[code]
�������::rb_totmChangeDate TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_TurnOffTimeMachine_Control_rb_totmChangeDate

 Tkw_TurnOffTimeMachine_Control_rb_totmChangeDate_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� rb_totmChangeDate
----
*������ �������������*:
[code]
�������::rb_totmChangeDate:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_TurnOffTimeMachine_Control_rb_totmChangeDate_Push

 Tkw_TurnOffTimeMachine_Control_rb_totmStayInCurrentRedaction = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� rb_totmStayInCurrentRedaction
----
*������ �������������*:
[code]
�������::rb_totmStayInCurrentRedaction TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_TurnOffTimeMachine_Control_rb_totmStayInCurrentRedaction

 Tkw_TurnOffTimeMachine_Control_rb_totmStayInCurrentRedaction_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� rb_totmStayInCurrentRedaction
----
*������ �������������*:
[code]
�������::rb_totmStayInCurrentRedaction:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_TurnOffTimeMachine_Control_rb_totmStayInCurrentRedaction_Push

 Tkw_TurnOffTimeMachine_Control_rb_totmGotoActualRedaction = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� rb_totmGotoActualRedaction
----
*������ �������������*:
[code]
�������::rb_totmGotoActualRedaction TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_TurnOffTimeMachine_Control_rb_totmGotoActualRedaction

 Tkw_TurnOffTimeMachine_Control_rb_totmGotoActualRedaction_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� rb_totmGotoActualRedaction
----
*������ �������������*:
[code]
�������::rb_totmGotoActualRedaction:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_TurnOffTimeMachine_Control_rb_totmGotoActualRedaction_Push

 Tkw_TurnOffTimeMachine_Control_deChangeDate = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� deChangeDate
----
*������ �������������*:
[code]
�������::deChangeDate TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_TurnOffTimeMachine_Control_deChangeDate

 Tkw_TurnOffTimeMachine_Control_deChangeDate_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� deChangeDate
----
*������ �������������*:
[code]
�������::deChangeDate:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_TurnOffTimeMachine_Control_deChangeDate_Push

 Tkw_TurnOffTimeMachine_Control_pbDialogIcon = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� pbDialogIcon
----
*������ �������������*:
[code]
�������::pbDialogIcon TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_TurnOffTimeMachine_Control_pbDialogIcon

 Tkw_TurnOffTimeMachine_Control_pbDialogIcon_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� pbDialogIcon
----
*������ �������������*:
[code]
�������::pbDialogIcon:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_TurnOffTimeMachine_Control_pbDialogIcon_Push

 Tkw_TurnOffTimeMachine_Control_lblTurnOnTimeMachineInfo = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� lblTurnOnTimeMachineInfo
----
*������ �������������*:
[code]
�������::lblTurnOnTimeMachineInfo TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_TurnOffTimeMachine_Control_lblTurnOnTimeMachineInfo

 Tkw_TurnOffTimeMachine_Control_lblTurnOnTimeMachineInfo_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� lblTurnOnTimeMachineInfo
----
*������ �������������*:
[code]
�������::lblTurnOnTimeMachineInfo:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_TurnOffTimeMachine_Control_lblTurnOnTimeMachineInfo_Push

 Tkw_TurnOffTimeMachine_Control_btnOk = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� btnOk
----
*������ �������������*:
[code]
�������::btnOk TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_TurnOffTimeMachine_Control_btnOk

 Tkw_TurnOffTimeMachine_Control_btnOk_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� btnOk
----
*������ �������������*:
[code]
�������::btnOk:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_TurnOffTimeMachine_Control_btnOk_Push

 Tkw_TurnOffTimeMachine_Control_btnCancel = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� btnCancel
----
*������ �������������*:
[code]
�������::btnCancel TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_TurnOffTimeMachine_Control_btnCancel

 Tkw_TurnOffTimeMachine_Control_btnCancel_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� btnCancel
----
*������ �������������*:
[code]
�������::btnCancel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_TurnOffTimeMachine_Control_btnCancel_Push

 TkwEnTurnOffTimeMachineRbTotmChangeDate = {final} class(TtfwPropertyLike)
  {* ����� ������� .Ten_TurnOffTimeMachine.rb_totmChangeDate
[panel]������� rb_totmChangeDate ����� Ten_TurnOffTimeMachine[panel]
*��� ����������:* TvtRadioButton
*������:*
[code]
OBJECT VAR l_TvtRadioButton
 aen_TurnOffTimeMachine .Ten_TurnOffTimeMachine.rb_totmChangeDate >>> l_TvtRadioButton
[code]  }
  private
   function rb_totmChangeDate(const aCtx: TtfwContext;
    aen_TurnOffTimeMachine: Ten_TurnOffTimeMachine): TvtRadioButton;
    {* ���������� ����� ������� .Ten_TurnOffTimeMachine.rb_totmChangeDate }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnTurnOffTimeMachineRbTotmChangeDate

 TkwEnTurnOffTimeMachineRbTotmStayInCurrentRedaction = {final} class(TtfwPropertyLike)
  {* ����� ������� .Ten_TurnOffTimeMachine.rb_totmStayInCurrentRedaction
[panel]������� rb_totmStayInCurrentRedaction ����� Ten_TurnOffTimeMachine[panel]
*��� ����������:* TvtRadioButton
*������:*
[code]
OBJECT VAR l_TvtRadioButton
 aen_TurnOffTimeMachine .Ten_TurnOffTimeMachine.rb_totmStayInCurrentRedaction >>> l_TvtRadioButton
[code]  }
  private
   function rb_totmStayInCurrentRedaction(const aCtx: TtfwContext;
    aen_TurnOffTimeMachine: Ten_TurnOffTimeMachine): TvtRadioButton;
    {* ���������� ����� ������� .Ten_TurnOffTimeMachine.rb_totmStayInCurrentRedaction }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnTurnOffTimeMachineRbTotmStayInCurrentRedaction

 TkwEnTurnOffTimeMachineRbTotmGotoActualRedaction = {final} class(TtfwPropertyLike)
  {* ����� ������� .Ten_TurnOffTimeMachine.rb_totmGotoActualRedaction
[panel]������� rb_totmGotoActualRedaction ����� Ten_TurnOffTimeMachine[panel]
*��� ����������:* TvtRadioButton
*������:*
[code]
OBJECT VAR l_TvtRadioButton
 aen_TurnOffTimeMachine .Ten_TurnOffTimeMachine.rb_totmGotoActualRedaction >>> l_TvtRadioButton
[code]  }
  private
   function rb_totmGotoActualRedaction(const aCtx: TtfwContext;
    aen_TurnOffTimeMachine: Ten_TurnOffTimeMachine): TvtRadioButton;
    {* ���������� ����� ������� .Ten_TurnOffTimeMachine.rb_totmGotoActualRedaction }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnTurnOffTimeMachineRbTotmGotoActualRedaction

 TkwEnTurnOffTimeMachineDeChangeDate = {final} class(TtfwPropertyLike)
  {* ����� ������� .Ten_TurnOffTimeMachine.deChangeDate
[panel]������� deChangeDate ����� Ten_TurnOffTimeMachine[panel]
*��� ����������:* TvtDblClickDateEdit
*������:*
[code]
OBJECT VAR l_TvtDblClickDateEdit
 aen_TurnOffTimeMachine .Ten_TurnOffTimeMachine.deChangeDate >>> l_TvtDblClickDateEdit
[code]  }
  private
   function deChangeDate(const aCtx: TtfwContext;
    aen_TurnOffTimeMachine: Ten_TurnOffTimeMachine): TvtDblClickDateEdit;
    {* ���������� ����� ������� .Ten_TurnOffTimeMachine.deChangeDate }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnTurnOffTimeMachineDeChangeDate

 TkwEnTurnOffTimeMachinePbDialogIcon = {final} class(TtfwPropertyLike)
  {* ����� ������� .Ten_TurnOffTimeMachine.pbDialogIcon
[panel]������� pbDialogIcon ����� Ten_TurnOffTimeMachine[panel]
*��� ����������:* TPaintBox
*������:*
[code]
OBJECT VAR l_TPaintBox
 aen_TurnOffTimeMachine .Ten_TurnOffTimeMachine.pbDialogIcon >>> l_TPaintBox
[code]  }
  private
   function pbDialogIcon(const aCtx: TtfwContext;
    aen_TurnOffTimeMachine: Ten_TurnOffTimeMachine): TPaintBox;
    {* ���������� ����� ������� .Ten_TurnOffTimeMachine.pbDialogIcon }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnTurnOffTimeMachinePbDialogIcon

 TkwEnTurnOffTimeMachineLblTurnOnTimeMachineInfo = {final} class(TtfwPropertyLike)
  {* ����� ������� .Ten_TurnOffTimeMachine.lblTurnOnTimeMachineInfo
[panel]������� lblTurnOnTimeMachineInfo ����� Ten_TurnOffTimeMachine[panel]
*��� ����������:* TvtLabel
*������:*
[code]
OBJECT VAR l_TvtLabel
 aen_TurnOffTimeMachine .Ten_TurnOffTimeMachine.lblTurnOnTimeMachineInfo >>> l_TvtLabel
[code]  }
  private
   function lblTurnOnTimeMachineInfo(const aCtx: TtfwContext;
    aen_TurnOffTimeMachine: Ten_TurnOffTimeMachine): TvtLabel;
    {* ���������� ����� ������� .Ten_TurnOffTimeMachine.lblTurnOnTimeMachineInfo }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnTurnOffTimeMachineLblTurnOnTimeMachineInfo

 TkwEnTurnOffTimeMachineBtnOk = {final} class(TtfwPropertyLike)
  {* ����� ������� .Ten_TurnOffTimeMachine.btnOk
[panel]������� btnOk ����� Ten_TurnOffTimeMachine[panel]
*��� ����������:* TvtButton
*������:*
[code]
OBJECT VAR l_TvtButton
 aen_TurnOffTimeMachine .Ten_TurnOffTimeMachine.btnOk >>> l_TvtButton
[code]  }
  private
   function btnOk(const aCtx: TtfwContext;
    aen_TurnOffTimeMachine: Ten_TurnOffTimeMachine): TvtButton;
    {* ���������� ����� ������� .Ten_TurnOffTimeMachine.btnOk }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnTurnOffTimeMachineBtnOk

 TkwEnTurnOffTimeMachineBtnCancel = {final} class(TtfwPropertyLike)
  {* ����� ������� .Ten_TurnOffTimeMachine.btnCancel
[panel]������� btnCancel ����� Ten_TurnOffTimeMachine[panel]
*��� ����������:* TvtButton
*������:*
[code]
OBJECT VAR l_TvtButton
 aen_TurnOffTimeMachine .Ten_TurnOffTimeMachine.btnCancel >>> l_TvtButton
[code]  }
  private
   function btnCancel(const aCtx: TtfwContext;
    aen_TurnOffTimeMachine: Ten_TurnOffTimeMachine): TvtButton;
    {* ���������� ����� ������� .Ten_TurnOffTimeMachine.btnCancel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnTurnOffTimeMachineBtnCancel

function Tkw_Form_TurnOffTimeMachine.GetString: AnsiString;
begin
 Result := 'en_TurnOffTimeMachine';
end;//Tkw_Form_TurnOffTimeMachine.GetString

class function Tkw_Form_TurnOffTimeMachine.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::TurnOffTimeMachine';
end;//Tkw_Form_TurnOffTimeMachine.GetWordNameForRegister

function Tkw_TurnOffTimeMachine_Control_rb_totmChangeDate.GetString: AnsiString;
begin
 Result := 'rb_totmChangeDate';
end;//Tkw_TurnOffTimeMachine_Control_rb_totmChangeDate.GetString

class procedure Tkw_TurnOffTimeMachine_Control_rb_totmChangeDate.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtRadioButton);
end;//Tkw_TurnOffTimeMachine_Control_rb_totmChangeDate.RegisterInEngine

class function Tkw_TurnOffTimeMachine_Control_rb_totmChangeDate.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::rb_totmChangeDate';
end;//Tkw_TurnOffTimeMachine_Control_rb_totmChangeDate.GetWordNameForRegister

procedure Tkw_TurnOffTimeMachine_Control_rb_totmChangeDate_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('rb_totmChangeDate');
 inherited;
end;//Tkw_TurnOffTimeMachine_Control_rb_totmChangeDate_Push.DoDoIt

class function Tkw_TurnOffTimeMachine_Control_rb_totmChangeDate_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::rb_totmChangeDate:push';
end;//Tkw_TurnOffTimeMachine_Control_rb_totmChangeDate_Push.GetWordNameForRegister

function Tkw_TurnOffTimeMachine_Control_rb_totmStayInCurrentRedaction.GetString: AnsiString;
begin
 Result := 'rb_totmStayInCurrentRedaction';
end;//Tkw_TurnOffTimeMachine_Control_rb_totmStayInCurrentRedaction.GetString

class procedure Tkw_TurnOffTimeMachine_Control_rb_totmStayInCurrentRedaction.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtRadioButton);
end;//Tkw_TurnOffTimeMachine_Control_rb_totmStayInCurrentRedaction.RegisterInEngine

class function Tkw_TurnOffTimeMachine_Control_rb_totmStayInCurrentRedaction.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::rb_totmStayInCurrentRedaction';
end;//Tkw_TurnOffTimeMachine_Control_rb_totmStayInCurrentRedaction.GetWordNameForRegister

procedure Tkw_TurnOffTimeMachine_Control_rb_totmStayInCurrentRedaction_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('rb_totmStayInCurrentRedaction');
 inherited;
end;//Tkw_TurnOffTimeMachine_Control_rb_totmStayInCurrentRedaction_Push.DoDoIt

class function Tkw_TurnOffTimeMachine_Control_rb_totmStayInCurrentRedaction_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::rb_totmStayInCurrentRedaction:push';
end;//Tkw_TurnOffTimeMachine_Control_rb_totmStayInCurrentRedaction_Push.GetWordNameForRegister

function Tkw_TurnOffTimeMachine_Control_rb_totmGotoActualRedaction.GetString: AnsiString;
begin
 Result := 'rb_totmGotoActualRedaction';
end;//Tkw_TurnOffTimeMachine_Control_rb_totmGotoActualRedaction.GetString

class procedure Tkw_TurnOffTimeMachine_Control_rb_totmGotoActualRedaction.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtRadioButton);
end;//Tkw_TurnOffTimeMachine_Control_rb_totmGotoActualRedaction.RegisterInEngine

class function Tkw_TurnOffTimeMachine_Control_rb_totmGotoActualRedaction.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::rb_totmGotoActualRedaction';
end;//Tkw_TurnOffTimeMachine_Control_rb_totmGotoActualRedaction.GetWordNameForRegister

procedure Tkw_TurnOffTimeMachine_Control_rb_totmGotoActualRedaction_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('rb_totmGotoActualRedaction');
 inherited;
end;//Tkw_TurnOffTimeMachine_Control_rb_totmGotoActualRedaction_Push.DoDoIt

class function Tkw_TurnOffTimeMachine_Control_rb_totmGotoActualRedaction_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::rb_totmGotoActualRedaction:push';
end;//Tkw_TurnOffTimeMachine_Control_rb_totmGotoActualRedaction_Push.GetWordNameForRegister

function Tkw_TurnOffTimeMachine_Control_deChangeDate.GetString: AnsiString;
begin
 Result := 'deChangeDate';
end;//Tkw_TurnOffTimeMachine_Control_deChangeDate.GetString

class procedure Tkw_TurnOffTimeMachine_Control_deChangeDate.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtDblClickDateEdit);
end;//Tkw_TurnOffTimeMachine_Control_deChangeDate.RegisterInEngine

class function Tkw_TurnOffTimeMachine_Control_deChangeDate.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::deChangeDate';
end;//Tkw_TurnOffTimeMachine_Control_deChangeDate.GetWordNameForRegister

procedure Tkw_TurnOffTimeMachine_Control_deChangeDate_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('deChangeDate');
 inherited;
end;//Tkw_TurnOffTimeMachine_Control_deChangeDate_Push.DoDoIt

class function Tkw_TurnOffTimeMachine_Control_deChangeDate_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::deChangeDate:push';
end;//Tkw_TurnOffTimeMachine_Control_deChangeDate_Push.GetWordNameForRegister

function Tkw_TurnOffTimeMachine_Control_pbDialogIcon.GetString: AnsiString;
begin
 Result := 'pbDialogIcon';
end;//Tkw_TurnOffTimeMachine_Control_pbDialogIcon.GetString

class procedure Tkw_TurnOffTimeMachine_Control_pbDialogIcon.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TPaintBox);
end;//Tkw_TurnOffTimeMachine_Control_pbDialogIcon.RegisterInEngine

class function Tkw_TurnOffTimeMachine_Control_pbDialogIcon.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pbDialogIcon';
end;//Tkw_TurnOffTimeMachine_Control_pbDialogIcon.GetWordNameForRegister

procedure Tkw_TurnOffTimeMachine_Control_pbDialogIcon_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('pbDialogIcon');
 inherited;
end;//Tkw_TurnOffTimeMachine_Control_pbDialogIcon_Push.DoDoIt

class function Tkw_TurnOffTimeMachine_Control_pbDialogIcon_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pbDialogIcon:push';
end;//Tkw_TurnOffTimeMachine_Control_pbDialogIcon_Push.GetWordNameForRegister

function Tkw_TurnOffTimeMachine_Control_lblTurnOnTimeMachineInfo.GetString: AnsiString;
begin
 Result := 'lblTurnOnTimeMachineInfo';
end;//Tkw_TurnOffTimeMachine_Control_lblTurnOnTimeMachineInfo.GetString

class procedure Tkw_TurnOffTimeMachine_Control_lblTurnOnTimeMachineInfo.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_TurnOffTimeMachine_Control_lblTurnOnTimeMachineInfo.RegisterInEngine

class function Tkw_TurnOffTimeMachine_Control_lblTurnOnTimeMachineInfo.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::lblTurnOnTimeMachineInfo';
end;//Tkw_TurnOffTimeMachine_Control_lblTurnOnTimeMachineInfo.GetWordNameForRegister

procedure Tkw_TurnOffTimeMachine_Control_lblTurnOnTimeMachineInfo_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('lblTurnOnTimeMachineInfo');
 inherited;
end;//Tkw_TurnOffTimeMachine_Control_lblTurnOnTimeMachineInfo_Push.DoDoIt

class function Tkw_TurnOffTimeMachine_Control_lblTurnOnTimeMachineInfo_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::lblTurnOnTimeMachineInfo:push';
end;//Tkw_TurnOffTimeMachine_Control_lblTurnOnTimeMachineInfo_Push.GetWordNameForRegister

function Tkw_TurnOffTimeMachine_Control_btnOk.GetString: AnsiString;
begin
 Result := 'btnOk';
end;//Tkw_TurnOffTimeMachine_Control_btnOk.GetString

class procedure Tkw_TurnOffTimeMachine_Control_btnOk.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtButton);
end;//Tkw_TurnOffTimeMachine_Control_btnOk.RegisterInEngine

class function Tkw_TurnOffTimeMachine_Control_btnOk.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::btnOk';
end;//Tkw_TurnOffTimeMachine_Control_btnOk.GetWordNameForRegister

procedure Tkw_TurnOffTimeMachine_Control_btnOk_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('btnOk');
 inherited;
end;//Tkw_TurnOffTimeMachine_Control_btnOk_Push.DoDoIt

class function Tkw_TurnOffTimeMachine_Control_btnOk_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::btnOk:push';
end;//Tkw_TurnOffTimeMachine_Control_btnOk_Push.GetWordNameForRegister

function Tkw_TurnOffTimeMachine_Control_btnCancel.GetString: AnsiString;
begin
 Result := 'btnCancel';
end;//Tkw_TurnOffTimeMachine_Control_btnCancel.GetString

class procedure Tkw_TurnOffTimeMachine_Control_btnCancel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtButton);
end;//Tkw_TurnOffTimeMachine_Control_btnCancel.RegisterInEngine

class function Tkw_TurnOffTimeMachine_Control_btnCancel.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::btnCancel';
end;//Tkw_TurnOffTimeMachine_Control_btnCancel.GetWordNameForRegister

procedure Tkw_TurnOffTimeMachine_Control_btnCancel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('btnCancel');
 inherited;
end;//Tkw_TurnOffTimeMachine_Control_btnCancel_Push.DoDoIt

class function Tkw_TurnOffTimeMachine_Control_btnCancel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::btnCancel:push';
end;//Tkw_TurnOffTimeMachine_Control_btnCancel_Push.GetWordNameForRegister

function TkwEnTurnOffTimeMachineRbTotmChangeDate.rb_totmChangeDate(const aCtx: TtfwContext;
 aen_TurnOffTimeMachine: Ten_TurnOffTimeMachine): TvtRadioButton;
 {* ���������� ����� ������� .Ten_TurnOffTimeMachine.rb_totmChangeDate }
begin
 Result := aen_TurnOffTimeMachine.rb_totmChangeDate;
end;//TkwEnTurnOffTimeMachineRbTotmChangeDate.rb_totmChangeDate

procedure TkwEnTurnOffTimeMachineRbTotmChangeDate.DoDoIt(const aCtx: TtfwContext);
var l_aen_TurnOffTimeMachine: Ten_TurnOffTimeMachine;
begin
 try
  l_aen_TurnOffTimeMachine := Ten_TurnOffTimeMachine(aCtx.rEngine.PopObjAs(Ten_TurnOffTimeMachine));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aen_TurnOffTimeMachine: Ten_TurnOffTimeMachine : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(rb_totmChangeDate(aCtx, l_aen_TurnOffTimeMachine));
end;//TkwEnTurnOffTimeMachineRbTotmChangeDate.DoDoIt

procedure TkwEnTurnOffTimeMachineRbTotmChangeDate.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� rb_totmChangeDate', aCtx);
end;//TkwEnTurnOffTimeMachineRbTotmChangeDate.SetValuePrim

function TkwEnTurnOffTimeMachineRbTotmChangeDate.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtRadioButton);
end;//TkwEnTurnOffTimeMachineRbTotmChangeDate.GetResultTypeInfo

function TkwEnTurnOffTimeMachineRbTotmChangeDate.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnTurnOffTimeMachineRbTotmChangeDate.GetAllParamsCount

function TkwEnTurnOffTimeMachineRbTotmChangeDate.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_TurnOffTimeMachine)]);
end;//TkwEnTurnOffTimeMachineRbTotmChangeDate.ParamsTypes

class function TkwEnTurnOffTimeMachineRbTotmChangeDate.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_TurnOffTimeMachine.rb_totmChangeDate';
end;//TkwEnTurnOffTimeMachineRbTotmChangeDate.GetWordNameForRegister

function TkwEnTurnOffTimeMachineRbTotmStayInCurrentRedaction.rb_totmStayInCurrentRedaction(const aCtx: TtfwContext;
 aen_TurnOffTimeMachine: Ten_TurnOffTimeMachine): TvtRadioButton;
 {* ���������� ����� ������� .Ten_TurnOffTimeMachine.rb_totmStayInCurrentRedaction }
begin
 Result := aen_TurnOffTimeMachine.rb_totmStayInCurrentRedaction;
end;//TkwEnTurnOffTimeMachineRbTotmStayInCurrentRedaction.rb_totmStayInCurrentRedaction

procedure TkwEnTurnOffTimeMachineRbTotmStayInCurrentRedaction.DoDoIt(const aCtx: TtfwContext);
var l_aen_TurnOffTimeMachine: Ten_TurnOffTimeMachine;
begin
 try
  l_aen_TurnOffTimeMachine := Ten_TurnOffTimeMachine(aCtx.rEngine.PopObjAs(Ten_TurnOffTimeMachine));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aen_TurnOffTimeMachine: Ten_TurnOffTimeMachine : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(rb_totmStayInCurrentRedaction(aCtx, l_aen_TurnOffTimeMachine));
end;//TkwEnTurnOffTimeMachineRbTotmStayInCurrentRedaction.DoDoIt

procedure TkwEnTurnOffTimeMachineRbTotmStayInCurrentRedaction.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� rb_totmStayInCurrentRedaction', aCtx);
end;//TkwEnTurnOffTimeMachineRbTotmStayInCurrentRedaction.SetValuePrim

function TkwEnTurnOffTimeMachineRbTotmStayInCurrentRedaction.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtRadioButton);
end;//TkwEnTurnOffTimeMachineRbTotmStayInCurrentRedaction.GetResultTypeInfo

function TkwEnTurnOffTimeMachineRbTotmStayInCurrentRedaction.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnTurnOffTimeMachineRbTotmStayInCurrentRedaction.GetAllParamsCount

function TkwEnTurnOffTimeMachineRbTotmStayInCurrentRedaction.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_TurnOffTimeMachine)]);
end;//TkwEnTurnOffTimeMachineRbTotmStayInCurrentRedaction.ParamsTypes

class function TkwEnTurnOffTimeMachineRbTotmStayInCurrentRedaction.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_TurnOffTimeMachine.rb_totmStayInCurrentRedaction';
end;//TkwEnTurnOffTimeMachineRbTotmStayInCurrentRedaction.GetWordNameForRegister

function TkwEnTurnOffTimeMachineRbTotmGotoActualRedaction.rb_totmGotoActualRedaction(const aCtx: TtfwContext;
 aen_TurnOffTimeMachine: Ten_TurnOffTimeMachine): TvtRadioButton;
 {* ���������� ����� ������� .Ten_TurnOffTimeMachine.rb_totmGotoActualRedaction }
begin
 Result := aen_TurnOffTimeMachine.rb_totmGotoActualRedaction;
end;//TkwEnTurnOffTimeMachineRbTotmGotoActualRedaction.rb_totmGotoActualRedaction

procedure TkwEnTurnOffTimeMachineRbTotmGotoActualRedaction.DoDoIt(const aCtx: TtfwContext);
var l_aen_TurnOffTimeMachine: Ten_TurnOffTimeMachine;
begin
 try
  l_aen_TurnOffTimeMachine := Ten_TurnOffTimeMachine(aCtx.rEngine.PopObjAs(Ten_TurnOffTimeMachine));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aen_TurnOffTimeMachine: Ten_TurnOffTimeMachine : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(rb_totmGotoActualRedaction(aCtx, l_aen_TurnOffTimeMachine));
end;//TkwEnTurnOffTimeMachineRbTotmGotoActualRedaction.DoDoIt

procedure TkwEnTurnOffTimeMachineRbTotmGotoActualRedaction.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� rb_totmGotoActualRedaction', aCtx);
end;//TkwEnTurnOffTimeMachineRbTotmGotoActualRedaction.SetValuePrim

function TkwEnTurnOffTimeMachineRbTotmGotoActualRedaction.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtRadioButton);
end;//TkwEnTurnOffTimeMachineRbTotmGotoActualRedaction.GetResultTypeInfo

function TkwEnTurnOffTimeMachineRbTotmGotoActualRedaction.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnTurnOffTimeMachineRbTotmGotoActualRedaction.GetAllParamsCount

function TkwEnTurnOffTimeMachineRbTotmGotoActualRedaction.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_TurnOffTimeMachine)]);
end;//TkwEnTurnOffTimeMachineRbTotmGotoActualRedaction.ParamsTypes

class function TkwEnTurnOffTimeMachineRbTotmGotoActualRedaction.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_TurnOffTimeMachine.rb_totmGotoActualRedaction';
end;//TkwEnTurnOffTimeMachineRbTotmGotoActualRedaction.GetWordNameForRegister

function TkwEnTurnOffTimeMachineDeChangeDate.deChangeDate(const aCtx: TtfwContext;
 aen_TurnOffTimeMachine: Ten_TurnOffTimeMachine): TvtDblClickDateEdit;
 {* ���������� ����� ������� .Ten_TurnOffTimeMachine.deChangeDate }
begin
 Result := aen_TurnOffTimeMachine.deChangeDate;
end;//TkwEnTurnOffTimeMachineDeChangeDate.deChangeDate

procedure TkwEnTurnOffTimeMachineDeChangeDate.DoDoIt(const aCtx: TtfwContext);
var l_aen_TurnOffTimeMachine: Ten_TurnOffTimeMachine;
begin
 try
  l_aen_TurnOffTimeMachine := Ten_TurnOffTimeMachine(aCtx.rEngine.PopObjAs(Ten_TurnOffTimeMachine));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aen_TurnOffTimeMachine: Ten_TurnOffTimeMachine : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(deChangeDate(aCtx, l_aen_TurnOffTimeMachine));
end;//TkwEnTurnOffTimeMachineDeChangeDate.DoDoIt

procedure TkwEnTurnOffTimeMachineDeChangeDate.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� deChangeDate', aCtx);
end;//TkwEnTurnOffTimeMachineDeChangeDate.SetValuePrim

function TkwEnTurnOffTimeMachineDeChangeDate.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtDblClickDateEdit);
end;//TkwEnTurnOffTimeMachineDeChangeDate.GetResultTypeInfo

function TkwEnTurnOffTimeMachineDeChangeDate.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnTurnOffTimeMachineDeChangeDate.GetAllParamsCount

function TkwEnTurnOffTimeMachineDeChangeDate.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_TurnOffTimeMachine)]);
end;//TkwEnTurnOffTimeMachineDeChangeDate.ParamsTypes

class function TkwEnTurnOffTimeMachineDeChangeDate.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_TurnOffTimeMachine.deChangeDate';
end;//TkwEnTurnOffTimeMachineDeChangeDate.GetWordNameForRegister

function TkwEnTurnOffTimeMachinePbDialogIcon.pbDialogIcon(const aCtx: TtfwContext;
 aen_TurnOffTimeMachine: Ten_TurnOffTimeMachine): TPaintBox;
 {* ���������� ����� ������� .Ten_TurnOffTimeMachine.pbDialogIcon }
begin
 Result := aen_TurnOffTimeMachine.pbDialogIcon;
end;//TkwEnTurnOffTimeMachinePbDialogIcon.pbDialogIcon

procedure TkwEnTurnOffTimeMachinePbDialogIcon.DoDoIt(const aCtx: TtfwContext);
var l_aen_TurnOffTimeMachine: Ten_TurnOffTimeMachine;
begin
 try
  l_aen_TurnOffTimeMachine := Ten_TurnOffTimeMachine(aCtx.rEngine.PopObjAs(Ten_TurnOffTimeMachine));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aen_TurnOffTimeMachine: Ten_TurnOffTimeMachine : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(pbDialogIcon(aCtx, l_aen_TurnOffTimeMachine));
end;//TkwEnTurnOffTimeMachinePbDialogIcon.DoDoIt

procedure TkwEnTurnOffTimeMachinePbDialogIcon.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� pbDialogIcon', aCtx);
end;//TkwEnTurnOffTimeMachinePbDialogIcon.SetValuePrim

function TkwEnTurnOffTimeMachinePbDialogIcon.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TPaintBox);
end;//TkwEnTurnOffTimeMachinePbDialogIcon.GetResultTypeInfo

function TkwEnTurnOffTimeMachinePbDialogIcon.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnTurnOffTimeMachinePbDialogIcon.GetAllParamsCount

function TkwEnTurnOffTimeMachinePbDialogIcon.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_TurnOffTimeMachine)]);
end;//TkwEnTurnOffTimeMachinePbDialogIcon.ParamsTypes

class function TkwEnTurnOffTimeMachinePbDialogIcon.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_TurnOffTimeMachine.pbDialogIcon';
end;//TkwEnTurnOffTimeMachinePbDialogIcon.GetWordNameForRegister

function TkwEnTurnOffTimeMachineLblTurnOnTimeMachineInfo.lblTurnOnTimeMachineInfo(const aCtx: TtfwContext;
 aen_TurnOffTimeMachine: Ten_TurnOffTimeMachine): TvtLabel;
 {* ���������� ����� ������� .Ten_TurnOffTimeMachine.lblTurnOnTimeMachineInfo }
begin
 Result := aen_TurnOffTimeMachine.lblTurnOnTimeMachineInfo;
end;//TkwEnTurnOffTimeMachineLblTurnOnTimeMachineInfo.lblTurnOnTimeMachineInfo

procedure TkwEnTurnOffTimeMachineLblTurnOnTimeMachineInfo.DoDoIt(const aCtx: TtfwContext);
var l_aen_TurnOffTimeMachine: Ten_TurnOffTimeMachine;
begin
 try
  l_aen_TurnOffTimeMachine := Ten_TurnOffTimeMachine(aCtx.rEngine.PopObjAs(Ten_TurnOffTimeMachine));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aen_TurnOffTimeMachine: Ten_TurnOffTimeMachine : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(lblTurnOnTimeMachineInfo(aCtx, l_aen_TurnOffTimeMachine));
end;//TkwEnTurnOffTimeMachineLblTurnOnTimeMachineInfo.DoDoIt

procedure TkwEnTurnOffTimeMachineLblTurnOnTimeMachineInfo.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� lblTurnOnTimeMachineInfo', aCtx);
end;//TkwEnTurnOffTimeMachineLblTurnOnTimeMachineInfo.SetValuePrim

function TkwEnTurnOffTimeMachineLblTurnOnTimeMachineInfo.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtLabel);
end;//TkwEnTurnOffTimeMachineLblTurnOnTimeMachineInfo.GetResultTypeInfo

function TkwEnTurnOffTimeMachineLblTurnOnTimeMachineInfo.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnTurnOffTimeMachineLblTurnOnTimeMachineInfo.GetAllParamsCount

function TkwEnTurnOffTimeMachineLblTurnOnTimeMachineInfo.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_TurnOffTimeMachine)]);
end;//TkwEnTurnOffTimeMachineLblTurnOnTimeMachineInfo.ParamsTypes

class function TkwEnTurnOffTimeMachineLblTurnOnTimeMachineInfo.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_TurnOffTimeMachine.lblTurnOnTimeMachineInfo';
end;//TkwEnTurnOffTimeMachineLblTurnOnTimeMachineInfo.GetWordNameForRegister

function TkwEnTurnOffTimeMachineBtnOk.btnOk(const aCtx: TtfwContext;
 aen_TurnOffTimeMachine: Ten_TurnOffTimeMachine): TvtButton;
 {* ���������� ����� ������� .Ten_TurnOffTimeMachine.btnOk }
begin
 Result := aen_TurnOffTimeMachine.btnOk;
end;//TkwEnTurnOffTimeMachineBtnOk.btnOk

procedure TkwEnTurnOffTimeMachineBtnOk.DoDoIt(const aCtx: TtfwContext);
var l_aen_TurnOffTimeMachine: Ten_TurnOffTimeMachine;
begin
 try
  l_aen_TurnOffTimeMachine := Ten_TurnOffTimeMachine(aCtx.rEngine.PopObjAs(Ten_TurnOffTimeMachine));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aen_TurnOffTimeMachine: Ten_TurnOffTimeMachine : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(btnOk(aCtx, l_aen_TurnOffTimeMachine));
end;//TkwEnTurnOffTimeMachineBtnOk.DoDoIt

procedure TkwEnTurnOffTimeMachineBtnOk.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� btnOk', aCtx);
end;//TkwEnTurnOffTimeMachineBtnOk.SetValuePrim

function TkwEnTurnOffTimeMachineBtnOk.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtButton);
end;//TkwEnTurnOffTimeMachineBtnOk.GetResultTypeInfo

function TkwEnTurnOffTimeMachineBtnOk.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnTurnOffTimeMachineBtnOk.GetAllParamsCount

function TkwEnTurnOffTimeMachineBtnOk.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_TurnOffTimeMachine)]);
end;//TkwEnTurnOffTimeMachineBtnOk.ParamsTypes

class function TkwEnTurnOffTimeMachineBtnOk.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_TurnOffTimeMachine.btnOk';
end;//TkwEnTurnOffTimeMachineBtnOk.GetWordNameForRegister

function TkwEnTurnOffTimeMachineBtnCancel.btnCancel(const aCtx: TtfwContext;
 aen_TurnOffTimeMachine: Ten_TurnOffTimeMachine): TvtButton;
 {* ���������� ����� ������� .Ten_TurnOffTimeMachine.btnCancel }
begin
 Result := aen_TurnOffTimeMachine.btnCancel;
end;//TkwEnTurnOffTimeMachineBtnCancel.btnCancel

procedure TkwEnTurnOffTimeMachineBtnCancel.DoDoIt(const aCtx: TtfwContext);
var l_aen_TurnOffTimeMachine: Ten_TurnOffTimeMachine;
begin
 try
  l_aen_TurnOffTimeMachine := Ten_TurnOffTimeMachine(aCtx.rEngine.PopObjAs(Ten_TurnOffTimeMachine));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aen_TurnOffTimeMachine: Ten_TurnOffTimeMachine : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(btnCancel(aCtx, l_aen_TurnOffTimeMachine));
end;//TkwEnTurnOffTimeMachineBtnCancel.DoDoIt

procedure TkwEnTurnOffTimeMachineBtnCancel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� btnCancel', aCtx);
end;//TkwEnTurnOffTimeMachineBtnCancel.SetValuePrim

function TkwEnTurnOffTimeMachineBtnCancel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtButton);
end;//TkwEnTurnOffTimeMachineBtnCancel.GetResultTypeInfo

function TkwEnTurnOffTimeMachineBtnCancel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnTurnOffTimeMachineBtnCancel.GetAllParamsCount

function TkwEnTurnOffTimeMachineBtnCancel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_TurnOffTimeMachine)]);
end;//TkwEnTurnOffTimeMachineBtnCancel.ParamsTypes

class function TkwEnTurnOffTimeMachineBtnCancel.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_TurnOffTimeMachine.btnCancel';
end;//TkwEnTurnOffTimeMachineBtnCancel.GetWordNameForRegister

initialization
 Tkw_Form_TurnOffTimeMachine.RegisterInEngine;
 {* ����������� Tkw_Form_TurnOffTimeMachine }
 Tkw_TurnOffTimeMachine_Control_rb_totmChangeDate.RegisterInEngine;
 {* ����������� Tkw_TurnOffTimeMachine_Control_rb_totmChangeDate }
 Tkw_TurnOffTimeMachine_Control_rb_totmChangeDate_Push.RegisterInEngine;
 {* ����������� Tkw_TurnOffTimeMachine_Control_rb_totmChangeDate_Push }
 Tkw_TurnOffTimeMachine_Control_rb_totmStayInCurrentRedaction.RegisterInEngine;
 {* ����������� Tkw_TurnOffTimeMachine_Control_rb_totmStayInCurrentRedaction }
 Tkw_TurnOffTimeMachine_Control_rb_totmStayInCurrentRedaction_Push.RegisterInEngine;
 {* ����������� Tkw_TurnOffTimeMachine_Control_rb_totmStayInCurrentRedaction_Push }
 Tkw_TurnOffTimeMachine_Control_rb_totmGotoActualRedaction.RegisterInEngine;
 {* ����������� Tkw_TurnOffTimeMachine_Control_rb_totmGotoActualRedaction }
 Tkw_TurnOffTimeMachine_Control_rb_totmGotoActualRedaction_Push.RegisterInEngine;
 {* ����������� Tkw_TurnOffTimeMachine_Control_rb_totmGotoActualRedaction_Push }
 Tkw_TurnOffTimeMachine_Control_deChangeDate.RegisterInEngine;
 {* ����������� Tkw_TurnOffTimeMachine_Control_deChangeDate }
 Tkw_TurnOffTimeMachine_Control_deChangeDate_Push.RegisterInEngine;
 {* ����������� Tkw_TurnOffTimeMachine_Control_deChangeDate_Push }
 Tkw_TurnOffTimeMachine_Control_pbDialogIcon.RegisterInEngine;
 {* ����������� Tkw_TurnOffTimeMachine_Control_pbDialogIcon }
 Tkw_TurnOffTimeMachine_Control_pbDialogIcon_Push.RegisterInEngine;
 {* ����������� Tkw_TurnOffTimeMachine_Control_pbDialogIcon_Push }
 Tkw_TurnOffTimeMachine_Control_lblTurnOnTimeMachineInfo.RegisterInEngine;
 {* ����������� Tkw_TurnOffTimeMachine_Control_lblTurnOnTimeMachineInfo }
 Tkw_TurnOffTimeMachine_Control_lblTurnOnTimeMachineInfo_Push.RegisterInEngine;
 {* ����������� Tkw_TurnOffTimeMachine_Control_lblTurnOnTimeMachineInfo_Push }
 Tkw_TurnOffTimeMachine_Control_btnOk.RegisterInEngine;
 {* ����������� Tkw_TurnOffTimeMachine_Control_btnOk }
 Tkw_TurnOffTimeMachine_Control_btnOk_Push.RegisterInEngine;
 {* ����������� Tkw_TurnOffTimeMachine_Control_btnOk_Push }
 Tkw_TurnOffTimeMachine_Control_btnCancel.RegisterInEngine;
 {* ����������� Tkw_TurnOffTimeMachine_Control_btnCancel }
 Tkw_TurnOffTimeMachine_Control_btnCancel_Push.RegisterInEngine;
 {* ����������� Tkw_TurnOffTimeMachine_Control_btnCancel_Push }
 TkwEnTurnOffTimeMachineRbTotmChangeDate.RegisterInEngine;
 {* ����������� en_TurnOffTimeMachine_rb_totmChangeDate }
 TkwEnTurnOffTimeMachineRbTotmStayInCurrentRedaction.RegisterInEngine;
 {* ����������� en_TurnOffTimeMachine_rb_totmStayInCurrentRedaction }
 TkwEnTurnOffTimeMachineRbTotmGotoActualRedaction.RegisterInEngine;
 {* ����������� en_TurnOffTimeMachine_rb_totmGotoActualRedaction }
 TkwEnTurnOffTimeMachineDeChangeDate.RegisterInEngine;
 {* ����������� en_TurnOffTimeMachine_deChangeDate }
 TkwEnTurnOffTimeMachinePbDialogIcon.RegisterInEngine;
 {* ����������� en_TurnOffTimeMachine_pbDialogIcon }
 TkwEnTurnOffTimeMachineLblTurnOnTimeMachineInfo.RegisterInEngine;
 {* ����������� en_TurnOffTimeMachine_lblTurnOnTimeMachineInfo }
 TkwEnTurnOffTimeMachineBtnOk.RegisterInEngine;
 {* ����������� en_TurnOffTimeMachine_btnOk }
 TkwEnTurnOffTimeMachineBtnCancel.RegisterInEngine;
 {* ����������� en_TurnOffTimeMachine_btnCancel }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* ����������� ���� TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Ten_TurnOffTimeMachine));
 {* ����������� ���� TurnOffTimeMachine }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtRadioButton));
 {* ����������� ���� TvtRadioButton }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtDblClickDateEdit));
 {* ����������� ���� TvtDblClickDateEdit }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TPaintBox));
 {* ����������� ���� TPaintBox }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtLabel));
 {* ����������� ���� TvtLabel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtButton));
 {* ����������� ���� TvtButton }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

end.
