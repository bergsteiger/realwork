unit ChatHistoryKeywordsPack;
 {* ����� ���� ������� ��� ������� � ����������� ��������� ����� ChatHistory }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Chat\ChatHistoryKeywordsPack.pas"
// ���������: "ScriptKeywordsPack"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , ChatHistory_Form
 {$If Defined(Nemesis)}
 , nscChatMemo
 {$IfEnd} // Defined(Nemesis)
 , tfwControlString
 {$If NOT Defined(NoVCL)}
 , kwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 , tfwScriptingInterfaces
 , tfwPropertyLike
 , tfwTypeInfo
 , TypInfo
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , TtfwClassRef_Proxy
 , SysUtils
;

type
 Tkw_Form_ChatHistory = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� ����� ChatHistory
----
*������ �������������*:
[code]
'aControl' �����::ChatHistory TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_ChatHistory

 Tkw_ChatHistory_Control_HistoryEditor = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� HistoryEditor
----
*������ �������������*:
[code]
�������::HistoryEditor TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_ChatHistory_Control_HistoryEditor

 Tkw_ChatHistory_Control_HistoryEditor_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� HistoryEditor
----
*������ �������������*:
[code]
�������::HistoryEditor:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_ChatHistory_Control_HistoryEditor_Push

 TkwChatHistoryFormHistoryEditor = {final} class(TtfwPropertyLike)
  {* ����� ������� .TChatHistoryForm.HistoryEditor
[panel]������� HistoryEditor ����� TChatHistoryForm[panel]
*��� ����������:* TnscChatMemo
*������:*
[code]
OBJECT VAR l_TnscChatMemo
 aChatHistoryForm .TChatHistoryForm.HistoryEditor >>> l_TnscChatMemo
[code]  }
  private
   function HistoryEditor(const aCtx: TtfwContext;
    aChatHistoryForm: TChatHistoryForm): TnscChatMemo;
    {* ���������� ����� ������� .TChatHistoryForm.HistoryEditor }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwChatHistoryFormHistoryEditor

class function Tkw_Form_ChatHistory.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::ChatHistory';
end;//Tkw_Form_ChatHistory.GetWordNameForRegister

function Tkw_Form_ChatHistory.GetString: AnsiString;
begin
 Result := 'ChatHistoryForm';
end;//Tkw_Form_ChatHistory.GetString

class function Tkw_ChatHistory_Control_HistoryEditor.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::HistoryEditor';
end;//Tkw_ChatHistory_Control_HistoryEditor.GetWordNameForRegister

function Tkw_ChatHistory_Control_HistoryEditor.GetString: AnsiString;
begin
 Result := 'HistoryEditor';
end;//Tkw_ChatHistory_Control_HistoryEditor.GetString

class procedure Tkw_ChatHistory_Control_HistoryEditor.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscChatMemo);
end;//Tkw_ChatHistory_Control_HistoryEditor.RegisterInEngine

procedure Tkw_ChatHistory_Control_HistoryEditor_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('HistoryEditor');
 inherited;
end;//Tkw_ChatHistory_Control_HistoryEditor_Push.DoDoIt

class function Tkw_ChatHistory_Control_HistoryEditor_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::HistoryEditor:push';
end;//Tkw_ChatHistory_Control_HistoryEditor_Push.GetWordNameForRegister

function TkwChatHistoryFormHistoryEditor.HistoryEditor(const aCtx: TtfwContext;
 aChatHistoryForm: TChatHistoryForm): TnscChatMemo;
 {* ���������� ����� ������� .TChatHistoryForm.HistoryEditor }
begin
 Result := aChatHistoryForm.HistoryEditor;
end;//TkwChatHistoryFormHistoryEditor.HistoryEditor

procedure TkwChatHistoryFormHistoryEditor.DoDoIt(const aCtx: TtfwContext);
var l_aChatHistoryForm: TChatHistoryForm;
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
 aCtx.rEngine.PushObj(HistoryEditor(aCtx, l_aChatHistoryForm));
end;//TkwChatHistoryFormHistoryEditor.DoDoIt

class function TkwChatHistoryFormHistoryEditor.GetWordNameForRegister: AnsiString;
begin
 Result := '.TChatHistoryForm.HistoryEditor';
end;//TkwChatHistoryFormHistoryEditor.GetWordNameForRegister

procedure TkwChatHistoryFormHistoryEditor.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� HistoryEditor', aCtx);
end;//TkwChatHistoryFormHistoryEditor.SetValuePrim

function TkwChatHistoryFormHistoryEditor.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscChatMemo);
end;//TkwChatHistoryFormHistoryEditor.GetResultTypeInfo

function TkwChatHistoryFormHistoryEditor.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwChatHistoryFormHistoryEditor.GetAllParamsCount

function TkwChatHistoryFormHistoryEditor.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TChatHistoryForm)]);
end;//TkwChatHistoryFormHistoryEditor.ParamsTypes

initialization
 Tkw_Form_ChatHistory.RegisterInEngine;
 {* ����������� Tkw_Form_ChatHistory }
 Tkw_ChatHistory_Control_HistoryEditor.RegisterInEngine;
 {* ����������� Tkw_ChatHistory_Control_HistoryEditor }
 Tkw_ChatHistory_Control_HistoryEditor_Push.RegisterInEngine;
 {* ����������� Tkw_ChatHistory_Control_HistoryEditor_Push }
 TkwChatHistoryFormHistoryEditor.RegisterInEngine;
 {* ����������� ChatHistoryForm_HistoryEditor }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* ����������� ���� TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TChatHistoryForm));
 {* ����������� ���� ChatHistory }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscChatMemo));
 {* ����������� ���� TnscChatMemo }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

end.
