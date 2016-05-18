unit QueryCardKeywordsPack;
 {* ����� ���� ������� ��� ������� � ����������� ��������� ����� QueryCard }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\QueryCardKeywordsPack.pas"
// ���������: "ScriptKeywordsPack"
// ������� ������: "QueryCardKeywordsPack" MUID: (4AA9393C0164_Pack)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3IntfUses
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)

implementation

{$If NOT Defined(Admin) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3ImplUses
 , QueryCard_Form
 , tfwPropertyLike
 , evQueryCardEditor
 , tfwScriptingInterfaces
 , TypInfo
 , tfwTypeInfo
 , evTextSource
 , tfwControlString
 , kwBynameControlPush
 , TtfwClassRef_Proxy
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
;

type
 TkwEnQueryCardEditor = {final} class(TtfwPropertyLike)
  {* ����� ������� .TenQueryCard.Editor }
  private
   function Editor(const aCtx: TtfwContext;
    aenQueryCard: TenQueryCard): TevQueryCardEditor;
    {* ���������� ����� ������� .TenQueryCard.Editor }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
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
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEnQueryCardTextSource

 Tkw_Form_QueryCard = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� ����� QueryCard
----
*������ �������������*:
[code]�����::QueryCard TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Form_QueryCard

 Tkw_QueryCard_Control_Editor = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� Editor
----
*������ �������������*:
[code]�������::Editor TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_QueryCard_Control_Editor

 Tkw_QueryCard_Control_Editor_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� Editor
----
*������ �������������*:
[code]�������::Editor:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_QueryCard_Control_Editor_Push

 Tkw_QueryCard_Component_TextSource = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� TextSource
----
*������ �������������*:
[code]���������::TextSource TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_QueryCard_Component_TextSource

function TkwEnQueryCardEditor.Editor(const aCtx: TtfwContext;
 aenQueryCard: TenQueryCard): TevQueryCardEditor;
 {* ���������� ����� ������� .TenQueryCard.Editor }
begin
 Result := aenQueryCard.Editor;
end;//TkwEnQueryCardEditor.Editor

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

function TkwEnQueryCardTextSource.TextSource(const aCtx: TtfwContext;
 aenQueryCard: TenQueryCard): TevTextSource;
 {* ���������� ����� ������� .TenQueryCard.TextSource }
begin
 Result := aenQueryCard.TextSource;
end;//TkwEnQueryCardTextSource.TextSource

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

function Tkw_Form_QueryCard.GetString: AnsiString;
begin
 Result := 'enQueryCard';
end;//Tkw_Form_QueryCard.GetString

class procedure Tkw_Form_QueryCard.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TenQueryCard);
end;//Tkw_Form_QueryCard.RegisterInEngine

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

initialization
 TkwEnQueryCardEditor.RegisterInEngine;
 {* ����������� enQueryCard_Editor }
 TkwEnQueryCardTextSource.RegisterInEngine;
 {* ����������� enQueryCard_TextSource }
 Tkw_Form_QueryCard.RegisterInEngine;
 {* ����������� Tkw_Form_QueryCard }
 Tkw_QueryCard_Control_Editor.RegisterInEngine;
 {* ����������� Tkw_QueryCard_Control_Editor }
 Tkw_QueryCard_Control_Editor_Push.RegisterInEngine;
 {* ����������� Tkw_QueryCard_Control_Editor_Push }
 Tkw_QueryCard_Component_TextSource.RegisterInEngine;
 {* ����������� Tkw_QueryCard_Component_TextSource }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TenQueryCard));
 {* ����������� ���� TenQueryCard }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TevQueryCardEditor));
 {* ����������� ���� TevQueryCardEditor }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TevTextSource));
 {* ����������� ���� TevTextSource }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)

end.
