unit WarningKeywordsPack;
 {* ����� ���� ������� ��� ������� � ����������� ��������� ����� Warning }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Document\Forms\WarningKeywordsPack.pas"
// ���������: "ScriptKeywordsPack"
// ������� ������: "WarningKeywordsPack" MUID: (4AB1355B01EA_Pack)

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
 , Warning_Form
 , tfwPropertyLike
 {$If Defined(Nemesis)}
 , nscEditor
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
 TkwWarningFormViewer = {final} class(TtfwPropertyLike)
  {* ����� ������� .TWarningForm.Viewer }
  private
   function Viewer(const aCtx: TtfwContext;
    aWarningForm: TWarningForm): TnscEditor;
    {* ���������� ����� ������� .TWarningForm.Viewer }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwWarningFormViewer

 Tkw_Form_Warning = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� ����� Warning
----
*������ �������������*:
[code]�����::Warning TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Form_Warning

 Tkw_Warning_Control_Viewer = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� Viewer
----
*������ �������������*:
[code]�������::Viewer TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Warning_Control_Viewer

 Tkw_Warning_Control_Viewer_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� Viewer
----
*������ �������������*:
[code]�������::Viewer:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Warning_Control_Viewer_Push

function TkwWarningFormViewer.Viewer(const aCtx: TtfwContext;
 aWarningForm: TWarningForm): TnscEditor;
 {* ���������� ����� ������� .TWarningForm.Viewer }
begin
 Result := aWarningForm.Viewer;
end;//TkwWarningFormViewer.Viewer

class function TkwWarningFormViewer.GetWordNameForRegister: AnsiString;
begin
 Result := '.TWarningForm.Viewer';
end;//TkwWarningFormViewer.GetWordNameForRegister

function TkwWarningFormViewer.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscEditor);
end;//TkwWarningFormViewer.GetResultTypeInfo

function TkwWarningFormViewer.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwWarningFormViewer.GetAllParamsCount

function TkwWarningFormViewer.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TWarningForm)]);
end;//TkwWarningFormViewer.ParamsTypes

procedure TkwWarningFormViewer.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� Viewer', aCtx);
end;//TkwWarningFormViewer.SetValuePrim

procedure TkwWarningFormViewer.DoDoIt(const aCtx: TtfwContext);
var l_aWarningForm: TWarningForm;
begin
 try
  l_aWarningForm := TWarningForm(aCtx.rEngine.PopObjAs(TWarningForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aWarningForm: TWarningForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(Viewer(aCtx, l_aWarningForm));
end;//TkwWarningFormViewer.DoDoIt

function Tkw_Form_Warning.GetString: AnsiString;
begin
 Result := 'WarningForm';
end;//Tkw_Form_Warning.GetString

class procedure Tkw_Form_Warning.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TWarningForm);
end;//Tkw_Form_Warning.RegisterInEngine

class function Tkw_Form_Warning.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::Warning';
end;//Tkw_Form_Warning.GetWordNameForRegister

function Tkw_Warning_Control_Viewer.GetString: AnsiString;
begin
 Result := 'Viewer';
end;//Tkw_Warning_Control_Viewer.GetString

class procedure Tkw_Warning_Control_Viewer.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscEditor);
end;//Tkw_Warning_Control_Viewer.RegisterInEngine

class function Tkw_Warning_Control_Viewer.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::Viewer';
end;//Tkw_Warning_Control_Viewer.GetWordNameForRegister

procedure Tkw_Warning_Control_Viewer_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('Viewer');
 inherited;
end;//Tkw_Warning_Control_Viewer_Push.DoDoIt

class function Tkw_Warning_Control_Viewer_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::Viewer:push';
end;//Tkw_Warning_Control_Viewer_Push.GetWordNameForRegister

initialization
 TkwWarningFormViewer.RegisterInEngine;
 {* ����������� WarningForm_Viewer }
 Tkw_Form_Warning.RegisterInEngine;
 {* ����������� Tkw_Form_Warning }
 Tkw_Warning_Control_Viewer.RegisterInEngine;
 {* ����������� Tkw_Warning_Control_Viewer }
 Tkw_Warning_Control_Viewer_Push.RegisterInEngine;
 {* ����������� Tkw_Warning_Control_Viewer_Push }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TWarningForm));
 {* ����������� ���� TWarningForm }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscEditor));
 {* ����������� ���� TnscEditor }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)

end.
