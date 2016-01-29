unit ChatHistoryKeywordsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/Chat/ChatHistoryKeywordsPack.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<ScriptKeywordsPack::Class>> F1 ���������� ��������::Chat::View::Chat::BaseChat::ChatHistoryKeywordsPack
//
// ����� ���� ������� ��� ������� � ����������� ��������� ����� ChatHistory
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
  ChatHistory_Form
  {$If defined(Nemesis)}
  ,
  nscChatMemo
  {$IfEnd} //Nemesis
  ,
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
  Tkw_Form_ChatHistory = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� ����� ChatHistory
----
*������ �������������*:
[code]
'aControl' �����::ChatHistory TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
  end;//Tkw_Form_ChatHistory

// start class Tkw_Form_ChatHistory

class function Tkw_Form_ChatHistory.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�����::ChatHistory';
end;//Tkw_Form_ChatHistory.GetWordNameForRegister

function Tkw_Form_ChatHistory.GetString: AnsiString;
 {-}
begin
 Result := 'ChatHistoryForm';
end;//Tkw_Form_ChatHistory.GetString

type
  Tkw_ChatHistory_Control_HistoryEditor = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� HistoryEditor
----
*������ �������������*:
[code]
�������::HistoryEditor TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_ChatHistory_Control_HistoryEditor

// start class Tkw_ChatHistory_Control_HistoryEditor

class function Tkw_ChatHistory_Control_HistoryEditor.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::HistoryEditor';
end;//Tkw_ChatHistory_Control_HistoryEditor.GetWordNameForRegister

function Tkw_ChatHistory_Control_HistoryEditor.GetString: AnsiString;
 {-}
begin
 Result := 'HistoryEditor';
end;//Tkw_ChatHistory_Control_HistoryEditor.GetString

class procedure Tkw_ChatHistory_Control_HistoryEditor.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TnscChatMemo);
end;//Tkw_ChatHistory_Control_HistoryEditor.RegisterInEngine

type
  Tkw_ChatHistory_Control_HistoryEditor_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� HistoryEditor
----
*������ �������������*:
[code]
�������::HistoryEditor:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_ChatHistory_Control_HistoryEditor_Push

// start class Tkw_ChatHistory_Control_HistoryEditor_Push

procedure Tkw_ChatHistory_Control_HistoryEditor_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('HistoryEditor');
 inherited;
end;//Tkw_ChatHistory_Control_HistoryEditor_Push.DoDoIt

class function Tkw_ChatHistory_Control_HistoryEditor_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::HistoryEditor:push';
end;//Tkw_ChatHistory_Control_HistoryEditor_Push.GetWordNameForRegister

type
  TkwChatHistoryFormHistoryEditor = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .TChatHistoryForm.HistoryEditor
[panel]������� HistoryEditor ����� TChatHistoryForm[panel]
*��� ����������:* TnscChatMemo
*������:*
[code]
OBJECT VAR l_TnscChatMemo
 aChatHistoryForm .TChatHistoryForm.HistoryEditor >>> l_TnscChatMemo
[code]  }
  private
  // private methods
   function HistoryEditor(const aCtx: TtfwContext;
     aChatHistoryForm: TChatHistoryForm): TnscChatMemo;
     {* ���������� ����� ������� .TChatHistoryForm.HistoryEditor }
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
  end;//TkwChatHistoryFormHistoryEditor

// start class TkwChatHistoryFormHistoryEditor

function TkwChatHistoryFormHistoryEditor.HistoryEditor(const aCtx: TtfwContext;
  aChatHistoryForm: TChatHistoryForm): TnscChatMemo;
 {-}
begin
 Result := aChatHistoryForm.HistoryEditor;
end;//TkwChatHistoryFormHistoryEditor.HistoryEditor

procedure TkwChatHistoryFormHistoryEditor.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aChatHistoryForm : TChatHistoryForm;
begin
 try
  l_aChatHistoryForm := TChatHistoryForm(aCtx.rEngine.PopObjAs(TChatHistoryForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aChatHistoryForm: TChatHistoryForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((HistoryEditor(aCtx, l_aChatHistoryForm)));
end;//TkwChatHistoryFormHistoryEditor.DoDoIt

class function TkwChatHistoryFormHistoryEditor.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TChatHistoryForm.HistoryEditor';
end;//TkwChatHistoryFormHistoryEditor.GetWordNameForRegister

procedure TkwChatHistoryFormHistoryEditor.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� HistoryEditor', aCtx);
end;//TkwChatHistoryFormHistoryEditor.SetValuePrim

function TkwChatHistoryFormHistoryEditor.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TnscChatMemo);
end;//TkwChatHistoryFormHistoryEditor.GetResultTypeInfo

function TkwChatHistoryFormHistoryEditor.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwChatHistoryFormHistoryEditor.GetAllParamsCount

function TkwChatHistoryFormHistoryEditor.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TChatHistoryForm)]);
end;//TkwChatHistoryFormHistoryEditor.ParamsTypes
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_Form_ChatHistory
 Tkw_Form_ChatHistory.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_ChatHistory_Control_HistoryEditor
 Tkw_ChatHistory_Control_HistoryEditor.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_ChatHistory_Control_HistoryEditor_Push
 Tkw_ChatHistory_Control_HistoryEditor_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� ChatHistoryForm_HistoryEditor
 TkwChatHistoryFormHistoryEditor.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� ���� TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� ���� ChatHistory
 TtfwTypeRegistrator.RegisterType(TypeInfo(TChatHistoryForm));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� ���� TnscChatMemo
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscChatMemo));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.