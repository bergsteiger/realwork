unit CustomizeTasksPanelKeywordsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// �����: ����� �.�.
// ������: "w:/common/components/gui/Garant/VCM/View/TasksPanel/CustomizeTasksPanelKeywordsPack.pas"
// �����: 13.09.2010 11:55
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<ScriptKeywordsPack::Class>> Shared Delphi Operations::VCMCustomization::View::TasksPanel::PrimTasksPanelMenu::CustomizeTasksPanelKeywordsPack
//
// ����� ���� ������� ��� ������� � ����������� ��������� ����� CustomizeTasksPanel
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\common\components\gui\sdoDefine.inc}

interface

{$If not defined(NoScripts) AND not defined(NoVCM)}
uses
  Classes
  {$If not defined(NoVCL)}
  ,
  StdCtrls
  {$IfEnd} //not NoVCL
  ,
  eeTreeView,
  vtPanel,
  vtCtrls,
  eeCheckBox,
  vtGroupBox,
  vtLabel,
  CustomizeTasksPanel_Form
  {$If not defined(NoVCL)}
  ,
  Buttons
  {$IfEnd} //not NoVCL
  ,
  tfwScriptingInterfaces,
  eeButton
  {$If not defined(NoScripts) AND not defined(NoVCL)}
  ,
  kwBynameControlPush
  {$IfEnd} //not NoScripts AND not NoVCL
  ,
  tfwControlString,
  vtButton,
  tfwPropertyLike
  ;

{$IfEnd} //not NoScripts AND not NoVCM

implementation

{$If not defined(NoScripts) AND not defined(NoVCM)}
uses
  TtfwClassRef_Proxy,
  tfwScriptingTypes,
  TypInfo,
  SysUtils,
  tfwTypeRegistrator
  ;

type
  Tkw_Form_CustomizeTasksPanel = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� ����� CustomizeTasksPanel
----
*������ �������������*:
[code]
'aControl' �����::CustomizeTasksPanel TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_Form_CustomizeTasksPanel

// start class Tkw_Form_CustomizeTasksPanel

class function Tkw_Form_CustomizeTasksPanel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�����::CustomizeTasksPanel';
end;//Tkw_Form_CustomizeTasksPanel.GetWordNameForRegister

function Tkw_Form_CustomizeTasksPanel.GetString: AnsiString;
 {-}
begin
 Result := 'CustomizeTasksPanelForm';
end;//Tkw_Form_CustomizeTasksPanel.GetString

class procedure Tkw_Form_CustomizeTasksPanel.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TCustomizeTasksPanelForm);
end;//Tkw_Form_CustomizeTasksPanel.RegisterInEngine

type
  Tkw_CustomizeTasksPanel_Control_spRight = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� spRight
----
*������ �������������*:
[code]
�������::spRight TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_CustomizeTasksPanel_Control_spRight

// start class Tkw_CustomizeTasksPanel_Control_spRight

class function Tkw_CustomizeTasksPanel_Control_spRight.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::spRight';
end;//Tkw_CustomizeTasksPanel_Control_spRight.GetWordNameForRegister

function Tkw_CustomizeTasksPanel_Control_spRight.GetString: AnsiString;
 {-}
begin
 Result := 'spRight';
end;//Tkw_CustomizeTasksPanel_Control_spRight.GetString

class procedure Tkw_CustomizeTasksPanel_Control_spRight.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtSplitter);
end;//Tkw_CustomizeTasksPanel_Control_spRight.RegisterInEngine

type
  Tkw_CustomizeTasksPanel_Control_spRight_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� spRight
----
*������ �������������*:
[code]
�������::spRight:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_CustomizeTasksPanel_Control_spRight_Push

// start class Tkw_CustomizeTasksPanel_Control_spRight_Push

procedure Tkw_CustomizeTasksPanel_Control_spRight_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('spRight');
 inherited;
end;//Tkw_CustomizeTasksPanel_Control_spRight_Push.DoDoIt

class function Tkw_CustomizeTasksPanel_Control_spRight_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::spRight:push';
end;//Tkw_CustomizeTasksPanel_Control_spRight_Push.GetWordNameForRegister

type
  Tkw_CustomizeTasksPanel_Control_pnlBottom = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� pnlBottom
----
*������ �������������*:
[code]
�������::pnlBottom TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_CustomizeTasksPanel_Control_pnlBottom

// start class Tkw_CustomizeTasksPanel_Control_pnlBottom

class function Tkw_CustomizeTasksPanel_Control_pnlBottom.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::pnlBottom';
end;//Tkw_CustomizeTasksPanel_Control_pnlBottom.GetWordNameForRegister

function Tkw_CustomizeTasksPanel_Control_pnlBottom.GetString: AnsiString;
 {-}
begin
 Result := 'pnlBottom';
end;//Tkw_CustomizeTasksPanel_Control_pnlBottom.GetString

class procedure Tkw_CustomizeTasksPanel_Control_pnlBottom.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_CustomizeTasksPanel_Control_pnlBottom.RegisterInEngine

type
  Tkw_CustomizeTasksPanel_Control_pnlBottom_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� pnlBottom
----
*������ �������������*:
[code]
�������::pnlBottom:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_CustomizeTasksPanel_Control_pnlBottom_Push

// start class Tkw_CustomizeTasksPanel_Control_pnlBottom_Push

procedure Tkw_CustomizeTasksPanel_Control_pnlBottom_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('pnlBottom');
 inherited;
end;//Tkw_CustomizeTasksPanel_Control_pnlBottom_Push.DoDoIt

class function Tkw_CustomizeTasksPanel_Control_pnlBottom_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::pnlBottom:push';
end;//Tkw_CustomizeTasksPanel_Control_pnlBottom_Push.GetWordNameForRegister

type
  Tkw_CustomizeTasksPanel_Control_lblConfirmSave = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� lblConfirmSave
----
*������ �������������*:
[code]
�������::lblConfirmSave TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_CustomizeTasksPanel_Control_lblConfirmSave

// start class Tkw_CustomizeTasksPanel_Control_lblConfirmSave

class function Tkw_CustomizeTasksPanel_Control_lblConfirmSave.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::lblConfirmSave';
end;//Tkw_CustomizeTasksPanel_Control_lblConfirmSave.GetWordNameForRegister

function Tkw_CustomizeTasksPanel_Control_lblConfirmSave.GetString: AnsiString;
 {-}
begin
 Result := 'lblConfirmSave';
end;//Tkw_CustomizeTasksPanel_Control_lblConfirmSave.GetString

class procedure Tkw_CustomizeTasksPanel_Control_lblConfirmSave.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_CustomizeTasksPanel_Control_lblConfirmSave.RegisterInEngine

type
  Tkw_CustomizeTasksPanel_Control_lblConfirmSave_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� lblConfirmSave
----
*������ �������������*:
[code]
�������::lblConfirmSave:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_CustomizeTasksPanel_Control_lblConfirmSave_Push

// start class Tkw_CustomizeTasksPanel_Control_lblConfirmSave_Push

procedure Tkw_CustomizeTasksPanel_Control_lblConfirmSave_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('lblConfirmSave');
 inherited;
end;//Tkw_CustomizeTasksPanel_Control_lblConfirmSave_Push.DoDoIt

class function Tkw_CustomizeTasksPanel_Control_lblConfirmSave_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::lblConfirmSave:push';
end;//Tkw_CustomizeTasksPanel_Control_lblConfirmSave_Push.GetWordNameForRegister

type
  Tkw_CustomizeTasksPanel_Control_lblAvailableOpsCaption = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� lblAvailableOpsCaption
----
*������ �������������*:
[code]
�������::lblAvailableOpsCaption TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_CustomizeTasksPanel_Control_lblAvailableOpsCaption

// start class Tkw_CustomizeTasksPanel_Control_lblAvailableOpsCaption

class function Tkw_CustomizeTasksPanel_Control_lblAvailableOpsCaption.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::lblAvailableOpsCaption';
end;//Tkw_CustomizeTasksPanel_Control_lblAvailableOpsCaption.GetWordNameForRegister

function Tkw_CustomizeTasksPanel_Control_lblAvailableOpsCaption.GetString: AnsiString;
 {-}
begin
 Result := 'lblAvailableOpsCaption';
end;//Tkw_CustomizeTasksPanel_Control_lblAvailableOpsCaption.GetString

class procedure Tkw_CustomizeTasksPanel_Control_lblAvailableOpsCaption.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_CustomizeTasksPanel_Control_lblAvailableOpsCaption.RegisterInEngine

type
  Tkw_CustomizeTasksPanel_Control_lblAvailableOpsCaption_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� lblAvailableOpsCaption
----
*������ �������������*:
[code]
�������::lblAvailableOpsCaption:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_CustomizeTasksPanel_Control_lblAvailableOpsCaption_Push

// start class Tkw_CustomizeTasksPanel_Control_lblAvailableOpsCaption_Push

procedure Tkw_CustomizeTasksPanel_Control_lblAvailableOpsCaption_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('lblAvailableOpsCaption');
 inherited;
end;//Tkw_CustomizeTasksPanel_Control_lblAvailableOpsCaption_Push.DoDoIt

class function Tkw_CustomizeTasksPanel_Control_lblAvailableOpsCaption_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::lblAvailableOpsCaption:push';
end;//Tkw_CustomizeTasksPanel_Control_lblAvailableOpsCaption_Push.GetWordNameForRegister

type
  Tkw_CustomizeTasksPanel_Control_btOk = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� btOk
----
*������ �������������*:
[code]
�������::btOk TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_CustomizeTasksPanel_Control_btOk

// start class Tkw_CustomizeTasksPanel_Control_btOk

class function Tkw_CustomizeTasksPanel_Control_btOk.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::btOk';
end;//Tkw_CustomizeTasksPanel_Control_btOk.GetWordNameForRegister

function Tkw_CustomizeTasksPanel_Control_btOk.GetString: AnsiString;
 {-}
begin
 Result := 'btOk';
end;//Tkw_CustomizeTasksPanel_Control_btOk.GetString

class procedure Tkw_CustomizeTasksPanel_Control_btOk.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtButton);
end;//Tkw_CustomizeTasksPanel_Control_btOk.RegisterInEngine

type
  Tkw_CustomizeTasksPanel_Control_btOk_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� btOk
----
*������ �������������*:
[code]
�������::btOk:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_CustomizeTasksPanel_Control_btOk_Push

// start class Tkw_CustomizeTasksPanel_Control_btOk_Push

procedure Tkw_CustomizeTasksPanel_Control_btOk_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('btOk');
 inherited;
end;//Tkw_CustomizeTasksPanel_Control_btOk_Push.DoDoIt

class function Tkw_CustomizeTasksPanel_Control_btOk_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::btOk:push';
end;//Tkw_CustomizeTasksPanel_Control_btOk_Push.GetWordNameForRegister

type
  Tkw_CustomizeTasksPanel_Control_btCancel = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� btCancel
----
*������ �������������*:
[code]
�������::btCancel TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_CustomizeTasksPanel_Control_btCancel

// start class Tkw_CustomizeTasksPanel_Control_btCancel

class function Tkw_CustomizeTasksPanel_Control_btCancel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::btCancel';
end;//Tkw_CustomizeTasksPanel_Control_btCancel.GetWordNameForRegister

function Tkw_CustomizeTasksPanel_Control_btCancel.GetString: AnsiString;
 {-}
begin
 Result := 'btCancel';
end;//Tkw_CustomizeTasksPanel_Control_btCancel.GetString

class procedure Tkw_CustomizeTasksPanel_Control_btCancel.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtButton);
end;//Tkw_CustomizeTasksPanel_Control_btCancel.RegisterInEngine

type
  Tkw_CustomizeTasksPanel_Control_btCancel_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� btCancel
----
*������ �������������*:
[code]
�������::btCancel:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_CustomizeTasksPanel_Control_btCancel_Push

// start class Tkw_CustomizeTasksPanel_Control_btCancel_Push

procedure Tkw_CustomizeTasksPanel_Control_btCancel_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('btCancel');
 inherited;
end;//Tkw_CustomizeTasksPanel_Control_btCancel_Push.DoDoIt

class function Tkw_CustomizeTasksPanel_Control_btCancel_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::btCancel:push';
end;//Tkw_CustomizeTasksPanel_Control_btCancel_Push.GetWordNameForRegister

type
  Tkw_CustomizeTasksPanel_Control_btApply = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� btApply
----
*������ �������������*:
[code]
�������::btApply TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_CustomizeTasksPanel_Control_btApply

// start class Tkw_CustomizeTasksPanel_Control_btApply

class function Tkw_CustomizeTasksPanel_Control_btApply.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::btApply';
end;//Tkw_CustomizeTasksPanel_Control_btApply.GetWordNameForRegister

function Tkw_CustomizeTasksPanel_Control_btApply.GetString: AnsiString;
 {-}
begin
 Result := 'btApply';
end;//Tkw_CustomizeTasksPanel_Control_btApply.GetString

class procedure Tkw_CustomizeTasksPanel_Control_btApply.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtButton);
end;//Tkw_CustomizeTasksPanel_Control_btApply.RegisterInEngine

type
  Tkw_CustomizeTasksPanel_Control_btApply_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� btApply
----
*������ �������������*:
[code]
�������::btApply:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_CustomizeTasksPanel_Control_btApply_Push

// start class Tkw_CustomizeTasksPanel_Control_btApply_Push

procedure Tkw_CustomizeTasksPanel_Control_btApply_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('btApply');
 inherited;
end;//Tkw_CustomizeTasksPanel_Control_btApply_Push.DoDoIt

class function Tkw_CustomizeTasksPanel_Control_btApply_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::btApply:push';
end;//Tkw_CustomizeTasksPanel_Control_btApply_Push.GetWordNameForRegister

type
  Tkw_CustomizeTasksPanel_Control_pnlRep = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� pnlRep
----
*������ �������������*:
[code]
�������::pnlRep TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_CustomizeTasksPanel_Control_pnlRep

// start class Tkw_CustomizeTasksPanel_Control_pnlRep

class function Tkw_CustomizeTasksPanel_Control_pnlRep.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::pnlRep';
end;//Tkw_CustomizeTasksPanel_Control_pnlRep.GetWordNameForRegister

function Tkw_CustomizeTasksPanel_Control_pnlRep.GetString: AnsiString;
 {-}
begin
 Result := 'pnlRep';
end;//Tkw_CustomizeTasksPanel_Control_pnlRep.GetString

class procedure Tkw_CustomizeTasksPanel_Control_pnlRep.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_CustomizeTasksPanel_Control_pnlRep.RegisterInEngine

type
  Tkw_CustomizeTasksPanel_Control_pnlRep_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� pnlRep
----
*������ �������������*:
[code]
�������::pnlRep:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_CustomizeTasksPanel_Control_pnlRep_Push

// start class Tkw_CustomizeTasksPanel_Control_pnlRep_Push

procedure Tkw_CustomizeTasksPanel_Control_pnlRep_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('pnlRep');
 inherited;
end;//Tkw_CustomizeTasksPanel_Control_pnlRep_Push.DoDoIt

class function Tkw_CustomizeTasksPanel_Control_pnlRep_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::pnlRep:push';
end;//Tkw_CustomizeTasksPanel_Control_pnlRep_Push.GetWordNameForRegister

type
  Tkw_CustomizeTasksPanel_Control_splRep = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� splRep
----
*������ �������������*:
[code]
�������::splRep TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_CustomizeTasksPanel_Control_splRep

// start class Tkw_CustomizeTasksPanel_Control_splRep

class function Tkw_CustomizeTasksPanel_Control_splRep.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::splRep';
end;//Tkw_CustomizeTasksPanel_Control_splRep.GetWordNameForRegister

function Tkw_CustomizeTasksPanel_Control_splRep.GetString: AnsiString;
 {-}
begin
 Result := 'splRep';
end;//Tkw_CustomizeTasksPanel_Control_splRep.GetString

class procedure Tkw_CustomizeTasksPanel_Control_splRep.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtSplitter);
end;//Tkw_CustomizeTasksPanel_Control_splRep.RegisterInEngine

type
  Tkw_CustomizeTasksPanel_Control_splRep_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� splRep
----
*������ �������������*:
[code]
�������::splRep:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_CustomizeTasksPanel_Control_splRep_Push

// start class Tkw_CustomizeTasksPanel_Control_splRep_Push

procedure Tkw_CustomizeTasksPanel_Control_splRep_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('splRep');
 inherited;
end;//Tkw_CustomizeTasksPanel_Control_splRep_Push.DoDoIt

class function Tkw_CustomizeTasksPanel_Control_splRep_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::splRep:push';
end;//Tkw_CustomizeTasksPanel_Control_splRep_Push.GetWordNameForRegister

type
  Tkw_CustomizeTasksPanel_Control_gbAvailableGroups = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� gbAvailableGroups
----
*������ �������������*:
[code]
�������::gbAvailableGroups TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_CustomizeTasksPanel_Control_gbAvailableGroups

// start class Tkw_CustomizeTasksPanel_Control_gbAvailableGroups

class function Tkw_CustomizeTasksPanel_Control_gbAvailableGroups.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::gbAvailableGroups';
end;//Tkw_CustomizeTasksPanel_Control_gbAvailableGroups.GetWordNameForRegister

function Tkw_CustomizeTasksPanel_Control_gbAvailableGroups.GetString: AnsiString;
 {-}
begin
 Result := 'gbAvailableGroups';
end;//Tkw_CustomizeTasksPanel_Control_gbAvailableGroups.GetString

class procedure Tkw_CustomizeTasksPanel_Control_gbAvailableGroups.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtGroupBox);
end;//Tkw_CustomizeTasksPanel_Control_gbAvailableGroups.RegisterInEngine

type
  Tkw_CustomizeTasksPanel_Control_gbAvailableGroups_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� gbAvailableGroups
----
*������ �������������*:
[code]
�������::gbAvailableGroups:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_CustomizeTasksPanel_Control_gbAvailableGroups_Push

// start class Tkw_CustomizeTasksPanel_Control_gbAvailableGroups_Push

procedure Tkw_CustomizeTasksPanel_Control_gbAvailableGroups_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('gbAvailableGroups');
 inherited;
end;//Tkw_CustomizeTasksPanel_Control_gbAvailableGroups_Push.DoDoIt

class function Tkw_CustomizeTasksPanel_Control_gbAvailableGroups_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::gbAvailableGroups:push';
end;//Tkw_CustomizeTasksPanel_Control_gbAvailableGroups_Push.GetWordNameForRegister

type
  Tkw_CustomizeTasksPanel_Control_tvRepGroups = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� tvRepGroups
----
*������ �������������*:
[code]
�������::tvRepGroups TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_CustomizeTasksPanel_Control_tvRepGroups

// start class Tkw_CustomizeTasksPanel_Control_tvRepGroups

class function Tkw_CustomizeTasksPanel_Control_tvRepGroups.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::tvRepGroups';
end;//Tkw_CustomizeTasksPanel_Control_tvRepGroups.GetWordNameForRegister

function Tkw_CustomizeTasksPanel_Control_tvRepGroups.GetString: AnsiString;
 {-}
begin
 Result := 'tvRepGroups';
end;//Tkw_CustomizeTasksPanel_Control_tvRepGroups.GetString

class procedure Tkw_CustomizeTasksPanel_Control_tvRepGroups.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TeeTreeView);
end;//Tkw_CustomizeTasksPanel_Control_tvRepGroups.RegisterInEngine

type
  Tkw_CustomizeTasksPanel_Control_tvRepGroups_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� tvRepGroups
----
*������ �������������*:
[code]
�������::tvRepGroups:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_CustomizeTasksPanel_Control_tvRepGroups_Push

// start class Tkw_CustomizeTasksPanel_Control_tvRepGroups_Push

procedure Tkw_CustomizeTasksPanel_Control_tvRepGroups_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('tvRepGroups');
 inherited;
end;//Tkw_CustomizeTasksPanel_Control_tvRepGroups_Push.DoDoIt

class function Tkw_CustomizeTasksPanel_Control_tvRepGroups_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::tvRepGroups:push';
end;//Tkw_CustomizeTasksPanel_Control_tvRepGroups_Push.GetWordNameForRegister

type
  Tkw_CustomizeTasksPanel_Control_vtPanel1 = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� vtPanel1
----
*������ �������������*:
[code]
�������::vtPanel1 TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_CustomizeTasksPanel_Control_vtPanel1

// start class Tkw_CustomizeTasksPanel_Control_vtPanel1

class function Tkw_CustomizeTasksPanel_Control_vtPanel1.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::vtPanel1';
end;//Tkw_CustomizeTasksPanel_Control_vtPanel1.GetWordNameForRegister

function Tkw_CustomizeTasksPanel_Control_vtPanel1.GetString: AnsiString;
 {-}
begin
 Result := 'vtPanel1';
end;//Tkw_CustomizeTasksPanel_Control_vtPanel1.GetString

class procedure Tkw_CustomizeTasksPanel_Control_vtPanel1.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_CustomizeTasksPanel_Control_vtPanel1.RegisterInEngine

type
  Tkw_CustomizeTasksPanel_Control_vtPanel1_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� vtPanel1
----
*������ �������������*:
[code]
�������::vtPanel1:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_CustomizeTasksPanel_Control_vtPanel1_Push

// start class Tkw_CustomizeTasksPanel_Control_vtPanel1_Push

procedure Tkw_CustomizeTasksPanel_Control_vtPanel1_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('vtPanel1');
 inherited;
end;//Tkw_CustomizeTasksPanel_Control_vtPanel1_Push.DoDoIt

class function Tkw_CustomizeTasksPanel_Control_vtPanel1_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::vtPanel1:push';
end;//Tkw_CustomizeTasksPanel_Control_vtPanel1_Push.GetWordNameForRegister

type
  Tkw_CustomizeTasksPanel_Control_cbGroupName = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� cbGroupName
----
*������ �������������*:
[code]
�������::cbGroupName TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_CustomizeTasksPanel_Control_cbGroupName

// start class Tkw_CustomizeTasksPanel_Control_cbGroupName

class function Tkw_CustomizeTasksPanel_Control_cbGroupName.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::cbGroupName';
end;//Tkw_CustomizeTasksPanel_Control_cbGroupName.GetWordNameForRegister

function Tkw_CustomizeTasksPanel_Control_cbGroupName.GetString: AnsiString;
 {-}
begin
 Result := 'cbGroupName';
end;//Tkw_CustomizeTasksPanel_Control_cbGroupName.GetString

class procedure Tkw_CustomizeTasksPanel_Control_cbGroupName.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtComboBox);
end;//Tkw_CustomizeTasksPanel_Control_cbGroupName.RegisterInEngine

type
  Tkw_CustomizeTasksPanel_Control_cbGroupName_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� cbGroupName
----
*������ �������������*:
[code]
�������::cbGroupName:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_CustomizeTasksPanel_Control_cbGroupName_Push

// start class Tkw_CustomizeTasksPanel_Control_cbGroupName_Push

procedure Tkw_CustomizeTasksPanel_Control_cbGroupName_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('cbGroupName');
 inherited;
end;//Tkw_CustomizeTasksPanel_Control_cbGroupName_Push.DoDoIt

class function Tkw_CustomizeTasksPanel_Control_cbGroupName_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::cbGroupName:push';
end;//Tkw_CustomizeTasksPanel_Control_cbGroupName_Push.GetWordNameForRegister

type
  Tkw_CustomizeTasksPanel_Control_btnAddGroup = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� btnAddGroup
----
*������ �������������*:
[code]
�������::btnAddGroup TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_CustomizeTasksPanel_Control_btnAddGroup

// start class Tkw_CustomizeTasksPanel_Control_btnAddGroup

class function Tkw_CustomizeTasksPanel_Control_btnAddGroup.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::btnAddGroup';
end;//Tkw_CustomizeTasksPanel_Control_btnAddGroup.GetWordNameForRegister

function Tkw_CustomizeTasksPanel_Control_btnAddGroup.GetString: AnsiString;
 {-}
begin
 Result := 'btnAddGroup';
end;//Tkw_CustomizeTasksPanel_Control_btnAddGroup.GetString

class procedure Tkw_CustomizeTasksPanel_Control_btnAddGroup.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TeeButton);
end;//Tkw_CustomizeTasksPanel_Control_btnAddGroup.RegisterInEngine

type
  Tkw_CustomizeTasksPanel_Control_btnAddGroup_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� btnAddGroup
----
*������ �������������*:
[code]
�������::btnAddGroup:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_CustomizeTasksPanel_Control_btnAddGroup_Push

// start class Tkw_CustomizeTasksPanel_Control_btnAddGroup_Push

procedure Tkw_CustomizeTasksPanel_Control_btnAddGroup_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('btnAddGroup');
 inherited;
end;//Tkw_CustomizeTasksPanel_Control_btnAddGroup_Push.DoDoIt

class function Tkw_CustomizeTasksPanel_Control_btnAddGroup_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::btnAddGroup:push';
end;//Tkw_CustomizeTasksPanel_Control_btnAddGroup_Push.GetWordNameForRegister

type
  Tkw_CustomizeTasksPanel_Control_btnChangeGroup = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� btnChangeGroup
----
*������ �������������*:
[code]
�������::btnChangeGroup TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_CustomizeTasksPanel_Control_btnChangeGroup

// start class Tkw_CustomizeTasksPanel_Control_btnChangeGroup

class function Tkw_CustomizeTasksPanel_Control_btnChangeGroup.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::btnChangeGroup';
end;//Tkw_CustomizeTasksPanel_Control_btnChangeGroup.GetWordNameForRegister

function Tkw_CustomizeTasksPanel_Control_btnChangeGroup.GetString: AnsiString;
 {-}
begin
 Result := 'btnChangeGroup';
end;//Tkw_CustomizeTasksPanel_Control_btnChangeGroup.GetString

class procedure Tkw_CustomizeTasksPanel_Control_btnChangeGroup.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TeeButton);
end;//Tkw_CustomizeTasksPanel_Control_btnChangeGroup.RegisterInEngine

type
  Tkw_CustomizeTasksPanel_Control_btnChangeGroup_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� btnChangeGroup
----
*������ �������������*:
[code]
�������::btnChangeGroup:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_CustomizeTasksPanel_Control_btnChangeGroup_Push

// start class Tkw_CustomizeTasksPanel_Control_btnChangeGroup_Push

procedure Tkw_CustomizeTasksPanel_Control_btnChangeGroup_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('btnChangeGroup');
 inherited;
end;//Tkw_CustomizeTasksPanel_Control_btnChangeGroup_Push.DoDoIt

class function Tkw_CustomizeTasksPanel_Control_btnChangeGroup_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::btnChangeGroup:push';
end;//Tkw_CustomizeTasksPanel_Control_btnChangeGroup_Push.GetWordNameForRegister

type
  Tkw_CustomizeTasksPanel_Control_btnDeleteGroup = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� btnDeleteGroup
----
*������ �������������*:
[code]
�������::btnDeleteGroup TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_CustomizeTasksPanel_Control_btnDeleteGroup

// start class Tkw_CustomizeTasksPanel_Control_btnDeleteGroup

class function Tkw_CustomizeTasksPanel_Control_btnDeleteGroup.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::btnDeleteGroup';
end;//Tkw_CustomizeTasksPanel_Control_btnDeleteGroup.GetWordNameForRegister

function Tkw_CustomizeTasksPanel_Control_btnDeleteGroup.GetString: AnsiString;
 {-}
begin
 Result := 'btnDeleteGroup';
end;//Tkw_CustomizeTasksPanel_Control_btnDeleteGroup.GetString

class procedure Tkw_CustomizeTasksPanel_Control_btnDeleteGroup.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TeeButton);
end;//Tkw_CustomizeTasksPanel_Control_btnDeleteGroup.RegisterInEngine

type
  Tkw_CustomizeTasksPanel_Control_btnDeleteGroup_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� btnDeleteGroup
----
*������ �������������*:
[code]
�������::btnDeleteGroup:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_CustomizeTasksPanel_Control_btnDeleteGroup_Push

// start class Tkw_CustomizeTasksPanel_Control_btnDeleteGroup_Push

procedure Tkw_CustomizeTasksPanel_Control_btnDeleteGroup_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('btnDeleteGroup');
 inherited;
end;//Tkw_CustomizeTasksPanel_Control_btnDeleteGroup_Push.DoDoIt

class function Tkw_CustomizeTasksPanel_Control_btnDeleteGroup_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::btnDeleteGroup:push';
end;//Tkw_CustomizeTasksPanel_Control_btnDeleteGroup_Push.GetWordNameForRegister

type
  Tkw_CustomizeTasksPanel_Control_gbAvailableOperations = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� gbAvailableOperations
----
*������ �������������*:
[code]
�������::gbAvailableOperations TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_CustomizeTasksPanel_Control_gbAvailableOperations

// start class Tkw_CustomizeTasksPanel_Control_gbAvailableOperations

class function Tkw_CustomizeTasksPanel_Control_gbAvailableOperations.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::gbAvailableOperations';
end;//Tkw_CustomizeTasksPanel_Control_gbAvailableOperations.GetWordNameForRegister

function Tkw_CustomizeTasksPanel_Control_gbAvailableOperations.GetString: AnsiString;
 {-}
begin
 Result := 'gbAvailableOperations';
end;//Tkw_CustomizeTasksPanel_Control_gbAvailableOperations.GetString

class procedure Tkw_CustomizeTasksPanel_Control_gbAvailableOperations.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtGroupBox);
end;//Tkw_CustomizeTasksPanel_Control_gbAvailableOperations.RegisterInEngine

type
  Tkw_CustomizeTasksPanel_Control_gbAvailableOperations_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� gbAvailableOperations
----
*������ �������������*:
[code]
�������::gbAvailableOperations:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_CustomizeTasksPanel_Control_gbAvailableOperations_Push

// start class Tkw_CustomizeTasksPanel_Control_gbAvailableOperations_Push

procedure Tkw_CustomizeTasksPanel_Control_gbAvailableOperations_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('gbAvailableOperations');
 inherited;
end;//Tkw_CustomizeTasksPanel_Control_gbAvailableOperations_Push.DoDoIt

class function Tkw_CustomizeTasksPanel_Control_gbAvailableOperations_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::gbAvailableOperations:push';
end;//Tkw_CustomizeTasksPanel_Control_gbAvailableOperations_Push.GetWordNameForRegister

type
  Tkw_CustomizeTasksPanel_Control_tvRepOps = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� tvRepOps
----
*������ �������������*:
[code]
�������::tvRepOps TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_CustomizeTasksPanel_Control_tvRepOps

// start class Tkw_CustomizeTasksPanel_Control_tvRepOps

class function Tkw_CustomizeTasksPanel_Control_tvRepOps.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::tvRepOps';
end;//Tkw_CustomizeTasksPanel_Control_tvRepOps.GetWordNameForRegister

function Tkw_CustomizeTasksPanel_Control_tvRepOps.GetString: AnsiString;
 {-}
begin
 Result := 'tvRepOps';
end;//Tkw_CustomizeTasksPanel_Control_tvRepOps.GetString

class procedure Tkw_CustomizeTasksPanel_Control_tvRepOps.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TeeTreeView);
end;//Tkw_CustomizeTasksPanel_Control_tvRepOps.RegisterInEngine

type
  Tkw_CustomizeTasksPanel_Control_tvRepOps_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� tvRepOps
----
*������ �������������*:
[code]
�������::tvRepOps:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_CustomizeTasksPanel_Control_tvRepOps_Push

// start class Tkw_CustomizeTasksPanel_Control_tvRepOps_Push

procedure Tkw_CustomizeTasksPanel_Control_tvRepOps_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('tvRepOps');
 inherited;
end;//Tkw_CustomizeTasksPanel_Control_tvRepOps_Push.DoDoIt

class function Tkw_CustomizeTasksPanel_Control_tvRepOps_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::tvRepOps:push';
end;//Tkw_CustomizeTasksPanel_Control_tvRepOps_Push.GetWordNameForRegister

type
  Tkw_CustomizeTasksPanel_Control_pnlForms = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� pnlForms
----
*������ �������������*:
[code]
�������::pnlForms TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_CustomizeTasksPanel_Control_pnlForms

// start class Tkw_CustomizeTasksPanel_Control_pnlForms

class function Tkw_CustomizeTasksPanel_Control_pnlForms.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::pnlForms';
end;//Tkw_CustomizeTasksPanel_Control_pnlForms.GetWordNameForRegister

function Tkw_CustomizeTasksPanel_Control_pnlForms.GetString: AnsiString;
 {-}
begin
 Result := 'pnlForms';
end;//Tkw_CustomizeTasksPanel_Control_pnlForms.GetString

class procedure Tkw_CustomizeTasksPanel_Control_pnlForms.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_CustomizeTasksPanel_Control_pnlForms.RegisterInEngine

type
  Tkw_CustomizeTasksPanel_Control_pnlForms_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� pnlForms
----
*������ �������������*:
[code]
�������::pnlForms:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_CustomizeTasksPanel_Control_pnlForms_Push

// start class Tkw_CustomizeTasksPanel_Control_pnlForms_Push

procedure Tkw_CustomizeTasksPanel_Control_pnlForms_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('pnlForms');
 inherited;
end;//Tkw_CustomizeTasksPanel_Control_pnlForms_Push.DoDoIt

class function Tkw_CustomizeTasksPanel_Control_pnlForms_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::pnlForms:push';
end;//Tkw_CustomizeTasksPanel_Control_pnlForms_Push.GetWordNameForRegister

type
  Tkw_CustomizeTasksPanel_Control_lblForms = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� lblForms
----
*������ �������������*:
[code]
�������::lblForms TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_CustomizeTasksPanel_Control_lblForms

// start class Tkw_CustomizeTasksPanel_Control_lblForms

class function Tkw_CustomizeTasksPanel_Control_lblForms.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::lblForms';
end;//Tkw_CustomizeTasksPanel_Control_lblForms.GetWordNameForRegister

function Tkw_CustomizeTasksPanel_Control_lblForms.GetString: AnsiString;
 {-}
begin
 Result := 'lblForms';
end;//Tkw_CustomizeTasksPanel_Control_lblForms.GetString

class procedure Tkw_CustomizeTasksPanel_Control_lblForms.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_CustomizeTasksPanel_Control_lblForms.RegisterInEngine

type
  Tkw_CustomizeTasksPanel_Control_lblForms_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� lblForms
----
*������ �������������*:
[code]
�������::lblForms:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_CustomizeTasksPanel_Control_lblForms_Push

// start class Tkw_CustomizeTasksPanel_Control_lblForms_Push

procedure Tkw_CustomizeTasksPanel_Control_lblForms_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('lblForms');
 inherited;
end;//Tkw_CustomizeTasksPanel_Control_lblForms_Push.DoDoIt

class function Tkw_CustomizeTasksPanel_Control_lblForms_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::lblForms:push';
end;//Tkw_CustomizeTasksPanel_Control_lblForms_Push.GetWordNameForRegister

type
  Tkw_CustomizeTasksPanel_Control_cbForms = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� cbForms
----
*������ �������������*:
[code]
�������::cbForms TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_CustomizeTasksPanel_Control_cbForms

// start class Tkw_CustomizeTasksPanel_Control_cbForms

class function Tkw_CustomizeTasksPanel_Control_cbForms.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::cbForms';
end;//Tkw_CustomizeTasksPanel_Control_cbForms.GetWordNameForRegister

function Tkw_CustomizeTasksPanel_Control_cbForms.GetString: AnsiString;
 {-}
begin
 Result := 'cbForms';
end;//Tkw_CustomizeTasksPanel_Control_cbForms.GetString

class procedure Tkw_CustomizeTasksPanel_Control_cbForms.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TComboBox);
end;//Tkw_CustomizeTasksPanel_Control_cbForms.RegisterInEngine

type
  Tkw_CustomizeTasksPanel_Control_cbForms_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� cbForms
----
*������ �������������*:
[code]
�������::cbForms:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_CustomizeTasksPanel_Control_cbForms_Push

// start class Tkw_CustomizeTasksPanel_Control_cbForms_Push

procedure Tkw_CustomizeTasksPanel_Control_cbForms_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('cbForms');
 inherited;
end;//Tkw_CustomizeTasksPanel_Control_cbForms_Push.DoDoIt

class function Tkw_CustomizeTasksPanel_Control_cbForms_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::cbForms:push';
end;//Tkw_CustomizeTasksPanel_Control_cbForms_Push.GetWordNameForRegister

type
  Tkw_CustomizeTasksPanel_Control_pnlMain = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� pnlMain
----
*������ �������������*:
[code]
�������::pnlMain TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_CustomizeTasksPanel_Control_pnlMain

// start class Tkw_CustomizeTasksPanel_Control_pnlMain

class function Tkw_CustomizeTasksPanel_Control_pnlMain.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::pnlMain';
end;//Tkw_CustomizeTasksPanel_Control_pnlMain.GetWordNameForRegister

function Tkw_CustomizeTasksPanel_Control_pnlMain.GetString: AnsiString;
 {-}
begin
 Result := 'pnlMain';
end;//Tkw_CustomizeTasksPanel_Control_pnlMain.GetString

class procedure Tkw_CustomizeTasksPanel_Control_pnlMain.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_CustomizeTasksPanel_Control_pnlMain.RegisterInEngine

type
  Tkw_CustomizeTasksPanel_Control_pnlMain_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� pnlMain
----
*������ �������������*:
[code]
�������::pnlMain:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_CustomizeTasksPanel_Control_pnlMain_Push

// start class Tkw_CustomizeTasksPanel_Control_pnlMain_Push

procedure Tkw_CustomizeTasksPanel_Control_pnlMain_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('pnlMain');
 inherited;
end;//Tkw_CustomizeTasksPanel_Control_pnlMain_Push.DoDoIt

class function Tkw_CustomizeTasksPanel_Control_pnlMain_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::pnlMain:push';
end;//Tkw_CustomizeTasksPanel_Control_pnlMain_Push.GetWordNameForRegister

type
  Tkw_CustomizeTasksPanel_Control_pnlLeft = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� pnlLeft
----
*������ �������������*:
[code]
�������::pnlLeft TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_CustomizeTasksPanel_Control_pnlLeft

// start class Tkw_CustomizeTasksPanel_Control_pnlLeft

class function Tkw_CustomizeTasksPanel_Control_pnlLeft.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::pnlLeft';
end;//Tkw_CustomizeTasksPanel_Control_pnlLeft.GetWordNameForRegister

function Tkw_CustomizeTasksPanel_Control_pnlLeft.GetString: AnsiString;
 {-}
begin
 Result := 'pnlLeft';
end;//Tkw_CustomizeTasksPanel_Control_pnlLeft.GetString

class procedure Tkw_CustomizeTasksPanel_Control_pnlLeft.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_CustomizeTasksPanel_Control_pnlLeft.RegisterInEngine

type
  Tkw_CustomizeTasksPanel_Control_pnlLeft_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� pnlLeft
----
*������ �������������*:
[code]
�������::pnlLeft:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_CustomizeTasksPanel_Control_pnlLeft_Push

// start class Tkw_CustomizeTasksPanel_Control_pnlLeft_Push

procedure Tkw_CustomizeTasksPanel_Control_pnlLeft_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('pnlLeft');
 inherited;
end;//Tkw_CustomizeTasksPanel_Control_pnlLeft_Push.DoDoIt

class function Tkw_CustomizeTasksPanel_Control_pnlLeft_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::pnlLeft:push';
end;//Tkw_CustomizeTasksPanel_Control_pnlLeft_Push.GetWordNameForRegister

type
  Tkw_CustomizeTasksPanel_Control_btnMoveOpToPanel = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� btnMoveOpToPanel
----
*������ �������������*:
[code]
�������::btnMoveOpToPanel TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_CustomizeTasksPanel_Control_btnMoveOpToPanel

// start class Tkw_CustomizeTasksPanel_Control_btnMoveOpToPanel

class function Tkw_CustomizeTasksPanel_Control_btnMoveOpToPanel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::btnMoveOpToPanel';
end;//Tkw_CustomizeTasksPanel_Control_btnMoveOpToPanel.GetWordNameForRegister

function Tkw_CustomizeTasksPanel_Control_btnMoveOpToPanel.GetString: AnsiString;
 {-}
begin
 Result := 'btnMoveOpToPanel';
end;//Tkw_CustomizeTasksPanel_Control_btnMoveOpToPanel.GetString

class procedure Tkw_CustomizeTasksPanel_Control_btnMoveOpToPanel.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TBitBtn);
end;//Tkw_CustomizeTasksPanel_Control_btnMoveOpToPanel.RegisterInEngine

type
  Tkw_CustomizeTasksPanel_Control_btnMoveOpToPanel_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� btnMoveOpToPanel
----
*������ �������������*:
[code]
�������::btnMoveOpToPanel:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_CustomizeTasksPanel_Control_btnMoveOpToPanel_Push

// start class Tkw_CustomizeTasksPanel_Control_btnMoveOpToPanel_Push

procedure Tkw_CustomizeTasksPanel_Control_btnMoveOpToPanel_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('btnMoveOpToPanel');
 inherited;
end;//Tkw_CustomizeTasksPanel_Control_btnMoveOpToPanel_Push.DoDoIt

class function Tkw_CustomizeTasksPanel_Control_btnMoveOpToPanel_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::btnMoveOpToPanel:push';
end;//Tkw_CustomizeTasksPanel_Control_btnMoveOpToPanel_Push.GetWordNameForRegister

type
  Tkw_CustomizeTasksPanel_Control_btnMoveOpToRep = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� btnMoveOpToRep
----
*������ �������������*:
[code]
�������::btnMoveOpToRep TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_CustomizeTasksPanel_Control_btnMoveOpToRep

// start class Tkw_CustomizeTasksPanel_Control_btnMoveOpToRep

class function Tkw_CustomizeTasksPanel_Control_btnMoveOpToRep.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::btnMoveOpToRep';
end;//Tkw_CustomizeTasksPanel_Control_btnMoveOpToRep.GetWordNameForRegister

function Tkw_CustomizeTasksPanel_Control_btnMoveOpToRep.GetString: AnsiString;
 {-}
begin
 Result := 'btnMoveOpToRep';
end;//Tkw_CustomizeTasksPanel_Control_btnMoveOpToRep.GetString

class procedure Tkw_CustomizeTasksPanel_Control_btnMoveOpToRep.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TBitBtn);
end;//Tkw_CustomizeTasksPanel_Control_btnMoveOpToRep.RegisterInEngine

type
  Tkw_CustomizeTasksPanel_Control_btnMoveOpToRep_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� btnMoveOpToRep
----
*������ �������������*:
[code]
�������::btnMoveOpToRep:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_CustomizeTasksPanel_Control_btnMoveOpToRep_Push

// start class Tkw_CustomizeTasksPanel_Control_btnMoveOpToRep_Push

procedure Tkw_CustomizeTasksPanel_Control_btnMoveOpToRep_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('btnMoveOpToRep');
 inherited;
end;//Tkw_CustomizeTasksPanel_Control_btnMoveOpToRep_Push.DoDoIt

class function Tkw_CustomizeTasksPanel_Control_btnMoveOpToRep_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::btnMoveOpToRep:push';
end;//Tkw_CustomizeTasksPanel_Control_btnMoveOpToRep_Push.GetWordNameForRegister

type
  Tkw_CustomizeTasksPanel_Control_btnMoveGroupToPanel = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� btnMoveGroupToPanel
----
*������ �������������*:
[code]
�������::btnMoveGroupToPanel TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_CustomizeTasksPanel_Control_btnMoveGroupToPanel

// start class Tkw_CustomizeTasksPanel_Control_btnMoveGroupToPanel

class function Tkw_CustomizeTasksPanel_Control_btnMoveGroupToPanel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::btnMoveGroupToPanel';
end;//Tkw_CustomizeTasksPanel_Control_btnMoveGroupToPanel.GetWordNameForRegister

function Tkw_CustomizeTasksPanel_Control_btnMoveGroupToPanel.GetString: AnsiString;
 {-}
begin
 Result := 'btnMoveGroupToPanel';
end;//Tkw_CustomizeTasksPanel_Control_btnMoveGroupToPanel.GetString

class procedure Tkw_CustomizeTasksPanel_Control_btnMoveGroupToPanel.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TBitBtn);
end;//Tkw_CustomizeTasksPanel_Control_btnMoveGroupToPanel.RegisterInEngine

type
  Tkw_CustomizeTasksPanel_Control_btnMoveGroupToPanel_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� btnMoveGroupToPanel
----
*������ �������������*:
[code]
�������::btnMoveGroupToPanel:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_CustomizeTasksPanel_Control_btnMoveGroupToPanel_Push

// start class Tkw_CustomizeTasksPanel_Control_btnMoveGroupToPanel_Push

procedure Tkw_CustomizeTasksPanel_Control_btnMoveGroupToPanel_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('btnMoveGroupToPanel');
 inherited;
end;//Tkw_CustomizeTasksPanel_Control_btnMoveGroupToPanel_Push.DoDoIt

class function Tkw_CustomizeTasksPanel_Control_btnMoveGroupToPanel_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::btnMoveGroupToPanel:push';
end;//Tkw_CustomizeTasksPanel_Control_btnMoveGroupToPanel_Push.GetWordNameForRegister

type
  Tkw_CustomizeTasksPanel_Control_btnMoveGroupToRep = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� btnMoveGroupToRep
----
*������ �������������*:
[code]
�������::btnMoveGroupToRep TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_CustomizeTasksPanel_Control_btnMoveGroupToRep

// start class Tkw_CustomizeTasksPanel_Control_btnMoveGroupToRep

class function Tkw_CustomizeTasksPanel_Control_btnMoveGroupToRep.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::btnMoveGroupToRep';
end;//Tkw_CustomizeTasksPanel_Control_btnMoveGroupToRep.GetWordNameForRegister

function Tkw_CustomizeTasksPanel_Control_btnMoveGroupToRep.GetString: AnsiString;
 {-}
begin
 Result := 'btnMoveGroupToRep';
end;//Tkw_CustomizeTasksPanel_Control_btnMoveGroupToRep.GetString

class procedure Tkw_CustomizeTasksPanel_Control_btnMoveGroupToRep.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TBitBtn);
end;//Tkw_CustomizeTasksPanel_Control_btnMoveGroupToRep.RegisterInEngine

type
  Tkw_CustomizeTasksPanel_Control_btnMoveGroupToRep_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� btnMoveGroupToRep
----
*������ �������������*:
[code]
�������::btnMoveGroupToRep:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_CustomizeTasksPanel_Control_btnMoveGroupToRep_Push

// start class Tkw_CustomizeTasksPanel_Control_btnMoveGroupToRep_Push

procedure Tkw_CustomizeTasksPanel_Control_btnMoveGroupToRep_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('btnMoveGroupToRep');
 inherited;
end;//Tkw_CustomizeTasksPanel_Control_btnMoveGroupToRep_Push.DoDoIt

class function Tkw_CustomizeTasksPanel_Control_btnMoveGroupToRep_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::btnMoveGroupToRep:push';
end;//Tkw_CustomizeTasksPanel_Control_btnMoveGroupToRep_Push.GetWordNameForRegister

type
  Tkw_CustomizeTasksPanel_Control_pnlTasksPanel = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� pnlTasksPanel
----
*������ �������������*:
[code]
�������::pnlTasksPanel TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_CustomizeTasksPanel_Control_pnlTasksPanel

// start class Tkw_CustomizeTasksPanel_Control_pnlTasksPanel

class function Tkw_CustomizeTasksPanel_Control_pnlTasksPanel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::pnlTasksPanel';
end;//Tkw_CustomizeTasksPanel_Control_pnlTasksPanel.GetWordNameForRegister

function Tkw_CustomizeTasksPanel_Control_pnlTasksPanel.GetString: AnsiString;
 {-}
begin
 Result := 'pnlTasksPanel';
end;//Tkw_CustomizeTasksPanel_Control_pnlTasksPanel.GetString

class procedure Tkw_CustomizeTasksPanel_Control_pnlTasksPanel.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_CustomizeTasksPanel_Control_pnlTasksPanel.RegisterInEngine

type
  Tkw_CustomizeTasksPanel_Control_pnlTasksPanel_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� pnlTasksPanel
----
*������ �������������*:
[code]
�������::pnlTasksPanel:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_CustomizeTasksPanel_Control_pnlTasksPanel_Push

// start class Tkw_CustomizeTasksPanel_Control_pnlTasksPanel_Push

procedure Tkw_CustomizeTasksPanel_Control_pnlTasksPanel_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('pnlTasksPanel');
 inherited;
end;//Tkw_CustomizeTasksPanel_Control_pnlTasksPanel_Push.DoDoIt

class function Tkw_CustomizeTasksPanel_Control_pnlTasksPanel_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::pnlTasksPanel:push';
end;//Tkw_CustomizeTasksPanel_Control_pnlTasksPanel_Push.GetWordNameForRegister

type
  Tkw_CustomizeTasksPanel_Control_gbTasksPanel = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� gbTasksPanel
----
*������ �������������*:
[code]
�������::gbTasksPanel TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_CustomizeTasksPanel_Control_gbTasksPanel

// start class Tkw_CustomizeTasksPanel_Control_gbTasksPanel

class function Tkw_CustomizeTasksPanel_Control_gbTasksPanel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::gbTasksPanel';
end;//Tkw_CustomizeTasksPanel_Control_gbTasksPanel.GetWordNameForRegister

function Tkw_CustomizeTasksPanel_Control_gbTasksPanel.GetString: AnsiString;
 {-}
begin
 Result := 'gbTasksPanel';
end;//Tkw_CustomizeTasksPanel_Control_gbTasksPanel.GetString

class procedure Tkw_CustomizeTasksPanel_Control_gbTasksPanel.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtGroupBox);
end;//Tkw_CustomizeTasksPanel_Control_gbTasksPanel.RegisterInEngine

type
  Tkw_CustomizeTasksPanel_Control_gbTasksPanel_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� gbTasksPanel
----
*������ �������������*:
[code]
�������::gbTasksPanel:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_CustomizeTasksPanel_Control_gbTasksPanel_Push

// start class Tkw_CustomizeTasksPanel_Control_gbTasksPanel_Push

procedure Tkw_CustomizeTasksPanel_Control_gbTasksPanel_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('gbTasksPanel');
 inherited;
end;//Tkw_CustomizeTasksPanel_Control_gbTasksPanel_Push.DoDoIt

class function Tkw_CustomizeTasksPanel_Control_gbTasksPanel_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::gbTasksPanel:push';
end;//Tkw_CustomizeTasksPanel_Control_gbTasksPanel_Push.GetWordNameForRegister

type
  Tkw_CustomizeTasksPanel_Control_tvTasksPanel = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� tvTasksPanel
----
*������ �������������*:
[code]
�������::tvTasksPanel TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_CustomizeTasksPanel_Control_tvTasksPanel

// start class Tkw_CustomizeTasksPanel_Control_tvTasksPanel

class function Tkw_CustomizeTasksPanel_Control_tvTasksPanel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::tvTasksPanel';
end;//Tkw_CustomizeTasksPanel_Control_tvTasksPanel.GetWordNameForRegister

function Tkw_CustomizeTasksPanel_Control_tvTasksPanel.GetString: AnsiString;
 {-}
begin
 Result := 'tvTasksPanel';
end;//Tkw_CustomizeTasksPanel_Control_tvTasksPanel.GetString

class procedure Tkw_CustomizeTasksPanel_Control_tvTasksPanel.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TeeTreeView);
end;//Tkw_CustomizeTasksPanel_Control_tvTasksPanel.RegisterInEngine

type
  Tkw_CustomizeTasksPanel_Control_tvTasksPanel_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� tvTasksPanel
----
*������ �������������*:
[code]
�������::tvTasksPanel:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_CustomizeTasksPanel_Control_tvTasksPanel_Push

// start class Tkw_CustomizeTasksPanel_Control_tvTasksPanel_Push

procedure Tkw_CustomizeTasksPanel_Control_tvTasksPanel_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('tvTasksPanel');
 inherited;
end;//Tkw_CustomizeTasksPanel_Control_tvTasksPanel_Push.DoDoIt

class function Tkw_CustomizeTasksPanel_Control_tvTasksPanel_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::tvTasksPanel:push';
end;//Tkw_CustomizeTasksPanel_Control_tvTasksPanel_Push.GetWordNameForRegister

type
  Tkw_CustomizeTasksPanel_Control_vtGroupBox3 = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� vtGroupBox3
----
*������ �������������*:
[code]
�������::vtGroupBox3 TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_CustomizeTasksPanel_Control_vtGroupBox3

// start class Tkw_CustomizeTasksPanel_Control_vtGroupBox3

class function Tkw_CustomizeTasksPanel_Control_vtGroupBox3.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::vtGroupBox3';
end;//Tkw_CustomizeTasksPanel_Control_vtGroupBox3.GetWordNameForRegister

function Tkw_CustomizeTasksPanel_Control_vtGroupBox3.GetString: AnsiString;
 {-}
begin
 Result := 'vtGroupBox3';
end;//Tkw_CustomizeTasksPanel_Control_vtGroupBox3.GetString

class procedure Tkw_CustomizeTasksPanel_Control_vtGroupBox3.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtGroupBox);
end;//Tkw_CustomizeTasksPanel_Control_vtGroupBox3.RegisterInEngine

type
  Tkw_CustomizeTasksPanel_Control_vtGroupBox3_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� vtGroupBox3
----
*������ �������������*:
[code]
�������::vtGroupBox3:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_CustomizeTasksPanel_Control_vtGroupBox3_Push

// start class Tkw_CustomizeTasksPanel_Control_vtGroupBox3_Push

procedure Tkw_CustomizeTasksPanel_Control_vtGroupBox3_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('vtGroupBox3');
 inherited;
end;//Tkw_CustomizeTasksPanel_Control_vtGroupBox3_Push.DoDoIt

class function Tkw_CustomizeTasksPanel_Control_vtGroupBox3_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::vtGroupBox3:push';
end;//Tkw_CustomizeTasksPanel_Control_vtGroupBox3_Push.GetWordNameForRegister

type
  Tkw_CustomizeTasksPanel_Control_lblCaption = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� lblCaption
----
*������ �������������*:
[code]
�������::lblCaption TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_CustomizeTasksPanel_Control_lblCaption

// start class Tkw_CustomizeTasksPanel_Control_lblCaption

class function Tkw_CustomizeTasksPanel_Control_lblCaption.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::lblCaption';
end;//Tkw_CustomizeTasksPanel_Control_lblCaption.GetWordNameForRegister

function Tkw_CustomizeTasksPanel_Control_lblCaption.GetString: AnsiString;
 {-}
begin
 Result := 'lblCaption';
end;//Tkw_CustomizeTasksPanel_Control_lblCaption.GetString

class procedure Tkw_CustomizeTasksPanel_Control_lblCaption.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_CustomizeTasksPanel_Control_lblCaption.RegisterInEngine

type
  Tkw_CustomizeTasksPanel_Control_lblCaption_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� lblCaption
----
*������ �������������*:
[code]
�������::lblCaption:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_CustomizeTasksPanel_Control_lblCaption_Push

// start class Tkw_CustomizeTasksPanel_Control_lblCaption_Push

procedure Tkw_CustomizeTasksPanel_Control_lblCaption_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('lblCaption');
 inherited;
end;//Tkw_CustomizeTasksPanel_Control_lblCaption_Push.DoDoIt

class function Tkw_CustomizeTasksPanel_Control_lblCaption_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::lblCaption:push';
end;//Tkw_CustomizeTasksPanel_Control_lblCaption_Push.GetWordNameForRegister

type
  Tkw_CustomizeTasksPanel_Control_edChange = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� edChange
----
*������ �������������*:
[code]
�������::edChange TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_CustomizeTasksPanel_Control_edChange

// start class Tkw_CustomizeTasksPanel_Control_edChange

class function Tkw_CustomizeTasksPanel_Control_edChange.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::edChange';
end;//Tkw_CustomizeTasksPanel_Control_edChange.GetWordNameForRegister

function Tkw_CustomizeTasksPanel_Control_edChange.GetString: AnsiString;
 {-}
begin
 Result := 'edChange';
end;//Tkw_CustomizeTasksPanel_Control_edChange.GetString

class procedure Tkw_CustomizeTasksPanel_Control_edChange.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtComboBox);
end;//Tkw_CustomizeTasksPanel_Control_edChange.RegisterInEngine

type
  Tkw_CustomizeTasksPanel_Control_edChange_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� edChange
----
*������ �������������*:
[code]
�������::edChange:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_CustomizeTasksPanel_Control_edChange_Push

// start class Tkw_CustomizeTasksPanel_Control_edChange_Push

procedure Tkw_CustomizeTasksPanel_Control_edChange_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('edChange');
 inherited;
end;//Tkw_CustomizeTasksPanel_Control_edChange_Push.DoDoIt

class function Tkw_CustomizeTasksPanel_Control_edChange_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::edChange:push';
end;//Tkw_CustomizeTasksPanel_Control_edChange_Push.GetWordNameForRegister

type
  Tkw_CustomizeTasksPanel_Control_cbForAllUseCases = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� cbForAllUseCases
----
*������ �������������*:
[code]
�������::cbForAllUseCases TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_CustomizeTasksPanel_Control_cbForAllUseCases

// start class Tkw_CustomizeTasksPanel_Control_cbForAllUseCases

class function Tkw_CustomizeTasksPanel_Control_cbForAllUseCases.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::cbForAllUseCases';
end;//Tkw_CustomizeTasksPanel_Control_cbForAllUseCases.GetWordNameForRegister

function Tkw_CustomizeTasksPanel_Control_cbForAllUseCases.GetString: AnsiString;
 {-}
begin
 Result := 'cbForAllUseCases';
end;//Tkw_CustomizeTasksPanel_Control_cbForAllUseCases.GetString

class procedure Tkw_CustomizeTasksPanel_Control_cbForAllUseCases.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TeeCheckBox);
end;//Tkw_CustomizeTasksPanel_Control_cbForAllUseCases.RegisterInEngine

type
  Tkw_CustomizeTasksPanel_Control_cbForAllUseCases_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� cbForAllUseCases
----
*������ �������������*:
[code]
�������::cbForAllUseCases:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_CustomizeTasksPanel_Control_cbForAllUseCases_Push

// start class Tkw_CustomizeTasksPanel_Control_cbForAllUseCases_Push

procedure Tkw_CustomizeTasksPanel_Control_cbForAllUseCases_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('cbForAllUseCases');
 inherited;
end;//Tkw_CustomizeTasksPanel_Control_cbForAllUseCases_Push.DoDoIt

class function Tkw_CustomizeTasksPanel_Control_cbForAllUseCases_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::cbForAllUseCases:push';
end;//Tkw_CustomizeTasksPanel_Control_cbForAllUseCases_Push.GetWordNameForRegister

type
  Tkw_CustomizeTasksPanel_Control_btnChangeItem = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� btnChangeItem
----
*������ �������������*:
[code]
�������::btnChangeItem TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_CustomizeTasksPanel_Control_btnChangeItem

// start class Tkw_CustomizeTasksPanel_Control_btnChangeItem

class function Tkw_CustomizeTasksPanel_Control_btnChangeItem.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::btnChangeItem';
end;//Tkw_CustomizeTasksPanel_Control_btnChangeItem.GetWordNameForRegister

function Tkw_CustomizeTasksPanel_Control_btnChangeItem.GetString: AnsiString;
 {-}
begin
 Result := 'btnChangeItem';
end;//Tkw_CustomizeTasksPanel_Control_btnChangeItem.GetString

class procedure Tkw_CustomizeTasksPanel_Control_btnChangeItem.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TeeButton);
end;//Tkw_CustomizeTasksPanel_Control_btnChangeItem.RegisterInEngine

type
  Tkw_CustomizeTasksPanel_Control_btnChangeItem_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� btnChangeItem
----
*������ �������������*:
[code]
�������::btnChangeItem:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_CustomizeTasksPanel_Control_btnChangeItem_Push

// start class Tkw_CustomizeTasksPanel_Control_btnChangeItem_Push

procedure Tkw_CustomizeTasksPanel_Control_btnChangeItem_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('btnChangeItem');
 inherited;
end;//Tkw_CustomizeTasksPanel_Control_btnChangeItem_Push.DoDoIt

class function Tkw_CustomizeTasksPanel_Control_btnChangeItem_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::btnChangeItem:push';
end;//Tkw_CustomizeTasksPanel_Control_btnChangeItem_Push.GetWordNameForRegister

type
  Tkw_CustomizeTasksPanel_Control_pnlOperationPos = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� pnlOperationPos
----
*������ �������������*:
[code]
�������::pnlOperationPos TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_CustomizeTasksPanel_Control_pnlOperationPos

// start class Tkw_CustomizeTasksPanel_Control_pnlOperationPos

class function Tkw_CustomizeTasksPanel_Control_pnlOperationPos.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::pnlOperationPos';
end;//Tkw_CustomizeTasksPanel_Control_pnlOperationPos.GetWordNameForRegister

function Tkw_CustomizeTasksPanel_Control_pnlOperationPos.GetString: AnsiString;
 {-}
begin
 Result := 'pnlOperationPos';
end;//Tkw_CustomizeTasksPanel_Control_pnlOperationPos.GetString

class procedure Tkw_CustomizeTasksPanel_Control_pnlOperationPos.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_CustomizeTasksPanel_Control_pnlOperationPos.RegisterInEngine

type
  Tkw_CustomizeTasksPanel_Control_pnlOperationPos_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� pnlOperationPos
----
*������ �������������*:
[code]
�������::pnlOperationPos:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_CustomizeTasksPanel_Control_pnlOperationPos_Push

// start class Tkw_CustomizeTasksPanel_Control_pnlOperationPos_Push

procedure Tkw_CustomizeTasksPanel_Control_pnlOperationPos_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('pnlOperationPos');
 inherited;
end;//Tkw_CustomizeTasksPanel_Control_pnlOperationPos_Push.DoDoIt

class function Tkw_CustomizeTasksPanel_Control_pnlOperationPos_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::pnlOperationPos:push';
end;//Tkw_CustomizeTasksPanel_Control_pnlOperationPos_Push.GetWordNameForRegister

type
  Tkw_CustomizeTasksPanel_Control_UpBitBtn = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� UpBitBtn
----
*������ �������������*:
[code]
�������::UpBitBtn TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_CustomizeTasksPanel_Control_UpBitBtn

// start class Tkw_CustomizeTasksPanel_Control_UpBitBtn

class function Tkw_CustomizeTasksPanel_Control_UpBitBtn.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::UpBitBtn';
end;//Tkw_CustomizeTasksPanel_Control_UpBitBtn.GetWordNameForRegister

function Tkw_CustomizeTasksPanel_Control_UpBitBtn.GetString: AnsiString;
 {-}
begin
 Result := 'UpBitBtn';
end;//Tkw_CustomizeTasksPanel_Control_UpBitBtn.GetString

class procedure Tkw_CustomizeTasksPanel_Control_UpBitBtn.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TBitBtn);
end;//Tkw_CustomizeTasksPanel_Control_UpBitBtn.RegisterInEngine

type
  Tkw_CustomizeTasksPanel_Control_UpBitBtn_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� UpBitBtn
----
*������ �������������*:
[code]
�������::UpBitBtn:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_CustomizeTasksPanel_Control_UpBitBtn_Push

// start class Tkw_CustomizeTasksPanel_Control_UpBitBtn_Push

procedure Tkw_CustomizeTasksPanel_Control_UpBitBtn_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('UpBitBtn');
 inherited;
end;//Tkw_CustomizeTasksPanel_Control_UpBitBtn_Push.DoDoIt

class function Tkw_CustomizeTasksPanel_Control_UpBitBtn_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::UpBitBtn:push';
end;//Tkw_CustomizeTasksPanel_Control_UpBitBtn_Push.GetWordNameForRegister

type
  Tkw_CustomizeTasksPanel_Control_DownBitBtn = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� DownBitBtn
----
*������ �������������*:
[code]
�������::DownBitBtn TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_CustomizeTasksPanel_Control_DownBitBtn

// start class Tkw_CustomizeTasksPanel_Control_DownBitBtn

class function Tkw_CustomizeTasksPanel_Control_DownBitBtn.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::DownBitBtn';
end;//Tkw_CustomizeTasksPanel_Control_DownBitBtn.GetWordNameForRegister

function Tkw_CustomizeTasksPanel_Control_DownBitBtn.GetString: AnsiString;
 {-}
begin
 Result := 'DownBitBtn';
end;//Tkw_CustomizeTasksPanel_Control_DownBitBtn.GetString

class procedure Tkw_CustomizeTasksPanel_Control_DownBitBtn.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TBitBtn);
end;//Tkw_CustomizeTasksPanel_Control_DownBitBtn.RegisterInEngine

type
  Tkw_CustomizeTasksPanel_Control_DownBitBtn_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� DownBitBtn
----
*������ �������������*:
[code]
�������::DownBitBtn:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_CustomizeTasksPanel_Control_DownBitBtn_Push

// start class Tkw_CustomizeTasksPanel_Control_DownBitBtn_Push

procedure Tkw_CustomizeTasksPanel_Control_DownBitBtn_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('DownBitBtn');
 inherited;
end;//Tkw_CustomizeTasksPanel_Control_DownBitBtn_Push.DoDoIt

class function Tkw_CustomizeTasksPanel_Control_DownBitBtn_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::DownBitBtn:push';
end;//Tkw_CustomizeTasksPanel_Control_DownBitBtn_Push.GetWordNameForRegister

type
  TkwCustomizeTasksPanelFormSpRight = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .TCustomizeTasksPanelForm.spRight
[panel]������� spRight ����� TCustomizeTasksPanelForm[panel]
*��� ����������:* TvtSplitter
*������:*
[code]
OBJECT VAR l_TvtSplitter
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.spRight >>> l_TvtSplitter
[code]  }
  private
  // private methods
   function SpRight(const aCtx: TtfwContext;
     aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtSplitter;
     {* ���������� ����� ������� .TCustomizeTasksPanelForm.spRight }
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
  end;//TkwCustomizeTasksPanelFormSpRight

// start class TkwCustomizeTasksPanelFormSpRight

function TkwCustomizeTasksPanelFormSpRight.SpRight(const aCtx: TtfwContext;
  aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtSplitter;
 {-}
begin
 Result := aCustomizeTasksPanelForm.spRight;
end;//TkwCustomizeTasksPanelFormSpRight.SpRight

procedure TkwCustomizeTasksPanelFormSpRight.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aCustomizeTasksPanelForm : TCustomizeTasksPanelForm;
begin
 try
  l_aCustomizeTasksPanelForm := TCustomizeTasksPanelForm(aCtx.rEngine.PopObjAs(TCustomizeTasksPanelForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aCustomizeTasksPanelForm: TCustomizeTasksPanelForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((SpRight(aCtx, l_aCustomizeTasksPanelForm)));
end;//TkwCustomizeTasksPanelFormSpRight.DoDoIt

class function TkwCustomizeTasksPanelFormSpRight.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TCustomizeTasksPanelForm.spRight';
end;//TkwCustomizeTasksPanelFormSpRight.GetWordNameForRegister

procedure TkwCustomizeTasksPanelFormSpRight.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� spRight', aCtx);
end;//TkwCustomizeTasksPanelFormSpRight.SetValuePrim

function TkwCustomizeTasksPanelFormSpRight.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtSplitter);
end;//TkwCustomizeTasksPanelFormSpRight.GetResultTypeInfo

function TkwCustomizeTasksPanelFormSpRight.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwCustomizeTasksPanelFormSpRight.GetAllParamsCount

function TkwCustomizeTasksPanelFormSpRight.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TCustomizeTasksPanelForm)]);
end;//TkwCustomizeTasksPanelFormSpRight.ParamsTypes

type
  TkwCustomizeTasksPanelFormPnlBottom = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .TCustomizeTasksPanelForm.pnlBottom
[panel]������� pnlBottom ����� TCustomizeTasksPanelForm[panel]
*��� ����������:* TvtPanel
*������:*
[code]
OBJECT VAR l_TvtPanel
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.pnlBottom >>> l_TvtPanel
[code]  }
  private
  // private methods
   function PnlBottom(const aCtx: TtfwContext;
     aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtPanel;
     {* ���������� ����� ������� .TCustomizeTasksPanelForm.pnlBottom }
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
  end;//TkwCustomizeTasksPanelFormPnlBottom

// start class TkwCustomizeTasksPanelFormPnlBottom

function TkwCustomizeTasksPanelFormPnlBottom.PnlBottom(const aCtx: TtfwContext;
  aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtPanel;
 {-}
begin
 Result := aCustomizeTasksPanelForm.pnlBottom;
end;//TkwCustomizeTasksPanelFormPnlBottom.PnlBottom

procedure TkwCustomizeTasksPanelFormPnlBottom.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aCustomizeTasksPanelForm : TCustomizeTasksPanelForm;
begin
 try
  l_aCustomizeTasksPanelForm := TCustomizeTasksPanelForm(aCtx.rEngine.PopObjAs(TCustomizeTasksPanelForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aCustomizeTasksPanelForm: TCustomizeTasksPanelForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((PnlBottom(aCtx, l_aCustomizeTasksPanelForm)));
end;//TkwCustomizeTasksPanelFormPnlBottom.DoDoIt

class function TkwCustomizeTasksPanelFormPnlBottom.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TCustomizeTasksPanelForm.pnlBottom';
end;//TkwCustomizeTasksPanelFormPnlBottom.GetWordNameForRegister

procedure TkwCustomizeTasksPanelFormPnlBottom.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� pnlBottom', aCtx);
end;//TkwCustomizeTasksPanelFormPnlBottom.SetValuePrim

function TkwCustomizeTasksPanelFormPnlBottom.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtPanel);
end;//TkwCustomizeTasksPanelFormPnlBottom.GetResultTypeInfo

function TkwCustomizeTasksPanelFormPnlBottom.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwCustomizeTasksPanelFormPnlBottom.GetAllParamsCount

function TkwCustomizeTasksPanelFormPnlBottom.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TCustomizeTasksPanelForm)]);
end;//TkwCustomizeTasksPanelFormPnlBottom.ParamsTypes

type
  TkwCustomizeTasksPanelFormLblConfirmSave = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .TCustomizeTasksPanelForm.lblConfirmSave
[panel]������� lblConfirmSave ����� TCustomizeTasksPanelForm[panel]
*��� ����������:* TvtLabel
*������:*
[code]
OBJECT VAR l_TvtLabel
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.lblConfirmSave >>> l_TvtLabel
[code]  }
  private
  // private methods
   function LblConfirmSave(const aCtx: TtfwContext;
     aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtLabel;
     {* ���������� ����� ������� .TCustomizeTasksPanelForm.lblConfirmSave }
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
  end;//TkwCustomizeTasksPanelFormLblConfirmSave

// start class TkwCustomizeTasksPanelFormLblConfirmSave

function TkwCustomizeTasksPanelFormLblConfirmSave.LblConfirmSave(const aCtx: TtfwContext;
  aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtLabel;
 {-}
begin
 Result := aCustomizeTasksPanelForm.lblConfirmSave;
end;//TkwCustomizeTasksPanelFormLblConfirmSave.LblConfirmSave

procedure TkwCustomizeTasksPanelFormLblConfirmSave.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aCustomizeTasksPanelForm : TCustomizeTasksPanelForm;
begin
 try
  l_aCustomizeTasksPanelForm := TCustomizeTasksPanelForm(aCtx.rEngine.PopObjAs(TCustomizeTasksPanelForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aCustomizeTasksPanelForm: TCustomizeTasksPanelForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((LblConfirmSave(aCtx, l_aCustomizeTasksPanelForm)));
end;//TkwCustomizeTasksPanelFormLblConfirmSave.DoDoIt

class function TkwCustomizeTasksPanelFormLblConfirmSave.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TCustomizeTasksPanelForm.lblConfirmSave';
end;//TkwCustomizeTasksPanelFormLblConfirmSave.GetWordNameForRegister

procedure TkwCustomizeTasksPanelFormLblConfirmSave.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� lblConfirmSave', aCtx);
end;//TkwCustomizeTasksPanelFormLblConfirmSave.SetValuePrim

function TkwCustomizeTasksPanelFormLblConfirmSave.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtLabel);
end;//TkwCustomizeTasksPanelFormLblConfirmSave.GetResultTypeInfo

function TkwCustomizeTasksPanelFormLblConfirmSave.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwCustomizeTasksPanelFormLblConfirmSave.GetAllParamsCount

function TkwCustomizeTasksPanelFormLblConfirmSave.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TCustomizeTasksPanelForm)]);
end;//TkwCustomizeTasksPanelFormLblConfirmSave.ParamsTypes

type
  TkwCustomizeTasksPanelFormLblAvailableOpsCaption = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .TCustomizeTasksPanelForm.lblAvailableOpsCaption
[panel]������� lblAvailableOpsCaption ����� TCustomizeTasksPanelForm[panel]
*��� ����������:* TvtLabel
*������:*
[code]
OBJECT VAR l_TvtLabel
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.lblAvailableOpsCaption >>> l_TvtLabel
[code]  }
  private
  // private methods
   function LblAvailableOpsCaption(const aCtx: TtfwContext;
     aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtLabel;
     {* ���������� ����� ������� .TCustomizeTasksPanelForm.lblAvailableOpsCaption }
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
  end;//TkwCustomizeTasksPanelFormLblAvailableOpsCaption

// start class TkwCustomizeTasksPanelFormLblAvailableOpsCaption

function TkwCustomizeTasksPanelFormLblAvailableOpsCaption.LblAvailableOpsCaption(const aCtx: TtfwContext;
  aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtLabel;
 {-}
begin
 Result := aCustomizeTasksPanelForm.lblAvailableOpsCaption;
end;//TkwCustomizeTasksPanelFormLblAvailableOpsCaption.LblAvailableOpsCaption

procedure TkwCustomizeTasksPanelFormLblAvailableOpsCaption.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aCustomizeTasksPanelForm : TCustomizeTasksPanelForm;
begin
 try
  l_aCustomizeTasksPanelForm := TCustomizeTasksPanelForm(aCtx.rEngine.PopObjAs(TCustomizeTasksPanelForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aCustomizeTasksPanelForm: TCustomizeTasksPanelForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((LblAvailableOpsCaption(aCtx, l_aCustomizeTasksPanelForm)));
end;//TkwCustomizeTasksPanelFormLblAvailableOpsCaption.DoDoIt

class function TkwCustomizeTasksPanelFormLblAvailableOpsCaption.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TCustomizeTasksPanelForm.lblAvailableOpsCaption';
end;//TkwCustomizeTasksPanelFormLblAvailableOpsCaption.GetWordNameForRegister

procedure TkwCustomizeTasksPanelFormLblAvailableOpsCaption.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� lblAvailableOpsCaption', aCtx);
end;//TkwCustomizeTasksPanelFormLblAvailableOpsCaption.SetValuePrim

function TkwCustomizeTasksPanelFormLblAvailableOpsCaption.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtLabel);
end;//TkwCustomizeTasksPanelFormLblAvailableOpsCaption.GetResultTypeInfo

function TkwCustomizeTasksPanelFormLblAvailableOpsCaption.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwCustomizeTasksPanelFormLblAvailableOpsCaption.GetAllParamsCount

function TkwCustomizeTasksPanelFormLblAvailableOpsCaption.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TCustomizeTasksPanelForm)]);
end;//TkwCustomizeTasksPanelFormLblAvailableOpsCaption.ParamsTypes

type
  TkwCustomizeTasksPanelFormBtOk = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .TCustomizeTasksPanelForm.btOk
[panel]������� btOk ����� TCustomizeTasksPanelForm[panel]
*��� ����������:* TvtButton
*������:*
[code]
OBJECT VAR l_TvtButton
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.btOk >>> l_TvtButton
[code]  }
  private
  // private methods
   function BtOk(const aCtx: TtfwContext;
     aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtButton;
     {* ���������� ����� ������� .TCustomizeTasksPanelForm.btOk }
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
  end;//TkwCustomizeTasksPanelFormBtOk

// start class TkwCustomizeTasksPanelFormBtOk

function TkwCustomizeTasksPanelFormBtOk.BtOk(const aCtx: TtfwContext;
  aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtButton;
 {-}
begin
 Result := aCustomizeTasksPanelForm.btOk;
end;//TkwCustomizeTasksPanelFormBtOk.BtOk

procedure TkwCustomizeTasksPanelFormBtOk.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aCustomizeTasksPanelForm : TCustomizeTasksPanelForm;
begin
 try
  l_aCustomizeTasksPanelForm := TCustomizeTasksPanelForm(aCtx.rEngine.PopObjAs(TCustomizeTasksPanelForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aCustomizeTasksPanelForm: TCustomizeTasksPanelForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((BtOk(aCtx, l_aCustomizeTasksPanelForm)));
end;//TkwCustomizeTasksPanelFormBtOk.DoDoIt

class function TkwCustomizeTasksPanelFormBtOk.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TCustomizeTasksPanelForm.btOk';
end;//TkwCustomizeTasksPanelFormBtOk.GetWordNameForRegister

procedure TkwCustomizeTasksPanelFormBtOk.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� btOk', aCtx);
end;//TkwCustomizeTasksPanelFormBtOk.SetValuePrim

function TkwCustomizeTasksPanelFormBtOk.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtButton);
end;//TkwCustomizeTasksPanelFormBtOk.GetResultTypeInfo

function TkwCustomizeTasksPanelFormBtOk.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwCustomizeTasksPanelFormBtOk.GetAllParamsCount

function TkwCustomizeTasksPanelFormBtOk.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TCustomizeTasksPanelForm)]);
end;//TkwCustomizeTasksPanelFormBtOk.ParamsTypes

type
  TkwCustomizeTasksPanelFormBtCancel = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .TCustomizeTasksPanelForm.btCancel
[panel]������� btCancel ����� TCustomizeTasksPanelForm[panel]
*��� ����������:* TvtButton
*������:*
[code]
OBJECT VAR l_TvtButton
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.btCancel >>> l_TvtButton
[code]  }
  private
  // private methods
   function BtCancel(const aCtx: TtfwContext;
     aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtButton;
     {* ���������� ����� ������� .TCustomizeTasksPanelForm.btCancel }
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
  end;//TkwCustomizeTasksPanelFormBtCancel

// start class TkwCustomizeTasksPanelFormBtCancel

function TkwCustomizeTasksPanelFormBtCancel.BtCancel(const aCtx: TtfwContext;
  aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtButton;
 {-}
begin
 Result := aCustomizeTasksPanelForm.btCancel;
end;//TkwCustomizeTasksPanelFormBtCancel.BtCancel

procedure TkwCustomizeTasksPanelFormBtCancel.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aCustomizeTasksPanelForm : TCustomizeTasksPanelForm;
begin
 try
  l_aCustomizeTasksPanelForm := TCustomizeTasksPanelForm(aCtx.rEngine.PopObjAs(TCustomizeTasksPanelForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aCustomizeTasksPanelForm: TCustomizeTasksPanelForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((BtCancel(aCtx, l_aCustomizeTasksPanelForm)));
end;//TkwCustomizeTasksPanelFormBtCancel.DoDoIt

class function TkwCustomizeTasksPanelFormBtCancel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TCustomizeTasksPanelForm.btCancel';
end;//TkwCustomizeTasksPanelFormBtCancel.GetWordNameForRegister

procedure TkwCustomizeTasksPanelFormBtCancel.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� btCancel', aCtx);
end;//TkwCustomizeTasksPanelFormBtCancel.SetValuePrim

function TkwCustomizeTasksPanelFormBtCancel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtButton);
end;//TkwCustomizeTasksPanelFormBtCancel.GetResultTypeInfo

function TkwCustomizeTasksPanelFormBtCancel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwCustomizeTasksPanelFormBtCancel.GetAllParamsCount

function TkwCustomizeTasksPanelFormBtCancel.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TCustomizeTasksPanelForm)]);
end;//TkwCustomizeTasksPanelFormBtCancel.ParamsTypes

type
  TkwCustomizeTasksPanelFormBtApply = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .TCustomizeTasksPanelForm.btApply
[panel]������� btApply ����� TCustomizeTasksPanelForm[panel]
*��� ����������:* TvtButton
*������:*
[code]
OBJECT VAR l_TvtButton
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.btApply >>> l_TvtButton
[code]  }
  private
  // private methods
   function BtApply(const aCtx: TtfwContext;
     aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtButton;
     {* ���������� ����� ������� .TCustomizeTasksPanelForm.btApply }
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
  end;//TkwCustomizeTasksPanelFormBtApply

// start class TkwCustomizeTasksPanelFormBtApply

function TkwCustomizeTasksPanelFormBtApply.BtApply(const aCtx: TtfwContext;
  aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtButton;
 {-}
begin
 Result := aCustomizeTasksPanelForm.btApply;
end;//TkwCustomizeTasksPanelFormBtApply.BtApply

procedure TkwCustomizeTasksPanelFormBtApply.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aCustomizeTasksPanelForm : TCustomizeTasksPanelForm;
begin
 try
  l_aCustomizeTasksPanelForm := TCustomizeTasksPanelForm(aCtx.rEngine.PopObjAs(TCustomizeTasksPanelForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aCustomizeTasksPanelForm: TCustomizeTasksPanelForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((BtApply(aCtx, l_aCustomizeTasksPanelForm)));
end;//TkwCustomizeTasksPanelFormBtApply.DoDoIt

class function TkwCustomizeTasksPanelFormBtApply.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TCustomizeTasksPanelForm.btApply';
end;//TkwCustomizeTasksPanelFormBtApply.GetWordNameForRegister

procedure TkwCustomizeTasksPanelFormBtApply.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� btApply', aCtx);
end;//TkwCustomizeTasksPanelFormBtApply.SetValuePrim

function TkwCustomizeTasksPanelFormBtApply.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtButton);
end;//TkwCustomizeTasksPanelFormBtApply.GetResultTypeInfo

function TkwCustomizeTasksPanelFormBtApply.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwCustomizeTasksPanelFormBtApply.GetAllParamsCount

function TkwCustomizeTasksPanelFormBtApply.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TCustomizeTasksPanelForm)]);
end;//TkwCustomizeTasksPanelFormBtApply.ParamsTypes

type
  TkwCustomizeTasksPanelFormPnlRep = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .TCustomizeTasksPanelForm.pnlRep
[panel]������� pnlRep ����� TCustomizeTasksPanelForm[panel]
*��� ����������:* TvtPanel
*������:*
[code]
OBJECT VAR l_TvtPanel
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.pnlRep >>> l_TvtPanel
[code]  }
  private
  // private methods
   function PnlRep(const aCtx: TtfwContext;
     aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtPanel;
     {* ���������� ����� ������� .TCustomizeTasksPanelForm.pnlRep }
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
  end;//TkwCustomizeTasksPanelFormPnlRep

// start class TkwCustomizeTasksPanelFormPnlRep

function TkwCustomizeTasksPanelFormPnlRep.PnlRep(const aCtx: TtfwContext;
  aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtPanel;
 {-}
begin
 Result := aCustomizeTasksPanelForm.pnlRep;
end;//TkwCustomizeTasksPanelFormPnlRep.PnlRep

procedure TkwCustomizeTasksPanelFormPnlRep.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aCustomizeTasksPanelForm : TCustomizeTasksPanelForm;
begin
 try
  l_aCustomizeTasksPanelForm := TCustomizeTasksPanelForm(aCtx.rEngine.PopObjAs(TCustomizeTasksPanelForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aCustomizeTasksPanelForm: TCustomizeTasksPanelForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((PnlRep(aCtx, l_aCustomizeTasksPanelForm)));
end;//TkwCustomizeTasksPanelFormPnlRep.DoDoIt

class function TkwCustomizeTasksPanelFormPnlRep.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TCustomizeTasksPanelForm.pnlRep';
end;//TkwCustomizeTasksPanelFormPnlRep.GetWordNameForRegister

procedure TkwCustomizeTasksPanelFormPnlRep.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� pnlRep', aCtx);
end;//TkwCustomizeTasksPanelFormPnlRep.SetValuePrim

function TkwCustomizeTasksPanelFormPnlRep.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtPanel);
end;//TkwCustomizeTasksPanelFormPnlRep.GetResultTypeInfo

function TkwCustomizeTasksPanelFormPnlRep.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwCustomizeTasksPanelFormPnlRep.GetAllParamsCount

function TkwCustomizeTasksPanelFormPnlRep.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TCustomizeTasksPanelForm)]);
end;//TkwCustomizeTasksPanelFormPnlRep.ParamsTypes

type
  TkwCustomizeTasksPanelFormSplRep = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .TCustomizeTasksPanelForm.splRep
[panel]������� splRep ����� TCustomizeTasksPanelForm[panel]
*��� ����������:* TvtSplitter
*������:*
[code]
OBJECT VAR l_TvtSplitter
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.splRep >>> l_TvtSplitter
[code]  }
  private
  // private methods
   function SplRep(const aCtx: TtfwContext;
     aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtSplitter;
     {* ���������� ����� ������� .TCustomizeTasksPanelForm.splRep }
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
  end;//TkwCustomizeTasksPanelFormSplRep

// start class TkwCustomizeTasksPanelFormSplRep

function TkwCustomizeTasksPanelFormSplRep.SplRep(const aCtx: TtfwContext;
  aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtSplitter;
 {-}
begin
 Result := aCustomizeTasksPanelForm.splRep;
end;//TkwCustomizeTasksPanelFormSplRep.SplRep

procedure TkwCustomizeTasksPanelFormSplRep.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aCustomizeTasksPanelForm : TCustomizeTasksPanelForm;
begin
 try
  l_aCustomizeTasksPanelForm := TCustomizeTasksPanelForm(aCtx.rEngine.PopObjAs(TCustomizeTasksPanelForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aCustomizeTasksPanelForm: TCustomizeTasksPanelForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((SplRep(aCtx, l_aCustomizeTasksPanelForm)));
end;//TkwCustomizeTasksPanelFormSplRep.DoDoIt

class function TkwCustomizeTasksPanelFormSplRep.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TCustomizeTasksPanelForm.splRep';
end;//TkwCustomizeTasksPanelFormSplRep.GetWordNameForRegister

procedure TkwCustomizeTasksPanelFormSplRep.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� splRep', aCtx);
end;//TkwCustomizeTasksPanelFormSplRep.SetValuePrim

function TkwCustomizeTasksPanelFormSplRep.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtSplitter);
end;//TkwCustomizeTasksPanelFormSplRep.GetResultTypeInfo

function TkwCustomizeTasksPanelFormSplRep.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwCustomizeTasksPanelFormSplRep.GetAllParamsCount

function TkwCustomizeTasksPanelFormSplRep.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TCustomizeTasksPanelForm)]);
end;//TkwCustomizeTasksPanelFormSplRep.ParamsTypes

type
  TkwCustomizeTasksPanelFormGbAvailableGroups = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .TCustomizeTasksPanelForm.gbAvailableGroups
[panel]������� gbAvailableGroups ����� TCustomizeTasksPanelForm[panel]
*��� ����������:* TvtGroupBox
*������:*
[code]
OBJECT VAR l_TvtGroupBox
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.gbAvailableGroups >>> l_TvtGroupBox
[code]  }
  private
  // private methods
   function GbAvailableGroups(const aCtx: TtfwContext;
     aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtGroupBox;
     {* ���������� ����� ������� .TCustomizeTasksPanelForm.gbAvailableGroups }
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
  end;//TkwCustomizeTasksPanelFormGbAvailableGroups

// start class TkwCustomizeTasksPanelFormGbAvailableGroups

function TkwCustomizeTasksPanelFormGbAvailableGroups.GbAvailableGroups(const aCtx: TtfwContext;
  aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtGroupBox;
 {-}
begin
 Result := aCustomizeTasksPanelForm.gbAvailableGroups;
end;//TkwCustomizeTasksPanelFormGbAvailableGroups.GbAvailableGroups

procedure TkwCustomizeTasksPanelFormGbAvailableGroups.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aCustomizeTasksPanelForm : TCustomizeTasksPanelForm;
begin
 try
  l_aCustomizeTasksPanelForm := TCustomizeTasksPanelForm(aCtx.rEngine.PopObjAs(TCustomizeTasksPanelForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aCustomizeTasksPanelForm: TCustomizeTasksPanelForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((GbAvailableGroups(aCtx, l_aCustomizeTasksPanelForm)));
end;//TkwCustomizeTasksPanelFormGbAvailableGroups.DoDoIt

class function TkwCustomizeTasksPanelFormGbAvailableGroups.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TCustomizeTasksPanelForm.gbAvailableGroups';
end;//TkwCustomizeTasksPanelFormGbAvailableGroups.GetWordNameForRegister

procedure TkwCustomizeTasksPanelFormGbAvailableGroups.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� gbAvailableGroups', aCtx);
end;//TkwCustomizeTasksPanelFormGbAvailableGroups.SetValuePrim

function TkwCustomizeTasksPanelFormGbAvailableGroups.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtGroupBox);
end;//TkwCustomizeTasksPanelFormGbAvailableGroups.GetResultTypeInfo

function TkwCustomizeTasksPanelFormGbAvailableGroups.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwCustomizeTasksPanelFormGbAvailableGroups.GetAllParamsCount

function TkwCustomizeTasksPanelFormGbAvailableGroups.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TCustomizeTasksPanelForm)]);
end;//TkwCustomizeTasksPanelFormGbAvailableGroups.ParamsTypes

type
  TkwCustomizeTasksPanelFormTvRepGroups = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .TCustomizeTasksPanelForm.tvRepGroups
[panel]������� tvRepGroups ����� TCustomizeTasksPanelForm[panel]
*��� ����������:* TeeTreeView
*������:*
[code]
OBJECT VAR l_TeeTreeView
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.tvRepGroups >>> l_TeeTreeView
[code]  }
  private
  // private methods
   function TvRepGroups(const aCtx: TtfwContext;
     aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TeeTreeView;
     {* ���������� ����� ������� .TCustomizeTasksPanelForm.tvRepGroups }
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
  end;//TkwCustomizeTasksPanelFormTvRepGroups

// start class TkwCustomizeTasksPanelFormTvRepGroups

function TkwCustomizeTasksPanelFormTvRepGroups.TvRepGroups(const aCtx: TtfwContext;
  aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TeeTreeView;
 {-}
begin
 Result := aCustomizeTasksPanelForm.tvRepGroups;
end;//TkwCustomizeTasksPanelFormTvRepGroups.TvRepGroups

procedure TkwCustomizeTasksPanelFormTvRepGroups.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aCustomizeTasksPanelForm : TCustomizeTasksPanelForm;
begin
 try
  l_aCustomizeTasksPanelForm := TCustomizeTasksPanelForm(aCtx.rEngine.PopObjAs(TCustomizeTasksPanelForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aCustomizeTasksPanelForm: TCustomizeTasksPanelForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((TvRepGroups(aCtx, l_aCustomizeTasksPanelForm)));
end;//TkwCustomizeTasksPanelFormTvRepGroups.DoDoIt

class function TkwCustomizeTasksPanelFormTvRepGroups.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TCustomizeTasksPanelForm.tvRepGroups';
end;//TkwCustomizeTasksPanelFormTvRepGroups.GetWordNameForRegister

procedure TkwCustomizeTasksPanelFormTvRepGroups.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� tvRepGroups', aCtx);
end;//TkwCustomizeTasksPanelFormTvRepGroups.SetValuePrim

function TkwCustomizeTasksPanelFormTvRepGroups.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TeeTreeView);
end;//TkwCustomizeTasksPanelFormTvRepGroups.GetResultTypeInfo

function TkwCustomizeTasksPanelFormTvRepGroups.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwCustomizeTasksPanelFormTvRepGroups.GetAllParamsCount

function TkwCustomizeTasksPanelFormTvRepGroups.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TCustomizeTasksPanelForm)]);
end;//TkwCustomizeTasksPanelFormTvRepGroups.ParamsTypes

type
  TkwCustomizeTasksPanelFormVtPanel1 = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .TCustomizeTasksPanelForm.vtPanel1
[panel]������� vtPanel1 ����� TCustomizeTasksPanelForm[panel]
*��� ����������:* TvtPanel
*������:*
[code]
OBJECT VAR l_TvtPanel
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.vtPanel1 >>> l_TvtPanel
[code]  }
  private
  // private methods
   function VtPanel1(const aCtx: TtfwContext;
     aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtPanel;
     {* ���������� ����� ������� .TCustomizeTasksPanelForm.vtPanel1 }
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
  end;//TkwCustomizeTasksPanelFormVtPanel1

// start class TkwCustomizeTasksPanelFormVtPanel1

function TkwCustomizeTasksPanelFormVtPanel1.VtPanel1(const aCtx: TtfwContext;
  aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtPanel;
 {-}
begin
 Result := aCustomizeTasksPanelForm.vtPanel1;
end;//TkwCustomizeTasksPanelFormVtPanel1.VtPanel1

procedure TkwCustomizeTasksPanelFormVtPanel1.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aCustomizeTasksPanelForm : TCustomizeTasksPanelForm;
begin
 try
  l_aCustomizeTasksPanelForm := TCustomizeTasksPanelForm(aCtx.rEngine.PopObjAs(TCustomizeTasksPanelForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aCustomizeTasksPanelForm: TCustomizeTasksPanelForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((VtPanel1(aCtx, l_aCustomizeTasksPanelForm)));
end;//TkwCustomizeTasksPanelFormVtPanel1.DoDoIt

class function TkwCustomizeTasksPanelFormVtPanel1.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TCustomizeTasksPanelForm.vtPanel1';
end;//TkwCustomizeTasksPanelFormVtPanel1.GetWordNameForRegister

procedure TkwCustomizeTasksPanelFormVtPanel1.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� vtPanel1', aCtx);
end;//TkwCustomizeTasksPanelFormVtPanel1.SetValuePrim

function TkwCustomizeTasksPanelFormVtPanel1.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtPanel);
end;//TkwCustomizeTasksPanelFormVtPanel1.GetResultTypeInfo

function TkwCustomizeTasksPanelFormVtPanel1.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwCustomizeTasksPanelFormVtPanel1.GetAllParamsCount

function TkwCustomizeTasksPanelFormVtPanel1.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TCustomizeTasksPanelForm)]);
end;//TkwCustomizeTasksPanelFormVtPanel1.ParamsTypes

type
  TkwCustomizeTasksPanelFormCbGroupName = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .TCustomizeTasksPanelForm.cbGroupName
[panel]������� cbGroupName ����� TCustomizeTasksPanelForm[panel]
*��� ����������:* TvtComboBox
*������:*
[code]
OBJECT VAR l_TvtComboBox
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.cbGroupName >>> l_TvtComboBox
[code]  }
  private
  // private methods
   function CbGroupName(const aCtx: TtfwContext;
     aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtComboBox;
     {* ���������� ����� ������� .TCustomizeTasksPanelForm.cbGroupName }
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
  end;//TkwCustomizeTasksPanelFormCbGroupName

// start class TkwCustomizeTasksPanelFormCbGroupName

function TkwCustomizeTasksPanelFormCbGroupName.CbGroupName(const aCtx: TtfwContext;
  aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtComboBox;
 {-}
begin
 Result := aCustomizeTasksPanelForm.cbGroupName;
end;//TkwCustomizeTasksPanelFormCbGroupName.CbGroupName

procedure TkwCustomizeTasksPanelFormCbGroupName.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aCustomizeTasksPanelForm : TCustomizeTasksPanelForm;
begin
 try
  l_aCustomizeTasksPanelForm := TCustomizeTasksPanelForm(aCtx.rEngine.PopObjAs(TCustomizeTasksPanelForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aCustomizeTasksPanelForm: TCustomizeTasksPanelForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((CbGroupName(aCtx, l_aCustomizeTasksPanelForm)));
end;//TkwCustomizeTasksPanelFormCbGroupName.DoDoIt

class function TkwCustomizeTasksPanelFormCbGroupName.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TCustomizeTasksPanelForm.cbGroupName';
end;//TkwCustomizeTasksPanelFormCbGroupName.GetWordNameForRegister

procedure TkwCustomizeTasksPanelFormCbGroupName.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� cbGroupName', aCtx);
end;//TkwCustomizeTasksPanelFormCbGroupName.SetValuePrim

function TkwCustomizeTasksPanelFormCbGroupName.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtComboBox);
end;//TkwCustomizeTasksPanelFormCbGroupName.GetResultTypeInfo

function TkwCustomizeTasksPanelFormCbGroupName.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwCustomizeTasksPanelFormCbGroupName.GetAllParamsCount

function TkwCustomizeTasksPanelFormCbGroupName.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TCustomizeTasksPanelForm)]);
end;//TkwCustomizeTasksPanelFormCbGroupName.ParamsTypes

type
  TkwCustomizeTasksPanelFormBtnAddGroup = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .TCustomizeTasksPanelForm.btnAddGroup
[panel]������� btnAddGroup ����� TCustomizeTasksPanelForm[panel]
*��� ����������:* TeeButton
*������:*
[code]
OBJECT VAR l_TeeButton
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.btnAddGroup >>> l_TeeButton
[code]  }
  private
  // private methods
   function BtnAddGroup(const aCtx: TtfwContext;
     aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TeeButton;
     {* ���������� ����� ������� .TCustomizeTasksPanelForm.btnAddGroup }
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
  end;//TkwCustomizeTasksPanelFormBtnAddGroup

// start class TkwCustomizeTasksPanelFormBtnAddGroup

function TkwCustomizeTasksPanelFormBtnAddGroup.BtnAddGroup(const aCtx: TtfwContext;
  aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TeeButton;
 {-}
begin
 Result := aCustomizeTasksPanelForm.btnAddGroup;
end;//TkwCustomizeTasksPanelFormBtnAddGroup.BtnAddGroup

procedure TkwCustomizeTasksPanelFormBtnAddGroup.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aCustomizeTasksPanelForm : TCustomizeTasksPanelForm;
begin
 try
  l_aCustomizeTasksPanelForm := TCustomizeTasksPanelForm(aCtx.rEngine.PopObjAs(TCustomizeTasksPanelForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aCustomizeTasksPanelForm: TCustomizeTasksPanelForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((BtnAddGroup(aCtx, l_aCustomizeTasksPanelForm)));
end;//TkwCustomizeTasksPanelFormBtnAddGroup.DoDoIt

class function TkwCustomizeTasksPanelFormBtnAddGroup.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TCustomizeTasksPanelForm.btnAddGroup';
end;//TkwCustomizeTasksPanelFormBtnAddGroup.GetWordNameForRegister

procedure TkwCustomizeTasksPanelFormBtnAddGroup.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� btnAddGroup', aCtx);
end;//TkwCustomizeTasksPanelFormBtnAddGroup.SetValuePrim

function TkwCustomizeTasksPanelFormBtnAddGroup.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TeeButton);
end;//TkwCustomizeTasksPanelFormBtnAddGroup.GetResultTypeInfo

function TkwCustomizeTasksPanelFormBtnAddGroup.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwCustomizeTasksPanelFormBtnAddGroup.GetAllParamsCount

function TkwCustomizeTasksPanelFormBtnAddGroup.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TCustomizeTasksPanelForm)]);
end;//TkwCustomizeTasksPanelFormBtnAddGroup.ParamsTypes

type
  TkwCustomizeTasksPanelFormBtnChangeGroup = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .TCustomizeTasksPanelForm.btnChangeGroup
[panel]������� btnChangeGroup ����� TCustomizeTasksPanelForm[panel]
*��� ����������:* TeeButton
*������:*
[code]
OBJECT VAR l_TeeButton
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.btnChangeGroup >>> l_TeeButton
[code]  }
  private
  // private methods
   function BtnChangeGroup(const aCtx: TtfwContext;
     aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TeeButton;
     {* ���������� ����� ������� .TCustomizeTasksPanelForm.btnChangeGroup }
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
  end;//TkwCustomizeTasksPanelFormBtnChangeGroup

// start class TkwCustomizeTasksPanelFormBtnChangeGroup

function TkwCustomizeTasksPanelFormBtnChangeGroup.BtnChangeGroup(const aCtx: TtfwContext;
  aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TeeButton;
 {-}
begin
 Result := aCustomizeTasksPanelForm.btnChangeGroup;
end;//TkwCustomizeTasksPanelFormBtnChangeGroup.BtnChangeGroup

procedure TkwCustomizeTasksPanelFormBtnChangeGroup.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aCustomizeTasksPanelForm : TCustomizeTasksPanelForm;
begin
 try
  l_aCustomizeTasksPanelForm := TCustomizeTasksPanelForm(aCtx.rEngine.PopObjAs(TCustomizeTasksPanelForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aCustomizeTasksPanelForm: TCustomizeTasksPanelForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((BtnChangeGroup(aCtx, l_aCustomizeTasksPanelForm)));
end;//TkwCustomizeTasksPanelFormBtnChangeGroup.DoDoIt

class function TkwCustomizeTasksPanelFormBtnChangeGroup.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TCustomizeTasksPanelForm.btnChangeGroup';
end;//TkwCustomizeTasksPanelFormBtnChangeGroup.GetWordNameForRegister

procedure TkwCustomizeTasksPanelFormBtnChangeGroup.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� btnChangeGroup', aCtx);
end;//TkwCustomizeTasksPanelFormBtnChangeGroup.SetValuePrim

function TkwCustomizeTasksPanelFormBtnChangeGroup.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TeeButton);
end;//TkwCustomizeTasksPanelFormBtnChangeGroup.GetResultTypeInfo

function TkwCustomizeTasksPanelFormBtnChangeGroup.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwCustomizeTasksPanelFormBtnChangeGroup.GetAllParamsCount

function TkwCustomizeTasksPanelFormBtnChangeGroup.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TCustomizeTasksPanelForm)]);
end;//TkwCustomizeTasksPanelFormBtnChangeGroup.ParamsTypes

type
  TkwCustomizeTasksPanelFormBtnDeleteGroup = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .TCustomizeTasksPanelForm.btnDeleteGroup
[panel]������� btnDeleteGroup ����� TCustomizeTasksPanelForm[panel]
*��� ����������:* TeeButton
*������:*
[code]
OBJECT VAR l_TeeButton
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.btnDeleteGroup >>> l_TeeButton
[code]  }
  private
  // private methods
   function BtnDeleteGroup(const aCtx: TtfwContext;
     aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TeeButton;
     {* ���������� ����� ������� .TCustomizeTasksPanelForm.btnDeleteGroup }
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
  end;//TkwCustomizeTasksPanelFormBtnDeleteGroup

// start class TkwCustomizeTasksPanelFormBtnDeleteGroup

function TkwCustomizeTasksPanelFormBtnDeleteGroup.BtnDeleteGroup(const aCtx: TtfwContext;
  aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TeeButton;
 {-}
begin
 Result := aCustomizeTasksPanelForm.btnDeleteGroup;
end;//TkwCustomizeTasksPanelFormBtnDeleteGroup.BtnDeleteGroup

procedure TkwCustomizeTasksPanelFormBtnDeleteGroup.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aCustomizeTasksPanelForm : TCustomizeTasksPanelForm;
begin
 try
  l_aCustomizeTasksPanelForm := TCustomizeTasksPanelForm(aCtx.rEngine.PopObjAs(TCustomizeTasksPanelForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aCustomizeTasksPanelForm: TCustomizeTasksPanelForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((BtnDeleteGroup(aCtx, l_aCustomizeTasksPanelForm)));
end;//TkwCustomizeTasksPanelFormBtnDeleteGroup.DoDoIt

class function TkwCustomizeTasksPanelFormBtnDeleteGroup.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TCustomizeTasksPanelForm.btnDeleteGroup';
end;//TkwCustomizeTasksPanelFormBtnDeleteGroup.GetWordNameForRegister

procedure TkwCustomizeTasksPanelFormBtnDeleteGroup.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� btnDeleteGroup', aCtx);
end;//TkwCustomizeTasksPanelFormBtnDeleteGroup.SetValuePrim

function TkwCustomizeTasksPanelFormBtnDeleteGroup.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TeeButton);
end;//TkwCustomizeTasksPanelFormBtnDeleteGroup.GetResultTypeInfo

function TkwCustomizeTasksPanelFormBtnDeleteGroup.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwCustomizeTasksPanelFormBtnDeleteGroup.GetAllParamsCount

function TkwCustomizeTasksPanelFormBtnDeleteGroup.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TCustomizeTasksPanelForm)]);
end;//TkwCustomizeTasksPanelFormBtnDeleteGroup.ParamsTypes

type
  TkwCustomizeTasksPanelFormGbAvailableOperations = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .TCustomizeTasksPanelForm.gbAvailableOperations
[panel]������� gbAvailableOperations ����� TCustomizeTasksPanelForm[panel]
*��� ����������:* TvtGroupBox
*������:*
[code]
OBJECT VAR l_TvtGroupBox
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.gbAvailableOperations >>> l_TvtGroupBox
[code]  }
  private
  // private methods
   function GbAvailableOperations(const aCtx: TtfwContext;
     aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtGroupBox;
     {* ���������� ����� ������� .TCustomizeTasksPanelForm.gbAvailableOperations }
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
  end;//TkwCustomizeTasksPanelFormGbAvailableOperations

// start class TkwCustomizeTasksPanelFormGbAvailableOperations

function TkwCustomizeTasksPanelFormGbAvailableOperations.GbAvailableOperations(const aCtx: TtfwContext;
  aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtGroupBox;
 {-}
begin
 Result := aCustomizeTasksPanelForm.gbAvailableOperations;
end;//TkwCustomizeTasksPanelFormGbAvailableOperations.GbAvailableOperations

procedure TkwCustomizeTasksPanelFormGbAvailableOperations.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aCustomizeTasksPanelForm : TCustomizeTasksPanelForm;
begin
 try
  l_aCustomizeTasksPanelForm := TCustomizeTasksPanelForm(aCtx.rEngine.PopObjAs(TCustomizeTasksPanelForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aCustomizeTasksPanelForm: TCustomizeTasksPanelForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((GbAvailableOperations(aCtx, l_aCustomizeTasksPanelForm)));
end;//TkwCustomizeTasksPanelFormGbAvailableOperations.DoDoIt

class function TkwCustomizeTasksPanelFormGbAvailableOperations.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TCustomizeTasksPanelForm.gbAvailableOperations';
end;//TkwCustomizeTasksPanelFormGbAvailableOperations.GetWordNameForRegister

procedure TkwCustomizeTasksPanelFormGbAvailableOperations.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� gbAvailableOperations', aCtx);
end;//TkwCustomizeTasksPanelFormGbAvailableOperations.SetValuePrim

function TkwCustomizeTasksPanelFormGbAvailableOperations.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtGroupBox);
end;//TkwCustomizeTasksPanelFormGbAvailableOperations.GetResultTypeInfo

function TkwCustomizeTasksPanelFormGbAvailableOperations.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwCustomizeTasksPanelFormGbAvailableOperations.GetAllParamsCount

function TkwCustomizeTasksPanelFormGbAvailableOperations.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TCustomizeTasksPanelForm)]);
end;//TkwCustomizeTasksPanelFormGbAvailableOperations.ParamsTypes

type
  TkwCustomizeTasksPanelFormTvRepOps = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .TCustomizeTasksPanelForm.tvRepOps
[panel]������� tvRepOps ����� TCustomizeTasksPanelForm[panel]
*��� ����������:* TeeTreeView
*������:*
[code]
OBJECT VAR l_TeeTreeView
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.tvRepOps >>> l_TeeTreeView
[code]  }
  private
  // private methods
   function TvRepOps(const aCtx: TtfwContext;
     aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TeeTreeView;
     {* ���������� ����� ������� .TCustomizeTasksPanelForm.tvRepOps }
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
  end;//TkwCustomizeTasksPanelFormTvRepOps

// start class TkwCustomizeTasksPanelFormTvRepOps

function TkwCustomizeTasksPanelFormTvRepOps.TvRepOps(const aCtx: TtfwContext;
  aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TeeTreeView;
 {-}
begin
 Result := aCustomizeTasksPanelForm.tvRepOps;
end;//TkwCustomizeTasksPanelFormTvRepOps.TvRepOps

procedure TkwCustomizeTasksPanelFormTvRepOps.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aCustomizeTasksPanelForm : TCustomizeTasksPanelForm;
begin
 try
  l_aCustomizeTasksPanelForm := TCustomizeTasksPanelForm(aCtx.rEngine.PopObjAs(TCustomizeTasksPanelForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aCustomizeTasksPanelForm: TCustomizeTasksPanelForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((TvRepOps(aCtx, l_aCustomizeTasksPanelForm)));
end;//TkwCustomizeTasksPanelFormTvRepOps.DoDoIt

class function TkwCustomizeTasksPanelFormTvRepOps.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TCustomizeTasksPanelForm.tvRepOps';
end;//TkwCustomizeTasksPanelFormTvRepOps.GetWordNameForRegister

procedure TkwCustomizeTasksPanelFormTvRepOps.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� tvRepOps', aCtx);
end;//TkwCustomizeTasksPanelFormTvRepOps.SetValuePrim

function TkwCustomizeTasksPanelFormTvRepOps.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TeeTreeView);
end;//TkwCustomizeTasksPanelFormTvRepOps.GetResultTypeInfo

function TkwCustomizeTasksPanelFormTvRepOps.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwCustomizeTasksPanelFormTvRepOps.GetAllParamsCount

function TkwCustomizeTasksPanelFormTvRepOps.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TCustomizeTasksPanelForm)]);
end;//TkwCustomizeTasksPanelFormTvRepOps.ParamsTypes

type
  TkwCustomizeTasksPanelFormPnlForms = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .TCustomizeTasksPanelForm.pnlForms
[panel]������� pnlForms ����� TCustomizeTasksPanelForm[panel]
*��� ����������:* TvtPanel
*������:*
[code]
OBJECT VAR l_TvtPanel
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.pnlForms >>> l_TvtPanel
[code]  }
  private
  // private methods
   function PnlForms(const aCtx: TtfwContext;
     aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtPanel;
     {* ���������� ����� ������� .TCustomizeTasksPanelForm.pnlForms }
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
  end;//TkwCustomizeTasksPanelFormPnlForms

// start class TkwCustomizeTasksPanelFormPnlForms

function TkwCustomizeTasksPanelFormPnlForms.PnlForms(const aCtx: TtfwContext;
  aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtPanel;
 {-}
begin
 Result := aCustomizeTasksPanelForm.pnlForms;
end;//TkwCustomizeTasksPanelFormPnlForms.PnlForms

procedure TkwCustomizeTasksPanelFormPnlForms.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aCustomizeTasksPanelForm : TCustomizeTasksPanelForm;
begin
 try
  l_aCustomizeTasksPanelForm := TCustomizeTasksPanelForm(aCtx.rEngine.PopObjAs(TCustomizeTasksPanelForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aCustomizeTasksPanelForm: TCustomizeTasksPanelForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((PnlForms(aCtx, l_aCustomizeTasksPanelForm)));
end;//TkwCustomizeTasksPanelFormPnlForms.DoDoIt

class function TkwCustomizeTasksPanelFormPnlForms.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TCustomizeTasksPanelForm.pnlForms';
end;//TkwCustomizeTasksPanelFormPnlForms.GetWordNameForRegister

procedure TkwCustomizeTasksPanelFormPnlForms.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� pnlForms', aCtx);
end;//TkwCustomizeTasksPanelFormPnlForms.SetValuePrim

function TkwCustomizeTasksPanelFormPnlForms.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtPanel);
end;//TkwCustomizeTasksPanelFormPnlForms.GetResultTypeInfo

function TkwCustomizeTasksPanelFormPnlForms.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwCustomizeTasksPanelFormPnlForms.GetAllParamsCount

function TkwCustomizeTasksPanelFormPnlForms.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TCustomizeTasksPanelForm)]);
end;//TkwCustomizeTasksPanelFormPnlForms.ParamsTypes

type
  TkwCustomizeTasksPanelFormLblForms = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .TCustomizeTasksPanelForm.lblForms
[panel]������� lblForms ����� TCustomizeTasksPanelForm[panel]
*��� ����������:* TvtLabel
*������:*
[code]
OBJECT VAR l_TvtLabel
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.lblForms >>> l_TvtLabel
[code]  }
  private
  // private methods
   function LblForms(const aCtx: TtfwContext;
     aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtLabel;
     {* ���������� ����� ������� .TCustomizeTasksPanelForm.lblForms }
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
  end;//TkwCustomizeTasksPanelFormLblForms

// start class TkwCustomizeTasksPanelFormLblForms

function TkwCustomizeTasksPanelFormLblForms.LblForms(const aCtx: TtfwContext;
  aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtLabel;
 {-}
begin
 Result := aCustomizeTasksPanelForm.lblForms;
end;//TkwCustomizeTasksPanelFormLblForms.LblForms

procedure TkwCustomizeTasksPanelFormLblForms.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aCustomizeTasksPanelForm : TCustomizeTasksPanelForm;
begin
 try
  l_aCustomizeTasksPanelForm := TCustomizeTasksPanelForm(aCtx.rEngine.PopObjAs(TCustomizeTasksPanelForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aCustomizeTasksPanelForm: TCustomizeTasksPanelForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((LblForms(aCtx, l_aCustomizeTasksPanelForm)));
end;//TkwCustomizeTasksPanelFormLblForms.DoDoIt

class function TkwCustomizeTasksPanelFormLblForms.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TCustomizeTasksPanelForm.lblForms';
end;//TkwCustomizeTasksPanelFormLblForms.GetWordNameForRegister

procedure TkwCustomizeTasksPanelFormLblForms.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� lblForms', aCtx);
end;//TkwCustomizeTasksPanelFormLblForms.SetValuePrim

function TkwCustomizeTasksPanelFormLblForms.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtLabel);
end;//TkwCustomizeTasksPanelFormLblForms.GetResultTypeInfo

function TkwCustomizeTasksPanelFormLblForms.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwCustomizeTasksPanelFormLblForms.GetAllParamsCount

function TkwCustomizeTasksPanelFormLblForms.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TCustomizeTasksPanelForm)]);
end;//TkwCustomizeTasksPanelFormLblForms.ParamsTypes

type
  TkwCustomizeTasksPanelFormCbForms = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .TCustomizeTasksPanelForm.cbForms
[panel]������� cbForms ����� TCustomizeTasksPanelForm[panel]
*��� ����������:* TComboBox
*������:*
[code]
OBJECT VAR l_TComboBox
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.cbForms >>> l_TComboBox
[code]  }
  private
  // private methods
   function CbForms(const aCtx: TtfwContext;
     aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TComboBox;
     {* ���������� ����� ������� .TCustomizeTasksPanelForm.cbForms }
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
  end;//TkwCustomizeTasksPanelFormCbForms

// start class TkwCustomizeTasksPanelFormCbForms

function TkwCustomizeTasksPanelFormCbForms.CbForms(const aCtx: TtfwContext;
  aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TComboBox;
 {-}
begin
 Result := aCustomizeTasksPanelForm.cbForms;
end;//TkwCustomizeTasksPanelFormCbForms.CbForms

procedure TkwCustomizeTasksPanelFormCbForms.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aCustomizeTasksPanelForm : TCustomizeTasksPanelForm;
begin
 try
  l_aCustomizeTasksPanelForm := TCustomizeTasksPanelForm(aCtx.rEngine.PopObjAs(TCustomizeTasksPanelForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aCustomizeTasksPanelForm: TCustomizeTasksPanelForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((CbForms(aCtx, l_aCustomizeTasksPanelForm)));
end;//TkwCustomizeTasksPanelFormCbForms.DoDoIt

class function TkwCustomizeTasksPanelFormCbForms.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TCustomizeTasksPanelForm.cbForms';
end;//TkwCustomizeTasksPanelFormCbForms.GetWordNameForRegister

procedure TkwCustomizeTasksPanelFormCbForms.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� cbForms', aCtx);
end;//TkwCustomizeTasksPanelFormCbForms.SetValuePrim

function TkwCustomizeTasksPanelFormCbForms.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TComboBox);
end;//TkwCustomizeTasksPanelFormCbForms.GetResultTypeInfo

function TkwCustomizeTasksPanelFormCbForms.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwCustomizeTasksPanelFormCbForms.GetAllParamsCount

function TkwCustomizeTasksPanelFormCbForms.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TCustomizeTasksPanelForm)]);
end;//TkwCustomizeTasksPanelFormCbForms.ParamsTypes

type
  TkwCustomizeTasksPanelFormPnlMain = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .TCustomizeTasksPanelForm.pnlMain
[panel]������� pnlMain ����� TCustomizeTasksPanelForm[panel]
*��� ����������:* TvtPanel
*������:*
[code]
OBJECT VAR l_TvtPanel
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.pnlMain >>> l_TvtPanel
[code]  }
  private
  // private methods
   function PnlMain(const aCtx: TtfwContext;
     aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtPanel;
     {* ���������� ����� ������� .TCustomizeTasksPanelForm.pnlMain }
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
  end;//TkwCustomizeTasksPanelFormPnlMain

// start class TkwCustomizeTasksPanelFormPnlMain

function TkwCustomizeTasksPanelFormPnlMain.PnlMain(const aCtx: TtfwContext;
  aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtPanel;
 {-}
begin
 Result := aCustomizeTasksPanelForm.pnlMain;
end;//TkwCustomizeTasksPanelFormPnlMain.PnlMain

procedure TkwCustomizeTasksPanelFormPnlMain.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aCustomizeTasksPanelForm : TCustomizeTasksPanelForm;
begin
 try
  l_aCustomizeTasksPanelForm := TCustomizeTasksPanelForm(aCtx.rEngine.PopObjAs(TCustomizeTasksPanelForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aCustomizeTasksPanelForm: TCustomizeTasksPanelForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((PnlMain(aCtx, l_aCustomizeTasksPanelForm)));
end;//TkwCustomizeTasksPanelFormPnlMain.DoDoIt

class function TkwCustomizeTasksPanelFormPnlMain.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TCustomizeTasksPanelForm.pnlMain';
end;//TkwCustomizeTasksPanelFormPnlMain.GetWordNameForRegister

procedure TkwCustomizeTasksPanelFormPnlMain.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� pnlMain', aCtx);
end;//TkwCustomizeTasksPanelFormPnlMain.SetValuePrim

function TkwCustomizeTasksPanelFormPnlMain.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtPanel);
end;//TkwCustomizeTasksPanelFormPnlMain.GetResultTypeInfo

function TkwCustomizeTasksPanelFormPnlMain.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwCustomizeTasksPanelFormPnlMain.GetAllParamsCount

function TkwCustomizeTasksPanelFormPnlMain.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TCustomizeTasksPanelForm)]);
end;//TkwCustomizeTasksPanelFormPnlMain.ParamsTypes

type
  TkwCustomizeTasksPanelFormPnlLeft = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .TCustomizeTasksPanelForm.pnlLeft
[panel]������� pnlLeft ����� TCustomizeTasksPanelForm[panel]
*��� ����������:* TvtPanel
*������:*
[code]
OBJECT VAR l_TvtPanel
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.pnlLeft >>> l_TvtPanel
[code]  }
  private
  // private methods
   function PnlLeft(const aCtx: TtfwContext;
     aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtPanel;
     {* ���������� ����� ������� .TCustomizeTasksPanelForm.pnlLeft }
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
  end;//TkwCustomizeTasksPanelFormPnlLeft

// start class TkwCustomizeTasksPanelFormPnlLeft

function TkwCustomizeTasksPanelFormPnlLeft.PnlLeft(const aCtx: TtfwContext;
  aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtPanel;
 {-}
begin
 Result := aCustomizeTasksPanelForm.pnlLeft;
end;//TkwCustomizeTasksPanelFormPnlLeft.PnlLeft

procedure TkwCustomizeTasksPanelFormPnlLeft.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aCustomizeTasksPanelForm : TCustomizeTasksPanelForm;
begin
 try
  l_aCustomizeTasksPanelForm := TCustomizeTasksPanelForm(aCtx.rEngine.PopObjAs(TCustomizeTasksPanelForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aCustomizeTasksPanelForm: TCustomizeTasksPanelForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((PnlLeft(aCtx, l_aCustomizeTasksPanelForm)));
end;//TkwCustomizeTasksPanelFormPnlLeft.DoDoIt

class function TkwCustomizeTasksPanelFormPnlLeft.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TCustomizeTasksPanelForm.pnlLeft';
end;//TkwCustomizeTasksPanelFormPnlLeft.GetWordNameForRegister

procedure TkwCustomizeTasksPanelFormPnlLeft.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� pnlLeft', aCtx);
end;//TkwCustomizeTasksPanelFormPnlLeft.SetValuePrim

function TkwCustomizeTasksPanelFormPnlLeft.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtPanel);
end;//TkwCustomizeTasksPanelFormPnlLeft.GetResultTypeInfo

function TkwCustomizeTasksPanelFormPnlLeft.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwCustomizeTasksPanelFormPnlLeft.GetAllParamsCount

function TkwCustomizeTasksPanelFormPnlLeft.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TCustomizeTasksPanelForm)]);
end;//TkwCustomizeTasksPanelFormPnlLeft.ParamsTypes

type
  TkwCustomizeTasksPanelFormBtnMoveOpToPanel = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .TCustomizeTasksPanelForm.btnMoveOpToPanel
[panel]������� btnMoveOpToPanel ����� TCustomizeTasksPanelForm[panel]
*��� ����������:* TBitBtn
*������:*
[code]
OBJECT VAR l_TBitBtn
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.btnMoveOpToPanel >>> l_TBitBtn
[code]  }
  private
  // private methods
   function BtnMoveOpToPanel(const aCtx: TtfwContext;
     aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TBitBtn;
     {* ���������� ����� ������� .TCustomizeTasksPanelForm.btnMoveOpToPanel }
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
  end;//TkwCustomizeTasksPanelFormBtnMoveOpToPanel

// start class TkwCustomizeTasksPanelFormBtnMoveOpToPanel

function TkwCustomizeTasksPanelFormBtnMoveOpToPanel.BtnMoveOpToPanel(const aCtx: TtfwContext;
  aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TBitBtn;
 {-}
begin
 Result := aCustomizeTasksPanelForm.btnMoveOpToPanel;
end;//TkwCustomizeTasksPanelFormBtnMoveOpToPanel.BtnMoveOpToPanel

procedure TkwCustomizeTasksPanelFormBtnMoveOpToPanel.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aCustomizeTasksPanelForm : TCustomizeTasksPanelForm;
begin
 try
  l_aCustomizeTasksPanelForm := TCustomizeTasksPanelForm(aCtx.rEngine.PopObjAs(TCustomizeTasksPanelForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aCustomizeTasksPanelForm: TCustomizeTasksPanelForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((BtnMoveOpToPanel(aCtx, l_aCustomizeTasksPanelForm)));
end;//TkwCustomizeTasksPanelFormBtnMoveOpToPanel.DoDoIt

class function TkwCustomizeTasksPanelFormBtnMoveOpToPanel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TCustomizeTasksPanelForm.btnMoveOpToPanel';
end;//TkwCustomizeTasksPanelFormBtnMoveOpToPanel.GetWordNameForRegister

procedure TkwCustomizeTasksPanelFormBtnMoveOpToPanel.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� btnMoveOpToPanel', aCtx);
end;//TkwCustomizeTasksPanelFormBtnMoveOpToPanel.SetValuePrim

function TkwCustomizeTasksPanelFormBtnMoveOpToPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TBitBtn);
end;//TkwCustomizeTasksPanelFormBtnMoveOpToPanel.GetResultTypeInfo

function TkwCustomizeTasksPanelFormBtnMoveOpToPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwCustomizeTasksPanelFormBtnMoveOpToPanel.GetAllParamsCount

function TkwCustomizeTasksPanelFormBtnMoveOpToPanel.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TCustomizeTasksPanelForm)]);
end;//TkwCustomizeTasksPanelFormBtnMoveOpToPanel.ParamsTypes

type
  TkwCustomizeTasksPanelFormBtnMoveOpToRep = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .TCustomizeTasksPanelForm.btnMoveOpToRep
[panel]������� btnMoveOpToRep ����� TCustomizeTasksPanelForm[panel]
*��� ����������:* TBitBtn
*������:*
[code]
OBJECT VAR l_TBitBtn
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.btnMoveOpToRep >>> l_TBitBtn
[code]  }
  private
  // private methods
   function BtnMoveOpToRep(const aCtx: TtfwContext;
     aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TBitBtn;
     {* ���������� ����� ������� .TCustomizeTasksPanelForm.btnMoveOpToRep }
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
  end;//TkwCustomizeTasksPanelFormBtnMoveOpToRep

// start class TkwCustomizeTasksPanelFormBtnMoveOpToRep

function TkwCustomizeTasksPanelFormBtnMoveOpToRep.BtnMoveOpToRep(const aCtx: TtfwContext;
  aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TBitBtn;
 {-}
begin
 Result := aCustomizeTasksPanelForm.btnMoveOpToRep;
end;//TkwCustomizeTasksPanelFormBtnMoveOpToRep.BtnMoveOpToRep

procedure TkwCustomizeTasksPanelFormBtnMoveOpToRep.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aCustomizeTasksPanelForm : TCustomizeTasksPanelForm;
begin
 try
  l_aCustomizeTasksPanelForm := TCustomizeTasksPanelForm(aCtx.rEngine.PopObjAs(TCustomizeTasksPanelForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aCustomizeTasksPanelForm: TCustomizeTasksPanelForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((BtnMoveOpToRep(aCtx, l_aCustomizeTasksPanelForm)));
end;//TkwCustomizeTasksPanelFormBtnMoveOpToRep.DoDoIt

class function TkwCustomizeTasksPanelFormBtnMoveOpToRep.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TCustomizeTasksPanelForm.btnMoveOpToRep';
end;//TkwCustomizeTasksPanelFormBtnMoveOpToRep.GetWordNameForRegister

procedure TkwCustomizeTasksPanelFormBtnMoveOpToRep.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� btnMoveOpToRep', aCtx);
end;//TkwCustomizeTasksPanelFormBtnMoveOpToRep.SetValuePrim

function TkwCustomizeTasksPanelFormBtnMoveOpToRep.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TBitBtn);
end;//TkwCustomizeTasksPanelFormBtnMoveOpToRep.GetResultTypeInfo

function TkwCustomizeTasksPanelFormBtnMoveOpToRep.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwCustomizeTasksPanelFormBtnMoveOpToRep.GetAllParamsCount

function TkwCustomizeTasksPanelFormBtnMoveOpToRep.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TCustomizeTasksPanelForm)]);
end;//TkwCustomizeTasksPanelFormBtnMoveOpToRep.ParamsTypes

type
  TkwCustomizeTasksPanelFormBtnMoveGroupToPanel = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .TCustomizeTasksPanelForm.btnMoveGroupToPanel
[panel]������� btnMoveGroupToPanel ����� TCustomizeTasksPanelForm[panel]
*��� ����������:* TBitBtn
*������:*
[code]
OBJECT VAR l_TBitBtn
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.btnMoveGroupToPanel >>> l_TBitBtn
[code]  }
  private
  // private methods
   function BtnMoveGroupToPanel(const aCtx: TtfwContext;
     aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TBitBtn;
     {* ���������� ����� ������� .TCustomizeTasksPanelForm.btnMoveGroupToPanel }
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
  end;//TkwCustomizeTasksPanelFormBtnMoveGroupToPanel

// start class TkwCustomizeTasksPanelFormBtnMoveGroupToPanel

function TkwCustomizeTasksPanelFormBtnMoveGroupToPanel.BtnMoveGroupToPanel(const aCtx: TtfwContext;
  aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TBitBtn;
 {-}
begin
 Result := aCustomizeTasksPanelForm.btnMoveGroupToPanel;
end;//TkwCustomizeTasksPanelFormBtnMoveGroupToPanel.BtnMoveGroupToPanel

procedure TkwCustomizeTasksPanelFormBtnMoveGroupToPanel.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aCustomizeTasksPanelForm : TCustomizeTasksPanelForm;
begin
 try
  l_aCustomizeTasksPanelForm := TCustomizeTasksPanelForm(aCtx.rEngine.PopObjAs(TCustomizeTasksPanelForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aCustomizeTasksPanelForm: TCustomizeTasksPanelForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((BtnMoveGroupToPanel(aCtx, l_aCustomizeTasksPanelForm)));
end;//TkwCustomizeTasksPanelFormBtnMoveGroupToPanel.DoDoIt

class function TkwCustomizeTasksPanelFormBtnMoveGroupToPanel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TCustomizeTasksPanelForm.btnMoveGroupToPanel';
end;//TkwCustomizeTasksPanelFormBtnMoveGroupToPanel.GetWordNameForRegister

procedure TkwCustomizeTasksPanelFormBtnMoveGroupToPanel.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� btnMoveGroupToPanel', aCtx);
end;//TkwCustomizeTasksPanelFormBtnMoveGroupToPanel.SetValuePrim

function TkwCustomizeTasksPanelFormBtnMoveGroupToPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TBitBtn);
end;//TkwCustomizeTasksPanelFormBtnMoveGroupToPanel.GetResultTypeInfo

function TkwCustomizeTasksPanelFormBtnMoveGroupToPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwCustomizeTasksPanelFormBtnMoveGroupToPanel.GetAllParamsCount

function TkwCustomizeTasksPanelFormBtnMoveGroupToPanel.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TCustomizeTasksPanelForm)]);
end;//TkwCustomizeTasksPanelFormBtnMoveGroupToPanel.ParamsTypes

type
  TkwCustomizeTasksPanelFormBtnMoveGroupToRep = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .TCustomizeTasksPanelForm.btnMoveGroupToRep
[panel]������� btnMoveGroupToRep ����� TCustomizeTasksPanelForm[panel]
*��� ����������:* TBitBtn
*������:*
[code]
OBJECT VAR l_TBitBtn
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.btnMoveGroupToRep >>> l_TBitBtn
[code]  }
  private
  // private methods
   function BtnMoveGroupToRep(const aCtx: TtfwContext;
     aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TBitBtn;
     {* ���������� ����� ������� .TCustomizeTasksPanelForm.btnMoveGroupToRep }
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
  end;//TkwCustomizeTasksPanelFormBtnMoveGroupToRep

// start class TkwCustomizeTasksPanelFormBtnMoveGroupToRep

function TkwCustomizeTasksPanelFormBtnMoveGroupToRep.BtnMoveGroupToRep(const aCtx: TtfwContext;
  aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TBitBtn;
 {-}
begin
 Result := aCustomizeTasksPanelForm.btnMoveGroupToRep;
end;//TkwCustomizeTasksPanelFormBtnMoveGroupToRep.BtnMoveGroupToRep

procedure TkwCustomizeTasksPanelFormBtnMoveGroupToRep.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aCustomizeTasksPanelForm : TCustomizeTasksPanelForm;
begin
 try
  l_aCustomizeTasksPanelForm := TCustomizeTasksPanelForm(aCtx.rEngine.PopObjAs(TCustomizeTasksPanelForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aCustomizeTasksPanelForm: TCustomizeTasksPanelForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((BtnMoveGroupToRep(aCtx, l_aCustomizeTasksPanelForm)));
end;//TkwCustomizeTasksPanelFormBtnMoveGroupToRep.DoDoIt

class function TkwCustomizeTasksPanelFormBtnMoveGroupToRep.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TCustomizeTasksPanelForm.btnMoveGroupToRep';
end;//TkwCustomizeTasksPanelFormBtnMoveGroupToRep.GetWordNameForRegister

procedure TkwCustomizeTasksPanelFormBtnMoveGroupToRep.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� btnMoveGroupToRep', aCtx);
end;//TkwCustomizeTasksPanelFormBtnMoveGroupToRep.SetValuePrim

function TkwCustomizeTasksPanelFormBtnMoveGroupToRep.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TBitBtn);
end;//TkwCustomizeTasksPanelFormBtnMoveGroupToRep.GetResultTypeInfo

function TkwCustomizeTasksPanelFormBtnMoveGroupToRep.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwCustomizeTasksPanelFormBtnMoveGroupToRep.GetAllParamsCount

function TkwCustomizeTasksPanelFormBtnMoveGroupToRep.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TCustomizeTasksPanelForm)]);
end;//TkwCustomizeTasksPanelFormBtnMoveGroupToRep.ParamsTypes

type
  TkwCustomizeTasksPanelFormPnlTasksPanel = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .TCustomizeTasksPanelForm.pnlTasksPanel
[panel]������� pnlTasksPanel ����� TCustomizeTasksPanelForm[panel]
*��� ����������:* TvtPanel
*������:*
[code]
OBJECT VAR l_TvtPanel
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.pnlTasksPanel >>> l_TvtPanel
[code]  }
  private
  // private methods
   function PnlTasksPanel(const aCtx: TtfwContext;
     aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtPanel;
     {* ���������� ����� ������� .TCustomizeTasksPanelForm.pnlTasksPanel }
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
  end;//TkwCustomizeTasksPanelFormPnlTasksPanel

// start class TkwCustomizeTasksPanelFormPnlTasksPanel

function TkwCustomizeTasksPanelFormPnlTasksPanel.PnlTasksPanel(const aCtx: TtfwContext;
  aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtPanel;
 {-}
begin
 Result := aCustomizeTasksPanelForm.pnlTasksPanel;
end;//TkwCustomizeTasksPanelFormPnlTasksPanel.PnlTasksPanel

procedure TkwCustomizeTasksPanelFormPnlTasksPanel.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aCustomizeTasksPanelForm : TCustomizeTasksPanelForm;
begin
 try
  l_aCustomizeTasksPanelForm := TCustomizeTasksPanelForm(aCtx.rEngine.PopObjAs(TCustomizeTasksPanelForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aCustomizeTasksPanelForm: TCustomizeTasksPanelForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((PnlTasksPanel(aCtx, l_aCustomizeTasksPanelForm)));
end;//TkwCustomizeTasksPanelFormPnlTasksPanel.DoDoIt

class function TkwCustomizeTasksPanelFormPnlTasksPanel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TCustomizeTasksPanelForm.pnlTasksPanel';
end;//TkwCustomizeTasksPanelFormPnlTasksPanel.GetWordNameForRegister

procedure TkwCustomizeTasksPanelFormPnlTasksPanel.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� pnlTasksPanel', aCtx);
end;//TkwCustomizeTasksPanelFormPnlTasksPanel.SetValuePrim

function TkwCustomizeTasksPanelFormPnlTasksPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtPanel);
end;//TkwCustomizeTasksPanelFormPnlTasksPanel.GetResultTypeInfo

function TkwCustomizeTasksPanelFormPnlTasksPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwCustomizeTasksPanelFormPnlTasksPanel.GetAllParamsCount

function TkwCustomizeTasksPanelFormPnlTasksPanel.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TCustomizeTasksPanelForm)]);
end;//TkwCustomizeTasksPanelFormPnlTasksPanel.ParamsTypes

type
  TkwCustomizeTasksPanelFormGbTasksPanel = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .TCustomizeTasksPanelForm.gbTasksPanel
[panel]������� gbTasksPanel ����� TCustomizeTasksPanelForm[panel]
*��� ����������:* TvtGroupBox
*������:*
[code]
OBJECT VAR l_TvtGroupBox
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.gbTasksPanel >>> l_TvtGroupBox
[code]  }
  private
  // private methods
   function GbTasksPanel(const aCtx: TtfwContext;
     aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtGroupBox;
     {* ���������� ����� ������� .TCustomizeTasksPanelForm.gbTasksPanel }
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
  end;//TkwCustomizeTasksPanelFormGbTasksPanel

// start class TkwCustomizeTasksPanelFormGbTasksPanel

function TkwCustomizeTasksPanelFormGbTasksPanel.GbTasksPanel(const aCtx: TtfwContext;
  aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtGroupBox;
 {-}
begin
 Result := aCustomizeTasksPanelForm.gbTasksPanel;
end;//TkwCustomizeTasksPanelFormGbTasksPanel.GbTasksPanel

procedure TkwCustomizeTasksPanelFormGbTasksPanel.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aCustomizeTasksPanelForm : TCustomizeTasksPanelForm;
begin
 try
  l_aCustomizeTasksPanelForm := TCustomizeTasksPanelForm(aCtx.rEngine.PopObjAs(TCustomizeTasksPanelForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aCustomizeTasksPanelForm: TCustomizeTasksPanelForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((GbTasksPanel(aCtx, l_aCustomizeTasksPanelForm)));
end;//TkwCustomizeTasksPanelFormGbTasksPanel.DoDoIt

class function TkwCustomizeTasksPanelFormGbTasksPanel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TCustomizeTasksPanelForm.gbTasksPanel';
end;//TkwCustomizeTasksPanelFormGbTasksPanel.GetWordNameForRegister

procedure TkwCustomizeTasksPanelFormGbTasksPanel.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� gbTasksPanel', aCtx);
end;//TkwCustomizeTasksPanelFormGbTasksPanel.SetValuePrim

function TkwCustomizeTasksPanelFormGbTasksPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtGroupBox);
end;//TkwCustomizeTasksPanelFormGbTasksPanel.GetResultTypeInfo

function TkwCustomizeTasksPanelFormGbTasksPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwCustomizeTasksPanelFormGbTasksPanel.GetAllParamsCount

function TkwCustomizeTasksPanelFormGbTasksPanel.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TCustomizeTasksPanelForm)]);
end;//TkwCustomizeTasksPanelFormGbTasksPanel.ParamsTypes

type
  TkwCustomizeTasksPanelFormTvTasksPanel = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .TCustomizeTasksPanelForm.tvTasksPanel
[panel]������� tvTasksPanel ����� TCustomizeTasksPanelForm[panel]
*��� ����������:* TeeTreeView
*������:*
[code]
OBJECT VAR l_TeeTreeView
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.tvTasksPanel >>> l_TeeTreeView
[code]  }
  private
  // private methods
   function TvTasksPanel(const aCtx: TtfwContext;
     aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TeeTreeView;
     {* ���������� ����� ������� .TCustomizeTasksPanelForm.tvTasksPanel }
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
  end;//TkwCustomizeTasksPanelFormTvTasksPanel

// start class TkwCustomizeTasksPanelFormTvTasksPanel

function TkwCustomizeTasksPanelFormTvTasksPanel.TvTasksPanel(const aCtx: TtfwContext;
  aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TeeTreeView;
 {-}
begin
 Result := aCustomizeTasksPanelForm.tvTasksPanel;
end;//TkwCustomizeTasksPanelFormTvTasksPanel.TvTasksPanel

procedure TkwCustomizeTasksPanelFormTvTasksPanel.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aCustomizeTasksPanelForm : TCustomizeTasksPanelForm;
begin
 try
  l_aCustomizeTasksPanelForm := TCustomizeTasksPanelForm(aCtx.rEngine.PopObjAs(TCustomizeTasksPanelForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aCustomizeTasksPanelForm: TCustomizeTasksPanelForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((TvTasksPanel(aCtx, l_aCustomizeTasksPanelForm)));
end;//TkwCustomizeTasksPanelFormTvTasksPanel.DoDoIt

class function TkwCustomizeTasksPanelFormTvTasksPanel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TCustomizeTasksPanelForm.tvTasksPanel';
end;//TkwCustomizeTasksPanelFormTvTasksPanel.GetWordNameForRegister

procedure TkwCustomizeTasksPanelFormTvTasksPanel.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� tvTasksPanel', aCtx);
end;//TkwCustomizeTasksPanelFormTvTasksPanel.SetValuePrim

function TkwCustomizeTasksPanelFormTvTasksPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TeeTreeView);
end;//TkwCustomizeTasksPanelFormTvTasksPanel.GetResultTypeInfo

function TkwCustomizeTasksPanelFormTvTasksPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwCustomizeTasksPanelFormTvTasksPanel.GetAllParamsCount

function TkwCustomizeTasksPanelFormTvTasksPanel.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TCustomizeTasksPanelForm)]);
end;//TkwCustomizeTasksPanelFormTvTasksPanel.ParamsTypes

type
  TkwCustomizeTasksPanelFormVtGroupBox3 = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .TCustomizeTasksPanelForm.vtGroupBox3
[panel]������� vtGroupBox3 ����� TCustomizeTasksPanelForm[panel]
*��� ����������:* TvtGroupBox
*������:*
[code]
OBJECT VAR l_TvtGroupBox
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.vtGroupBox3 >>> l_TvtGroupBox
[code]  }
  private
  // private methods
   function VtGroupBox3(const aCtx: TtfwContext;
     aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtGroupBox;
     {* ���������� ����� ������� .TCustomizeTasksPanelForm.vtGroupBox3 }
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
  end;//TkwCustomizeTasksPanelFormVtGroupBox3

// start class TkwCustomizeTasksPanelFormVtGroupBox3

function TkwCustomizeTasksPanelFormVtGroupBox3.VtGroupBox3(const aCtx: TtfwContext;
  aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtGroupBox;
 {-}
begin
 Result := aCustomizeTasksPanelForm.vtGroupBox3;
end;//TkwCustomizeTasksPanelFormVtGroupBox3.VtGroupBox3

procedure TkwCustomizeTasksPanelFormVtGroupBox3.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aCustomizeTasksPanelForm : TCustomizeTasksPanelForm;
begin
 try
  l_aCustomizeTasksPanelForm := TCustomizeTasksPanelForm(aCtx.rEngine.PopObjAs(TCustomizeTasksPanelForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aCustomizeTasksPanelForm: TCustomizeTasksPanelForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((VtGroupBox3(aCtx, l_aCustomizeTasksPanelForm)));
end;//TkwCustomizeTasksPanelFormVtGroupBox3.DoDoIt

class function TkwCustomizeTasksPanelFormVtGroupBox3.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TCustomizeTasksPanelForm.vtGroupBox3';
end;//TkwCustomizeTasksPanelFormVtGroupBox3.GetWordNameForRegister

procedure TkwCustomizeTasksPanelFormVtGroupBox3.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� vtGroupBox3', aCtx);
end;//TkwCustomizeTasksPanelFormVtGroupBox3.SetValuePrim

function TkwCustomizeTasksPanelFormVtGroupBox3.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtGroupBox);
end;//TkwCustomizeTasksPanelFormVtGroupBox3.GetResultTypeInfo

function TkwCustomizeTasksPanelFormVtGroupBox3.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwCustomizeTasksPanelFormVtGroupBox3.GetAllParamsCount

function TkwCustomizeTasksPanelFormVtGroupBox3.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TCustomizeTasksPanelForm)]);
end;//TkwCustomizeTasksPanelFormVtGroupBox3.ParamsTypes

type
  TkwCustomizeTasksPanelFormLblCaption = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .TCustomizeTasksPanelForm.lblCaption
[panel]������� lblCaption ����� TCustomizeTasksPanelForm[panel]
*��� ����������:* TvtLabel
*������:*
[code]
OBJECT VAR l_TvtLabel
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.lblCaption >>> l_TvtLabel
[code]  }
  private
  // private methods
   function LblCaption(const aCtx: TtfwContext;
     aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtLabel;
     {* ���������� ����� ������� .TCustomizeTasksPanelForm.lblCaption }
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
  end;//TkwCustomizeTasksPanelFormLblCaption

// start class TkwCustomizeTasksPanelFormLblCaption

function TkwCustomizeTasksPanelFormLblCaption.LblCaption(const aCtx: TtfwContext;
  aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtLabel;
 {-}
begin
 Result := aCustomizeTasksPanelForm.lblCaption;
end;//TkwCustomizeTasksPanelFormLblCaption.LblCaption

procedure TkwCustomizeTasksPanelFormLblCaption.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aCustomizeTasksPanelForm : TCustomizeTasksPanelForm;
begin
 try
  l_aCustomizeTasksPanelForm := TCustomizeTasksPanelForm(aCtx.rEngine.PopObjAs(TCustomizeTasksPanelForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aCustomizeTasksPanelForm: TCustomizeTasksPanelForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((LblCaption(aCtx, l_aCustomizeTasksPanelForm)));
end;//TkwCustomizeTasksPanelFormLblCaption.DoDoIt

class function TkwCustomizeTasksPanelFormLblCaption.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TCustomizeTasksPanelForm.lblCaption';
end;//TkwCustomizeTasksPanelFormLblCaption.GetWordNameForRegister

procedure TkwCustomizeTasksPanelFormLblCaption.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� lblCaption', aCtx);
end;//TkwCustomizeTasksPanelFormLblCaption.SetValuePrim

function TkwCustomizeTasksPanelFormLblCaption.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtLabel);
end;//TkwCustomizeTasksPanelFormLblCaption.GetResultTypeInfo

function TkwCustomizeTasksPanelFormLblCaption.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwCustomizeTasksPanelFormLblCaption.GetAllParamsCount

function TkwCustomizeTasksPanelFormLblCaption.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TCustomizeTasksPanelForm)]);
end;//TkwCustomizeTasksPanelFormLblCaption.ParamsTypes

type
  TkwCustomizeTasksPanelFormEdChange = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .TCustomizeTasksPanelForm.edChange
[panel]������� edChange ����� TCustomizeTasksPanelForm[panel]
*��� ����������:* TvtComboBox
*������:*
[code]
OBJECT VAR l_TvtComboBox
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.edChange >>> l_TvtComboBox
[code]  }
  private
  // private methods
   function EdChange(const aCtx: TtfwContext;
     aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtComboBox;
     {* ���������� ����� ������� .TCustomizeTasksPanelForm.edChange }
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
  end;//TkwCustomizeTasksPanelFormEdChange

// start class TkwCustomizeTasksPanelFormEdChange

function TkwCustomizeTasksPanelFormEdChange.EdChange(const aCtx: TtfwContext;
  aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtComboBox;
 {-}
begin
 Result := aCustomizeTasksPanelForm.edChange;
end;//TkwCustomizeTasksPanelFormEdChange.EdChange

procedure TkwCustomizeTasksPanelFormEdChange.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aCustomizeTasksPanelForm : TCustomizeTasksPanelForm;
begin
 try
  l_aCustomizeTasksPanelForm := TCustomizeTasksPanelForm(aCtx.rEngine.PopObjAs(TCustomizeTasksPanelForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aCustomizeTasksPanelForm: TCustomizeTasksPanelForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((EdChange(aCtx, l_aCustomizeTasksPanelForm)));
end;//TkwCustomizeTasksPanelFormEdChange.DoDoIt

class function TkwCustomizeTasksPanelFormEdChange.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TCustomizeTasksPanelForm.edChange';
end;//TkwCustomizeTasksPanelFormEdChange.GetWordNameForRegister

procedure TkwCustomizeTasksPanelFormEdChange.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� edChange', aCtx);
end;//TkwCustomizeTasksPanelFormEdChange.SetValuePrim

function TkwCustomizeTasksPanelFormEdChange.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtComboBox);
end;//TkwCustomizeTasksPanelFormEdChange.GetResultTypeInfo

function TkwCustomizeTasksPanelFormEdChange.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwCustomizeTasksPanelFormEdChange.GetAllParamsCount

function TkwCustomizeTasksPanelFormEdChange.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TCustomizeTasksPanelForm)]);
end;//TkwCustomizeTasksPanelFormEdChange.ParamsTypes

type
  TkwCustomizeTasksPanelFormCbForAllUseCases = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .TCustomizeTasksPanelForm.cbForAllUseCases
[panel]������� cbForAllUseCases ����� TCustomizeTasksPanelForm[panel]
*��� ����������:* TeeCheckBox
*������:*
[code]
OBJECT VAR l_TeeCheckBox
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.cbForAllUseCases >>> l_TeeCheckBox
[code]  }
  private
  // private methods
   function CbForAllUseCases(const aCtx: TtfwContext;
     aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TeeCheckBox;
     {* ���������� ����� ������� .TCustomizeTasksPanelForm.cbForAllUseCases }
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
  end;//TkwCustomizeTasksPanelFormCbForAllUseCases

// start class TkwCustomizeTasksPanelFormCbForAllUseCases

function TkwCustomizeTasksPanelFormCbForAllUseCases.CbForAllUseCases(const aCtx: TtfwContext;
  aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TeeCheckBox;
 {-}
begin
 Result := aCustomizeTasksPanelForm.cbForAllUseCases;
end;//TkwCustomizeTasksPanelFormCbForAllUseCases.CbForAllUseCases

procedure TkwCustomizeTasksPanelFormCbForAllUseCases.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aCustomizeTasksPanelForm : TCustomizeTasksPanelForm;
begin
 try
  l_aCustomizeTasksPanelForm := TCustomizeTasksPanelForm(aCtx.rEngine.PopObjAs(TCustomizeTasksPanelForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aCustomizeTasksPanelForm: TCustomizeTasksPanelForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((CbForAllUseCases(aCtx, l_aCustomizeTasksPanelForm)));
end;//TkwCustomizeTasksPanelFormCbForAllUseCases.DoDoIt

class function TkwCustomizeTasksPanelFormCbForAllUseCases.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TCustomizeTasksPanelForm.cbForAllUseCases';
end;//TkwCustomizeTasksPanelFormCbForAllUseCases.GetWordNameForRegister

procedure TkwCustomizeTasksPanelFormCbForAllUseCases.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� cbForAllUseCases', aCtx);
end;//TkwCustomizeTasksPanelFormCbForAllUseCases.SetValuePrim

function TkwCustomizeTasksPanelFormCbForAllUseCases.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TeeCheckBox);
end;//TkwCustomizeTasksPanelFormCbForAllUseCases.GetResultTypeInfo

function TkwCustomizeTasksPanelFormCbForAllUseCases.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwCustomizeTasksPanelFormCbForAllUseCases.GetAllParamsCount

function TkwCustomizeTasksPanelFormCbForAllUseCases.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TCustomizeTasksPanelForm)]);
end;//TkwCustomizeTasksPanelFormCbForAllUseCases.ParamsTypes

type
  TkwCustomizeTasksPanelFormBtnChangeItem = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .TCustomizeTasksPanelForm.btnChangeItem
[panel]������� btnChangeItem ����� TCustomizeTasksPanelForm[panel]
*��� ����������:* TeeButton
*������:*
[code]
OBJECT VAR l_TeeButton
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.btnChangeItem >>> l_TeeButton
[code]  }
  private
  // private methods
   function BtnChangeItem(const aCtx: TtfwContext;
     aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TeeButton;
     {* ���������� ����� ������� .TCustomizeTasksPanelForm.btnChangeItem }
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
  end;//TkwCustomizeTasksPanelFormBtnChangeItem

// start class TkwCustomizeTasksPanelFormBtnChangeItem

function TkwCustomizeTasksPanelFormBtnChangeItem.BtnChangeItem(const aCtx: TtfwContext;
  aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TeeButton;
 {-}
begin
 Result := aCustomizeTasksPanelForm.btnChangeItem;
end;//TkwCustomizeTasksPanelFormBtnChangeItem.BtnChangeItem

procedure TkwCustomizeTasksPanelFormBtnChangeItem.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aCustomizeTasksPanelForm : TCustomizeTasksPanelForm;
begin
 try
  l_aCustomizeTasksPanelForm := TCustomizeTasksPanelForm(aCtx.rEngine.PopObjAs(TCustomizeTasksPanelForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aCustomizeTasksPanelForm: TCustomizeTasksPanelForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((BtnChangeItem(aCtx, l_aCustomizeTasksPanelForm)));
end;//TkwCustomizeTasksPanelFormBtnChangeItem.DoDoIt

class function TkwCustomizeTasksPanelFormBtnChangeItem.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TCustomizeTasksPanelForm.btnChangeItem';
end;//TkwCustomizeTasksPanelFormBtnChangeItem.GetWordNameForRegister

procedure TkwCustomizeTasksPanelFormBtnChangeItem.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� btnChangeItem', aCtx);
end;//TkwCustomizeTasksPanelFormBtnChangeItem.SetValuePrim

function TkwCustomizeTasksPanelFormBtnChangeItem.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TeeButton);
end;//TkwCustomizeTasksPanelFormBtnChangeItem.GetResultTypeInfo

function TkwCustomizeTasksPanelFormBtnChangeItem.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwCustomizeTasksPanelFormBtnChangeItem.GetAllParamsCount

function TkwCustomizeTasksPanelFormBtnChangeItem.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TCustomizeTasksPanelForm)]);
end;//TkwCustomizeTasksPanelFormBtnChangeItem.ParamsTypes

type
  TkwCustomizeTasksPanelFormPnlOperationPos = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .TCustomizeTasksPanelForm.pnlOperationPos
[panel]������� pnlOperationPos ����� TCustomizeTasksPanelForm[panel]
*��� ����������:* TvtPanel
*������:*
[code]
OBJECT VAR l_TvtPanel
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.pnlOperationPos >>> l_TvtPanel
[code]  }
  private
  // private methods
   function PnlOperationPos(const aCtx: TtfwContext;
     aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtPanel;
     {* ���������� ����� ������� .TCustomizeTasksPanelForm.pnlOperationPos }
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
  end;//TkwCustomizeTasksPanelFormPnlOperationPos

// start class TkwCustomizeTasksPanelFormPnlOperationPos

function TkwCustomizeTasksPanelFormPnlOperationPos.PnlOperationPos(const aCtx: TtfwContext;
  aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtPanel;
 {-}
begin
 Result := aCustomizeTasksPanelForm.pnlOperationPos;
end;//TkwCustomizeTasksPanelFormPnlOperationPos.PnlOperationPos

procedure TkwCustomizeTasksPanelFormPnlOperationPos.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aCustomizeTasksPanelForm : TCustomizeTasksPanelForm;
begin
 try
  l_aCustomizeTasksPanelForm := TCustomizeTasksPanelForm(aCtx.rEngine.PopObjAs(TCustomizeTasksPanelForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aCustomizeTasksPanelForm: TCustomizeTasksPanelForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((PnlOperationPos(aCtx, l_aCustomizeTasksPanelForm)));
end;//TkwCustomizeTasksPanelFormPnlOperationPos.DoDoIt

class function TkwCustomizeTasksPanelFormPnlOperationPos.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TCustomizeTasksPanelForm.pnlOperationPos';
end;//TkwCustomizeTasksPanelFormPnlOperationPos.GetWordNameForRegister

procedure TkwCustomizeTasksPanelFormPnlOperationPos.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� pnlOperationPos', aCtx);
end;//TkwCustomizeTasksPanelFormPnlOperationPos.SetValuePrim

function TkwCustomizeTasksPanelFormPnlOperationPos.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtPanel);
end;//TkwCustomizeTasksPanelFormPnlOperationPos.GetResultTypeInfo

function TkwCustomizeTasksPanelFormPnlOperationPos.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwCustomizeTasksPanelFormPnlOperationPos.GetAllParamsCount

function TkwCustomizeTasksPanelFormPnlOperationPos.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TCustomizeTasksPanelForm)]);
end;//TkwCustomizeTasksPanelFormPnlOperationPos.ParamsTypes

type
  TkwCustomizeTasksPanelFormUpBitBtn = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .TCustomizeTasksPanelForm.UpBitBtn
[panel]������� UpBitBtn ����� TCustomizeTasksPanelForm[panel]
*��� ����������:* TBitBtn
*������:*
[code]
OBJECT VAR l_TBitBtn
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.UpBitBtn >>> l_TBitBtn
[code]  }
  private
  // private methods
   function UpBitBtn(const aCtx: TtfwContext;
     aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TBitBtn;
     {* ���������� ����� ������� .TCustomizeTasksPanelForm.UpBitBtn }
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
  end;//TkwCustomizeTasksPanelFormUpBitBtn

// start class TkwCustomizeTasksPanelFormUpBitBtn

function TkwCustomizeTasksPanelFormUpBitBtn.UpBitBtn(const aCtx: TtfwContext;
  aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TBitBtn;
 {-}
begin
 Result := aCustomizeTasksPanelForm.UpBitBtn;
end;//TkwCustomizeTasksPanelFormUpBitBtn.UpBitBtn

procedure TkwCustomizeTasksPanelFormUpBitBtn.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aCustomizeTasksPanelForm : TCustomizeTasksPanelForm;
begin
 try
  l_aCustomizeTasksPanelForm := TCustomizeTasksPanelForm(aCtx.rEngine.PopObjAs(TCustomizeTasksPanelForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aCustomizeTasksPanelForm: TCustomizeTasksPanelForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((UpBitBtn(aCtx, l_aCustomizeTasksPanelForm)));
end;//TkwCustomizeTasksPanelFormUpBitBtn.DoDoIt

class function TkwCustomizeTasksPanelFormUpBitBtn.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TCustomizeTasksPanelForm.UpBitBtn';
end;//TkwCustomizeTasksPanelFormUpBitBtn.GetWordNameForRegister

procedure TkwCustomizeTasksPanelFormUpBitBtn.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� UpBitBtn', aCtx);
end;//TkwCustomizeTasksPanelFormUpBitBtn.SetValuePrim

function TkwCustomizeTasksPanelFormUpBitBtn.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TBitBtn);
end;//TkwCustomizeTasksPanelFormUpBitBtn.GetResultTypeInfo

function TkwCustomizeTasksPanelFormUpBitBtn.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwCustomizeTasksPanelFormUpBitBtn.GetAllParamsCount

function TkwCustomizeTasksPanelFormUpBitBtn.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TCustomizeTasksPanelForm)]);
end;//TkwCustomizeTasksPanelFormUpBitBtn.ParamsTypes

type
  TkwCustomizeTasksPanelFormDownBitBtn = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .TCustomizeTasksPanelForm.DownBitBtn
[panel]������� DownBitBtn ����� TCustomizeTasksPanelForm[panel]
*��� ����������:* TBitBtn
*������:*
[code]
OBJECT VAR l_TBitBtn
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.DownBitBtn >>> l_TBitBtn
[code]  }
  private
  // private methods
   function DownBitBtn(const aCtx: TtfwContext;
     aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TBitBtn;
     {* ���������� ����� ������� .TCustomizeTasksPanelForm.DownBitBtn }
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
  end;//TkwCustomizeTasksPanelFormDownBitBtn

// start class TkwCustomizeTasksPanelFormDownBitBtn

function TkwCustomizeTasksPanelFormDownBitBtn.DownBitBtn(const aCtx: TtfwContext;
  aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TBitBtn;
 {-}
begin
 Result := aCustomizeTasksPanelForm.DownBitBtn;
end;//TkwCustomizeTasksPanelFormDownBitBtn.DownBitBtn

procedure TkwCustomizeTasksPanelFormDownBitBtn.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aCustomizeTasksPanelForm : TCustomizeTasksPanelForm;
begin
 try
  l_aCustomizeTasksPanelForm := TCustomizeTasksPanelForm(aCtx.rEngine.PopObjAs(TCustomizeTasksPanelForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aCustomizeTasksPanelForm: TCustomizeTasksPanelForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((DownBitBtn(aCtx, l_aCustomizeTasksPanelForm)));
end;//TkwCustomizeTasksPanelFormDownBitBtn.DoDoIt

class function TkwCustomizeTasksPanelFormDownBitBtn.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TCustomizeTasksPanelForm.DownBitBtn';
end;//TkwCustomizeTasksPanelFormDownBitBtn.GetWordNameForRegister

procedure TkwCustomizeTasksPanelFormDownBitBtn.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� DownBitBtn', aCtx);
end;//TkwCustomizeTasksPanelFormDownBitBtn.SetValuePrim

function TkwCustomizeTasksPanelFormDownBitBtn.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TBitBtn);
end;//TkwCustomizeTasksPanelFormDownBitBtn.GetResultTypeInfo

function TkwCustomizeTasksPanelFormDownBitBtn.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwCustomizeTasksPanelFormDownBitBtn.GetAllParamsCount

function TkwCustomizeTasksPanelFormDownBitBtn.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TCustomizeTasksPanelForm)]);
end;//TkwCustomizeTasksPanelFormDownBitBtn.ParamsTypes
{$IfEnd} //not NoScripts AND not NoVCM

initialization
{$If not defined(NoScripts) AND not defined(NoVCM)}
// ����������� Tkw_Form_CustomizeTasksPanel
 Tkw_Form_CustomizeTasksPanel.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoVCM)}
// ����������� Tkw_CustomizeTasksPanel_Control_spRight
 Tkw_CustomizeTasksPanel_Control_spRight.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoVCM)}
// ����������� Tkw_CustomizeTasksPanel_Control_spRight_Push
 Tkw_CustomizeTasksPanel_Control_spRight_Push.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoVCM)}
// ����������� Tkw_CustomizeTasksPanel_Control_pnlBottom
 Tkw_CustomizeTasksPanel_Control_pnlBottom.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoVCM)}
// ����������� Tkw_CustomizeTasksPanel_Control_pnlBottom_Push
 Tkw_CustomizeTasksPanel_Control_pnlBottom_Push.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoVCM)}
// ����������� Tkw_CustomizeTasksPanel_Control_lblConfirmSave
 Tkw_CustomizeTasksPanel_Control_lblConfirmSave.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoVCM)}
// ����������� Tkw_CustomizeTasksPanel_Control_lblConfirmSave_Push
 Tkw_CustomizeTasksPanel_Control_lblConfirmSave_Push.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoVCM)}
// ����������� Tkw_CustomizeTasksPanel_Control_lblAvailableOpsCaption
 Tkw_CustomizeTasksPanel_Control_lblAvailableOpsCaption.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoVCM)}
// ����������� Tkw_CustomizeTasksPanel_Control_lblAvailableOpsCaption_Push
 Tkw_CustomizeTasksPanel_Control_lblAvailableOpsCaption_Push.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoVCM)}
// ����������� Tkw_CustomizeTasksPanel_Control_btOk
 Tkw_CustomizeTasksPanel_Control_btOk.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoVCM)}
// ����������� Tkw_CustomizeTasksPanel_Control_btOk_Push
 Tkw_CustomizeTasksPanel_Control_btOk_Push.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoVCM)}
// ����������� Tkw_CustomizeTasksPanel_Control_btCancel
 Tkw_CustomizeTasksPanel_Control_btCancel.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoVCM)}
// ����������� Tkw_CustomizeTasksPanel_Control_btCancel_Push
 Tkw_CustomizeTasksPanel_Control_btCancel_Push.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoVCM)}
// ����������� Tkw_CustomizeTasksPanel_Control_btApply
 Tkw_CustomizeTasksPanel_Control_btApply.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoVCM)}
// ����������� Tkw_CustomizeTasksPanel_Control_btApply_Push
 Tkw_CustomizeTasksPanel_Control_btApply_Push.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoVCM)}
// ����������� Tkw_CustomizeTasksPanel_Control_pnlRep
 Tkw_CustomizeTasksPanel_Control_pnlRep.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoVCM)}
// ����������� Tkw_CustomizeTasksPanel_Control_pnlRep_Push
 Tkw_CustomizeTasksPanel_Control_pnlRep_Push.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoVCM)}
// ����������� Tkw_CustomizeTasksPanel_Control_splRep
 Tkw_CustomizeTasksPanel_Control_splRep.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoVCM)}
// ����������� Tkw_CustomizeTasksPanel_Control_splRep_Push
 Tkw_CustomizeTasksPanel_Control_splRep_Push.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoVCM)}
// ����������� Tkw_CustomizeTasksPanel_Control_gbAvailableGroups
 Tkw_CustomizeTasksPanel_Control_gbAvailableGroups.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoVCM)}
// ����������� Tkw_CustomizeTasksPanel_Control_gbAvailableGroups_Push
 Tkw_CustomizeTasksPanel_Control_gbAvailableGroups_Push.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoVCM)}
// ����������� Tkw_CustomizeTasksPanel_Control_tvRepGroups
 Tkw_CustomizeTasksPanel_Control_tvRepGroups.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoVCM)}
// ����������� Tkw_CustomizeTasksPanel_Control_tvRepGroups_Push
 Tkw_CustomizeTasksPanel_Control_tvRepGroups_Push.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoVCM)}
// ����������� Tkw_CustomizeTasksPanel_Control_vtPanel1
 Tkw_CustomizeTasksPanel_Control_vtPanel1.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoVCM)}
// ����������� Tkw_CustomizeTasksPanel_Control_vtPanel1_Push
 Tkw_CustomizeTasksPanel_Control_vtPanel1_Push.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoVCM)}
// ����������� Tkw_CustomizeTasksPanel_Control_cbGroupName
 Tkw_CustomizeTasksPanel_Control_cbGroupName.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoVCM)}
// ����������� Tkw_CustomizeTasksPanel_Control_cbGroupName_Push
 Tkw_CustomizeTasksPanel_Control_cbGroupName_Push.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoVCM)}
// ����������� Tkw_CustomizeTasksPanel_Control_btnAddGroup
 Tkw_CustomizeTasksPanel_Control_btnAddGroup.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoVCM)}
// ����������� Tkw_CustomizeTasksPanel_Control_btnAddGroup_Push
 Tkw_CustomizeTasksPanel_Control_btnAddGroup_Push.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoVCM)}
// ����������� Tkw_CustomizeTasksPanel_Control_btnChangeGroup
 Tkw_CustomizeTasksPanel_Control_btnChangeGroup.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoVCM)}
// ����������� Tkw_CustomizeTasksPanel_Control_btnChangeGroup_Push
 Tkw_CustomizeTasksPanel_Control_btnChangeGroup_Push.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoVCM)}
// ����������� Tkw_CustomizeTasksPanel_Control_btnDeleteGroup
 Tkw_CustomizeTasksPanel_Control_btnDeleteGroup.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoVCM)}
// ����������� Tkw_CustomizeTasksPanel_Control_btnDeleteGroup_Push
 Tkw_CustomizeTasksPanel_Control_btnDeleteGroup_Push.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoVCM)}
// ����������� Tkw_CustomizeTasksPanel_Control_gbAvailableOperations
 Tkw_CustomizeTasksPanel_Control_gbAvailableOperations.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoVCM)}
// ����������� Tkw_CustomizeTasksPanel_Control_gbAvailableOperations_Push
 Tkw_CustomizeTasksPanel_Control_gbAvailableOperations_Push.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoVCM)}
// ����������� Tkw_CustomizeTasksPanel_Control_tvRepOps
 Tkw_CustomizeTasksPanel_Control_tvRepOps.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoVCM)}
// ����������� Tkw_CustomizeTasksPanel_Control_tvRepOps_Push
 Tkw_CustomizeTasksPanel_Control_tvRepOps_Push.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoVCM)}
// ����������� Tkw_CustomizeTasksPanel_Control_pnlForms
 Tkw_CustomizeTasksPanel_Control_pnlForms.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoVCM)}
// ����������� Tkw_CustomizeTasksPanel_Control_pnlForms_Push
 Tkw_CustomizeTasksPanel_Control_pnlForms_Push.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoVCM)}
// ����������� Tkw_CustomizeTasksPanel_Control_lblForms
 Tkw_CustomizeTasksPanel_Control_lblForms.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoVCM)}
// ����������� Tkw_CustomizeTasksPanel_Control_lblForms_Push
 Tkw_CustomizeTasksPanel_Control_lblForms_Push.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoVCM)}
// ����������� Tkw_CustomizeTasksPanel_Control_cbForms
 Tkw_CustomizeTasksPanel_Control_cbForms.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoVCM)}
// ����������� Tkw_CustomizeTasksPanel_Control_cbForms_Push
 Tkw_CustomizeTasksPanel_Control_cbForms_Push.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoVCM)}
// ����������� Tkw_CustomizeTasksPanel_Control_pnlMain
 Tkw_CustomizeTasksPanel_Control_pnlMain.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoVCM)}
// ����������� Tkw_CustomizeTasksPanel_Control_pnlMain_Push
 Tkw_CustomizeTasksPanel_Control_pnlMain_Push.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoVCM)}
// ����������� Tkw_CustomizeTasksPanel_Control_pnlLeft
 Tkw_CustomizeTasksPanel_Control_pnlLeft.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoVCM)}
// ����������� Tkw_CustomizeTasksPanel_Control_pnlLeft_Push
 Tkw_CustomizeTasksPanel_Control_pnlLeft_Push.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoVCM)}
// ����������� Tkw_CustomizeTasksPanel_Control_btnMoveOpToPanel
 Tkw_CustomizeTasksPanel_Control_btnMoveOpToPanel.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoVCM)}
// ����������� Tkw_CustomizeTasksPanel_Control_btnMoveOpToPanel_Push
 Tkw_CustomizeTasksPanel_Control_btnMoveOpToPanel_Push.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoVCM)}
// ����������� Tkw_CustomizeTasksPanel_Control_btnMoveOpToRep
 Tkw_CustomizeTasksPanel_Control_btnMoveOpToRep.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoVCM)}
// ����������� Tkw_CustomizeTasksPanel_Control_btnMoveOpToRep_Push
 Tkw_CustomizeTasksPanel_Control_btnMoveOpToRep_Push.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoVCM)}
// ����������� Tkw_CustomizeTasksPanel_Control_btnMoveGroupToPanel
 Tkw_CustomizeTasksPanel_Control_btnMoveGroupToPanel.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoVCM)}
// ����������� Tkw_CustomizeTasksPanel_Control_btnMoveGroupToPanel_Push
 Tkw_CustomizeTasksPanel_Control_btnMoveGroupToPanel_Push.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoVCM)}
// ����������� Tkw_CustomizeTasksPanel_Control_btnMoveGroupToRep
 Tkw_CustomizeTasksPanel_Control_btnMoveGroupToRep.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoVCM)}
// ����������� Tkw_CustomizeTasksPanel_Control_btnMoveGroupToRep_Push
 Tkw_CustomizeTasksPanel_Control_btnMoveGroupToRep_Push.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoVCM)}
// ����������� Tkw_CustomizeTasksPanel_Control_pnlTasksPanel
 Tkw_CustomizeTasksPanel_Control_pnlTasksPanel.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoVCM)}
// ����������� Tkw_CustomizeTasksPanel_Control_pnlTasksPanel_Push
 Tkw_CustomizeTasksPanel_Control_pnlTasksPanel_Push.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoVCM)}
// ����������� Tkw_CustomizeTasksPanel_Control_gbTasksPanel
 Tkw_CustomizeTasksPanel_Control_gbTasksPanel.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoVCM)}
// ����������� Tkw_CustomizeTasksPanel_Control_gbTasksPanel_Push
 Tkw_CustomizeTasksPanel_Control_gbTasksPanel_Push.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoVCM)}
// ����������� Tkw_CustomizeTasksPanel_Control_tvTasksPanel
 Tkw_CustomizeTasksPanel_Control_tvTasksPanel.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoVCM)}
// ����������� Tkw_CustomizeTasksPanel_Control_tvTasksPanel_Push
 Tkw_CustomizeTasksPanel_Control_tvTasksPanel_Push.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoVCM)}
// ����������� Tkw_CustomizeTasksPanel_Control_vtGroupBox3
 Tkw_CustomizeTasksPanel_Control_vtGroupBox3.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoVCM)}
// ����������� Tkw_CustomizeTasksPanel_Control_vtGroupBox3_Push
 Tkw_CustomizeTasksPanel_Control_vtGroupBox3_Push.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoVCM)}
// ����������� Tkw_CustomizeTasksPanel_Control_lblCaption
 Tkw_CustomizeTasksPanel_Control_lblCaption.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoVCM)}
// ����������� Tkw_CustomizeTasksPanel_Control_lblCaption_Push
 Tkw_CustomizeTasksPanel_Control_lblCaption_Push.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoVCM)}
// ����������� Tkw_CustomizeTasksPanel_Control_edChange
 Tkw_CustomizeTasksPanel_Control_edChange.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoVCM)}
// ����������� Tkw_CustomizeTasksPanel_Control_edChange_Push
 Tkw_CustomizeTasksPanel_Control_edChange_Push.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoVCM)}
// ����������� Tkw_CustomizeTasksPanel_Control_cbForAllUseCases
 Tkw_CustomizeTasksPanel_Control_cbForAllUseCases.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoVCM)}
// ����������� Tkw_CustomizeTasksPanel_Control_cbForAllUseCases_Push
 Tkw_CustomizeTasksPanel_Control_cbForAllUseCases_Push.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoVCM)}
// ����������� Tkw_CustomizeTasksPanel_Control_btnChangeItem
 Tkw_CustomizeTasksPanel_Control_btnChangeItem.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoVCM)}
// ����������� Tkw_CustomizeTasksPanel_Control_btnChangeItem_Push
 Tkw_CustomizeTasksPanel_Control_btnChangeItem_Push.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoVCM)}
// ����������� Tkw_CustomizeTasksPanel_Control_pnlOperationPos
 Tkw_CustomizeTasksPanel_Control_pnlOperationPos.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoVCM)}
// ����������� Tkw_CustomizeTasksPanel_Control_pnlOperationPos_Push
 Tkw_CustomizeTasksPanel_Control_pnlOperationPos_Push.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoVCM)}
// ����������� Tkw_CustomizeTasksPanel_Control_UpBitBtn
 Tkw_CustomizeTasksPanel_Control_UpBitBtn.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoVCM)}
// ����������� Tkw_CustomizeTasksPanel_Control_UpBitBtn_Push
 Tkw_CustomizeTasksPanel_Control_UpBitBtn_Push.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoVCM)}
// ����������� Tkw_CustomizeTasksPanel_Control_DownBitBtn
 Tkw_CustomizeTasksPanel_Control_DownBitBtn.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoVCM)}
// ����������� Tkw_CustomizeTasksPanel_Control_DownBitBtn_Push
 Tkw_CustomizeTasksPanel_Control_DownBitBtn_Push.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoVCM)}
// ����������� CustomizeTasksPanelForm_spRight
 TkwCustomizeTasksPanelFormSpRight.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoVCM)}
// ����������� CustomizeTasksPanelForm_pnlBottom
 TkwCustomizeTasksPanelFormPnlBottom.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoVCM)}
// ����������� CustomizeTasksPanelForm_lblConfirmSave
 TkwCustomizeTasksPanelFormLblConfirmSave.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoVCM)}
// ����������� CustomizeTasksPanelForm_lblAvailableOpsCaption
 TkwCustomizeTasksPanelFormLblAvailableOpsCaption.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoVCM)}
// ����������� CustomizeTasksPanelForm_btOk
 TkwCustomizeTasksPanelFormBtOk.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoVCM)}
// ����������� CustomizeTasksPanelForm_btCancel
 TkwCustomizeTasksPanelFormBtCancel.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoVCM)}
// ����������� CustomizeTasksPanelForm_btApply
 TkwCustomizeTasksPanelFormBtApply.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoVCM)}
// ����������� CustomizeTasksPanelForm_pnlRep
 TkwCustomizeTasksPanelFormPnlRep.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoVCM)}
// ����������� CustomizeTasksPanelForm_splRep
 TkwCustomizeTasksPanelFormSplRep.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoVCM)}
// ����������� CustomizeTasksPanelForm_gbAvailableGroups
 TkwCustomizeTasksPanelFormGbAvailableGroups.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoVCM)}
// ����������� CustomizeTasksPanelForm_tvRepGroups
 TkwCustomizeTasksPanelFormTvRepGroups.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoVCM)}
// ����������� CustomizeTasksPanelForm_vtPanel1
 TkwCustomizeTasksPanelFormVtPanel1.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoVCM)}
// ����������� CustomizeTasksPanelForm_cbGroupName
 TkwCustomizeTasksPanelFormCbGroupName.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoVCM)}
// ����������� CustomizeTasksPanelForm_btnAddGroup
 TkwCustomizeTasksPanelFormBtnAddGroup.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoVCM)}
// ����������� CustomizeTasksPanelForm_btnChangeGroup
 TkwCustomizeTasksPanelFormBtnChangeGroup.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoVCM)}
// ����������� CustomizeTasksPanelForm_btnDeleteGroup
 TkwCustomizeTasksPanelFormBtnDeleteGroup.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoVCM)}
// ����������� CustomizeTasksPanelForm_gbAvailableOperations
 TkwCustomizeTasksPanelFormGbAvailableOperations.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoVCM)}
// ����������� CustomizeTasksPanelForm_tvRepOps
 TkwCustomizeTasksPanelFormTvRepOps.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoVCM)}
// ����������� CustomizeTasksPanelForm_pnlForms
 TkwCustomizeTasksPanelFormPnlForms.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoVCM)}
// ����������� CustomizeTasksPanelForm_lblForms
 TkwCustomizeTasksPanelFormLblForms.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoVCM)}
// ����������� CustomizeTasksPanelForm_cbForms
 TkwCustomizeTasksPanelFormCbForms.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoVCM)}
// ����������� CustomizeTasksPanelForm_pnlMain
 TkwCustomizeTasksPanelFormPnlMain.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoVCM)}
// ����������� CustomizeTasksPanelForm_pnlLeft
 TkwCustomizeTasksPanelFormPnlLeft.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoVCM)}
// ����������� CustomizeTasksPanelForm_btnMoveOpToPanel
 TkwCustomizeTasksPanelFormBtnMoveOpToPanel.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoVCM)}
// ����������� CustomizeTasksPanelForm_btnMoveOpToRep
 TkwCustomizeTasksPanelFormBtnMoveOpToRep.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoVCM)}
// ����������� CustomizeTasksPanelForm_btnMoveGroupToPanel
 TkwCustomizeTasksPanelFormBtnMoveGroupToPanel.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoVCM)}
// ����������� CustomizeTasksPanelForm_btnMoveGroupToRep
 TkwCustomizeTasksPanelFormBtnMoveGroupToRep.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoVCM)}
// ����������� CustomizeTasksPanelForm_pnlTasksPanel
 TkwCustomizeTasksPanelFormPnlTasksPanel.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoVCM)}
// ����������� CustomizeTasksPanelForm_gbTasksPanel
 TkwCustomizeTasksPanelFormGbTasksPanel.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoVCM)}
// ����������� CustomizeTasksPanelForm_tvTasksPanel
 TkwCustomizeTasksPanelFormTvTasksPanel.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoVCM)}
// ����������� CustomizeTasksPanelForm_vtGroupBox3
 TkwCustomizeTasksPanelFormVtGroupBox3.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoVCM)}
// ����������� CustomizeTasksPanelForm_lblCaption
 TkwCustomizeTasksPanelFormLblCaption.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoVCM)}
// ����������� CustomizeTasksPanelForm_edChange
 TkwCustomizeTasksPanelFormEdChange.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoVCM)}
// ����������� CustomizeTasksPanelForm_cbForAllUseCases
 TkwCustomizeTasksPanelFormCbForAllUseCases.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoVCM)}
// ����������� CustomizeTasksPanelForm_btnChangeItem
 TkwCustomizeTasksPanelFormBtnChangeItem.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoVCM)}
// ����������� CustomizeTasksPanelForm_pnlOperationPos
 TkwCustomizeTasksPanelFormPnlOperationPos.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoVCM)}
// ����������� CustomizeTasksPanelForm_UpBitBtn
 TkwCustomizeTasksPanelFormUpBitBtn.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoVCM)}
// ����������� CustomizeTasksPanelForm_DownBitBtn
 TkwCustomizeTasksPanelFormDownBitBtn.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoVCM)}
// ����������� ���� TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //not NoScripts AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoVCM)}
// ����������� ���� CustomizeTasksPanel
 TtfwTypeRegistrator.RegisterType(TypeInfo(TCustomizeTasksPanelForm));
{$IfEnd} //not NoScripts AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoVCM)}
// ����������� ���� TvtSplitter
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtSplitter));
{$IfEnd} //not NoScripts AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoVCM)}
// ����������� ���� TvtPanel
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
{$IfEnd} //not NoScripts AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoVCM)}
// ����������� ���� TvtLabel
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtLabel));
{$IfEnd} //not NoScripts AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoVCM)}
// ����������� ���� TvtButton
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtButton));
{$IfEnd} //not NoScripts AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoVCM)}
// ����������� ���� TvtGroupBox
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtGroupBox));
{$IfEnd} //not NoScripts AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoVCM)}
// ����������� ���� TeeTreeView
 TtfwTypeRegistrator.RegisterType(TypeInfo(TeeTreeView));
{$IfEnd} //not NoScripts AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoVCM)}
// ����������� ���� TvtComboBox
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtComboBox));
{$IfEnd} //not NoScripts AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoVCM)}
// ����������� ���� TeeButton
 TtfwTypeRegistrator.RegisterType(TypeInfo(TeeButton));
{$IfEnd} //not NoScripts AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoVCM)}
// ����������� ���� TComboBox
 TtfwTypeRegistrator.RegisterType(TypeInfo(TComboBox));
{$IfEnd} //not NoScripts AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoVCM)}
// ����������� ���� TBitBtn
 TtfwTypeRegistrator.RegisterType(TypeInfo(TBitBtn));
{$IfEnd} //not NoScripts AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoVCM)}
// ����������� ���� TeeCheckBox
 TtfwTypeRegistrator.RegisterType(TypeInfo(TeeCheckBox));
{$IfEnd} //not NoScripts AND not NoVCM

end.