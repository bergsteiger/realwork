unit SynchroView_WarningBaloonKeywordsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/Document/SynchroView_WarningBaloonKeywordsPack.pas"
// �����: 05.02.2009 19:28
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<ScriptKeywordsPack::Class>> F1 ������ � ���������� � ������� ����������::Document::View::Document::Document::SynchroView_WarningBaloonKeywordsPack
//
// ����� ���� ������� ��� ������� � ����������� ��������� ����� SynchroView_WarningBaloon
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
  SynchroView_WarningBaloon_Form
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
  Tkw_Form_SynchroView_WarningBaloon = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� ����� SynchroView_WarningBaloon
----
*������ �������������*:
[code]
'aControl' �����::SynchroView_WarningBaloon TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
  end;//Tkw_Form_SynchroView_WarningBaloon

// start class Tkw_Form_SynchroView_WarningBaloon

class function Tkw_Form_SynchroView_WarningBaloon.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�����::SynchroView_WarningBaloon';
end;//Tkw_Form_SynchroView_WarningBaloon.GetWordNameForRegister

function Tkw_Form_SynchroView_WarningBaloon.GetString: AnsiString;
 {-}
begin
 Result := 'SynchroView_WarningBaloonForm';
end;//Tkw_Form_SynchroView_WarningBaloon.GetString

type
  Tkw_SynchroView_WarningBaloon_Control_Viewer = {final scriptword} class(TtfwControlString)
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
  end;//Tkw_SynchroView_WarningBaloon_Control_Viewer

// start class Tkw_SynchroView_WarningBaloon_Control_Viewer

class function Tkw_SynchroView_WarningBaloon_Control_Viewer.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::Viewer';
end;//Tkw_SynchroView_WarningBaloon_Control_Viewer.GetWordNameForRegister

function Tkw_SynchroView_WarningBaloon_Control_Viewer.GetString: AnsiString;
 {-}
begin
 Result := 'Viewer';
end;//Tkw_SynchroView_WarningBaloon_Control_Viewer.GetString

class procedure Tkw_SynchroView_WarningBaloon_Control_Viewer.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TnscEditor);
end;//Tkw_SynchroView_WarningBaloon_Control_Viewer.RegisterInEngine

type
  Tkw_SynchroView_WarningBaloon_Control_Viewer_Push = {final scriptword} class(TkwBynameControlPush)
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
  end;//Tkw_SynchroView_WarningBaloon_Control_Viewer_Push

// start class Tkw_SynchroView_WarningBaloon_Control_Viewer_Push

procedure Tkw_SynchroView_WarningBaloon_Control_Viewer_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('Viewer');
 inherited;
end;//Tkw_SynchroView_WarningBaloon_Control_Viewer_Push.DoDoIt

class function Tkw_SynchroView_WarningBaloon_Control_Viewer_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::Viewer:push';
end;//Tkw_SynchroView_WarningBaloon_Control_Viewer_Push.GetWordNameForRegister

type
  TkwSynchroViewWarningBaloonFormViewer = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .TSynchroView_WarningBaloonForm.Viewer
[panel]������� Viewer ����� TSynchroView_WarningBaloonForm[panel]
*��� ����������:* TnscEditor
*������:*
[code]
OBJECT VAR l_TnscEditor
 aSynchroView_WarningBaloonForm .TSynchroView_WarningBaloonForm.Viewer >>> l_TnscEditor
[code]  }
  private
  // private methods
   function Viewer(const aCtx: TtfwContext;
     aSynchroView_WarningBaloonForm: TSynchroView_WarningBaloonForm): TnscEditor;
     {* ���������� ����� ������� .TSynchroView_WarningBaloonForm.Viewer }
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
  end;//TkwSynchroViewWarningBaloonFormViewer

// start class TkwSynchroViewWarningBaloonFormViewer

function TkwSynchroViewWarningBaloonFormViewer.Viewer(const aCtx: TtfwContext;
  aSynchroView_WarningBaloonForm: TSynchroView_WarningBaloonForm): TnscEditor;
 {-}
begin
 Result := aSynchroView_WarningBaloonForm.Viewer;
end;//TkwSynchroViewWarningBaloonFormViewer.Viewer

procedure TkwSynchroViewWarningBaloonFormViewer.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aSynchroView_WarningBaloonForm : TSynchroView_WarningBaloonForm;
begin
 try
  l_aSynchroView_WarningBaloonForm := TSynchroView_WarningBaloonForm(aCtx.rEngine.PopObjAs(TSynchroView_WarningBaloonForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aSynchroView_WarningBaloonForm: TSynchroView_WarningBaloonForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((Viewer(aCtx, l_aSynchroView_WarningBaloonForm)));
end;//TkwSynchroViewWarningBaloonFormViewer.DoDoIt

class function TkwSynchroViewWarningBaloonFormViewer.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TSynchroView_WarningBaloonForm.Viewer';
end;//TkwSynchroViewWarningBaloonFormViewer.GetWordNameForRegister

procedure TkwSynchroViewWarningBaloonFormViewer.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� Viewer', aCtx);
end;//TkwSynchroViewWarningBaloonFormViewer.SetValuePrim

function TkwSynchroViewWarningBaloonFormViewer.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TnscEditor);
end;//TkwSynchroViewWarningBaloonFormViewer.GetResultTypeInfo

function TkwSynchroViewWarningBaloonFormViewer.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwSynchroViewWarningBaloonFormViewer.GetAllParamsCount

function TkwSynchroViewWarningBaloonFormViewer.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TSynchroView_WarningBaloonForm)]);
end;//TkwSynchroViewWarningBaloonFormViewer.ParamsTypes
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_Form_SynchroView_WarningBaloon
 Tkw_Form_SynchroView_WarningBaloon.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_SynchroView_WarningBaloon_Control_Viewer
 Tkw_SynchroView_WarningBaloon_Control_Viewer.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_SynchroView_WarningBaloon_Control_Viewer_Push
 Tkw_SynchroView_WarningBaloon_Control_Viewer_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� SynchroView_WarningBaloonForm_Viewer
 TkwSynchroViewWarningBaloonFormViewer.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� ���� TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� ���� SynchroView_WarningBaloon
 TtfwTypeRegistrator.RegisterType(TypeInfo(TSynchroView_WarningBaloonForm));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� ���� TnscEditor
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscEditor));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.