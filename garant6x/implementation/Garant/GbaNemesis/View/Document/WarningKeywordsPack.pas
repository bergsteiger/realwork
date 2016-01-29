unit WarningKeywordsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/Document/WarningKeywordsPack.pas"
// �����: 05.02.2009 19:28
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<ScriptKeywordsPack::Class>> F1 ������ � ���������� � ������� ����������::Document::View::Document::Document::WarningKeywordsPack
//
// ����� ���� ������� ��� ������� � ����������� ��������� ����� Warning
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
  {$If defined(Nemesis)}
  ,
  nscEditor
  {$IfEnd} //Nemesis
  ,
  Warning_Form,
  tfwScriptingInterfaces
  {$If not defined(NoScripts) AND not defined(NoVCL)}
  ,
  kwBynameControlPush
  {$IfEnd} //not NoScripts AND not NoVCL
  ,
  tfwControlString,
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
  Tkw_Form_Warning = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� ����� Warning
----
*������ �������������*:
[code]
'aControl' �����::Warning TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
  end;//Tkw_Form_Warning

// start class Tkw_Form_Warning

class function Tkw_Form_Warning.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�����::Warning';
end;//Tkw_Form_Warning.GetWordNameForRegister

function Tkw_Form_Warning.GetString: AnsiString;
 {-}
begin
 Result := 'WarningForm';
end;//Tkw_Form_Warning.GetString

type
  Tkw_Warning_Control_Viewer = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� Viewer
----
*������ �������������*:
[code]
�������::Viewer TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_Warning_Control_Viewer

// start class Tkw_Warning_Control_Viewer

class function Tkw_Warning_Control_Viewer.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::Viewer';
end;//Tkw_Warning_Control_Viewer.GetWordNameForRegister

function Tkw_Warning_Control_Viewer.GetString: AnsiString;
 {-}
begin
 Result := 'Viewer';
end;//Tkw_Warning_Control_Viewer.GetString

class procedure Tkw_Warning_Control_Viewer.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TnscEditor);
end;//Tkw_Warning_Control_Viewer.RegisterInEngine

type
  Tkw_Warning_Control_Viewer_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� Viewer
----
*������ �������������*:
[code]
�������::Viewer:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_Warning_Control_Viewer_Push

// start class Tkw_Warning_Control_Viewer_Push

procedure Tkw_Warning_Control_Viewer_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('Viewer');
 inherited;
end;//Tkw_Warning_Control_Viewer_Push.DoDoIt

class function Tkw_Warning_Control_Viewer_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::Viewer:push';
end;//Tkw_Warning_Control_Viewer_Push.GetWordNameForRegister

type
  TkwWarningFormViewer = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .TWarningForm.Viewer
[panel]������� Viewer ����� TWarningForm[panel]
*��� ����������:* TnscEditor
*������:*
[code]
OBJECT VAR l_TnscEditor
 aWarningForm .TWarningForm.Viewer >>> l_TnscEditor
[code]  }
  private
  // private methods
   function Viewer(const aCtx: TtfwContext;
     aWarningForm: TWarningForm): TnscEditor;
     {* ���������� ����� ������� .TWarningForm.Viewer }
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
  end;//TkwWarningFormViewer

// start class TkwWarningFormViewer

function TkwWarningFormViewer.Viewer(const aCtx: TtfwContext;
  aWarningForm: TWarningForm): TnscEditor;
 {-}
begin
 Result := aWarningForm.Viewer;
end;//TkwWarningFormViewer.Viewer

procedure TkwWarningFormViewer.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aWarningForm : TWarningForm;
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
 aCtx.rEngine.PushObj((Viewer(aCtx, l_aWarningForm)));
end;//TkwWarningFormViewer.DoDoIt

class function TkwWarningFormViewer.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TWarningForm.Viewer';
end;//TkwWarningFormViewer.GetWordNameForRegister

procedure TkwWarningFormViewer.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� Viewer', aCtx);
end;//TkwWarningFormViewer.SetValuePrim

function TkwWarningFormViewer.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TnscEditor);
end;//TkwWarningFormViewer.GetResultTypeInfo

function TkwWarningFormViewer.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwWarningFormViewer.GetAllParamsCount

function TkwWarningFormViewer.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TWarningForm)]);
end;//TkwWarningFormViewer.ParamsTypes
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_Form_Warning
 Tkw_Form_Warning.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_Warning_Control_Viewer
 Tkw_Warning_Control_Viewer.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_Warning_Control_Viewer_Push
 Tkw_Warning_Control_Viewer_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� WarningForm_Viewer
 TkwWarningFormViewer.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� ���� TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� ���� Warning
 TtfwTypeRegistrator.RegisterType(TypeInfo(TWarningForm));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� ���� TnscEditor
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscEditor));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.