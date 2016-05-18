unit PreviewFormKeywordsPack;
 {* ����� ���� ������� ��� ������� � ����������� ��������� ����� PreviewForm }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\PreviewFormKeywordsPack.pas"
// ���������: "ScriptKeywordsPack"
// ������� ������: "PreviewFormKeywordsPack" MUID: (4AAF6F8100DB_Pack)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3IntfUses
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)

implementation

{$If NOT Defined(Admin) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3ImplUses
 , Preview_Form
 , tfwPropertyLike
 {$If Defined(Nemesis)}
 , nscPreviewPanel
 {$IfEnd} // Defined(Nemesis)
 , tfwScriptingInterfaces
 , TypInfo
 , tfwTypeInfo
 , tfwControlString
 , kwBynameControlPush
 , TtfwClassRef_Proxy
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
;

type
 TkwEfPreviewFormPreviewPanel = {final} class(TtfwPropertyLike)
  {* ����� ������� .TefPreviewForm.PreviewPanel }
  private
   function PreviewPanel(const aCtx: TtfwContext;
    aefPreviewForm: TefPreviewForm): TnscPreviewPanel;
    {* ���������� ����� ������� .TefPreviewForm.PreviewPanel }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEfPreviewFormPreviewPanel

 Tkw_Form_PreviewForm = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� ����� PreviewForm
----
*������ �������������*:
[code]�����::PreviewForm TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Form_PreviewForm

 Tkw_PreviewForm_Control_PreviewPanel = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� PreviewPanel
----
*������ �������������*:
[code]�������::PreviewPanel TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_PreviewForm_Control_PreviewPanel

 Tkw_PreviewForm_Control_PreviewPanel_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� PreviewPanel
----
*������ �������������*:
[code]�������::PreviewPanel:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_PreviewForm_Control_PreviewPanel_Push

function TkwEfPreviewFormPreviewPanel.PreviewPanel(const aCtx: TtfwContext;
 aefPreviewForm: TefPreviewForm): TnscPreviewPanel;
 {* ���������� ����� ������� .TefPreviewForm.PreviewPanel }
begin
 Result := aefPreviewForm.PreviewPanel;
end;//TkwEfPreviewFormPreviewPanel.PreviewPanel

class function TkwEfPreviewFormPreviewPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefPreviewForm.PreviewPanel';
end;//TkwEfPreviewFormPreviewPanel.GetWordNameForRegister

function TkwEfPreviewFormPreviewPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscPreviewPanel);
end;//TkwEfPreviewFormPreviewPanel.GetResultTypeInfo

function TkwEfPreviewFormPreviewPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEfPreviewFormPreviewPanel.GetAllParamsCount

function TkwEfPreviewFormPreviewPanel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TefPreviewForm)]);
end;//TkwEfPreviewFormPreviewPanel.ParamsTypes

procedure TkwEfPreviewFormPreviewPanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� PreviewPanel', aCtx);
end;//TkwEfPreviewFormPreviewPanel.SetValuePrim

procedure TkwEfPreviewFormPreviewPanel.DoDoIt(const aCtx: TtfwContext);
var l_aefPreviewForm: TefPreviewForm;
begin
 try
  l_aefPreviewForm := TefPreviewForm(aCtx.rEngine.PopObjAs(TefPreviewForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aefPreviewForm: TefPreviewForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(PreviewPanel(aCtx, l_aefPreviewForm));
end;//TkwEfPreviewFormPreviewPanel.DoDoIt

function Tkw_Form_PreviewForm.GetString: AnsiString;
begin
 Result := 'efPreviewForm';
end;//Tkw_Form_PreviewForm.GetString

class procedure Tkw_Form_PreviewForm.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TefPreviewForm);
end;//Tkw_Form_PreviewForm.RegisterInEngine

class function Tkw_Form_PreviewForm.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::PreviewForm';
end;//Tkw_Form_PreviewForm.GetWordNameForRegister

function Tkw_PreviewForm_Control_PreviewPanel.GetString: AnsiString;
begin
 Result := 'PreviewPanel';
end;//Tkw_PreviewForm_Control_PreviewPanel.GetString

class procedure Tkw_PreviewForm_Control_PreviewPanel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscPreviewPanel);
end;//Tkw_PreviewForm_Control_PreviewPanel.RegisterInEngine

class function Tkw_PreviewForm_Control_PreviewPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::PreviewPanel';
end;//Tkw_PreviewForm_Control_PreviewPanel.GetWordNameForRegister

procedure Tkw_PreviewForm_Control_PreviewPanel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('PreviewPanel');
 inherited;
end;//Tkw_PreviewForm_Control_PreviewPanel_Push.DoDoIt

class function Tkw_PreviewForm_Control_PreviewPanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::PreviewPanel:push';
end;//Tkw_PreviewForm_Control_PreviewPanel_Push.GetWordNameForRegister

initialization
 TkwEfPreviewFormPreviewPanel.RegisterInEngine;
 {* ����������� efPreviewForm_PreviewPanel }
 Tkw_Form_PreviewForm.RegisterInEngine;
 {* ����������� Tkw_Form_PreviewForm }
 Tkw_PreviewForm_Control_PreviewPanel.RegisterInEngine;
 {* ����������� Tkw_PreviewForm_Control_PreviewPanel }
 Tkw_PreviewForm_Control_PreviewPanel_Push.RegisterInEngine;
 {* ����������� Tkw_PreviewForm_Control_PreviewPanel_Push }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TefPreviewForm));
 {* ����������� ���� TefPreviewForm }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscPreviewPanel));
 {* ����������� ���� TnscPreviewPanel }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)

end.
