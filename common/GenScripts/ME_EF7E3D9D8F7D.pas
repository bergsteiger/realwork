unit PreviewFormKeywordsPack;
 {* ����� ���� ������� ��� ������� � ����������� ��������� ����� PreviewForm }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\PreviewFormKeywordsPack.pas"
// ���������: "ScriptKeywordsPack"
// ������� ������: "PreviewFormKeywordsPack" MUID: (EF7E3D9D8F7D)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 {$If Defined(Nemesis)}
 , nscPreviewPanel
 {$IfEnd} // Defined(Nemesis)
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(NoScripts)

implementation

{$If NOT Defined(Admin) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , Preview_Form
 , tfwControlString
 {$If NOT Defined(NoVCL)}
 , kwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 , tfwScriptingInterfaces
 , tfwPropertyLike
 , TypInfo
 , tfwTypeInfo
 , TtfwClassRef_Proxy
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
;

type
 Tkw_Form_PreviewForm = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� ����� PreviewForm
----
*������ �������������*:
[code]
'aControl' �����::PreviewForm TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Form_PreviewForm

 Tkw_PreviewForm_Control_PreviewPanel = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� PreviewPanel
----
*������ �������������*:
[code]
�������::PreviewPanel TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_PreviewForm_Control_PreviewPanel

 Tkw_PreviewForm_Control_PreviewPanel_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* ����� ������� ��� �������� PreviewPanel
----
*������ �������������*:
[code]
�������::PreviewPanel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_PreviewForm_Control_PreviewPanel_Push

 TkwEfPreviewFormPreviewPanel = {final} class(TtfwPropertyLike)
  {* ����� ������� .TefPreviewForm.PreviewPanel }
  private
   function PreviewPanel(const aCtx: TtfwContext;
    aefPreviewForm: TefPreviewForm): TnscPreviewPanel;
    {* ���������� ����� ������� .TefPreviewForm.PreviewPanel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEfPreviewFormPreviewPanel

function Tkw_Form_PreviewForm.GetString: AnsiString;
begin
 Result := 'efPreviewForm';
end;//Tkw_Form_PreviewForm.GetString

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

function TkwEfPreviewFormPreviewPanel.PreviewPanel(const aCtx: TtfwContext;
 aefPreviewForm: TefPreviewForm): TnscPreviewPanel;
 {* ���������� ����� ������� .TefPreviewForm.PreviewPanel }
begin
 Result := aefPreviewForm.PreviewPanel;
end;//TkwEfPreviewFormPreviewPanel.PreviewPanel

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

initialization
 Tkw_Form_PreviewForm.RegisterInEngine;
 {* ����������� Tkw_Form_PreviewForm }
 Tkw_PreviewForm_Control_PreviewPanel.RegisterInEngine;
 {* ����������� Tkw_PreviewForm_Control_PreviewPanel }
 Tkw_PreviewForm_Control_PreviewPanel_Push.RegisterInEngine;
 {* ����������� Tkw_PreviewForm_Control_PreviewPanel_Push }
 TkwEfPreviewFormPreviewPanel.RegisterInEngine;
 {* ����������� efPreviewForm_PreviewPanel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TefPreviewForm));
 {* ����������� ���� TefPreviewForm }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscPreviewPanel));
 {* ����������� ���� TnscPreviewPanel }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(NoScripts)

end.
