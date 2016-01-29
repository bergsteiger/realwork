unit AdminFormKeywordsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/Admin/AdminFormKeywordsPack.pas"
// �����: 07.09.2009 18:00
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<ScriptKeywordsPack::Class>> F1 �������������::Admin::View::Admin::Admin::AdminFormKeywordsPack
//
// ����� ���� ������� ��� ������� � ����������� ��������� ����� AdminForm
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If defined(Admin) AND not defined(NoScripts)}
uses
  vtSizeablePanel,
  vtPanel,
  vtProportionalPanel,
  Admin_Form,
  tfwScriptingInterfaces
  {$If not defined(NoScripts) AND not defined(NoVCL)}
  ,
  kwBynameControlPush
  {$IfEnd} //not NoScripts AND not NoVCL
  ,
  tfwControlString,
  tfwPropertyLike
  ;

{$IfEnd} //Admin AND not NoScripts

implementation

{$If defined(Admin) AND not defined(NoScripts)}
uses
  TtfwClassRef_Proxy,
  tfwScriptingTypes,
  TypInfo,
  SysUtils,
  tfwTypeRegistrator
  ;

type
  Tkw_Form_AdminForm = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� ����� AdminForm
----
*������ �������������*:
[code]
'aControl' �����::AdminForm TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
  end;//Tkw_Form_AdminForm

// start class Tkw_Form_AdminForm

class function Tkw_Form_AdminForm.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�����::AdminForm';
end;//Tkw_Form_AdminForm.GetWordNameForRegister

function Tkw_Form_AdminForm.GetString: AnsiString;
 {-}
begin
 Result := 'cfAdminForm';
end;//Tkw_Form_AdminForm.GetString

type
  Tkw_AdminForm_Control_BackgroundPanel = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� BackgroundPanel
----
*������ �������������*:
[code]
�������::BackgroundPanel TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_AdminForm_Control_BackgroundPanel

// start class Tkw_AdminForm_Control_BackgroundPanel

class function Tkw_AdminForm_Control_BackgroundPanel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::BackgroundPanel';
end;//Tkw_AdminForm_Control_BackgroundPanel.GetWordNameForRegister

function Tkw_AdminForm_Control_BackgroundPanel.GetString: AnsiString;
 {-}
begin
 Result := 'BackgroundPanel';
end;//Tkw_AdminForm_Control_BackgroundPanel.GetString

class procedure Tkw_AdminForm_Control_BackgroundPanel.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtProportionalPanel);
end;//Tkw_AdminForm_Control_BackgroundPanel.RegisterInEngine

type
  Tkw_AdminForm_Control_BackgroundPanel_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� BackgroundPanel
----
*������ �������������*:
[code]
�������::BackgroundPanel:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_AdminForm_Control_BackgroundPanel_Push

// start class Tkw_AdminForm_Control_BackgroundPanel_Push

procedure Tkw_AdminForm_Control_BackgroundPanel_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('BackgroundPanel');
 inherited;
end;//Tkw_AdminForm_Control_BackgroundPanel_Push.DoDoIt

class function Tkw_AdminForm_Control_BackgroundPanel_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::BackgroundPanel:push';
end;//Tkw_AdminForm_Control_BackgroundPanel_Push.GetWordNameForRegister

type
  Tkw_AdminForm_Control_PropertyZone = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� PropertyZone
----
*������ �������������*:
[code]
�������::PropertyZone TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_AdminForm_Control_PropertyZone

// start class Tkw_AdminForm_Control_PropertyZone

class function Tkw_AdminForm_Control_PropertyZone.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::PropertyZone';
end;//Tkw_AdminForm_Control_PropertyZone.GetWordNameForRegister

function Tkw_AdminForm_Control_PropertyZone.GetString: AnsiString;
 {-}
begin
 Result := 'PropertyZone';
end;//Tkw_AdminForm_Control_PropertyZone.GetString

class procedure Tkw_AdminForm_Control_PropertyZone.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtSizeablePanel);
end;//Tkw_AdminForm_Control_PropertyZone.RegisterInEngine

type
  Tkw_AdminForm_Control_PropertyZone_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� PropertyZone
----
*������ �������������*:
[code]
�������::PropertyZone:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_AdminForm_Control_PropertyZone_Push

// start class Tkw_AdminForm_Control_PropertyZone_Push

procedure Tkw_AdminForm_Control_PropertyZone_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('PropertyZone');
 inherited;
end;//Tkw_AdminForm_Control_PropertyZone_Push.DoDoIt

class function Tkw_AdminForm_Control_PropertyZone_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::PropertyZone:push';
end;//Tkw_AdminForm_Control_PropertyZone_Push.GetWordNameForRegister

type
  Tkw_AdminForm_Control_TreeZone = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� TreeZone
----
*������ �������������*:
[code]
�������::TreeZone TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_AdminForm_Control_TreeZone

// start class Tkw_AdminForm_Control_TreeZone

class function Tkw_AdminForm_Control_TreeZone.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::TreeZone';
end;//Tkw_AdminForm_Control_TreeZone.GetWordNameForRegister

function Tkw_AdminForm_Control_TreeZone.GetString: AnsiString;
 {-}
begin
 Result := 'TreeZone';
end;//Tkw_AdminForm_Control_TreeZone.GetString

class procedure Tkw_AdminForm_Control_TreeZone.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_AdminForm_Control_TreeZone.RegisterInEngine

type
  Tkw_AdminForm_Control_TreeZone_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� TreeZone
----
*������ �������������*:
[code]
�������::TreeZone:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_AdminForm_Control_TreeZone_Push

// start class Tkw_AdminForm_Control_TreeZone_Push

procedure Tkw_AdminForm_Control_TreeZone_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('TreeZone');
 inherited;
end;//Tkw_AdminForm_Control_TreeZone_Push.DoDoIt

class function Tkw_AdminForm_Control_TreeZone_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::TreeZone:push';
end;//Tkw_AdminForm_Control_TreeZone_Push.GetWordNameForRegister

type
  TkwCfAdminFormBackgroundPanel = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .TcfAdminForm.BackgroundPanel
[panel]������� BackgroundPanel ����� TcfAdminForm[panel]
*��� ����������:* TvtProportionalPanel
*������:*
[code]
OBJECT VAR l_TvtProportionalPanel
 acfAdminForm .TcfAdminForm.BackgroundPanel >>> l_TvtProportionalPanel
[code]  }
  private
  // private methods
   function BackgroundPanel(const aCtx: TtfwContext;
     acfAdminForm: TcfAdminForm): TvtProportionalPanel;
     {* ���������� ����� ������� .TcfAdminForm.BackgroundPanel }
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
  end;//TkwCfAdminFormBackgroundPanel

// start class TkwCfAdminFormBackgroundPanel

function TkwCfAdminFormBackgroundPanel.BackgroundPanel(const aCtx: TtfwContext;
  acfAdminForm: TcfAdminForm): TvtProportionalPanel;
 {-}
begin
 Result := acfAdminForm.BackgroundPanel;
end;//TkwCfAdminFormBackgroundPanel.BackgroundPanel

procedure TkwCfAdminFormBackgroundPanel.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_acfAdminForm : TcfAdminForm;
begin
 try
  l_acfAdminForm := TcfAdminForm(aCtx.rEngine.PopObjAs(TcfAdminForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� acfAdminForm: TcfAdminForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((BackgroundPanel(aCtx, l_acfAdminForm)));
end;//TkwCfAdminFormBackgroundPanel.DoDoIt

class function TkwCfAdminFormBackgroundPanel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TcfAdminForm.BackgroundPanel';
end;//TkwCfAdminFormBackgroundPanel.GetWordNameForRegister

procedure TkwCfAdminFormBackgroundPanel.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� BackgroundPanel', aCtx);
end;//TkwCfAdminFormBackgroundPanel.SetValuePrim

function TkwCfAdminFormBackgroundPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtProportionalPanel);
end;//TkwCfAdminFormBackgroundPanel.GetResultTypeInfo

function TkwCfAdminFormBackgroundPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwCfAdminFormBackgroundPanel.GetAllParamsCount

function TkwCfAdminFormBackgroundPanel.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TcfAdminForm)]);
end;//TkwCfAdminFormBackgroundPanel.ParamsTypes

type
  TkwCfAdminFormPropertyZone = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .TcfAdminForm.PropertyZone
[panel]������� PropertyZone ����� TcfAdminForm[panel]
*��� ����������:* TvtSizeablePanel
*������:*
[code]
OBJECT VAR l_TvtSizeablePanel
 acfAdminForm .TcfAdminForm.PropertyZone >>> l_TvtSizeablePanel
[code]  }
  private
  // private methods
   function PropertyZone(const aCtx: TtfwContext;
     acfAdminForm: TcfAdminForm): TvtSizeablePanel;
     {* ���������� ����� ������� .TcfAdminForm.PropertyZone }
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
  end;//TkwCfAdminFormPropertyZone

// start class TkwCfAdminFormPropertyZone

function TkwCfAdminFormPropertyZone.PropertyZone(const aCtx: TtfwContext;
  acfAdminForm: TcfAdminForm): TvtSizeablePanel;
 {-}
begin
 Result := acfAdminForm.PropertyZone;
end;//TkwCfAdminFormPropertyZone.PropertyZone

procedure TkwCfAdminFormPropertyZone.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_acfAdminForm : TcfAdminForm;
begin
 try
  l_acfAdminForm := TcfAdminForm(aCtx.rEngine.PopObjAs(TcfAdminForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� acfAdminForm: TcfAdminForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((PropertyZone(aCtx, l_acfAdminForm)));
end;//TkwCfAdminFormPropertyZone.DoDoIt

class function TkwCfAdminFormPropertyZone.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TcfAdminForm.PropertyZone';
end;//TkwCfAdminFormPropertyZone.GetWordNameForRegister

procedure TkwCfAdminFormPropertyZone.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� PropertyZone', aCtx);
end;//TkwCfAdminFormPropertyZone.SetValuePrim

function TkwCfAdminFormPropertyZone.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtSizeablePanel);
end;//TkwCfAdminFormPropertyZone.GetResultTypeInfo

function TkwCfAdminFormPropertyZone.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwCfAdminFormPropertyZone.GetAllParamsCount

function TkwCfAdminFormPropertyZone.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TcfAdminForm)]);
end;//TkwCfAdminFormPropertyZone.ParamsTypes

type
  TkwCfAdminFormTreeZone = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .TcfAdminForm.TreeZone
[panel]������� TreeZone ����� TcfAdminForm[panel]
*��� ����������:* TvtPanel
*������:*
[code]
OBJECT VAR l_TvtPanel
 acfAdminForm .TcfAdminForm.TreeZone >>> l_TvtPanel
[code]  }
  private
  // private methods
   function TreeZone(const aCtx: TtfwContext;
     acfAdminForm: TcfAdminForm): TvtPanel;
     {* ���������� ����� ������� .TcfAdminForm.TreeZone }
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
  end;//TkwCfAdminFormTreeZone

// start class TkwCfAdminFormTreeZone

function TkwCfAdminFormTreeZone.TreeZone(const aCtx: TtfwContext;
  acfAdminForm: TcfAdminForm): TvtPanel;
 {-}
begin
 Result := acfAdminForm.TreeZone;
end;//TkwCfAdminFormTreeZone.TreeZone

procedure TkwCfAdminFormTreeZone.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_acfAdminForm : TcfAdminForm;
begin
 try
  l_acfAdminForm := TcfAdminForm(aCtx.rEngine.PopObjAs(TcfAdminForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� acfAdminForm: TcfAdminForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((TreeZone(aCtx, l_acfAdminForm)));
end;//TkwCfAdminFormTreeZone.DoDoIt

class function TkwCfAdminFormTreeZone.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TcfAdminForm.TreeZone';
end;//TkwCfAdminFormTreeZone.GetWordNameForRegister

procedure TkwCfAdminFormTreeZone.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� TreeZone', aCtx);
end;//TkwCfAdminFormTreeZone.SetValuePrim

function TkwCfAdminFormTreeZone.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtPanel);
end;//TkwCfAdminFormTreeZone.GetResultTypeInfo

function TkwCfAdminFormTreeZone.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwCfAdminFormTreeZone.GetAllParamsCount

function TkwCfAdminFormTreeZone.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TcfAdminForm)]);
end;//TkwCfAdminFormTreeZone.ParamsTypes
{$IfEnd} //Admin AND not NoScripts

initialization
{$If defined(Admin) AND not defined(NoScripts)}
// ����������� Tkw_Form_AdminForm
 Tkw_Form_AdminForm.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// ����������� Tkw_AdminForm_Control_BackgroundPanel
 Tkw_AdminForm_Control_BackgroundPanel.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// ����������� Tkw_AdminForm_Control_BackgroundPanel_Push
 Tkw_AdminForm_Control_BackgroundPanel_Push.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// ����������� Tkw_AdminForm_Control_PropertyZone
 Tkw_AdminForm_Control_PropertyZone.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// ����������� Tkw_AdminForm_Control_PropertyZone_Push
 Tkw_AdminForm_Control_PropertyZone_Push.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// ����������� Tkw_AdminForm_Control_TreeZone
 Tkw_AdminForm_Control_TreeZone.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// ����������� Tkw_AdminForm_Control_TreeZone_Push
 Tkw_AdminForm_Control_TreeZone_Push.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// ����������� cfAdminForm_BackgroundPanel
 TkwCfAdminFormBackgroundPanel.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// ����������� cfAdminForm_PropertyZone
 TkwCfAdminFormPropertyZone.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// ����������� cfAdminForm_TreeZone
 TkwCfAdminFormTreeZone.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// ����������� ���� TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// ����������� ���� AdminForm
 TtfwTypeRegistrator.RegisterType(TypeInfo(TcfAdminForm));
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// ����������� ���� TvtProportionalPanel
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtProportionalPanel));
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// ����������� ���� TvtSizeablePanel
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtSizeablePanel));
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// ����������� ���� TvtPanel
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
{$IfEnd} //Admin AND not NoScripts

end.