unit AdminFormKeywordsPack;
 {* ����� ���� ������� ��� ������� � ����������� ��������� ����� AdminForm }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Admin\Forms\AdminFormKeywordsPack.pas"
// ���������: "ScriptKeywordsPack"
// ������� ������: "AdminFormKeywordsPack" MUID: (4AA8E4F1002A_Pack)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If Defined(Admin) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3IntfUses
;
{$IfEnd} // Defined(Admin) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)

implementation

{$If Defined(Admin) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3ImplUses
 , Admin_Form
 , tfwPropertyLike
 , vtProportionalPanel
 , tfwScriptingInterfaces
 , TypInfo
 , tfwTypeInfo
 , vtSizeablePanel
 , vtPanel
 , tfwControlString
 , kwBynameControlPush
 , TtfwClassRef_Proxy
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
 //#UC START# *4AA8E4F1002A_Packimpl_uses*
 //#UC END# *4AA8E4F1002A_Packimpl_uses*
;

type
 TkwCfAdminFormBackgroundPanel = {final} class(TtfwPropertyLike)
  {* ����� ������� .TcfAdminForm.BackgroundPanel }
  private
   function BackgroundPanel(const aCtx: TtfwContext;
    acfAdminForm: TcfAdminForm): TvtProportionalPanel;
    {* ���������� ����� ������� .TcfAdminForm.BackgroundPanel }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwCfAdminFormBackgroundPanel

 TkwCfAdminFormPropertyZone = {final} class(TtfwPropertyLike)
  {* ����� ������� .TcfAdminForm.PropertyZone }
  private
   function PropertyZone(const aCtx: TtfwContext;
    acfAdminForm: TcfAdminForm): TvtSizeablePanel;
    {* ���������� ����� ������� .TcfAdminForm.PropertyZone }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwCfAdminFormPropertyZone

 TkwCfAdminFormTreeZone = {final} class(TtfwPropertyLike)
  {* ����� ������� .TcfAdminForm.TreeZone }
  private
   function TreeZone(const aCtx: TtfwContext;
    acfAdminForm: TcfAdminForm): TvtPanel;
    {* ���������� ����� ������� .TcfAdminForm.TreeZone }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwCfAdminFormTreeZone

 Tkw_Form_AdminForm = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� ����� AdminForm
----
*������ �������������*:
[code]�����::AdminForm TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Form_AdminForm

 Tkw_AdminForm_Control_BackgroundPanel = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� BackgroundPanel
----
*������ �������������*:
[code]�������::BackgroundPanel TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_AdminForm_Control_BackgroundPanel

 Tkw_AdminForm_Control_BackgroundPanel_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� BackgroundPanel
----
*������ �������������*:
[code]�������::BackgroundPanel:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_AdminForm_Control_BackgroundPanel_Push

 Tkw_AdminForm_Control_PropertyZone = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� PropertyZone
----
*������ �������������*:
[code]�������::PropertyZone TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_AdminForm_Control_PropertyZone

 Tkw_AdminForm_Control_PropertyZone_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� PropertyZone
----
*������ �������������*:
[code]�������::PropertyZone:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_AdminForm_Control_PropertyZone_Push

 Tkw_AdminForm_Control_TreeZone = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� TreeZone
----
*������ �������������*:
[code]�������::TreeZone TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_AdminForm_Control_TreeZone

 Tkw_AdminForm_Control_TreeZone_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� TreeZone
----
*������ �������������*:
[code]�������::TreeZone:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_AdminForm_Control_TreeZone_Push

function TkwCfAdminFormBackgroundPanel.BackgroundPanel(const aCtx: TtfwContext;
 acfAdminForm: TcfAdminForm): TvtProportionalPanel;
 {* ���������� ����� ������� .TcfAdminForm.BackgroundPanel }
begin
 Result := acfAdminForm.BackgroundPanel;
end;//TkwCfAdminFormBackgroundPanel.BackgroundPanel

class function TkwCfAdminFormBackgroundPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TcfAdminForm.BackgroundPanel';
end;//TkwCfAdminFormBackgroundPanel.GetWordNameForRegister

function TkwCfAdminFormBackgroundPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtProportionalPanel);
end;//TkwCfAdminFormBackgroundPanel.GetResultTypeInfo

function TkwCfAdminFormBackgroundPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwCfAdminFormBackgroundPanel.GetAllParamsCount

function TkwCfAdminFormBackgroundPanel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TcfAdminForm)]);
end;//TkwCfAdminFormBackgroundPanel.ParamsTypes

procedure TkwCfAdminFormBackgroundPanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� BackgroundPanel', aCtx);
end;//TkwCfAdminFormBackgroundPanel.SetValuePrim

procedure TkwCfAdminFormBackgroundPanel.DoDoIt(const aCtx: TtfwContext);
var l_acfAdminForm: TcfAdminForm;
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
 aCtx.rEngine.PushObj(BackgroundPanel(aCtx, l_acfAdminForm));
end;//TkwCfAdminFormBackgroundPanel.DoDoIt

function TkwCfAdminFormPropertyZone.PropertyZone(const aCtx: TtfwContext;
 acfAdminForm: TcfAdminForm): TvtSizeablePanel;
 {* ���������� ����� ������� .TcfAdminForm.PropertyZone }
begin
 Result := acfAdminForm.PropertyZone;
end;//TkwCfAdminFormPropertyZone.PropertyZone

class function TkwCfAdminFormPropertyZone.GetWordNameForRegister: AnsiString;
begin
 Result := '.TcfAdminForm.PropertyZone';
end;//TkwCfAdminFormPropertyZone.GetWordNameForRegister

function TkwCfAdminFormPropertyZone.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtSizeablePanel);
end;//TkwCfAdminFormPropertyZone.GetResultTypeInfo

function TkwCfAdminFormPropertyZone.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwCfAdminFormPropertyZone.GetAllParamsCount

function TkwCfAdminFormPropertyZone.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TcfAdminForm)]);
end;//TkwCfAdminFormPropertyZone.ParamsTypes

procedure TkwCfAdminFormPropertyZone.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� PropertyZone', aCtx);
end;//TkwCfAdminFormPropertyZone.SetValuePrim

procedure TkwCfAdminFormPropertyZone.DoDoIt(const aCtx: TtfwContext);
var l_acfAdminForm: TcfAdminForm;
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
 aCtx.rEngine.PushObj(PropertyZone(aCtx, l_acfAdminForm));
end;//TkwCfAdminFormPropertyZone.DoDoIt

function TkwCfAdminFormTreeZone.TreeZone(const aCtx: TtfwContext;
 acfAdminForm: TcfAdminForm): TvtPanel;
 {* ���������� ����� ������� .TcfAdminForm.TreeZone }
begin
 Result := acfAdminForm.TreeZone;
end;//TkwCfAdminFormTreeZone.TreeZone

class function TkwCfAdminFormTreeZone.GetWordNameForRegister: AnsiString;
begin
 Result := '.TcfAdminForm.TreeZone';
end;//TkwCfAdminFormTreeZone.GetWordNameForRegister

function TkwCfAdminFormTreeZone.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwCfAdminFormTreeZone.GetResultTypeInfo

function TkwCfAdminFormTreeZone.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwCfAdminFormTreeZone.GetAllParamsCount

function TkwCfAdminFormTreeZone.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TcfAdminForm)]);
end;//TkwCfAdminFormTreeZone.ParamsTypes

procedure TkwCfAdminFormTreeZone.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� TreeZone', aCtx);
end;//TkwCfAdminFormTreeZone.SetValuePrim

procedure TkwCfAdminFormTreeZone.DoDoIt(const aCtx: TtfwContext);
var l_acfAdminForm: TcfAdminForm;
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
 aCtx.rEngine.PushObj(TreeZone(aCtx, l_acfAdminForm));
end;//TkwCfAdminFormTreeZone.DoDoIt

function Tkw_Form_AdminForm.GetString: AnsiString;
begin
 Result := 'cfAdminForm';
end;//Tkw_Form_AdminForm.GetString

class procedure Tkw_Form_AdminForm.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TcfAdminForm);
end;//Tkw_Form_AdminForm.RegisterInEngine

class function Tkw_Form_AdminForm.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::AdminForm';
end;//Tkw_Form_AdminForm.GetWordNameForRegister

function Tkw_AdminForm_Control_BackgroundPanel.GetString: AnsiString;
begin
 Result := 'BackgroundPanel';
end;//Tkw_AdminForm_Control_BackgroundPanel.GetString

class procedure Tkw_AdminForm_Control_BackgroundPanel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtProportionalPanel);
end;//Tkw_AdminForm_Control_BackgroundPanel.RegisterInEngine

class function Tkw_AdminForm_Control_BackgroundPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::BackgroundPanel';
end;//Tkw_AdminForm_Control_BackgroundPanel.GetWordNameForRegister

procedure Tkw_AdminForm_Control_BackgroundPanel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('BackgroundPanel');
 inherited;
end;//Tkw_AdminForm_Control_BackgroundPanel_Push.DoDoIt

class function Tkw_AdminForm_Control_BackgroundPanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::BackgroundPanel:push';
end;//Tkw_AdminForm_Control_BackgroundPanel_Push.GetWordNameForRegister

function Tkw_AdminForm_Control_PropertyZone.GetString: AnsiString;
begin
 Result := 'PropertyZone';
end;//Tkw_AdminForm_Control_PropertyZone.GetString

class procedure Tkw_AdminForm_Control_PropertyZone.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtSizeablePanel);
end;//Tkw_AdminForm_Control_PropertyZone.RegisterInEngine

class function Tkw_AdminForm_Control_PropertyZone.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::PropertyZone';
end;//Tkw_AdminForm_Control_PropertyZone.GetWordNameForRegister

procedure Tkw_AdminForm_Control_PropertyZone_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('PropertyZone');
 inherited;
end;//Tkw_AdminForm_Control_PropertyZone_Push.DoDoIt

class function Tkw_AdminForm_Control_PropertyZone_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::PropertyZone:push';
end;//Tkw_AdminForm_Control_PropertyZone_Push.GetWordNameForRegister

function Tkw_AdminForm_Control_TreeZone.GetString: AnsiString;
begin
 Result := 'TreeZone';
end;//Tkw_AdminForm_Control_TreeZone.GetString

class procedure Tkw_AdminForm_Control_TreeZone.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_AdminForm_Control_TreeZone.RegisterInEngine

class function Tkw_AdminForm_Control_TreeZone.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::TreeZone';
end;//Tkw_AdminForm_Control_TreeZone.GetWordNameForRegister

procedure Tkw_AdminForm_Control_TreeZone_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('TreeZone');
 inherited;
end;//Tkw_AdminForm_Control_TreeZone_Push.DoDoIt

class function Tkw_AdminForm_Control_TreeZone_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::TreeZone:push';
end;//Tkw_AdminForm_Control_TreeZone_Push.GetWordNameForRegister

initialization
 TkwCfAdminFormBackgroundPanel.RegisterInEngine;
 {* ����������� cfAdminForm_BackgroundPanel }
 TkwCfAdminFormPropertyZone.RegisterInEngine;
 {* ����������� cfAdminForm_PropertyZone }
 TkwCfAdminFormTreeZone.RegisterInEngine;
 {* ����������� cfAdminForm_TreeZone }
 Tkw_Form_AdminForm.RegisterInEngine;
 {* ����������� Tkw_Form_AdminForm }
 Tkw_AdminForm_Control_BackgroundPanel.RegisterInEngine;
 {* ����������� Tkw_AdminForm_Control_BackgroundPanel }
 Tkw_AdminForm_Control_BackgroundPanel_Push.RegisterInEngine;
 {* ����������� Tkw_AdminForm_Control_BackgroundPanel_Push }
 Tkw_AdminForm_Control_PropertyZone.RegisterInEngine;
 {* ����������� Tkw_AdminForm_Control_PropertyZone }
 Tkw_AdminForm_Control_PropertyZone_Push.RegisterInEngine;
 {* ����������� Tkw_AdminForm_Control_PropertyZone_Push }
 Tkw_AdminForm_Control_TreeZone.RegisterInEngine;
 {* ����������� Tkw_AdminForm_Control_TreeZone }
 Tkw_AdminForm_Control_TreeZone_Push.RegisterInEngine;
 {* ����������� Tkw_AdminForm_Control_TreeZone_Push }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TcfAdminForm));
 {* ����������� ���� TcfAdminForm }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtProportionalPanel));
 {* ����������� ���� TvtProportionalPanel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtSizeablePanel));
 {* ����������� ���� TvtSizeablePanel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
 {* ����������� ���� TvtPanel }
{$IfEnd} // Defined(Admin) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)

end.
