unit TurnOnTimeMachineKeywordsPack;
 {* ����� ���� ������� ��� ������� � ����������� ��������� ����� TurnOnTimeMachine }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Document\TurnOnTimeMachineKeywordsPack.pas"
// ���������: "ScriptKeywordsPack"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , Document_Module
 , vtRadioButton
 , vtDblClickDateEdit
 {$If NOT Defined(NoVCL)}
 , ExtCtrls
 {$IfEnd} // NOT Defined(NoVCL)
 , vtLabel
 , vtButton
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
 Tkw_Form_TurnOnTimeMachine = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� ����� TurnOnTimeMachine
----
*������ �������������*:
[code]
'aControl' �����::TurnOnTimeMachine TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_TurnOnTimeMachine

 Tkw_TurnOnTimeMachine_Control_rb_totmOnDate = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� rb_totmOnDate
----
*������ �������������*:
[code]
�������::rb_totmOnDate TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_TurnOnTimeMachine_Control_rb_totmOnDate

 Tkw_TurnOnTimeMachine_Control_rb_totmOnDate_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� rb_totmOnDate
----
*������ �������������*:
[code]
�������::rb_totmOnDate:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_TurnOnTimeMachine_Control_rb_totmOnDate_Push

 Tkw_TurnOnTimeMachine_Control_rb_totmOnCurrentRedation = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� rb_totmOnCurrentRedation
----
*������ �������������*:
[code]
�������::rb_totmOnCurrentRedation TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_TurnOnTimeMachine_Control_rb_totmOnCurrentRedation

 Tkw_TurnOnTimeMachine_Control_rb_totmOnCurrentRedation_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� rb_totmOnCurrentRedation
----
*������ �������������*:
[code]
�������::rb_totmOnCurrentRedation:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_TurnOnTimeMachine_Control_rb_totmOnCurrentRedation_Push

 Tkw_TurnOnTimeMachine_Control_deDate = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� deDate
----
*������ �������������*:
[code]
�������::deDate TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_TurnOnTimeMachine_Control_deDate

 Tkw_TurnOnTimeMachine_Control_deDate_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� deDate
----
*������ �������������*:
[code]
�������::deDate:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_TurnOnTimeMachine_Control_deDate_Push

 Tkw_TurnOnTimeMachine_Control_pbDialogIcon = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� pbDialogIcon
----
*������ �������������*:
[code]
�������::pbDialogIcon TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_TurnOnTimeMachine_Control_pbDialogIcon

 Tkw_TurnOnTimeMachine_Control_pbDialogIcon_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� pbDialogIcon
----
*������ �������������*:
[code]
�������::pbDialogIcon:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_TurnOnTimeMachine_Control_pbDialogIcon_Push

 Tkw_TurnOnTimeMachine_Control_lblTurnOnTimeMachineInfo = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� lblTurnOnTimeMachineInfo
----
*������ �������������*:
[code]
�������::lblTurnOnTimeMachineInfo TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_TurnOnTimeMachine_Control_lblTurnOnTimeMachineInfo

 Tkw_TurnOnTimeMachine_Control_lblTurnOnTimeMachineInfo_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� lblTurnOnTimeMachineInfo
----
*������ �������������*:
[code]
�������::lblTurnOnTimeMachineInfo:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_TurnOnTimeMachine_Control_lblTurnOnTimeMachineInfo_Push

 Tkw_TurnOnTimeMachine_Control_btnOk = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� btnOk
----
*������ �������������*:
[code]
�������::btnOk TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_TurnOnTimeMachine_Control_btnOk

 Tkw_TurnOnTimeMachine_Control_btnOk_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� btnOk
----
*������ �������������*:
[code]
�������::btnOk:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_TurnOnTimeMachine_Control_btnOk_Push

 Tkw_TurnOnTimeMachine_Control_btnCancel = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� btnCancel
----
*������ �������������*:
[code]
�������::btnCancel TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_TurnOnTimeMachine_Control_btnCancel

 Tkw_TurnOnTimeMachine_Control_btnCancel_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� btnCancel
----
*������ �������������*:
[code]
�������::btnCancel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_TurnOnTimeMachine_Control_btnCancel_Push

 TkwEnTurnOnTimeMachineRbTotmOnDate = {final} class(TtfwPropertyLike)
  {* ����� ������� .Ten_TurnOnTimeMachine.rb_totmOnDate
[panel]������� rb_totmOnDate ����� Ten_TurnOnTimeMachine[panel]
*��� ����������:* TvtRadioButton
*������:*
[code]
OBJECT VAR l_TvtRadioButton
 aen_TurnOnTimeMachine .Ten_TurnOnTimeMachine.rb_totmOnDate >>> l_TvtRadioButton
[code]  }
  private
   function rb_totmOnDate(const aCtx: TtfwContext;
    aen_TurnOnTimeMachine: Ten_TurnOnTimeMachine): TvtRadioButton;
    {* ���������� ����� ������� .Ten_TurnOnTimeMachine.rb_totmOnDate }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnTurnOnTimeMachineRbTotmOnDate

 TkwEnTurnOnTimeMachineRbTotmOnCurrentRedation = {final} class(TtfwPropertyLike)
  {* ����� ������� .Ten_TurnOnTimeMachine.rb_totmOnCurrentRedation
[panel]������� rb_totmOnCurrentRedation ����� Ten_TurnOnTimeMachine[panel]
*��� ����������:* TvtRadioButton
*������:*
[code]
OBJECT VAR l_TvtRadioButton
 aen_TurnOnTimeMachine .Ten_TurnOnTimeMachine.rb_totmOnCurrentRedation >>> l_TvtRadioButton
[code]  }
  private
   function rb_totmOnCurrentRedation(const aCtx: TtfwContext;
    aen_TurnOnTimeMachine: Ten_TurnOnTimeMachine): TvtRadioButton;
    {* ���������� ����� ������� .Ten_TurnOnTimeMachine.rb_totmOnCurrentRedation }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnTurnOnTimeMachineRbTotmOnCurrentRedation

 TkwEnTurnOnTimeMachineDeDate = {final} class(TtfwPropertyLike)
  {* ����� ������� .Ten_TurnOnTimeMachine.deDate
[panel]������� deDate ����� Ten_TurnOnTimeMachine[panel]
*��� ����������:* TvtDblClickDateEdit
*������:*
[code]
OBJECT VAR l_TvtDblClickDateEdit
 aen_TurnOnTimeMachine .Ten_TurnOnTimeMachine.deDate >>> l_TvtDblClickDateEdit
[code]  }
  private
   function deDate(const aCtx: TtfwContext;
    aen_TurnOnTimeMachine: Ten_TurnOnTimeMachine): TvtDblClickDateEdit;
    {* ���������� ����� ������� .Ten_TurnOnTimeMachine.deDate }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnTurnOnTimeMachineDeDate

 TkwEnTurnOnTimeMachinePbDialogIcon = {final} class(TtfwPropertyLike)
  {* ����� ������� .Ten_TurnOnTimeMachine.pbDialogIcon
[panel]������� pbDialogIcon ����� Ten_TurnOnTimeMachine[panel]
*��� ����������:* TPaintBox
*������:*
[code]
OBJECT VAR l_TPaintBox
 aen_TurnOnTimeMachine .Ten_TurnOnTimeMachine.pbDialogIcon >>> l_TPaintBox
[code]  }
  private
   function pbDialogIcon(const aCtx: TtfwContext;
    aen_TurnOnTimeMachine: Ten_TurnOnTimeMachine): TPaintBox;
    {* ���������� ����� ������� .Ten_TurnOnTimeMachine.pbDialogIcon }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnTurnOnTimeMachinePbDialogIcon

 TkwEnTurnOnTimeMachineLblTurnOnTimeMachineInfo = {final} class(TtfwPropertyLike)
  {* ����� ������� .Ten_TurnOnTimeMachine.lblTurnOnTimeMachineInfo
[panel]������� lblTurnOnTimeMachineInfo ����� Ten_TurnOnTimeMachine[panel]
*��� ����������:* TvtLabel
*������:*
[code]
OBJECT VAR l_TvtLabel
 aen_TurnOnTimeMachine .Ten_TurnOnTimeMachine.lblTurnOnTimeMachineInfo >>> l_TvtLabel
[code]  }
  private
   function lblTurnOnTimeMachineInfo(const aCtx: TtfwContext;
    aen_TurnOnTimeMachine: Ten_TurnOnTimeMachine): TvtLabel;
    {* ���������� ����� ������� .Ten_TurnOnTimeMachine.lblTurnOnTimeMachineInfo }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnTurnOnTimeMachineLblTurnOnTimeMachineInfo

 TkwEnTurnOnTimeMachineBtnOk = {final} class(TtfwPropertyLike)
  {* ����� ������� .Ten_TurnOnTimeMachine.btnOk
[panel]������� btnOk ����� Ten_TurnOnTimeMachine[panel]
*��� ����������:* TvtButton
*������:*
[code]
OBJECT VAR l_TvtButton
 aen_TurnOnTimeMachine .Ten_TurnOnTimeMachine.btnOk >>> l_TvtButton
[code]  }
  private
   function btnOk(const aCtx: TtfwContext;
    aen_TurnOnTimeMachine: Ten_TurnOnTimeMachine): TvtButton;
    {* ���������� ����� ������� .Ten_TurnOnTimeMachine.btnOk }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnTurnOnTimeMachineBtnOk

 TkwEnTurnOnTimeMachineBtnCancel = {final} class(TtfwPropertyLike)
  {* ����� ������� .Ten_TurnOnTimeMachine.btnCancel
[panel]������� btnCancel ����� Ten_TurnOnTimeMachine[panel]
*��� ����������:* TvtButton
*������:*
[code]
OBJECT VAR l_TvtButton
 aen_TurnOnTimeMachine .Ten_TurnOnTimeMachine.btnCancel >>> l_TvtButton
[code]  }
  private
   function btnCancel(const aCtx: TtfwContext;
    aen_TurnOnTimeMachine: Ten_TurnOnTimeMachine): TvtButton;
    {* ���������� ����� ������� .Ten_TurnOnTimeMachine.btnCancel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnTurnOnTimeMachineBtnCancel

class function Tkw_Form_TurnOnTimeMachine.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::TurnOnTimeMachine';
end;//Tkw_Form_TurnOnTimeMachine.GetWordNameForRegister

function Tkw_Form_TurnOnTimeMachine.GetString: AnsiString;
begin
 Result := 'en_TurnOnTimeMachine';
end;//Tkw_Form_TurnOnTimeMachine.GetString

class function Tkw_TurnOnTimeMachine_Control_rb_totmOnDate.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::rb_totmOnDate';
end;//Tkw_TurnOnTimeMachine_Control_rb_totmOnDate.GetWordNameForRegister

function Tkw_TurnOnTimeMachine_Control_rb_totmOnDate.GetString: AnsiString;
begin
 Result := 'rb_totmOnDate';
end;//Tkw_TurnOnTimeMachine_Control_rb_totmOnDate.GetString

class procedure Tkw_TurnOnTimeMachine_Control_rb_totmOnDate.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtRadioButton);
end;//Tkw_TurnOnTimeMachine_Control_rb_totmOnDate.RegisterInEngine

procedure Tkw_TurnOnTimeMachine_Control_rb_totmOnDate_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_CFCC6EBD4298_var*
//#UC END# *4DAEEDE10285_CFCC6EBD4298_var*
begin
//#UC START# *4DAEEDE10285_CFCC6EBD4298_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_CFCC6EBD4298_impl*
end;//Tkw_TurnOnTimeMachine_Control_rb_totmOnDate_Push.DoDoIt

class function Tkw_TurnOnTimeMachine_Control_rb_totmOnDate_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::rb_totmOnDate:push';
end;//Tkw_TurnOnTimeMachine_Control_rb_totmOnDate_Push.GetWordNameForRegister

class function Tkw_TurnOnTimeMachine_Control_rb_totmOnCurrentRedation.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::rb_totmOnCurrentRedation';
end;//Tkw_TurnOnTimeMachine_Control_rb_totmOnCurrentRedation.GetWordNameForRegister

function Tkw_TurnOnTimeMachine_Control_rb_totmOnCurrentRedation.GetString: AnsiString;
begin
 Result := 'rb_totmOnCurrentRedation';
end;//Tkw_TurnOnTimeMachine_Control_rb_totmOnCurrentRedation.GetString

class procedure Tkw_TurnOnTimeMachine_Control_rb_totmOnCurrentRedation.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtRadioButton);
end;//Tkw_TurnOnTimeMachine_Control_rb_totmOnCurrentRedation.RegisterInEngine

procedure Tkw_TurnOnTimeMachine_Control_rb_totmOnCurrentRedation_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_723237D81DCB_var*
//#UC END# *4DAEEDE10285_723237D81DCB_var*
begin
//#UC START# *4DAEEDE10285_723237D81DCB_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_723237D81DCB_impl*
end;//Tkw_TurnOnTimeMachine_Control_rb_totmOnCurrentRedation_Push.DoDoIt

class function Tkw_TurnOnTimeMachine_Control_rb_totmOnCurrentRedation_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::rb_totmOnCurrentRedation:push';
end;//Tkw_TurnOnTimeMachine_Control_rb_totmOnCurrentRedation_Push.GetWordNameForRegister

class function Tkw_TurnOnTimeMachine_Control_deDate.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::deDate';
end;//Tkw_TurnOnTimeMachine_Control_deDate.GetWordNameForRegister

function Tkw_TurnOnTimeMachine_Control_deDate.GetString: AnsiString;
begin
 Result := 'deDate';
end;//Tkw_TurnOnTimeMachine_Control_deDate.GetString

class procedure Tkw_TurnOnTimeMachine_Control_deDate.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtDblClickDateEdit);
end;//Tkw_TurnOnTimeMachine_Control_deDate.RegisterInEngine

procedure Tkw_TurnOnTimeMachine_Control_deDate_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_3186ABAE2AA9_var*
//#UC END# *4DAEEDE10285_3186ABAE2AA9_var*
begin
//#UC START# *4DAEEDE10285_3186ABAE2AA9_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_3186ABAE2AA9_impl*
end;//Tkw_TurnOnTimeMachine_Control_deDate_Push.DoDoIt

class function Tkw_TurnOnTimeMachine_Control_deDate_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::deDate:push';
end;//Tkw_TurnOnTimeMachine_Control_deDate_Push.GetWordNameForRegister

class function Tkw_TurnOnTimeMachine_Control_pbDialogIcon.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pbDialogIcon';
end;//Tkw_TurnOnTimeMachine_Control_pbDialogIcon.GetWordNameForRegister

function Tkw_TurnOnTimeMachine_Control_pbDialogIcon.GetString: AnsiString;
begin
 Result := 'pbDialogIcon';
end;//Tkw_TurnOnTimeMachine_Control_pbDialogIcon.GetString

class procedure Tkw_TurnOnTimeMachine_Control_pbDialogIcon.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TPaintBox);
end;//Tkw_TurnOnTimeMachine_Control_pbDialogIcon.RegisterInEngine

procedure Tkw_TurnOnTimeMachine_Control_pbDialogIcon_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_33CAA65DF7D1_var*
//#UC END# *4DAEEDE10285_33CAA65DF7D1_var*
begin
//#UC START# *4DAEEDE10285_33CAA65DF7D1_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_33CAA65DF7D1_impl*
end;//Tkw_TurnOnTimeMachine_Control_pbDialogIcon_Push.DoDoIt

class function Tkw_TurnOnTimeMachine_Control_pbDialogIcon_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pbDialogIcon:push';
end;//Tkw_TurnOnTimeMachine_Control_pbDialogIcon_Push.GetWordNameForRegister

class function Tkw_TurnOnTimeMachine_Control_lblTurnOnTimeMachineInfo.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::lblTurnOnTimeMachineInfo';
end;//Tkw_TurnOnTimeMachine_Control_lblTurnOnTimeMachineInfo.GetWordNameForRegister

function Tkw_TurnOnTimeMachine_Control_lblTurnOnTimeMachineInfo.GetString: AnsiString;
begin
 Result := 'lblTurnOnTimeMachineInfo';
end;//Tkw_TurnOnTimeMachine_Control_lblTurnOnTimeMachineInfo.GetString

class procedure Tkw_TurnOnTimeMachine_Control_lblTurnOnTimeMachineInfo.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_TurnOnTimeMachine_Control_lblTurnOnTimeMachineInfo.RegisterInEngine

procedure Tkw_TurnOnTimeMachine_Control_lblTurnOnTimeMachineInfo_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_6090FF1AC866_var*
//#UC END# *4DAEEDE10285_6090FF1AC866_var*
begin
//#UC START# *4DAEEDE10285_6090FF1AC866_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_6090FF1AC866_impl*
end;//Tkw_TurnOnTimeMachine_Control_lblTurnOnTimeMachineInfo_Push.DoDoIt

class function Tkw_TurnOnTimeMachine_Control_lblTurnOnTimeMachineInfo_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::lblTurnOnTimeMachineInfo:push';
end;//Tkw_TurnOnTimeMachine_Control_lblTurnOnTimeMachineInfo_Push.GetWordNameForRegister

class function Tkw_TurnOnTimeMachine_Control_btnOk.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::btnOk';
end;//Tkw_TurnOnTimeMachine_Control_btnOk.GetWordNameForRegister

function Tkw_TurnOnTimeMachine_Control_btnOk.GetString: AnsiString;
begin
 Result := 'btnOk';
end;//Tkw_TurnOnTimeMachine_Control_btnOk.GetString

class procedure Tkw_TurnOnTimeMachine_Control_btnOk.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtButton);
end;//Tkw_TurnOnTimeMachine_Control_btnOk.RegisterInEngine

procedure Tkw_TurnOnTimeMachine_Control_btnOk_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_31C7F4871998_var*
//#UC END# *4DAEEDE10285_31C7F4871998_var*
begin
//#UC START# *4DAEEDE10285_31C7F4871998_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_31C7F4871998_impl*
end;//Tkw_TurnOnTimeMachine_Control_btnOk_Push.DoDoIt

class function Tkw_TurnOnTimeMachine_Control_btnOk_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::btnOk:push';
end;//Tkw_TurnOnTimeMachine_Control_btnOk_Push.GetWordNameForRegister

class function Tkw_TurnOnTimeMachine_Control_btnCancel.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::btnCancel';
end;//Tkw_TurnOnTimeMachine_Control_btnCancel.GetWordNameForRegister

function Tkw_TurnOnTimeMachine_Control_btnCancel.GetString: AnsiString;
begin
 Result := 'btnCancel';
end;//Tkw_TurnOnTimeMachine_Control_btnCancel.GetString

class procedure Tkw_TurnOnTimeMachine_Control_btnCancel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtButton);
end;//Tkw_TurnOnTimeMachine_Control_btnCancel.RegisterInEngine

procedure Tkw_TurnOnTimeMachine_Control_btnCancel_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_477582858D4D_var*
//#UC END# *4DAEEDE10285_477582858D4D_var*
begin
//#UC START# *4DAEEDE10285_477582858D4D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_477582858D4D_impl*
end;//Tkw_TurnOnTimeMachine_Control_btnCancel_Push.DoDoIt

class function Tkw_TurnOnTimeMachine_Control_btnCancel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::btnCancel:push';
end;//Tkw_TurnOnTimeMachine_Control_btnCancel_Push.GetWordNameForRegister

function TkwEnTurnOnTimeMachineRbTotmOnDate.rb_totmOnDate(const aCtx: TtfwContext;
 aen_TurnOnTimeMachine: Ten_TurnOnTimeMachine): TvtRadioButton;
 {* ���������� ����� ������� .Ten_TurnOnTimeMachine.rb_totmOnDate }
begin
 Result := aen_TurnOnTimeMachine.rb_totmOnDate;
end;//TkwEnTurnOnTimeMachineRbTotmOnDate.rb_totmOnDate

procedure TkwEnTurnOnTimeMachineRbTotmOnDate.DoDoIt(const aCtx: TtfwContext);
var l_aen_TurnOnTimeMachine: Ten_TurnOnTimeMachine;
begin
 try
  l_aen_TurnOnTimeMachine := Ten_TurnOnTimeMachine(aCtx.rEngine.PopObjAs(Ten_TurnOnTimeMachine));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aen_TurnOnTimeMachine: Ten_TurnOnTimeMachine : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(rb_totmOnDate(aCtx, l_aen_TurnOnTimeMachine));
end;//TkwEnTurnOnTimeMachineRbTotmOnDate.DoDoIt

class function TkwEnTurnOnTimeMachineRbTotmOnDate.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_TurnOnTimeMachine.rb_totmOnDate';
end;//TkwEnTurnOnTimeMachineRbTotmOnDate.GetWordNameForRegister

procedure TkwEnTurnOnTimeMachineRbTotmOnDate.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� rb_totmOnDate', aCtx);
end;//TkwEnTurnOnTimeMachineRbTotmOnDate.SetValuePrim

function TkwEnTurnOnTimeMachineRbTotmOnDate.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtRadioButton);
end;//TkwEnTurnOnTimeMachineRbTotmOnDate.GetResultTypeInfo

function TkwEnTurnOnTimeMachineRbTotmOnDate.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnTurnOnTimeMachineRbTotmOnDate.GetAllParamsCount

function TkwEnTurnOnTimeMachineRbTotmOnDate.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_TurnOnTimeMachine)]);
end;//TkwEnTurnOnTimeMachineRbTotmOnDate.ParamsTypes

function TkwEnTurnOnTimeMachineRbTotmOnCurrentRedation.rb_totmOnCurrentRedation(const aCtx: TtfwContext;
 aen_TurnOnTimeMachine: Ten_TurnOnTimeMachine): TvtRadioButton;
 {* ���������� ����� ������� .Ten_TurnOnTimeMachine.rb_totmOnCurrentRedation }
begin
 Result := aen_TurnOnTimeMachine.rb_totmOnCurrentRedation;
end;//TkwEnTurnOnTimeMachineRbTotmOnCurrentRedation.rb_totmOnCurrentRedation

procedure TkwEnTurnOnTimeMachineRbTotmOnCurrentRedation.DoDoIt(const aCtx: TtfwContext);
var l_aen_TurnOnTimeMachine: Ten_TurnOnTimeMachine;
begin
 try
  l_aen_TurnOnTimeMachine := Ten_TurnOnTimeMachine(aCtx.rEngine.PopObjAs(Ten_TurnOnTimeMachine));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aen_TurnOnTimeMachine: Ten_TurnOnTimeMachine : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(rb_totmOnCurrentRedation(aCtx, l_aen_TurnOnTimeMachine));
end;//TkwEnTurnOnTimeMachineRbTotmOnCurrentRedation.DoDoIt

class function TkwEnTurnOnTimeMachineRbTotmOnCurrentRedation.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_TurnOnTimeMachine.rb_totmOnCurrentRedation';
end;//TkwEnTurnOnTimeMachineRbTotmOnCurrentRedation.GetWordNameForRegister

procedure TkwEnTurnOnTimeMachineRbTotmOnCurrentRedation.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� rb_totmOnCurrentRedation', aCtx);
end;//TkwEnTurnOnTimeMachineRbTotmOnCurrentRedation.SetValuePrim

function TkwEnTurnOnTimeMachineRbTotmOnCurrentRedation.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtRadioButton);
end;//TkwEnTurnOnTimeMachineRbTotmOnCurrentRedation.GetResultTypeInfo

function TkwEnTurnOnTimeMachineRbTotmOnCurrentRedation.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnTurnOnTimeMachineRbTotmOnCurrentRedation.GetAllParamsCount

function TkwEnTurnOnTimeMachineRbTotmOnCurrentRedation.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_TurnOnTimeMachine)]);
end;//TkwEnTurnOnTimeMachineRbTotmOnCurrentRedation.ParamsTypes

function TkwEnTurnOnTimeMachineDeDate.deDate(const aCtx: TtfwContext;
 aen_TurnOnTimeMachine: Ten_TurnOnTimeMachine): TvtDblClickDateEdit;
 {* ���������� ����� ������� .Ten_TurnOnTimeMachine.deDate }
begin
 Result := aen_TurnOnTimeMachine.deDate;
end;//TkwEnTurnOnTimeMachineDeDate.deDate

procedure TkwEnTurnOnTimeMachineDeDate.DoDoIt(const aCtx: TtfwContext);
var l_aen_TurnOnTimeMachine: Ten_TurnOnTimeMachine;
begin
 try
  l_aen_TurnOnTimeMachine := Ten_TurnOnTimeMachine(aCtx.rEngine.PopObjAs(Ten_TurnOnTimeMachine));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aen_TurnOnTimeMachine: Ten_TurnOnTimeMachine : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(deDate(aCtx, l_aen_TurnOnTimeMachine));
end;//TkwEnTurnOnTimeMachineDeDate.DoDoIt

class function TkwEnTurnOnTimeMachineDeDate.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_TurnOnTimeMachine.deDate';
end;//TkwEnTurnOnTimeMachineDeDate.GetWordNameForRegister

procedure TkwEnTurnOnTimeMachineDeDate.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� deDate', aCtx);
end;//TkwEnTurnOnTimeMachineDeDate.SetValuePrim

function TkwEnTurnOnTimeMachineDeDate.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtDblClickDateEdit);
end;//TkwEnTurnOnTimeMachineDeDate.GetResultTypeInfo

function TkwEnTurnOnTimeMachineDeDate.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnTurnOnTimeMachineDeDate.GetAllParamsCount

function TkwEnTurnOnTimeMachineDeDate.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_TurnOnTimeMachine)]);
end;//TkwEnTurnOnTimeMachineDeDate.ParamsTypes

function TkwEnTurnOnTimeMachinePbDialogIcon.pbDialogIcon(const aCtx: TtfwContext;
 aen_TurnOnTimeMachine: Ten_TurnOnTimeMachine): TPaintBox;
 {* ���������� ����� ������� .Ten_TurnOnTimeMachine.pbDialogIcon }
begin
 Result := aen_TurnOnTimeMachine.pbDialogIcon;
end;//TkwEnTurnOnTimeMachinePbDialogIcon.pbDialogIcon

procedure TkwEnTurnOnTimeMachinePbDialogIcon.DoDoIt(const aCtx: TtfwContext);
var l_aen_TurnOnTimeMachine: Ten_TurnOnTimeMachine;
begin
 try
  l_aen_TurnOnTimeMachine := Ten_TurnOnTimeMachine(aCtx.rEngine.PopObjAs(Ten_TurnOnTimeMachine));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aen_TurnOnTimeMachine: Ten_TurnOnTimeMachine : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(pbDialogIcon(aCtx, l_aen_TurnOnTimeMachine));
end;//TkwEnTurnOnTimeMachinePbDialogIcon.DoDoIt

class function TkwEnTurnOnTimeMachinePbDialogIcon.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_TurnOnTimeMachine.pbDialogIcon';
end;//TkwEnTurnOnTimeMachinePbDialogIcon.GetWordNameForRegister

procedure TkwEnTurnOnTimeMachinePbDialogIcon.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� pbDialogIcon', aCtx);
end;//TkwEnTurnOnTimeMachinePbDialogIcon.SetValuePrim

function TkwEnTurnOnTimeMachinePbDialogIcon.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TPaintBox);
end;//TkwEnTurnOnTimeMachinePbDialogIcon.GetResultTypeInfo

function TkwEnTurnOnTimeMachinePbDialogIcon.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnTurnOnTimeMachinePbDialogIcon.GetAllParamsCount

function TkwEnTurnOnTimeMachinePbDialogIcon.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_TurnOnTimeMachine)]);
end;//TkwEnTurnOnTimeMachinePbDialogIcon.ParamsTypes

function TkwEnTurnOnTimeMachineLblTurnOnTimeMachineInfo.lblTurnOnTimeMachineInfo(const aCtx: TtfwContext;
 aen_TurnOnTimeMachine: Ten_TurnOnTimeMachine): TvtLabel;
 {* ���������� ����� ������� .Ten_TurnOnTimeMachine.lblTurnOnTimeMachineInfo }
begin
 Result := aen_TurnOnTimeMachine.lblTurnOnTimeMachineInfo;
end;//TkwEnTurnOnTimeMachineLblTurnOnTimeMachineInfo.lblTurnOnTimeMachineInfo

procedure TkwEnTurnOnTimeMachineLblTurnOnTimeMachineInfo.DoDoIt(const aCtx: TtfwContext);
var l_aen_TurnOnTimeMachine: Ten_TurnOnTimeMachine;
begin
 try
  l_aen_TurnOnTimeMachine := Ten_TurnOnTimeMachine(aCtx.rEngine.PopObjAs(Ten_TurnOnTimeMachine));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aen_TurnOnTimeMachine: Ten_TurnOnTimeMachine : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(lblTurnOnTimeMachineInfo(aCtx, l_aen_TurnOnTimeMachine));
end;//TkwEnTurnOnTimeMachineLblTurnOnTimeMachineInfo.DoDoIt

class function TkwEnTurnOnTimeMachineLblTurnOnTimeMachineInfo.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_TurnOnTimeMachine.lblTurnOnTimeMachineInfo';
end;//TkwEnTurnOnTimeMachineLblTurnOnTimeMachineInfo.GetWordNameForRegister

procedure TkwEnTurnOnTimeMachineLblTurnOnTimeMachineInfo.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� lblTurnOnTimeMachineInfo', aCtx);
end;//TkwEnTurnOnTimeMachineLblTurnOnTimeMachineInfo.SetValuePrim

function TkwEnTurnOnTimeMachineLblTurnOnTimeMachineInfo.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtLabel);
end;//TkwEnTurnOnTimeMachineLblTurnOnTimeMachineInfo.GetResultTypeInfo

function TkwEnTurnOnTimeMachineLblTurnOnTimeMachineInfo.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnTurnOnTimeMachineLblTurnOnTimeMachineInfo.GetAllParamsCount

function TkwEnTurnOnTimeMachineLblTurnOnTimeMachineInfo.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_TurnOnTimeMachine)]);
end;//TkwEnTurnOnTimeMachineLblTurnOnTimeMachineInfo.ParamsTypes

function TkwEnTurnOnTimeMachineBtnOk.btnOk(const aCtx: TtfwContext;
 aen_TurnOnTimeMachine: Ten_TurnOnTimeMachine): TvtButton;
 {* ���������� ����� ������� .Ten_TurnOnTimeMachine.btnOk }
begin
 Result := aen_TurnOnTimeMachine.btnOk;
end;//TkwEnTurnOnTimeMachineBtnOk.btnOk

procedure TkwEnTurnOnTimeMachineBtnOk.DoDoIt(const aCtx: TtfwContext);
var l_aen_TurnOnTimeMachine: Ten_TurnOnTimeMachine;
begin
 try
  l_aen_TurnOnTimeMachine := Ten_TurnOnTimeMachine(aCtx.rEngine.PopObjAs(Ten_TurnOnTimeMachine));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aen_TurnOnTimeMachine: Ten_TurnOnTimeMachine : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(btnOk(aCtx, l_aen_TurnOnTimeMachine));
end;//TkwEnTurnOnTimeMachineBtnOk.DoDoIt

class function TkwEnTurnOnTimeMachineBtnOk.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_TurnOnTimeMachine.btnOk';
end;//TkwEnTurnOnTimeMachineBtnOk.GetWordNameForRegister

procedure TkwEnTurnOnTimeMachineBtnOk.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� btnOk', aCtx);
end;//TkwEnTurnOnTimeMachineBtnOk.SetValuePrim

function TkwEnTurnOnTimeMachineBtnOk.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtButton);
end;//TkwEnTurnOnTimeMachineBtnOk.GetResultTypeInfo

function TkwEnTurnOnTimeMachineBtnOk.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnTurnOnTimeMachineBtnOk.GetAllParamsCount

function TkwEnTurnOnTimeMachineBtnOk.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_TurnOnTimeMachine)]);
end;//TkwEnTurnOnTimeMachineBtnOk.ParamsTypes

function TkwEnTurnOnTimeMachineBtnCancel.btnCancel(const aCtx: TtfwContext;
 aen_TurnOnTimeMachine: Ten_TurnOnTimeMachine): TvtButton;
 {* ���������� ����� ������� .Ten_TurnOnTimeMachine.btnCancel }
begin
 Result := aen_TurnOnTimeMachine.btnCancel;
end;//TkwEnTurnOnTimeMachineBtnCancel.btnCancel

procedure TkwEnTurnOnTimeMachineBtnCancel.DoDoIt(const aCtx: TtfwContext);
var l_aen_TurnOnTimeMachine: Ten_TurnOnTimeMachine;
begin
 try
  l_aen_TurnOnTimeMachine := Ten_TurnOnTimeMachine(aCtx.rEngine.PopObjAs(Ten_TurnOnTimeMachine));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aen_TurnOnTimeMachine: Ten_TurnOnTimeMachine : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(btnCancel(aCtx, l_aen_TurnOnTimeMachine));
end;//TkwEnTurnOnTimeMachineBtnCancel.DoDoIt

class function TkwEnTurnOnTimeMachineBtnCancel.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_TurnOnTimeMachine.btnCancel';
end;//TkwEnTurnOnTimeMachineBtnCancel.GetWordNameForRegister

procedure TkwEnTurnOnTimeMachineBtnCancel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� btnCancel', aCtx);
end;//TkwEnTurnOnTimeMachineBtnCancel.SetValuePrim

function TkwEnTurnOnTimeMachineBtnCancel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtButton);
end;//TkwEnTurnOnTimeMachineBtnCancel.GetResultTypeInfo

function TkwEnTurnOnTimeMachineBtnCancel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnTurnOnTimeMachineBtnCancel.GetAllParamsCount

function TkwEnTurnOnTimeMachineBtnCancel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_TurnOnTimeMachine)]);
end;//TkwEnTurnOnTimeMachineBtnCancel.ParamsTypes

initialization
 Tkw_Form_TurnOnTimeMachine.RegisterInEngine;
 {* ����������� Tkw_Form_TurnOnTimeMachine }
 Tkw_TurnOnTimeMachine_Control_rb_totmOnDate.RegisterInEngine;
 {* ����������� Tkw_TurnOnTimeMachine_Control_rb_totmOnDate }
 Tkw_TurnOnTimeMachine_Control_rb_totmOnDate_Push.RegisterInEngine;
 {* ����������� Tkw_TurnOnTimeMachine_Control_rb_totmOnDate_Push }
 Tkw_TurnOnTimeMachine_Control_rb_totmOnCurrentRedation.RegisterInEngine;
 {* ����������� Tkw_TurnOnTimeMachine_Control_rb_totmOnCurrentRedation }
 Tkw_TurnOnTimeMachine_Control_rb_totmOnCurrentRedation_Push.RegisterInEngine;
 {* ����������� Tkw_TurnOnTimeMachine_Control_rb_totmOnCurrentRedation_Push }
 Tkw_TurnOnTimeMachine_Control_deDate.RegisterInEngine;
 {* ����������� Tkw_TurnOnTimeMachine_Control_deDate }
 Tkw_TurnOnTimeMachine_Control_deDate_Push.RegisterInEngine;
 {* ����������� Tkw_TurnOnTimeMachine_Control_deDate_Push }
 Tkw_TurnOnTimeMachine_Control_pbDialogIcon.RegisterInEngine;
 {* ����������� Tkw_TurnOnTimeMachine_Control_pbDialogIcon }
 Tkw_TurnOnTimeMachine_Control_pbDialogIcon_Push.RegisterInEngine;
 {* ����������� Tkw_TurnOnTimeMachine_Control_pbDialogIcon_Push }
 Tkw_TurnOnTimeMachine_Control_lblTurnOnTimeMachineInfo.RegisterInEngine;
 {* ����������� Tkw_TurnOnTimeMachine_Control_lblTurnOnTimeMachineInfo }
 Tkw_TurnOnTimeMachine_Control_lblTurnOnTimeMachineInfo_Push.RegisterInEngine;
 {* ����������� Tkw_TurnOnTimeMachine_Control_lblTurnOnTimeMachineInfo_Push }
 Tkw_TurnOnTimeMachine_Control_btnOk.RegisterInEngine;
 {* ����������� Tkw_TurnOnTimeMachine_Control_btnOk }
 Tkw_TurnOnTimeMachine_Control_btnOk_Push.RegisterInEngine;
 {* ����������� Tkw_TurnOnTimeMachine_Control_btnOk_Push }
 Tkw_TurnOnTimeMachine_Control_btnCancel.RegisterInEngine;
 {* ����������� Tkw_TurnOnTimeMachine_Control_btnCancel }
 Tkw_TurnOnTimeMachine_Control_btnCancel_Push.RegisterInEngine;
 {* ����������� Tkw_TurnOnTimeMachine_Control_btnCancel_Push }
 TkwEnTurnOnTimeMachineRbTotmOnDate.RegisterInEngine;
 {* ����������� en_TurnOnTimeMachine_rb_totmOnDate }
 TkwEnTurnOnTimeMachineRbTotmOnCurrentRedation.RegisterInEngine;
 {* ����������� en_TurnOnTimeMachine_rb_totmOnCurrentRedation }
 TkwEnTurnOnTimeMachineDeDate.RegisterInEngine;
 {* ����������� en_TurnOnTimeMachine_deDate }
 TkwEnTurnOnTimeMachinePbDialogIcon.RegisterInEngine;
 {* ����������� en_TurnOnTimeMachine_pbDialogIcon }
 TkwEnTurnOnTimeMachineLblTurnOnTimeMachineInfo.RegisterInEngine;
 {* ����������� en_TurnOnTimeMachine_lblTurnOnTimeMachineInfo }
 TkwEnTurnOnTimeMachineBtnOk.RegisterInEngine;
 {* ����������� en_TurnOnTimeMachine_btnOk }
 TkwEnTurnOnTimeMachineBtnCancel.RegisterInEngine;
 {* ����������� en_TurnOnTimeMachine_btnCancel }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* ����������� ���� TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Ten_TurnOnTimeMachine));
 {* ����������� ���� TurnOnTimeMachine }
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
