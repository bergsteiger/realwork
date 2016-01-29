unit QueryCardKeywordsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View$For F1 and Monitorings"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/Search/QueryCardKeywordsPack.pas"
// �����: 10.09.2009 21:03
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<ScriptKeywordsPack::Class>> F1 Common For Shell And Monitoring::Search::View$For F1 and Monitorings::Search$Presentation for F1 and Monitorings::CommonSearch::QueryCardKeywordsPack
//
// ����� ���� ������� ��� ������� � ����������� ��������� ����� QueryCard
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(NoScripts)}
uses
  evTextSource,
  evQueryCardEditor,
  QueryCard_Form,
  tfwScriptingInterfaces
  {$If not defined(NoScripts) AND not defined(NoVCL)}
  ,
  kwBynameControlPush
  {$IfEnd} //not NoScripts AND not NoVCL
  ,
  tfwControlString,
  tfwPropertyLike
  ;

{$IfEnd} //not Admin AND not NoScripts

implementation

{$If not defined(Admin) AND not defined(NoScripts)}
uses
  TtfwClassRef_Proxy,
  tfwScriptingTypes,
  TypInfo,
  SysUtils,
  tfwTypeRegistrator
  ;

type
  Tkw_Form_QueryCard = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� ����� QueryCard
----
*������ �������������*:
[code]
'aControl' �����::QueryCard TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
  end;//Tkw_Form_QueryCard

// start class Tkw_Form_QueryCard

class function Tkw_Form_QueryCard.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�����::QueryCard';
end;//Tkw_Form_QueryCard.GetWordNameForRegister

function Tkw_Form_QueryCard.GetString: AnsiString;
 {-}
begin
 Result := 'enQueryCard';
end;//Tkw_Form_QueryCard.GetString

type
  Tkw_QueryCard_Control_Editor = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� Editor
----
*������ �������������*:
[code]
�������::Editor TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_QueryCard_Control_Editor

// start class Tkw_QueryCard_Control_Editor

class function Tkw_QueryCard_Control_Editor.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::Editor';
end;//Tkw_QueryCard_Control_Editor.GetWordNameForRegister

function Tkw_QueryCard_Control_Editor.GetString: AnsiString;
 {-}
begin
 Result := 'Editor';
end;//Tkw_QueryCard_Control_Editor.GetString

class procedure Tkw_QueryCard_Control_Editor.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TevQueryCardEditor);
end;//Tkw_QueryCard_Control_Editor.RegisterInEngine

type
  Tkw_QueryCard_Control_Editor_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� Editor
----
*������ �������������*:
[code]
�������::Editor:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_QueryCard_Control_Editor_Push

// start class Tkw_QueryCard_Control_Editor_Push

procedure Tkw_QueryCard_Control_Editor_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('Editor');
 inherited;
end;//Tkw_QueryCard_Control_Editor_Push.DoDoIt

class function Tkw_QueryCard_Control_Editor_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::Editor:push';
end;//Tkw_QueryCard_Control_Editor_Push.GetWordNameForRegister

type
  Tkw_QueryCard_Component_TextSource = {final scriptword} class(TtfwControlString)
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
  end;//Tkw_QueryCard_Component_TextSource

// start class Tkw_QueryCard_Component_TextSource

class function Tkw_QueryCard_Component_TextSource.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '���������::TextSource';
end;//Tkw_QueryCard_Component_TextSource.GetWordNameForRegister

function Tkw_QueryCard_Component_TextSource.GetString: AnsiString;
 {-}
begin
 Result := 'TextSource';
end;//Tkw_QueryCard_Component_TextSource.GetString

class procedure Tkw_QueryCard_Component_TextSource.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TevTextSource);
end;//Tkw_QueryCard_Component_TextSource.RegisterInEngine

type
  TkwEnQueryCardEditor = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .TenQueryCard.Editor
[panel]������� Editor ����� TenQueryCard[panel]
*��� ����������:* TevQueryCardEditor
*������:*
[code]
OBJECT VAR l_TevQueryCardEditor
 aenQueryCard .TenQueryCard.Editor >>> l_TevQueryCardEditor
[code]  }
  private
  // private methods
   function Editor(const aCtx: TtfwContext;
     aenQueryCard: TenQueryCard): TevQueryCardEditor;
     {* ���������� ����� ������� .TenQueryCard.Editor }
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
  end;//TkwEnQueryCardEditor

// start class TkwEnQueryCardEditor

function TkwEnQueryCardEditor.Editor(const aCtx: TtfwContext;
  aenQueryCard: TenQueryCard): TevQueryCardEditor;
 {-}
begin
 Result := aenQueryCard.Editor;
end;//TkwEnQueryCardEditor.Editor

procedure TkwEnQueryCardEditor.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aenQueryCard : TenQueryCard;
begin
 try
  l_aenQueryCard := TenQueryCard(aCtx.rEngine.PopObjAs(TenQueryCard));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aenQueryCard: TenQueryCard : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((Editor(aCtx, l_aenQueryCard)));
end;//TkwEnQueryCardEditor.DoDoIt

class function TkwEnQueryCardEditor.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TenQueryCard.Editor';
end;//TkwEnQueryCardEditor.GetWordNameForRegister

procedure TkwEnQueryCardEditor.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� Editor', aCtx);
end;//TkwEnQueryCardEditor.SetValuePrim

function TkwEnQueryCardEditor.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TevQueryCardEditor);
end;//TkwEnQueryCardEditor.GetResultTypeInfo

function TkwEnQueryCardEditor.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEnQueryCardEditor.GetAllParamsCount

function TkwEnQueryCardEditor.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TenQueryCard)]);
end;//TkwEnQueryCardEditor.ParamsTypes

type
  TkwEnQueryCardTextSource = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .TenQueryCard.TextSource
[panel]������� TextSource ����� TenQueryCard[panel]
*��� ����������:* TevTextSource
*������:*
[code]
OBJECT VAR l_TevTextSource
 aenQueryCard .TenQueryCard.TextSource >>> l_TevTextSource
[code]  }
  private
  // private methods
   function TextSource(const aCtx: TtfwContext;
     aenQueryCard: TenQueryCard): TevTextSource;
     {* ���������� ����� ������� .TenQueryCard.TextSource }
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
  end;//TkwEnQueryCardTextSource

// start class TkwEnQueryCardTextSource

function TkwEnQueryCardTextSource.TextSource(const aCtx: TtfwContext;
  aenQueryCard: TenQueryCard): TevTextSource;
 {-}
begin
 Result := aenQueryCard.TextSource;
end;//TkwEnQueryCardTextSource.TextSource

procedure TkwEnQueryCardTextSource.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aenQueryCard : TenQueryCard;
begin
 try
  l_aenQueryCard := TenQueryCard(aCtx.rEngine.PopObjAs(TenQueryCard));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aenQueryCard: TenQueryCard : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((TextSource(aCtx, l_aenQueryCard)));
end;//TkwEnQueryCardTextSource.DoDoIt

class function TkwEnQueryCardTextSource.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TenQueryCard.TextSource';
end;//TkwEnQueryCardTextSource.GetWordNameForRegister

procedure TkwEnQueryCardTextSource.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� TextSource', aCtx);
end;//TkwEnQueryCardTextSource.SetValuePrim

function TkwEnQueryCardTextSource.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TevTextSource);
end;//TkwEnQueryCardTextSource.GetResultTypeInfo

function TkwEnQueryCardTextSource.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEnQueryCardTextSource.GetAllParamsCount

function TkwEnQueryCardTextSource.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TenQueryCard)]);
end;//TkwEnQueryCardTextSource.ParamsTypes
{$IfEnd} //not Admin AND not NoScripts

initialization
{$If not defined(Admin) AND not defined(NoScripts)}
// ����������� Tkw_Form_QueryCard
 Tkw_Form_QueryCard.RegisterInEngine;
{$IfEnd} //not Admin AND not NoScripts
{$If not defined(Admin) AND not defined(NoScripts)}
// ����������� Tkw_QueryCard_Control_Editor
 Tkw_QueryCard_Control_Editor.RegisterInEngine;
{$IfEnd} //not Admin AND not NoScripts
{$If not defined(Admin) AND not defined(NoScripts)}
// ����������� Tkw_QueryCard_Control_Editor_Push
 Tkw_QueryCard_Control_Editor_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not NoScripts
{$If not defined(Admin) AND not defined(NoScripts)}
// ����������� Tkw_QueryCard_Component_TextSource
 Tkw_QueryCard_Component_TextSource.RegisterInEngine;
{$IfEnd} //not Admin AND not NoScripts
{$If not defined(Admin) AND not defined(NoScripts)}
// ����������� enQueryCard_Editor
 TkwEnQueryCardEditor.RegisterInEngine;
{$IfEnd} //not Admin AND not NoScripts
{$If not defined(Admin) AND not defined(NoScripts)}
// ����������� enQueryCard_TextSource
 TkwEnQueryCardTextSource.RegisterInEngine;
{$IfEnd} //not Admin AND not NoScripts
{$If not defined(Admin) AND not defined(NoScripts)}
// ����������� ���� TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //not Admin AND not NoScripts
{$If not defined(Admin) AND not defined(NoScripts)}
// ����������� ���� QueryCard
 TtfwTypeRegistrator.RegisterType(TypeInfo(TenQueryCard));
{$IfEnd} //not Admin AND not NoScripts
{$If not defined(Admin) AND not defined(NoScripts)}
// ����������� ���� TevQueryCardEditor
 TtfwTypeRegistrator.RegisterType(TypeInfo(TevQueryCardEditor));
{$IfEnd} //not Admin AND not NoScripts
{$If not defined(Admin) AND not defined(NoScripts)}
// ����������� ���� TevTextSource
 TtfwTypeRegistrator.RegisterType(TypeInfo(TevTextSource));
{$IfEnd} //not Admin AND not NoScripts

end.