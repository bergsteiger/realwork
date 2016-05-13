unit QueryCardKeywordsPack;
 {* ����� ���� ������� ��� ������� � ����������� ��������� ����� QueryCard }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\QueryCardKeywordsPack.pas"
// ���������: "ScriptKeywordsPack"
// ������� ������: "QueryCardKeywordsPack" MUID: (ED7E2BA7F4EF)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , evQueryCardEditor
 , evTextSource
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(NoScripts)

implementation

{$If NOT Defined(Admin) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , QueryCard_Form
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
 Tkw_Form_QueryCard = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� ����� QueryCard
----
*������ �������������*:
[code]
'aControl' �����::QueryCard TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Form_QueryCard

 Tkw_QueryCard_Control_Editor = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� Editor
----
*������ �������������*:
[code]
�������::Editor TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_QueryCard_Control_Editor

 Tkw_QueryCard_Control_Editor_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* ����� ������� ��� �������� Editor
----
*������ �������������*:
[code]
�������::Editor:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_QueryCard_Control_Editor_Push

 Tkw_QueryCard_Component_TextSource = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� TextSource
----
*������ �������������*:
[code]
���������::TextSource TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_QueryCard_Component_TextSource

 TkwEnQueryCardEditor = {final} class(TtfwPropertyLike)
  {* ����� ������� .TenQueryCard.Editor }
  private
   function Editor(const aCtx: TtfwContext;
    aenQueryCard: TenQueryCard): TevQueryCardEditor;
    {* ���������� ����� ������� .TenQueryCard.Editor }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEnQueryCardEditor

 TkwEnQueryCardTextSource = {final} class(TtfwPropertyLike)
  {* ����� ������� .TenQueryCard.TextSource }
  private
   function TextSource(const aCtx: TtfwContext;
    aenQueryCard: TenQueryCard): TevTextSource;
    {* ���������� ����� ������� .TenQueryCard.TextSource }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEnQueryCardTextSource

function Tkw_Form_QueryCard.GetString: AnsiString;
begin
 Result := 'enQueryCard';
end;//Tkw_Form_QueryCard.GetString

class function Tkw_Form_QueryCard.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::QueryCard';
end;//Tkw_Form_QueryCard.GetWordNameForRegister

function Tkw_QueryCard_Control_Editor.GetString: AnsiString;
begin
 Result := 'Editor';
end;//Tkw_QueryCard_Control_Editor.GetString

class procedure Tkw_QueryCard_Control_Editor.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TevQueryCardEditor);
end;//Tkw_QueryCard_Control_Editor.RegisterInEngine

class function Tkw_QueryCard_Control_Editor.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::Editor';
end;//Tkw_QueryCard_Control_Editor.GetWordNameForRegister

procedure Tkw_QueryCard_Control_Editor_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('Editor');
 inherited;
end;//Tkw_QueryCard_Control_Editor_Push.DoDoIt

class function Tkw_QueryCard_Control_Editor_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::Editor:push';
end;//Tkw_QueryCard_Control_Editor_Push.GetWordNameForRegister

function Tkw_QueryCard_Component_TextSource.GetString: AnsiString;
begin
 Result := 'TextSource';
end;//Tkw_QueryCard_Component_TextSource.GetString

class procedure Tkw_QueryCard_Component_TextSource.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TevTextSource);
end;//Tkw_QueryCard_Component_TextSource.RegisterInEngine

class function Tkw_QueryCard_Component_TextSource.GetWordNameForRegister: AnsiString;
begin
 Result := '���������::TextSource';
end;//Tkw_QueryCard_Component_TextSource.GetWordNameForRegister

function TkwEnQueryCardEditor.Editor(const aCtx: TtfwContext;
 aenQueryCard: TenQueryCard): TevQueryCardEditor;
 {* ���������� ����� ������� .TenQueryCard.Editor }
begin
 Result := aenQueryCard.Editor;
end;//TkwEnQueryCardEditor.Editor

procedure TkwEnQueryCardEditor.DoDoIt(const aCtx: TtfwContext);
var l_aenQueryCard: TenQueryCard;
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
 aCtx.rEngine.PushObj(Editor(aCtx, l_aenQueryCard));
end;//TkwEnQueryCardEditor.DoDoIt

class function TkwEnQueryCardEditor.GetWordNameForRegister: AnsiString;
begin
 Result := '.TenQueryCard.Editor';
end;//TkwEnQueryCardEditor.GetWordNameForRegister

function TkwEnQueryCardEditor.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TevQueryCardEditor);
end;//TkwEnQueryCardEditor.GetResultTypeInfo

function TkwEnQueryCardEditor.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnQueryCardEditor.GetAllParamsCount

function TkwEnQueryCardEditor.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TenQueryCard)]);
end;//TkwEnQueryCardEditor.ParamsTypes

procedure TkwEnQueryCardEditor.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� Editor', aCtx);
end;//TkwEnQueryCardEditor.SetValuePrim

function TkwEnQueryCardTextSource.TextSource(const aCtx: TtfwContext;
 aenQueryCard: TenQueryCard): TevTextSource;
 {* ���������� ����� ������� .TenQueryCard.TextSource }
begin
 Result := aenQueryCard.TextSource;
end;//TkwEnQueryCardTextSource.TextSource

procedure TkwEnQueryCardTextSource.DoDoIt(const aCtx: TtfwContext);
var l_aenQueryCard: TenQueryCard;
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
 aCtx.rEngine.PushObj(TextSource(aCtx, l_aenQueryCard));
end;//TkwEnQueryCardTextSource.DoDoIt

class function TkwEnQueryCardTextSource.GetWordNameForRegister: AnsiString;
begin
 Result := '.TenQueryCard.TextSource';
end;//TkwEnQueryCardTextSource.GetWordNameForRegister

function TkwEnQueryCardTextSource.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TevTextSource);
end;//TkwEnQueryCardTextSource.GetResultTypeInfo

function TkwEnQueryCardTextSource.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnQueryCardTextSource.GetAllParamsCount

function TkwEnQueryCardTextSource.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TenQueryCard)]);
end;//TkwEnQueryCardTextSource.ParamsTypes

procedure TkwEnQueryCardTextSource.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� TextSource', aCtx);
end;//TkwEnQueryCardTextSource.SetValuePrim

initialization
 Tkw_Form_QueryCard.RegisterInEngine;
 {* ����������� Tkw_Form_QueryCard }
 Tkw_QueryCard_Control_Editor.RegisterInEngine;
 {* ����������� Tkw_QueryCard_Control_Editor }
 Tkw_QueryCard_Control_Editor_Push.RegisterInEngine;
 {* ����������� Tkw_QueryCard_Control_Editor_Push }
 Tkw_QueryCard_Component_TextSource.RegisterInEngine;
 {* ����������� Tkw_QueryCard_Component_TextSource }
 TkwEnQueryCardEditor.RegisterInEngine;
 {* ����������� enQueryCard_Editor }
 TkwEnQueryCardTextSource.RegisterInEngine;
 {* ����������� enQueryCard_TextSource }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TenQueryCard));
 {* ����������� ���� TenQueryCard }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TevQueryCardEditor));
 {* ����������� ���� TevQueryCardEditor }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TevTextSource));
 {* ����������� ���� TevTextSource }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(NoScripts)

end.
