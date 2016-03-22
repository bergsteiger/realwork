unit WarningKeywordsPack;
 {* ����� ���� ������� ��� ������� � ����������� ��������� ����� Warning }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Document\WarningKeywordsPack.pas"
// ���������: "ScriptKeywordsPack"
// ������� ������: "WarningKeywordsPack" MUID: (AC8C0D7A6291)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 {$If Defined(Nemesis)}
 , nscEditor
 {$IfEnd} // Defined(Nemesis)
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , Warning_Form
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
 Tkw_Form_Warning = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� ����� Warning
----
*������ �������������*:
[code]
'aControl' �����::Warning TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Form_Warning

 Tkw_Warning_Control_Viewer = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� Viewer
----
*������ �������������*:
[code]
�������::Viewer TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Warning_Control_Viewer

 Tkw_Warning_Control_Viewer_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� Viewer
----
*������ �������������*:
[code]
�������::Viewer:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Warning_Control_Viewer_Push

 TkwWarningFormViewer = {final} class(TtfwPropertyLike)
  {* ����� ������� .TWarningForm.Viewer
[panel]������� Viewer ����� TWarningForm[panel]
*��� ����������:* TnscEditor
*������:*
[code]
OBJECT VAR l_TnscEditor
 aWarningForm .TWarningForm.Viewer >>> l_TnscEditor
[code]  }
  private
   function Viewer(const aCtx: TtfwContext;
    aWarningForm: TWarningForm): TnscEditor;
    {* ���������� ����� ������� .TWarningForm.Viewer }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwWarningFormViewer

function Tkw_Form_Warning.GetString: AnsiString;
begin
 Result := 'WarningForm';
end;//Tkw_Form_Warning.GetString

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

function TkwWarningFormViewer.Viewer(const aCtx: TtfwContext;
 aWarningForm: TWarningForm): TnscEditor;
 {* ���������� ����� ������� .TWarningForm.Viewer }
begin
 Result := aWarningForm.Viewer;
end;//TkwWarningFormViewer.Viewer

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

procedure TkwWarningFormViewer.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� Viewer', aCtx);
end;//TkwWarningFormViewer.SetValuePrim

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

class function TkwWarningFormViewer.GetWordNameForRegister: AnsiString;
begin
 Result := '.TWarningForm.Viewer';
end;//TkwWarningFormViewer.GetWordNameForRegister

initialization
 Tkw_Form_Warning.RegisterInEngine;
 {* ����������� Tkw_Form_Warning }
 Tkw_Warning_Control_Viewer.RegisterInEngine;
 {* ����������� Tkw_Warning_Control_Viewer }
 Tkw_Warning_Control_Viewer_Push.RegisterInEngine;
 {* ����������� Tkw_Warning_Control_Viewer_Push }
 TkwWarningFormViewer.RegisterInEngine;
 {* ����������� WarningForm_Viewer }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* ����������� ���� TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TWarningForm));
 {* ����������� ���� Warning }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscEditor));
 {* ����������� ���� TnscEditor }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

end.
