unit PageSetupKeywordsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View$For F1 and Monitorings"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/Search/PageSetupKeywordsPack.pas"
// �����: 10.09.2009 21:03
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<ScriptKeywordsPack::Class>> F1 Common For Shell And Monitoring::Search::View$For F1 and Monitorings::Search$Presentation for F1 and Monitorings::CommonSearch::PageSetupKeywordsPack
//
// ����� ���� ������� ��� ������� � ����������� ��������� ����� PageSetup
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(NoScripts)}
uses
  PageSetup_Form,
  vtGroupBox
  {$If defined(Nemesis)}
  ,
  nscPageControl
  {$IfEnd} //Nemesis
  ,
  tfwScriptingInterfaces
  {$If not defined(NoScripts) AND not defined(NoVCL)}
  ,
  kwBynameControlPush
  {$IfEnd} //not NoScripts AND not NoVCL
  ,
  tfwControlString,
  tfwPropertyLike
  ;

{$IfEnd} //not Admin AND not NoScripts

implementation

{$If not defined(Admin) AND not defined(NoScripts)}
uses
  TtfwClassRef_Proxy,
  tfwScriptingTypes,
  TypInfo,
  SysUtils,
  tfwTypeRegistrator
  ;

type
  Tkw_Form_PageSetup = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� ����� PageSetup
----
*������ �������������*:
[code]
'aControl' �����::PageSetup TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_Form_PageSetup

// start class Tkw_Form_PageSetup

class function Tkw_Form_PageSetup.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�����::PageSetup';
end;//Tkw_Form_PageSetup.GetWordNameForRegister

function Tkw_Form_PageSetup.GetString: AnsiString;
 {-}
begin
 Result := 'en_PageSetup';
end;//Tkw_Form_PageSetup.GetString

class procedure Tkw_Form_PageSetup.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(Ten_PageSetup);
end;//Tkw_Form_PageSetup.RegisterInEngine

type
  Tkw_PageSetup_Control_PreviewGroupBox = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� PreviewGroupBox
----
*������ �������������*:
[code]
�������::PreviewGroupBox TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_PageSetup_Control_PreviewGroupBox

// start class Tkw_PageSetup_Control_PreviewGroupBox

class function Tkw_PageSetup_Control_PreviewGroupBox.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::PreviewGroupBox';
end;//Tkw_PageSetup_Control_PreviewGroupBox.GetWordNameForRegister

function Tkw_PageSetup_Control_PreviewGroupBox.GetString: AnsiString;
 {-}
begin
 Result := 'PreviewGroupBox';
end;//Tkw_PageSetup_Control_PreviewGroupBox.GetString

class procedure Tkw_PageSetup_Control_PreviewGroupBox.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtGroupBox);
end;//Tkw_PageSetup_Control_PreviewGroupBox.RegisterInEngine

type
  Tkw_PageSetup_Control_PreviewGroupBox_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� PreviewGroupBox
----
*������ �������������*:
[code]
�������::PreviewGroupBox:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_PageSetup_Control_PreviewGroupBox_Push

// start class Tkw_PageSetup_Control_PreviewGroupBox_Push

procedure Tkw_PageSetup_Control_PreviewGroupBox_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('PreviewGroupBox');
 inherited;
end;//Tkw_PageSetup_Control_PreviewGroupBox_Push.DoDoIt

class function Tkw_PageSetup_Control_PreviewGroupBox_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::PreviewGroupBox:push';
end;//Tkw_PageSetup_Control_PreviewGroupBox_Push.GetWordNameForRegister

type
  Tkw_PageSetup_Control_SettingsPageControl = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� SettingsPageControl
----
*������ �������������*:
[code]
�������::SettingsPageControl TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_PageSetup_Control_SettingsPageControl

// start class Tkw_PageSetup_Control_SettingsPageControl

class function Tkw_PageSetup_Control_SettingsPageControl.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::SettingsPageControl';
end;//Tkw_PageSetup_Control_SettingsPageControl.GetWordNameForRegister

function Tkw_PageSetup_Control_SettingsPageControl.GetString: AnsiString;
 {-}
begin
 Result := 'SettingsPageControl';
end;//Tkw_PageSetup_Control_SettingsPageControl.GetString

class procedure Tkw_PageSetup_Control_SettingsPageControl.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TnscPageControl);
end;//Tkw_PageSetup_Control_SettingsPageControl.RegisterInEngine

type
  Tkw_PageSetup_Control_SettingsPageControl_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� SettingsPageControl
----
*������ �������������*:
[code]
�������::SettingsPageControl:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_PageSetup_Control_SettingsPageControl_Push

// start class Tkw_PageSetup_Control_SettingsPageControl_Push

procedure Tkw_PageSetup_Control_SettingsPageControl_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('SettingsPageControl');
 inherited;
end;//Tkw_PageSetup_Control_SettingsPageControl_Push.DoDoIt

class function Tkw_PageSetup_Control_SettingsPageControl_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::SettingsPageControl:push';
end;//Tkw_PageSetup_Control_SettingsPageControl_Push.GetWordNameForRegister

type
  TkwEnPageSetupPreviewGroupBox = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .Ten_PageSetup.PreviewGroupBox
[panel]������� PreviewGroupBox ����� Ten_PageSetup[panel]
*��� ����������:* TvtGroupBox
*������:*
[code]
OBJECT VAR l_TvtGroupBox
 aen_PageSetup .Ten_PageSetup.PreviewGroupBox >>> l_TvtGroupBox
[code]  }
  private
  // private methods
   function PreviewGroupBox(const aCtx: TtfwContext;
     aen_PageSetup: Ten_PageSetup): TvtGroupBox;
     {* ���������� ����� ������� .Ten_PageSetup.PreviewGroupBox }
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
  end;//TkwEnPageSetupPreviewGroupBox

// start class TkwEnPageSetupPreviewGroupBox

function TkwEnPageSetupPreviewGroupBox.PreviewGroupBox(const aCtx: TtfwContext;
  aen_PageSetup: Ten_PageSetup): TvtGroupBox;
 {-}
begin
 Result := aen_PageSetup.PreviewGroupBox;
end;//TkwEnPageSetupPreviewGroupBox.PreviewGroupBox

procedure TkwEnPageSetupPreviewGroupBox.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aen_PageSetup : Ten_PageSetup;
begin
 try
  l_aen_PageSetup := Ten_PageSetup(aCtx.rEngine.PopObjAs(Ten_PageSetup));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aen_PageSetup: Ten_PageSetup : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((PreviewGroupBox(aCtx, l_aen_PageSetup)));
end;//TkwEnPageSetupPreviewGroupBox.DoDoIt

class function TkwEnPageSetupPreviewGroupBox.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.Ten_PageSetup.PreviewGroupBox';
end;//TkwEnPageSetupPreviewGroupBox.GetWordNameForRegister

procedure TkwEnPageSetupPreviewGroupBox.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� PreviewGroupBox', aCtx);
end;//TkwEnPageSetupPreviewGroupBox.SetValuePrim

function TkwEnPageSetupPreviewGroupBox.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtGroupBox);
end;//TkwEnPageSetupPreviewGroupBox.GetResultTypeInfo

function TkwEnPageSetupPreviewGroupBox.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEnPageSetupPreviewGroupBox.GetAllParamsCount

function TkwEnPageSetupPreviewGroupBox.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_PageSetup)]);
end;//TkwEnPageSetupPreviewGroupBox.ParamsTypes

type
  TkwEnPageSetupSettingsPageControl = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .Ten_PageSetup.SettingsPageControl
[panel]������� SettingsPageControl ����� Ten_PageSetup[panel]
*��� ����������:* TnscPageControl
*������:*
[code]
OBJECT VAR l_TnscPageControl
 aen_PageSetup .Ten_PageSetup.SettingsPageControl >>> l_TnscPageControl
[code]  }
  private
  // private methods
   function SettingsPageControl(const aCtx: TtfwContext;
     aen_PageSetup: Ten_PageSetup): TnscPageControl;
     {* ���������� ����� ������� .Ten_PageSetup.SettingsPageControl }
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
  end;//TkwEnPageSetupSettingsPageControl

// start class TkwEnPageSetupSettingsPageControl

function TkwEnPageSetupSettingsPageControl.SettingsPageControl(const aCtx: TtfwContext;
  aen_PageSetup: Ten_PageSetup): TnscPageControl;
 {-}
begin
 Result := aen_PageSetup.SettingsPageControl;
end;//TkwEnPageSetupSettingsPageControl.SettingsPageControl

procedure TkwEnPageSetupSettingsPageControl.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aen_PageSetup : Ten_PageSetup;
begin
 try
  l_aen_PageSetup := Ten_PageSetup(aCtx.rEngine.PopObjAs(Ten_PageSetup));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aen_PageSetup: Ten_PageSetup : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((SettingsPageControl(aCtx, l_aen_PageSetup)));
end;//TkwEnPageSetupSettingsPageControl.DoDoIt

class function TkwEnPageSetupSettingsPageControl.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.Ten_PageSetup.SettingsPageControl';
end;//TkwEnPageSetupSettingsPageControl.GetWordNameForRegister

procedure TkwEnPageSetupSettingsPageControl.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� SettingsPageControl', aCtx);
end;//TkwEnPageSetupSettingsPageControl.SetValuePrim

function TkwEnPageSetupSettingsPageControl.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TnscPageControl);
end;//TkwEnPageSetupSettingsPageControl.GetResultTypeInfo

function TkwEnPageSetupSettingsPageControl.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEnPageSetupSettingsPageControl.GetAllParamsCount

function TkwEnPageSetupSettingsPageControl.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_PageSetup)]);
end;//TkwEnPageSetupSettingsPageControl.ParamsTypes
{$IfEnd} //not Admin AND not NoScripts

initialization
{$If not defined(Admin) AND not defined(NoScripts)}
// ����������� Tkw_Form_PageSetup
 Tkw_Form_PageSetup.RegisterInEngine;
{$IfEnd} //not Admin AND not NoScripts
{$If not defined(Admin) AND not defined(NoScripts)}
// ����������� Tkw_PageSetup_Control_PreviewGroupBox
 Tkw_PageSetup_Control_PreviewGroupBox.RegisterInEngine;
{$IfEnd} //not Admin AND not NoScripts
{$If not defined(Admin) AND not defined(NoScripts)}
// ����������� Tkw_PageSetup_Control_PreviewGroupBox_Push
 Tkw_PageSetup_Control_PreviewGroupBox_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not NoScripts
{$If not defined(Admin) AND not defined(NoScripts)}
// ����������� Tkw_PageSetup_Control_SettingsPageControl
 Tkw_PageSetup_Control_SettingsPageControl.RegisterInEngine;
{$IfEnd} //not Admin AND not NoScripts
{$If not defined(Admin) AND not defined(NoScripts)}
// ����������� Tkw_PageSetup_Control_SettingsPageControl_Push
 Tkw_PageSetup_Control_SettingsPageControl_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not NoScripts
{$If not defined(Admin) AND not defined(NoScripts)}
// ����������� en_PageSetup_PreviewGroupBox
 TkwEnPageSetupPreviewGroupBox.RegisterInEngine;
{$IfEnd} //not Admin AND not NoScripts
{$If not defined(Admin) AND not defined(NoScripts)}
// ����������� en_PageSetup_SettingsPageControl
 TkwEnPageSetupSettingsPageControl.RegisterInEngine;
{$IfEnd} //not Admin AND not NoScripts
{$If not defined(Admin) AND not defined(NoScripts)}
// ����������� ���� TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //not Admin AND not NoScripts
{$If not defined(Admin) AND not defined(NoScripts)}
// ����������� ���� PageSetup
 TtfwTypeRegistrator.RegisterType(TypeInfo(Ten_PageSetup));
{$IfEnd} //not Admin AND not NoScripts
{$If not defined(Admin) AND not defined(NoScripts)}
// ����������� ���� TvtGroupBox
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtGroupBox));
{$IfEnd} //not Admin AND not NoScripts
{$If not defined(Admin) AND not defined(NoScripts)}
// ����������� ���� TnscPageControl
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscPageControl));
{$IfEnd} //not Admin AND not NoScripts

end.