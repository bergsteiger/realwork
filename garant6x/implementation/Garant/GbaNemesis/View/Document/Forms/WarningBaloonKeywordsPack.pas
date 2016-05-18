unit WarningBaloonKeywordsPack;
 {* ����� ���� ������� ��� ������� � ����������� ��������� ����� WarningBaloon }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Document\Forms\WarningBaloonKeywordsPack.pas"
// ���������: "ScriptKeywordsPack"
// ������� ������: "WarningBaloonKeywordsPack" MUID: (4EA58A3903B4_Pack)

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
 , WarningBaloon_Form
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
 TkwWarningBaloonFormViewer = {final} class(TtfwPropertyLike)
  {* ����� ������� .TWarningBaloonForm.Viewer }
  private
   function Viewer(const aCtx: TtfwContext;
    aWarningBaloonForm: TWarningBaloonForm): TnscEditor;
    {* ���������� ����� ������� .TWarningBaloonForm.Viewer }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwWarningBaloonFormViewer

 Tkw_Form_WarningBaloon = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� ����� WarningBaloon
----
*������ �������������*:
[code]�����::WarningBaloon TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Form_WarningBaloon

 Tkw_WarningBaloon_Control_Viewer = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� Viewer
----
*������ �������������*:
[code]�������::Viewer TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_WarningBaloon_Control_Viewer

 Tkw_WarningBaloon_Control_Viewer_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� Viewer
----
*������ �������������*:
[code]�������::Viewer:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_WarningBaloon_Control_Viewer_Push

function TkwWarningBaloonFormViewer.Viewer(const aCtx: TtfwContext;
 aWarningBaloonForm: TWarningBaloonForm): TnscEditor;
 {* ���������� ����� ������� .TWarningBaloonForm.Viewer }
begin
 Result := aWarningBaloonForm.Viewer;
end;//TkwWarningBaloonFormViewer.Viewer

class function TkwWarningBaloonFormViewer.GetWordNameForRegister: AnsiString;
begin
 Result := '.TWarningBaloonForm.Viewer';
end;//TkwWarningBaloonFormViewer.GetWordNameForRegister

function TkwWarningBaloonFormViewer.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscEditor);
end;//TkwWarningBaloonFormViewer.GetResultTypeInfo

function TkwWarningBaloonFormViewer.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwWarningBaloonFormViewer.GetAllParamsCount

function TkwWarningBaloonFormViewer.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TWarningBaloonForm)]);
end;//TkwWarningBaloonFormViewer.ParamsTypes

procedure TkwWarningBaloonFormViewer.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� Viewer', aCtx);
end;//TkwWarningBaloonFormViewer.SetValuePrim

procedure TkwWarningBaloonFormViewer.DoDoIt(const aCtx: TtfwContext);
var l_aWarningBaloonForm: TWarningBaloonForm;
begin
 try
  l_aWarningBaloonForm := TWarningBaloonForm(aCtx.rEngine.PopObjAs(TWarningBaloonForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aWarningBaloonForm: TWarningBaloonForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(Viewer(aCtx, l_aWarningBaloonForm));
end;//TkwWarningBaloonFormViewer.DoDoIt

function Tkw_Form_WarningBaloon.GetString: AnsiString;
begin
 Result := 'WarningBaloonForm';
end;//Tkw_Form_WarningBaloon.GetString

class procedure Tkw_Form_WarningBaloon.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TWarningBaloonForm);
end;//Tkw_Form_WarningBaloon.RegisterInEngine

class function Tkw_Form_WarningBaloon.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::WarningBaloon';
end;//Tkw_Form_WarningBaloon.GetWordNameForRegister

function Tkw_WarningBaloon_Control_Viewer.GetString: AnsiString;
begin
 Result := 'Viewer';
end;//Tkw_WarningBaloon_Control_Viewer.GetString

class procedure Tkw_WarningBaloon_Control_Viewer.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscEditor);
end;//Tkw_WarningBaloon_Control_Viewer.RegisterInEngine

class function Tkw_WarningBaloon_Control_Viewer.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::Viewer';
end;//Tkw_WarningBaloon_Control_Viewer.GetWordNameForRegister

procedure Tkw_WarningBaloon_Control_Viewer_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('Viewer');
 inherited;
end;//Tkw_WarningBaloon_Control_Viewer_Push.DoDoIt

class function Tkw_WarningBaloon_Control_Viewer_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::Viewer:push';
end;//Tkw_WarningBaloon_Control_Viewer_Push.GetWordNameForRegister

initialization
 TkwWarningBaloonFormViewer.RegisterInEngine;
 {* ����������� WarningBaloonForm_Viewer }
 Tkw_Form_WarningBaloon.RegisterInEngine;
 {* ����������� Tkw_Form_WarningBaloon }
 Tkw_WarningBaloon_Control_Viewer.RegisterInEngine;
 {* ����������� Tkw_WarningBaloon_Control_Viewer }
 Tkw_WarningBaloon_Control_Viewer_Push.RegisterInEngine;
 {* ����������� Tkw_WarningBaloon_Control_Viewer_Push }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TWarningBaloonForm));
 {* ����������� ���� TWarningBaloonForm }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscEditor));
 {* ����������� ���� TnscEditor }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)

end.
