unit WarningBaloonKeywordsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/Document/WarningBaloonKeywordsPack.pas"
// �����: 05.02.2009 19:28
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<ScriptKeywordsPack::Class>> F1 ������ � ���������� � ������� ����������::Document::View::Document::Document::WarningBaloonKeywordsPack
//
// ����� ���� ������� ��� ������� � ����������� ��������� ����� WarningBaloon
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
  tfwScriptingInterfaces,
  WarningBaloon_Form
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
  Tkw_Form_WarningBaloon = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� ����� WarningBaloon
----
*������ �������������*:
[code]
'aControl' �����::WarningBaloon TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
  end;//Tkw_Form_WarningBaloon

// start class Tkw_Form_WarningBaloon

class function Tkw_Form_WarningBaloon.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�����::WarningBaloon';
end;//Tkw_Form_WarningBaloon.GetWordNameForRegister

function Tkw_Form_WarningBaloon.GetString: AnsiString;
 {-}
begin
 Result := 'WarningBaloonForm';
end;//Tkw_Form_WarningBaloon.GetString

type
  Tkw_WarningBaloon_Control_Viewer = {final scriptword} class(TtfwControlString)
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
  end;//Tkw_WarningBaloon_Control_Viewer

// start class Tkw_WarningBaloon_Control_Viewer

class function Tkw_WarningBaloon_Control_Viewer.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::Viewer';
end;//Tkw_WarningBaloon_Control_Viewer.GetWordNameForRegister

function Tkw_WarningBaloon_Control_Viewer.GetString: AnsiString;
 {-}
begin
 Result := 'Viewer';
end;//Tkw_WarningBaloon_Control_Viewer.GetString

class procedure Tkw_WarningBaloon_Control_Viewer.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TnscEditor);
end;//Tkw_WarningBaloon_Control_Viewer.RegisterInEngine

type
  Tkw_WarningBaloon_Control_Viewer_Push = {final scriptword} class(TkwBynameControlPush)
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
  end;//Tkw_WarningBaloon_Control_Viewer_Push

// start class Tkw_WarningBaloon_Control_Viewer_Push

procedure Tkw_WarningBaloon_Control_Viewer_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('Viewer');
 inherited;
end;//Tkw_WarningBaloon_Control_Viewer_Push.DoDoIt

class function Tkw_WarningBaloon_Control_Viewer_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::Viewer:push';
end;//Tkw_WarningBaloon_Control_Viewer_Push.GetWordNameForRegister

type
  TkwWarningBaloonFormViewer = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .TWarningBaloonForm.Viewer
[panel]������� Viewer ����� TWarningBaloonForm[panel]
*��� ����������:* TnscEditor
*������:*
[code]
OBJECT VAR l_TnscEditor
 aWarningBaloonForm .TWarningBaloonForm.Viewer >>> l_TnscEditor
[code]  }
  private
  // private methods
   function Viewer(const aCtx: TtfwContext;
     aWarningBaloonForm: TWarningBaloonForm): TnscEditor;
     {* ���������� ����� ������� .TWarningBaloonForm.Viewer }
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
  end;//TkwWarningBaloonFormViewer

// start class TkwWarningBaloonFormViewer

function TkwWarningBaloonFormViewer.Viewer(const aCtx: TtfwContext;
  aWarningBaloonForm: TWarningBaloonForm): TnscEditor;
 {-}
begin
 Result := aWarningBaloonForm.Viewer;
end;//TkwWarningBaloonFormViewer.Viewer

procedure TkwWarningBaloonFormViewer.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aWarningBaloonForm : TWarningBaloonForm;
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
 aCtx.rEngine.PushObj((Viewer(aCtx, l_aWarningBaloonForm)));
end;//TkwWarningBaloonFormViewer.DoDoIt

class function TkwWarningBaloonFormViewer.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TWarningBaloonForm.Viewer';
end;//TkwWarningBaloonFormViewer.GetWordNameForRegister

procedure TkwWarningBaloonFormViewer.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� Viewer', aCtx);
end;//TkwWarningBaloonFormViewer.SetValuePrim

function TkwWarningBaloonFormViewer.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TnscEditor);
end;//TkwWarningBaloonFormViewer.GetResultTypeInfo

function TkwWarningBaloonFormViewer.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwWarningBaloonFormViewer.GetAllParamsCount

function TkwWarningBaloonFormViewer.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TWarningBaloonForm)]);
end;//TkwWarningBaloonFormViewer.ParamsTypes
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_Form_WarningBaloon
 Tkw_Form_WarningBaloon.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_WarningBaloon_Control_Viewer
 Tkw_WarningBaloon_Control_Viewer.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_WarningBaloon_Control_Viewer_Push
 Tkw_WarningBaloon_Control_Viewer_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� WarningBaloonForm_Viewer
 TkwWarningBaloonFormViewer.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� ���� TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� ���� WarningBaloon
 TtfwTypeRegistrator.RegisterType(TypeInfo(TWarningBaloonForm));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� ���� TnscEditor
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscEditor));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.