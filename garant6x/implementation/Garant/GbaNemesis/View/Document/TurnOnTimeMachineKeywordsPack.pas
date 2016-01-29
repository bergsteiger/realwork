unit TurnOnTimeMachineKeywordsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/Document/TurnOnTimeMachineKeywordsPack.pas"
// �����: 05.02.2009 19:28
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<ScriptKeywordsPack::Class>> F1 ������ � ���������� � ������� ����������::Document::View::Document::Document::TurnOnTimeMachineKeywordsPack
//
// ����� ���� ������� ��� ������� � ����������� ��������� ����� TurnOnTimeMachine
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
uses
  Classes
  {$If not defined(NoVCL)}
  ,
  ExtCtrls
  {$IfEnd} //not NoVCL
  ,
  TurnOnTimeMachine_Form,
  vtDblClickDateEdit,
  vtLabel,
  tfwScriptingInterfaces
  {$If not defined(NoScripts) AND not defined(NoVCL)}
  ,
  kwBynameControlPush
  {$IfEnd} //not NoScripts AND not NoVCL
  ,
  tfwControlString,
  vtButton,
  vtRadioButton,
  tfwPropertyLike
  ;

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

implementation

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
uses
  TtfwClassRef_Proxy,
  tfwScriptingTypes,
  TypInfo,
  SysUtils,
  tfwTypeRegistrator
  ;

type
  Tkw_Form_TurnOnTimeMachine = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� ����� TurnOnTimeMachine
----
*������ �������������*:
[code]
'aControl' �����::TurnOnTimeMachine TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
  end;//Tkw_Form_TurnOnTimeMachine

// start class Tkw_Form_TurnOnTimeMachine

class function Tkw_Form_TurnOnTimeMachine.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�����::TurnOnTimeMachine';
end;//Tkw_Form_TurnOnTimeMachine.GetWordNameForRegister

function Tkw_Form_TurnOnTimeMachine.GetString: AnsiString;
 {-}
begin
 Result := 'en_TurnOnTimeMachine';
end;//Tkw_Form_TurnOnTimeMachine.GetString

type
  Tkw_TurnOnTimeMachine_Control_rb_totmOnDate = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� rb_totmOnDate
----
*������ �������������*:
[code]
�������::rb_totmOnDate TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_TurnOnTimeMachine_Control_rb_totmOnDate

// start class Tkw_TurnOnTimeMachine_Control_rb_totmOnDate

class function Tkw_TurnOnTimeMachine_Control_rb_totmOnDate.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::rb_totmOnDate';
end;//Tkw_TurnOnTimeMachine_Control_rb_totmOnDate.GetWordNameForRegister

function Tkw_TurnOnTimeMachine_Control_rb_totmOnDate.GetString: AnsiString;
 {-}
begin
 Result := 'rb_totmOnDate';
end;//Tkw_TurnOnTimeMachine_Control_rb_totmOnDate.GetString

class procedure Tkw_TurnOnTimeMachine_Control_rb_totmOnDate.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtRadioButton);
end;//Tkw_TurnOnTimeMachine_Control_rb_totmOnDate.RegisterInEngine

type
  Tkw_TurnOnTimeMachine_Control_rb_totmOnDate_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� rb_totmOnDate
----
*������ �������������*:
[code]
�������::rb_totmOnDate:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_TurnOnTimeMachine_Control_rb_totmOnDate_Push

// start class Tkw_TurnOnTimeMachine_Control_rb_totmOnDate_Push

procedure Tkw_TurnOnTimeMachine_Control_rb_totmOnDate_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('rb_totmOnDate');
 inherited;
end;//Tkw_TurnOnTimeMachine_Control_rb_totmOnDate_Push.DoDoIt

class function Tkw_TurnOnTimeMachine_Control_rb_totmOnDate_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::rb_totmOnDate:push';
end;//Tkw_TurnOnTimeMachine_Control_rb_totmOnDate_Push.GetWordNameForRegister

type
  Tkw_TurnOnTimeMachine_Control_rb_totmOnCurrentRedation = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� rb_totmOnCurrentRedation
----
*������ �������������*:
[code]
�������::rb_totmOnCurrentRedation TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_TurnOnTimeMachine_Control_rb_totmOnCurrentRedation

// start class Tkw_TurnOnTimeMachine_Control_rb_totmOnCurrentRedation

class function Tkw_TurnOnTimeMachine_Control_rb_totmOnCurrentRedation.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::rb_totmOnCurrentRedation';
end;//Tkw_TurnOnTimeMachine_Control_rb_totmOnCurrentRedation.GetWordNameForRegister

function Tkw_TurnOnTimeMachine_Control_rb_totmOnCurrentRedation.GetString: AnsiString;
 {-}
begin
 Result := 'rb_totmOnCurrentRedation';
end;//Tkw_TurnOnTimeMachine_Control_rb_totmOnCurrentRedation.GetString

class procedure Tkw_TurnOnTimeMachine_Control_rb_totmOnCurrentRedation.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtRadioButton);
end;//Tkw_TurnOnTimeMachine_Control_rb_totmOnCurrentRedation.RegisterInEngine

type
  Tkw_TurnOnTimeMachine_Control_rb_totmOnCurrentRedation_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� rb_totmOnCurrentRedation
----
*������ �������������*:
[code]
�������::rb_totmOnCurrentRedation:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_TurnOnTimeMachine_Control_rb_totmOnCurrentRedation_Push

// start class Tkw_TurnOnTimeMachine_Control_rb_totmOnCurrentRedation_Push

procedure Tkw_TurnOnTimeMachine_Control_rb_totmOnCurrentRedation_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('rb_totmOnCurrentRedation');
 inherited;
end;//Tkw_TurnOnTimeMachine_Control_rb_totmOnCurrentRedation_Push.DoDoIt

class function Tkw_TurnOnTimeMachine_Control_rb_totmOnCurrentRedation_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::rb_totmOnCurrentRedation:push';
end;//Tkw_TurnOnTimeMachine_Control_rb_totmOnCurrentRedation_Push.GetWordNameForRegister

type
  Tkw_TurnOnTimeMachine_Control_deDate = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� deDate
----
*������ �������������*:
[code]
�������::deDate TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_TurnOnTimeMachine_Control_deDate

// start class Tkw_TurnOnTimeMachine_Control_deDate

class function Tkw_TurnOnTimeMachine_Control_deDate.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::deDate';
end;//Tkw_TurnOnTimeMachine_Control_deDate.GetWordNameForRegister

function Tkw_TurnOnTimeMachine_Control_deDate.GetString: AnsiString;
 {-}
begin
 Result := 'deDate';
end;//Tkw_TurnOnTimeMachine_Control_deDate.GetString

class procedure Tkw_TurnOnTimeMachine_Control_deDate.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtDblClickDateEdit);
end;//Tkw_TurnOnTimeMachine_Control_deDate.RegisterInEngine

type
  Tkw_TurnOnTimeMachine_Control_deDate_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� deDate
----
*������ �������������*:
[code]
�������::deDate:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_TurnOnTimeMachine_Control_deDate_Push

// start class Tkw_TurnOnTimeMachine_Control_deDate_Push

procedure Tkw_TurnOnTimeMachine_Control_deDate_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('deDate');
 inherited;
end;//Tkw_TurnOnTimeMachine_Control_deDate_Push.DoDoIt

class function Tkw_TurnOnTimeMachine_Control_deDate_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::deDate:push';
end;//Tkw_TurnOnTimeMachine_Control_deDate_Push.GetWordNameForRegister

type
  Tkw_TurnOnTimeMachine_Control_pbDialogIcon = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� pbDialogIcon
----
*������ �������������*:
[code]
�������::pbDialogIcon TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_TurnOnTimeMachine_Control_pbDialogIcon

// start class Tkw_TurnOnTimeMachine_Control_pbDialogIcon

class function Tkw_TurnOnTimeMachine_Control_pbDialogIcon.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::pbDialogIcon';
end;//Tkw_TurnOnTimeMachine_Control_pbDialogIcon.GetWordNameForRegister

function Tkw_TurnOnTimeMachine_Control_pbDialogIcon.GetString: AnsiString;
 {-}
begin
 Result := 'pbDialogIcon';
end;//Tkw_TurnOnTimeMachine_Control_pbDialogIcon.GetString

class procedure Tkw_TurnOnTimeMachine_Control_pbDialogIcon.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TPaintBox);
end;//Tkw_TurnOnTimeMachine_Control_pbDialogIcon.RegisterInEngine

type
  Tkw_TurnOnTimeMachine_Control_pbDialogIcon_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� pbDialogIcon
----
*������ �������������*:
[code]
�������::pbDialogIcon:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_TurnOnTimeMachine_Control_pbDialogIcon_Push

// start class Tkw_TurnOnTimeMachine_Control_pbDialogIcon_Push

procedure Tkw_TurnOnTimeMachine_Control_pbDialogIcon_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('pbDialogIcon');
 inherited;
end;//Tkw_TurnOnTimeMachine_Control_pbDialogIcon_Push.DoDoIt

class function Tkw_TurnOnTimeMachine_Control_pbDialogIcon_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::pbDialogIcon:push';
end;//Tkw_TurnOnTimeMachine_Control_pbDialogIcon_Push.GetWordNameForRegister

type
  Tkw_TurnOnTimeMachine_Control_lblTurnOnTimeMachineInfo = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� lblTurnOnTimeMachineInfo
----
*������ �������������*:
[code]
�������::lblTurnOnTimeMachineInfo TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_TurnOnTimeMachine_Control_lblTurnOnTimeMachineInfo

// start class Tkw_TurnOnTimeMachine_Control_lblTurnOnTimeMachineInfo

class function Tkw_TurnOnTimeMachine_Control_lblTurnOnTimeMachineInfo.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::lblTurnOnTimeMachineInfo';
end;//Tkw_TurnOnTimeMachine_Control_lblTurnOnTimeMachineInfo.GetWordNameForRegister

function Tkw_TurnOnTimeMachine_Control_lblTurnOnTimeMachineInfo.GetString: AnsiString;
 {-}
begin
 Result := 'lblTurnOnTimeMachineInfo';
end;//Tkw_TurnOnTimeMachine_Control_lblTurnOnTimeMachineInfo.GetString

class procedure Tkw_TurnOnTimeMachine_Control_lblTurnOnTimeMachineInfo.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_TurnOnTimeMachine_Control_lblTurnOnTimeMachineInfo.RegisterInEngine

type
  Tkw_TurnOnTimeMachine_Control_lblTurnOnTimeMachineInfo_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� lblTurnOnTimeMachineInfo
----
*������ �������������*:
[code]
�������::lblTurnOnTimeMachineInfo:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_TurnOnTimeMachine_Control_lblTurnOnTimeMachineInfo_Push

// start class Tkw_TurnOnTimeMachine_Control_lblTurnOnTimeMachineInfo_Push

procedure Tkw_TurnOnTimeMachine_Control_lblTurnOnTimeMachineInfo_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('lblTurnOnTimeMachineInfo');
 inherited;
end;//Tkw_TurnOnTimeMachine_Control_lblTurnOnTimeMachineInfo_Push.DoDoIt

class function Tkw_TurnOnTimeMachine_Control_lblTurnOnTimeMachineInfo_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::lblTurnOnTimeMachineInfo:push';
end;//Tkw_TurnOnTimeMachine_Control_lblTurnOnTimeMachineInfo_Push.GetWordNameForRegister

type
  Tkw_TurnOnTimeMachine_Control_btnOk = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� btnOk
----
*������ �������������*:
[code]
�������::btnOk TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_TurnOnTimeMachine_Control_btnOk

// start class Tkw_TurnOnTimeMachine_Control_btnOk

class function Tkw_TurnOnTimeMachine_Control_btnOk.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::btnOk';
end;//Tkw_TurnOnTimeMachine_Control_btnOk.GetWordNameForRegister

function Tkw_TurnOnTimeMachine_Control_btnOk.GetString: AnsiString;
 {-}
begin
 Result := 'btnOk';
end;//Tkw_TurnOnTimeMachine_Control_btnOk.GetString

class procedure Tkw_TurnOnTimeMachine_Control_btnOk.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtButton);
end;//Tkw_TurnOnTimeMachine_Control_btnOk.RegisterInEngine

type
  Tkw_TurnOnTimeMachine_Control_btnOk_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� btnOk
----
*������ �������������*:
[code]
�������::btnOk:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_TurnOnTimeMachine_Control_btnOk_Push

// start class Tkw_TurnOnTimeMachine_Control_btnOk_Push

procedure Tkw_TurnOnTimeMachine_Control_btnOk_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('btnOk');
 inherited;
end;//Tkw_TurnOnTimeMachine_Control_btnOk_Push.DoDoIt

class function Tkw_TurnOnTimeMachine_Control_btnOk_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::btnOk:push';
end;//Tkw_TurnOnTimeMachine_Control_btnOk_Push.GetWordNameForRegister

type
  Tkw_TurnOnTimeMachine_Control_btnCancel = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� btnCancel
----
*������ �������������*:
[code]
�������::btnCancel TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_TurnOnTimeMachine_Control_btnCancel

// start class Tkw_TurnOnTimeMachine_Control_btnCancel

class function Tkw_TurnOnTimeMachine_Control_btnCancel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::btnCancel';
end;//Tkw_TurnOnTimeMachine_Control_btnCancel.GetWordNameForRegister

function Tkw_TurnOnTimeMachine_Control_btnCancel.GetString: AnsiString;
 {-}
begin
 Result := 'btnCancel';
end;//Tkw_TurnOnTimeMachine_Control_btnCancel.GetString

class procedure Tkw_TurnOnTimeMachine_Control_btnCancel.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtButton);
end;//Tkw_TurnOnTimeMachine_Control_btnCancel.RegisterInEngine

type
  Tkw_TurnOnTimeMachine_Control_btnCancel_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� btnCancel
----
*������ �������������*:
[code]
�������::btnCancel:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_TurnOnTimeMachine_Control_btnCancel_Push

// start class Tkw_TurnOnTimeMachine_Control_btnCancel_Push

procedure Tkw_TurnOnTimeMachine_Control_btnCancel_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('btnCancel');
 inherited;
end;//Tkw_TurnOnTimeMachine_Control_btnCancel_Push.DoDoIt

class function Tkw_TurnOnTimeMachine_Control_btnCancel_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::btnCancel:push';
end;//Tkw_TurnOnTimeMachine_Control_btnCancel_Push.GetWordNameForRegister

type
  TkwEnTurnOnTimeMachineRbTotmOnDate = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .Ten_TurnOnTimeMachine.rb_totmOnDate
[panel]������� rb_totmOnDate ����� Ten_TurnOnTimeMachine[panel]
*��� ����������:* TvtRadioButton
*������:*
[code]
OBJECT VAR l_TvtRadioButton
 aen_TurnOnTimeMachine .Ten_TurnOnTimeMachine.rb_totmOnDate >>> l_TvtRadioButton
[code]  }
  private
  // private methods
   function RbTotmOnDate(const aCtx: TtfwContext;
     aen_TurnOnTimeMachine: Ten_TurnOnTimeMachine): TvtRadioButton;
     {* ���������� ����� ������� .Ten_TurnOnTimeMachine.rb_totmOnDate }
  protected
  // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
  public
  // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
  end;//TkwEnTurnOnTimeMachineRbTotmOnDate

// start class TkwEnTurnOnTimeMachineRbTotmOnDate

function TkwEnTurnOnTimeMachineRbTotmOnDate.RbTotmOnDate(const aCtx: TtfwContext;
  aen_TurnOnTimeMachine: Ten_TurnOnTimeMachine): TvtRadioButton;
 {-}
begin
 Result := aen_TurnOnTimeMachine.rb_totmOnDate;
end;//TkwEnTurnOnTimeMachineRbTotmOnDate.RbTotmOnDate

procedure TkwEnTurnOnTimeMachineRbTotmOnDate.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aen_TurnOnTimeMachine : Ten_TurnOnTimeMachine;
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
 aCtx.rEngine.PushObj((RbTotmOnDate(aCtx, l_aen_TurnOnTimeMachine)));
end;//TkwEnTurnOnTimeMachineRbTotmOnDate.DoDoIt

class function TkwEnTurnOnTimeMachineRbTotmOnDate.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.Ten_TurnOnTimeMachine.rb_totmOnDate';
end;//TkwEnTurnOnTimeMachineRbTotmOnDate.GetWordNameForRegister

procedure TkwEnTurnOnTimeMachineRbTotmOnDate.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� rb_totmOnDate', aCtx);
end;//TkwEnTurnOnTimeMachineRbTotmOnDate.SetValuePrim

function TkwEnTurnOnTimeMachineRbTotmOnDate.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtRadioButton);
end;//TkwEnTurnOnTimeMachineRbTotmOnDate.GetResultTypeInfo

function TkwEnTurnOnTimeMachineRbTotmOnDate.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEnTurnOnTimeMachineRbTotmOnDate.GetAllParamsCount

function TkwEnTurnOnTimeMachineRbTotmOnDate.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_TurnOnTimeMachine)]);
end;//TkwEnTurnOnTimeMachineRbTotmOnDate.ParamsTypes

type
  TkwEnTurnOnTimeMachineRbTotmOnCurrentRedation = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .Ten_TurnOnTimeMachine.rb_totmOnCurrentRedation
[panel]������� rb_totmOnCurrentRedation ����� Ten_TurnOnTimeMachine[panel]
*��� ����������:* TvtRadioButton
*������:*
[code]
OBJECT VAR l_TvtRadioButton
 aen_TurnOnTimeMachine .Ten_TurnOnTimeMachine.rb_totmOnCurrentRedation >>> l_TvtRadioButton
[code]  }
  private
  // private methods
   function RbTotmOnCurrentRedation(const aCtx: TtfwContext;
     aen_TurnOnTimeMachine: Ten_TurnOnTimeMachine): TvtRadioButton;
     {* ���������� ����� ������� .Ten_TurnOnTimeMachine.rb_totmOnCurrentRedation }
  protected
  // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
  public
  // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
  end;//TkwEnTurnOnTimeMachineRbTotmOnCurrentRedation

// start class TkwEnTurnOnTimeMachineRbTotmOnCurrentRedation

function TkwEnTurnOnTimeMachineRbTotmOnCurrentRedation.RbTotmOnCurrentRedation(const aCtx: TtfwContext;
  aen_TurnOnTimeMachine: Ten_TurnOnTimeMachine): TvtRadioButton;
 {-}
begin
 Result := aen_TurnOnTimeMachine.rb_totmOnCurrentRedation;
end;//TkwEnTurnOnTimeMachineRbTotmOnCurrentRedation.RbTotmOnCurrentRedation

procedure TkwEnTurnOnTimeMachineRbTotmOnCurrentRedation.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aen_TurnOnTimeMachine : Ten_TurnOnTimeMachine;
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
 aCtx.rEngine.PushObj((RbTotmOnCurrentRedation(aCtx, l_aen_TurnOnTimeMachine)));
end;//TkwEnTurnOnTimeMachineRbTotmOnCurrentRedation.DoDoIt

class function TkwEnTurnOnTimeMachineRbTotmOnCurrentRedation.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.Ten_TurnOnTimeMachine.rb_totmOnCurrentRedation';
end;//TkwEnTurnOnTimeMachineRbTotmOnCurrentRedation.GetWordNameForRegister

procedure TkwEnTurnOnTimeMachineRbTotmOnCurrentRedation.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� rb_totmOnCurrentRedation', aCtx);
end;//TkwEnTurnOnTimeMachineRbTotmOnCurrentRedation.SetValuePrim

function TkwEnTurnOnTimeMachineRbTotmOnCurrentRedation.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtRadioButton);
end;//TkwEnTurnOnTimeMachineRbTotmOnCurrentRedation.GetResultTypeInfo

function TkwEnTurnOnTimeMachineRbTotmOnCurrentRedation.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEnTurnOnTimeMachineRbTotmOnCurrentRedation.GetAllParamsCount

function TkwEnTurnOnTimeMachineRbTotmOnCurrentRedation.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_TurnOnTimeMachine)]);
end;//TkwEnTurnOnTimeMachineRbTotmOnCurrentRedation.ParamsTypes

type
  TkwEnTurnOnTimeMachineDeDate = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .Ten_TurnOnTimeMachine.deDate
[panel]������� deDate ����� Ten_TurnOnTimeMachine[panel]
*��� ����������:* TvtDblClickDateEdit
*������:*
[code]
OBJECT VAR l_TvtDblClickDateEdit
 aen_TurnOnTimeMachine .Ten_TurnOnTimeMachine.deDate >>> l_TvtDblClickDateEdit
[code]  }
  private
  // private methods
   function DeDate(const aCtx: TtfwContext;
     aen_TurnOnTimeMachine: Ten_TurnOnTimeMachine): TvtDblClickDateEdit;
     {* ���������� ����� ������� .Ten_TurnOnTimeMachine.deDate }
  protected
  // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
  public
  // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
  end;//TkwEnTurnOnTimeMachineDeDate

// start class TkwEnTurnOnTimeMachineDeDate

function TkwEnTurnOnTimeMachineDeDate.DeDate(const aCtx: TtfwContext;
  aen_TurnOnTimeMachine: Ten_TurnOnTimeMachine): TvtDblClickDateEdit;
 {-}
begin
 Result := aen_TurnOnTimeMachine.deDate;
end;//TkwEnTurnOnTimeMachineDeDate.DeDate

procedure TkwEnTurnOnTimeMachineDeDate.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aen_TurnOnTimeMachine : Ten_TurnOnTimeMachine;
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
 aCtx.rEngine.PushObj((DeDate(aCtx, l_aen_TurnOnTimeMachine)));
end;//TkwEnTurnOnTimeMachineDeDate.DoDoIt

class function TkwEnTurnOnTimeMachineDeDate.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.Ten_TurnOnTimeMachine.deDate';
end;//TkwEnTurnOnTimeMachineDeDate.GetWordNameForRegister

procedure TkwEnTurnOnTimeMachineDeDate.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� deDate', aCtx);
end;//TkwEnTurnOnTimeMachineDeDate.SetValuePrim

function TkwEnTurnOnTimeMachineDeDate.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtDblClickDateEdit);
end;//TkwEnTurnOnTimeMachineDeDate.GetResultTypeInfo

function TkwEnTurnOnTimeMachineDeDate.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEnTurnOnTimeMachineDeDate.GetAllParamsCount

function TkwEnTurnOnTimeMachineDeDate.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_TurnOnTimeMachine)]);
end;//TkwEnTurnOnTimeMachineDeDate.ParamsTypes

type
  TkwEnTurnOnTimeMachinePbDialogIcon = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .Ten_TurnOnTimeMachine.pbDialogIcon
[panel]������� pbDialogIcon ����� Ten_TurnOnTimeMachine[panel]
*��� ����������:* TPaintBox
*������:*
[code]
OBJECT VAR l_TPaintBox
 aen_TurnOnTimeMachine .Ten_TurnOnTimeMachine.pbDialogIcon >>> l_TPaintBox
[code]  }
  private
  // private methods
   function PbDialogIcon(const aCtx: TtfwContext;
     aen_TurnOnTimeMachine: Ten_TurnOnTimeMachine): TPaintBox;
     {* ���������� ����� ������� .Ten_TurnOnTimeMachine.pbDialogIcon }
  protected
  // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
  public
  // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
  end;//TkwEnTurnOnTimeMachinePbDialogIcon

// start class TkwEnTurnOnTimeMachinePbDialogIcon

function TkwEnTurnOnTimeMachinePbDialogIcon.PbDialogIcon(const aCtx: TtfwContext;
  aen_TurnOnTimeMachine: Ten_TurnOnTimeMachine): TPaintBox;
 {-}
begin
 Result := aen_TurnOnTimeMachine.pbDialogIcon;
end;//TkwEnTurnOnTimeMachinePbDialogIcon.PbDialogIcon

procedure TkwEnTurnOnTimeMachinePbDialogIcon.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aen_TurnOnTimeMachine : Ten_TurnOnTimeMachine;
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
 aCtx.rEngine.PushObj((PbDialogIcon(aCtx, l_aen_TurnOnTimeMachine)));
end;//TkwEnTurnOnTimeMachinePbDialogIcon.DoDoIt

class function TkwEnTurnOnTimeMachinePbDialogIcon.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.Ten_TurnOnTimeMachine.pbDialogIcon';
end;//TkwEnTurnOnTimeMachinePbDialogIcon.GetWordNameForRegister

procedure TkwEnTurnOnTimeMachinePbDialogIcon.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� pbDialogIcon', aCtx);
end;//TkwEnTurnOnTimeMachinePbDialogIcon.SetValuePrim

function TkwEnTurnOnTimeMachinePbDialogIcon.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TPaintBox);
end;//TkwEnTurnOnTimeMachinePbDialogIcon.GetResultTypeInfo

function TkwEnTurnOnTimeMachinePbDialogIcon.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEnTurnOnTimeMachinePbDialogIcon.GetAllParamsCount

function TkwEnTurnOnTimeMachinePbDialogIcon.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_TurnOnTimeMachine)]);
end;//TkwEnTurnOnTimeMachinePbDialogIcon.ParamsTypes

type
  TkwEnTurnOnTimeMachineLblTurnOnTimeMachineInfo = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .Ten_TurnOnTimeMachine.lblTurnOnTimeMachineInfo
[panel]������� lblTurnOnTimeMachineInfo ����� Ten_TurnOnTimeMachine[panel]
*��� ����������:* TvtLabel
*������:*
[code]
OBJECT VAR l_TvtLabel
 aen_TurnOnTimeMachine .Ten_TurnOnTimeMachine.lblTurnOnTimeMachineInfo >>> l_TvtLabel
[code]  }
  private
  // private methods
   function LblTurnOnTimeMachineInfo(const aCtx: TtfwContext;
     aen_TurnOnTimeMachine: Ten_TurnOnTimeMachine): TvtLabel;
     {* ���������� ����� ������� .Ten_TurnOnTimeMachine.lblTurnOnTimeMachineInfo }
  protected
  // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
  public
  // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
  end;//TkwEnTurnOnTimeMachineLblTurnOnTimeMachineInfo

// start class TkwEnTurnOnTimeMachineLblTurnOnTimeMachineInfo

function TkwEnTurnOnTimeMachineLblTurnOnTimeMachineInfo.LblTurnOnTimeMachineInfo(const aCtx: TtfwContext;
  aen_TurnOnTimeMachine: Ten_TurnOnTimeMachine): TvtLabel;
 {-}
begin
 Result := aen_TurnOnTimeMachine.lblTurnOnTimeMachineInfo;
end;//TkwEnTurnOnTimeMachineLblTurnOnTimeMachineInfo.LblTurnOnTimeMachineInfo

procedure TkwEnTurnOnTimeMachineLblTurnOnTimeMachineInfo.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aen_TurnOnTimeMachine : Ten_TurnOnTimeMachine;
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
 aCtx.rEngine.PushObj((LblTurnOnTimeMachineInfo(aCtx, l_aen_TurnOnTimeMachine)));
end;//TkwEnTurnOnTimeMachineLblTurnOnTimeMachineInfo.DoDoIt

class function TkwEnTurnOnTimeMachineLblTurnOnTimeMachineInfo.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.Ten_TurnOnTimeMachine.lblTurnOnTimeMachineInfo';
end;//TkwEnTurnOnTimeMachineLblTurnOnTimeMachineInfo.GetWordNameForRegister

procedure TkwEnTurnOnTimeMachineLblTurnOnTimeMachineInfo.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� lblTurnOnTimeMachineInfo', aCtx);
end;//TkwEnTurnOnTimeMachineLblTurnOnTimeMachineInfo.SetValuePrim

function TkwEnTurnOnTimeMachineLblTurnOnTimeMachineInfo.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtLabel);
end;//TkwEnTurnOnTimeMachineLblTurnOnTimeMachineInfo.GetResultTypeInfo

function TkwEnTurnOnTimeMachineLblTurnOnTimeMachineInfo.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEnTurnOnTimeMachineLblTurnOnTimeMachineInfo.GetAllParamsCount

function TkwEnTurnOnTimeMachineLblTurnOnTimeMachineInfo.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_TurnOnTimeMachine)]);
end;//TkwEnTurnOnTimeMachineLblTurnOnTimeMachineInfo.ParamsTypes

type
  TkwEnTurnOnTimeMachineBtnOk = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .Ten_TurnOnTimeMachine.btnOk
[panel]������� btnOk ����� Ten_TurnOnTimeMachine[panel]
*��� ����������:* TvtButton
*������:*
[code]
OBJECT VAR l_TvtButton
 aen_TurnOnTimeMachine .Ten_TurnOnTimeMachine.btnOk >>> l_TvtButton
[code]  }
  private
  // private methods
   function BtnOk(const aCtx: TtfwContext;
     aen_TurnOnTimeMachine: Ten_TurnOnTimeMachine): TvtButton;
     {* ���������� ����� ������� .Ten_TurnOnTimeMachine.btnOk }
  protected
  // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
  public
  // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
  end;//TkwEnTurnOnTimeMachineBtnOk

// start class TkwEnTurnOnTimeMachineBtnOk

function TkwEnTurnOnTimeMachineBtnOk.BtnOk(const aCtx: TtfwContext;
  aen_TurnOnTimeMachine: Ten_TurnOnTimeMachine): TvtButton;
 {-}
begin
 Result := aen_TurnOnTimeMachine.btnOk;
end;//TkwEnTurnOnTimeMachineBtnOk.BtnOk

procedure TkwEnTurnOnTimeMachineBtnOk.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aen_TurnOnTimeMachine : Ten_TurnOnTimeMachine;
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
 aCtx.rEngine.PushObj((BtnOk(aCtx, l_aen_TurnOnTimeMachine)));
end;//TkwEnTurnOnTimeMachineBtnOk.DoDoIt

class function TkwEnTurnOnTimeMachineBtnOk.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.Ten_TurnOnTimeMachine.btnOk';
end;//TkwEnTurnOnTimeMachineBtnOk.GetWordNameForRegister

procedure TkwEnTurnOnTimeMachineBtnOk.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� btnOk', aCtx);
end;//TkwEnTurnOnTimeMachineBtnOk.SetValuePrim

function TkwEnTurnOnTimeMachineBtnOk.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtButton);
end;//TkwEnTurnOnTimeMachineBtnOk.GetResultTypeInfo

function TkwEnTurnOnTimeMachineBtnOk.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEnTurnOnTimeMachineBtnOk.GetAllParamsCount

function TkwEnTurnOnTimeMachineBtnOk.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_TurnOnTimeMachine)]);
end;//TkwEnTurnOnTimeMachineBtnOk.ParamsTypes

type
  TkwEnTurnOnTimeMachineBtnCancel = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .Ten_TurnOnTimeMachine.btnCancel
[panel]������� btnCancel ����� Ten_TurnOnTimeMachine[panel]
*��� ����������:* TvtButton
*������:*
[code]
OBJECT VAR l_TvtButton
 aen_TurnOnTimeMachine .Ten_TurnOnTimeMachine.btnCancel >>> l_TvtButton
[code]  }
  private
  // private methods
   function BtnCancel(const aCtx: TtfwContext;
     aen_TurnOnTimeMachine: Ten_TurnOnTimeMachine): TvtButton;
     {* ���������� ����� ������� .Ten_TurnOnTimeMachine.btnCancel }
  protected
  // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
  public
  // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
  end;//TkwEnTurnOnTimeMachineBtnCancel

// start class TkwEnTurnOnTimeMachineBtnCancel

function TkwEnTurnOnTimeMachineBtnCancel.BtnCancel(const aCtx: TtfwContext;
  aen_TurnOnTimeMachine: Ten_TurnOnTimeMachine): TvtButton;
 {-}
begin
 Result := aen_TurnOnTimeMachine.btnCancel;
end;//TkwEnTurnOnTimeMachineBtnCancel.BtnCancel

procedure TkwEnTurnOnTimeMachineBtnCancel.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aen_TurnOnTimeMachine : Ten_TurnOnTimeMachine;
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
 aCtx.rEngine.PushObj((BtnCancel(aCtx, l_aen_TurnOnTimeMachine)));
end;//TkwEnTurnOnTimeMachineBtnCancel.DoDoIt

class function TkwEnTurnOnTimeMachineBtnCancel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.Ten_TurnOnTimeMachine.btnCancel';
end;//TkwEnTurnOnTimeMachineBtnCancel.GetWordNameForRegister

procedure TkwEnTurnOnTimeMachineBtnCancel.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� btnCancel', aCtx);
end;//TkwEnTurnOnTimeMachineBtnCancel.SetValuePrim

function TkwEnTurnOnTimeMachineBtnCancel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtButton);
end;//TkwEnTurnOnTimeMachineBtnCancel.GetResultTypeInfo

function TkwEnTurnOnTimeMachineBtnCancel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEnTurnOnTimeMachineBtnCancel.GetAllParamsCount

function TkwEnTurnOnTimeMachineBtnCancel.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_TurnOnTimeMachine)]);
end;//TkwEnTurnOnTimeMachineBtnCancel.ParamsTypes
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_Form_TurnOnTimeMachine
 Tkw_Form_TurnOnTimeMachine.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_TurnOnTimeMachine_Control_rb_totmOnDate
 Tkw_TurnOnTimeMachine_Control_rb_totmOnDate.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_TurnOnTimeMachine_Control_rb_totmOnDate_Push
 Tkw_TurnOnTimeMachine_Control_rb_totmOnDate_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_TurnOnTimeMachine_Control_rb_totmOnCurrentRedation
 Tkw_TurnOnTimeMachine_Control_rb_totmOnCurrentRedation.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_TurnOnTimeMachine_Control_rb_totmOnCurrentRedation_Push
 Tkw_TurnOnTimeMachine_Control_rb_totmOnCurrentRedation_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_TurnOnTimeMachine_Control_deDate
 Tkw_TurnOnTimeMachine_Control_deDate.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_TurnOnTimeMachine_Control_deDate_Push
 Tkw_TurnOnTimeMachine_Control_deDate_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_TurnOnTimeMachine_Control_pbDialogIcon
 Tkw_TurnOnTimeMachine_Control_pbDialogIcon.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_TurnOnTimeMachine_Control_pbDialogIcon_Push
 Tkw_TurnOnTimeMachine_Control_pbDialogIcon_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_TurnOnTimeMachine_Control_lblTurnOnTimeMachineInfo
 Tkw_TurnOnTimeMachine_Control_lblTurnOnTimeMachineInfo.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_TurnOnTimeMachine_Control_lblTurnOnTimeMachineInfo_Push
 Tkw_TurnOnTimeMachine_Control_lblTurnOnTimeMachineInfo_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_TurnOnTimeMachine_Control_btnOk
 Tkw_TurnOnTimeMachine_Control_btnOk.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_TurnOnTimeMachine_Control_btnOk_Push
 Tkw_TurnOnTimeMachine_Control_btnOk_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_TurnOnTimeMachine_Control_btnCancel
 Tkw_TurnOnTimeMachine_Control_btnCancel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_TurnOnTimeMachine_Control_btnCancel_Push
 Tkw_TurnOnTimeMachine_Control_btnCancel_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� en_TurnOnTimeMachine_rb_totmOnDate
 TkwEnTurnOnTimeMachineRbTotmOnDate.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� en_TurnOnTimeMachine_rb_totmOnCurrentRedation
 TkwEnTurnOnTimeMachineRbTotmOnCurrentRedation.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� en_TurnOnTimeMachine_deDate
 TkwEnTurnOnTimeMachineDeDate.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� en_TurnOnTimeMachine_pbDialogIcon
 TkwEnTurnOnTimeMachinePbDialogIcon.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� en_TurnOnTimeMachine_lblTurnOnTimeMachineInfo
 TkwEnTurnOnTimeMachineLblTurnOnTimeMachineInfo.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� en_TurnOnTimeMachine_btnOk
 TkwEnTurnOnTimeMachineBtnOk.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� en_TurnOnTimeMachine_btnCancel
 TkwEnTurnOnTimeMachineBtnCancel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� ���� TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� ���� TurnOnTimeMachine
 TtfwTypeRegistrator.RegisterType(TypeInfo(Ten_TurnOnTimeMachine));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� ���� TvtRadioButton
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtRadioButton));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� ���� TvtDblClickDateEdit
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtDblClickDateEdit));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� ���� TPaintBox
 TtfwTypeRegistrator.RegisterType(TypeInfo(TPaintBox));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� ���� TvtLabel
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtLabel));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� ���� TvtButton
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtButton));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.