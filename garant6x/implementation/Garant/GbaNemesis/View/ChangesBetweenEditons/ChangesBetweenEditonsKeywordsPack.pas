unit ChangesBetweenEditonsKeywordsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/ChangesBetweenEditons/ChangesBetweenEditonsKeywordsPack.pas"
// �����: 24.05.2011 17:14
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<ScriptKeywordsPack::Class>> F1 ���������������� �������::ChangesBetweenEditions::View::ChangesBetweenEditons::ChangesBetweenEditions::ChangesBetweenEditonsKeywordsPack
//
// ����� ���� ������� ��� ������� � ����������� ��������� ����� ChangesBetweenEditons
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
  ChangesBetweenEditons_Form
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
  TtfwClassRef_Proxy
  {$If defined(Nemesis)}
  ,
  nscTextSource
  {$IfEnd} //Nemesis
  ,
  tfwScriptingTypes,
  TypInfo,
  SysUtils,
  tfwTypeRegistrator
  ;

type
  Tkw_Form_ChangesBetweenEditons = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� ����� ChangesBetweenEditons
----
*������ �������������*:
[code]
'aControl' �����::ChangesBetweenEditons TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
  end;//Tkw_Form_ChangesBetweenEditons

// start class Tkw_Form_ChangesBetweenEditons

class function Tkw_Form_ChangesBetweenEditons.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�����::ChangesBetweenEditons';
end;//Tkw_Form_ChangesBetweenEditons.GetWordNameForRegister

function Tkw_Form_ChangesBetweenEditons.GetString: AnsiString;
 {-}
begin
 Result := 'ChangesBetweenEditonsForm';
end;//Tkw_Form_ChangesBetweenEditons.GetString

type
  Tkw_ChangesBetweenEditons_Control_Text = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� Text
----
*������ �������������*:
[code]
�������::Text TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_ChangesBetweenEditons_Control_Text

// start class Tkw_ChangesBetweenEditons_Control_Text

class function Tkw_ChangesBetweenEditons_Control_Text.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::Text';
end;//Tkw_ChangesBetweenEditons_Control_Text.GetWordNameForRegister

function Tkw_ChangesBetweenEditons_Control_Text.GetString: AnsiString;
 {-}
begin
 Result := 'Text';
end;//Tkw_ChangesBetweenEditons_Control_Text.GetString

class procedure Tkw_ChangesBetweenEditons_Control_Text.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TnscEditor);
end;//Tkw_ChangesBetweenEditons_Control_Text.RegisterInEngine

type
  Tkw_ChangesBetweenEditons_Control_Text_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� Text
----
*������ �������������*:
[code]
�������::Text:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_ChangesBetweenEditons_Control_Text_Push

// start class Tkw_ChangesBetweenEditons_Control_Text_Push

procedure Tkw_ChangesBetweenEditons_Control_Text_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('Text');
 inherited;
end;//Tkw_ChangesBetweenEditons_Control_Text_Push.DoDoIt

class function Tkw_ChangesBetweenEditons_Control_Text_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::Text:push';
end;//Tkw_ChangesBetweenEditons_Control_Text_Push.GetWordNameForRegister

type
  Tkw_ChangesBetweenEditons_Component_TextSource = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� TextSource
----
*������ �������������*:
[code]
���������::TextSource TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_ChangesBetweenEditons_Component_TextSource

// start class Tkw_ChangesBetweenEditons_Component_TextSource

class function Tkw_ChangesBetweenEditons_Component_TextSource.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '���������::TextSource';
end;//Tkw_ChangesBetweenEditons_Component_TextSource.GetWordNameForRegister

function Tkw_ChangesBetweenEditons_Component_TextSource.GetString: AnsiString;
 {-}
begin
 Result := 'TextSource';
end;//Tkw_ChangesBetweenEditons_Component_TextSource.GetString

class procedure Tkw_ChangesBetweenEditons_Component_TextSource.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TnscTextSource);
end;//Tkw_ChangesBetweenEditons_Component_TextSource.RegisterInEngine

type
  TkwChangesBetweenEditonsFormText = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .TChangesBetweenEditonsForm.Text
[panel]������� Text ����� TChangesBetweenEditonsForm[panel]
*��� ����������:* TnscEditor
*������:*
[code]
OBJECT VAR l_TnscEditor
 aChangesBetweenEditonsForm .TChangesBetweenEditonsForm.Text >>> l_TnscEditor
[code]  }
  private
  // private methods
   function Text(const aCtx: TtfwContext;
     aChangesBetweenEditonsForm: TChangesBetweenEditonsForm): TnscEditor;
     {* ���������� ����� ������� .TChangesBetweenEditonsForm.Text }
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
  end;//TkwChangesBetweenEditonsFormText

// start class TkwChangesBetweenEditonsFormText

function TkwChangesBetweenEditonsFormText.Text(const aCtx: TtfwContext;
  aChangesBetweenEditonsForm: TChangesBetweenEditonsForm): TnscEditor;
 {-}
begin
 Result := aChangesBetweenEditonsForm.Text;
end;//TkwChangesBetweenEditonsFormText.Text

procedure TkwChangesBetweenEditonsFormText.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aChangesBetweenEditonsForm : TChangesBetweenEditonsForm;
begin
 try
  l_aChangesBetweenEditonsForm := TChangesBetweenEditonsForm(aCtx.rEngine.PopObjAs(TChangesBetweenEditonsForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aChangesBetweenEditonsForm: TChangesBetweenEditonsForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((Text(aCtx, l_aChangesBetweenEditonsForm)));
end;//TkwChangesBetweenEditonsFormText.DoDoIt

class function TkwChangesBetweenEditonsFormText.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TChangesBetweenEditonsForm.Text';
end;//TkwChangesBetweenEditonsFormText.GetWordNameForRegister

procedure TkwChangesBetweenEditonsFormText.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� Text', aCtx);
end;//TkwChangesBetweenEditonsFormText.SetValuePrim

function TkwChangesBetweenEditonsFormText.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TnscEditor);
end;//TkwChangesBetweenEditonsFormText.GetResultTypeInfo

function TkwChangesBetweenEditonsFormText.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwChangesBetweenEditonsFormText.GetAllParamsCount

function TkwChangesBetweenEditonsFormText.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TChangesBetweenEditonsForm)]);
end;//TkwChangesBetweenEditonsFormText.ParamsTypes
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_Form_ChangesBetweenEditons
 Tkw_Form_ChangesBetweenEditons.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_ChangesBetweenEditons_Control_Text
 Tkw_ChangesBetweenEditons_Control_Text.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_ChangesBetweenEditons_Control_Text_Push
 Tkw_ChangesBetweenEditons_Control_Text_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_ChangesBetweenEditons_Component_TextSource
 Tkw_ChangesBetweenEditons_Component_TextSource.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� ChangesBetweenEditonsForm_Text
 TkwChangesBetweenEditonsFormText.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� ���� TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� ���� ChangesBetweenEditons
 TtfwTypeRegistrator.RegisterType(TypeInfo(TChangesBetweenEditonsForm));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� ���� TnscEditor
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscEditor));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.