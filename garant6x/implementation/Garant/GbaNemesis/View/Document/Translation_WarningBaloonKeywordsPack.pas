unit Translation_WarningBaloonKeywordsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/Document/Translation_WarningBaloonKeywordsPack.pas"
// �����: 05.02.2009 19:28
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<ScriptKeywordsPack::Class>> F1 ������ � ���������� � ������� ����������::Document::View::Document::Document::Translation_WarningBaloonKeywordsPack
//
// ����� ���� ������� ��� ������� � ����������� ��������� ����� Translation_WarningBaloon
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
  Translation_WarningBaloon_Form
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
  Tkw_Form_Translation_WarningBaloon = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� ����� Translation_WarningBaloon
----
*������ �������������*:
[code]
'aControl' �����::Translation_WarningBaloon TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
  end;//Tkw_Form_Translation_WarningBaloon

// start class Tkw_Form_Translation_WarningBaloon

class function Tkw_Form_Translation_WarningBaloon.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�����::Translation_WarningBaloon';
end;//Tkw_Form_Translation_WarningBaloon.GetWordNameForRegister

function Tkw_Form_Translation_WarningBaloon.GetString: AnsiString;
 {-}
begin
 Result := 'Translation_WarningBaloonForm';
end;//Tkw_Form_Translation_WarningBaloon.GetString

type
  Tkw_Translation_WarningBaloon_Control_Viewer = {final scriptword} class(TtfwControlString)
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
  end;//Tkw_Translation_WarningBaloon_Control_Viewer

// start class Tkw_Translation_WarningBaloon_Control_Viewer

class function Tkw_Translation_WarningBaloon_Control_Viewer.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::Viewer';
end;//Tkw_Translation_WarningBaloon_Control_Viewer.GetWordNameForRegister

function Tkw_Translation_WarningBaloon_Control_Viewer.GetString: AnsiString;
 {-}
begin
 Result := 'Viewer';
end;//Tkw_Translation_WarningBaloon_Control_Viewer.GetString

class procedure Tkw_Translation_WarningBaloon_Control_Viewer.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TnscEditor);
end;//Tkw_Translation_WarningBaloon_Control_Viewer.RegisterInEngine

type
  Tkw_Translation_WarningBaloon_Control_Viewer_Push = {final scriptword} class(TkwBynameControlPush)
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
  end;//Tkw_Translation_WarningBaloon_Control_Viewer_Push

// start class Tkw_Translation_WarningBaloon_Control_Viewer_Push

procedure Tkw_Translation_WarningBaloon_Control_Viewer_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('Viewer');
 inherited;
end;//Tkw_Translation_WarningBaloon_Control_Viewer_Push.DoDoIt

class function Tkw_Translation_WarningBaloon_Control_Viewer_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::Viewer:push';
end;//Tkw_Translation_WarningBaloon_Control_Viewer_Push.GetWordNameForRegister

type
  TkwTranslationWarningBaloonFormViewer = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .TTranslation_WarningBaloonForm.Viewer
[panel]������� Viewer ����� TTranslation_WarningBaloonForm[panel]
*��� ����������:* TnscEditor
*������:*
[code]
OBJECT VAR l_TnscEditor
 aTranslation_WarningBaloonForm .TTranslation_WarningBaloonForm.Viewer >>> l_TnscEditor
[code]  }
  private
  // private methods
   function Viewer(const aCtx: TtfwContext;
     aTranslation_WarningBaloonForm: TTranslation_WarningBaloonForm): TnscEditor;
     {* ���������� ����� ������� .TTranslation_WarningBaloonForm.Viewer }
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
  end;//TkwTranslationWarningBaloonFormViewer

// start class TkwTranslationWarningBaloonFormViewer

function TkwTranslationWarningBaloonFormViewer.Viewer(const aCtx: TtfwContext;
  aTranslation_WarningBaloonForm: TTranslation_WarningBaloonForm): TnscEditor;
 {-}
begin
 Result := aTranslation_WarningBaloonForm.Viewer;
end;//TkwTranslationWarningBaloonFormViewer.Viewer

procedure TkwTranslationWarningBaloonFormViewer.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aTranslation_WarningBaloonForm : TTranslation_WarningBaloonForm;
begin
 try
  l_aTranslation_WarningBaloonForm := TTranslation_WarningBaloonForm(aCtx.rEngine.PopObjAs(TTranslation_WarningBaloonForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aTranslation_WarningBaloonForm: TTranslation_WarningBaloonForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((Viewer(aCtx, l_aTranslation_WarningBaloonForm)));
end;//TkwTranslationWarningBaloonFormViewer.DoDoIt

class function TkwTranslationWarningBaloonFormViewer.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TTranslation_WarningBaloonForm.Viewer';
end;//TkwTranslationWarningBaloonFormViewer.GetWordNameForRegister

procedure TkwTranslationWarningBaloonFormViewer.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� Viewer', aCtx);
end;//TkwTranslationWarningBaloonFormViewer.SetValuePrim

function TkwTranslationWarningBaloonFormViewer.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TnscEditor);
end;//TkwTranslationWarningBaloonFormViewer.GetResultTypeInfo

function TkwTranslationWarningBaloonFormViewer.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwTranslationWarningBaloonFormViewer.GetAllParamsCount

function TkwTranslationWarningBaloonFormViewer.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TTranslation_WarningBaloonForm)]);
end;//TkwTranslationWarningBaloonFormViewer.ParamsTypes
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_Form_Translation_WarningBaloon
 Tkw_Form_Translation_WarningBaloon.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_Translation_WarningBaloon_Control_Viewer
 Tkw_Translation_WarningBaloon_Control_Viewer.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_Translation_WarningBaloon_Control_Viewer_Push
 Tkw_Translation_WarningBaloon_Control_Viewer_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Translation_WarningBaloonForm_Viewer
 TkwTranslationWarningBaloonFormViewer.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� ���� TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� ���� Translation_WarningBaloon
 TtfwTypeRegistrator.RegisterType(TypeInfo(TTranslation_WarningBaloonForm));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� ���� TnscEditor
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscEditor));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.