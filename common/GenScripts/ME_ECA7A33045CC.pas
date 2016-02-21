unit ChatHistoryKeywordsPack;
 {* Набор слов словаря для доступа к экземплярам контролов формы ChatHistory }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Chat\ChatHistoryKeywordsPack.pas"
// Стереотип: "ScriptKeywordsPack"

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
  {* Слово словаря для идентификатора формы ChatHistory
----
*Пример использования*:
[code]
'aControl' форма::ChatHistory TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_ChatHistory

 Tkw_ChatHistory_Control_HistoryEditor = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола HistoryEditor
----
*Пример использования*:
[code]
контрол::HistoryEditor TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_ChatHistory_Control_HistoryEditor

 Tkw_ChatHistory_Control_HistoryEditor_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола HistoryEditor
----
*Пример использования*:
[code]
контрол::HistoryEditor:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_ChatHistory_Control_HistoryEditor_Push

 TkwChatHistoryFormHistoryEditor = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TChatHistoryForm.HistoryEditor
[panel]Контрол HistoryEditor формы TChatHistoryForm[panel]
*Тип результата:* TnscChatMemo
*Пример:*
[code]
OBJECT VAR l_TnscChatMemo
 aChatHistoryForm .TChatHistoryForm.HistoryEditor >>> l_TnscChatMemo
[code]  }
  private
   function HistoryEditor(const aCtx: TtfwContext;
    aChatHistoryForm: TChatHistoryForm): TnscChatMemo;
    {* Реализация слова скрипта .TChatHistoryForm.HistoryEditor }
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
 Result := 'форма::ChatHistory';
end;//Tkw_Form_ChatHistory.GetWordNameForRegister

function Tkw_Form_ChatHistory.GetString: AnsiString;
begin
 Result := 'ChatHistoryForm';
end;//Tkw_Form_ChatHistory.GetString

class function Tkw_ChatHistory_Control_HistoryEditor.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::HistoryEditor';
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
 Result := 'контрол::HistoryEditor:push';
end;//Tkw_ChatHistory_Control_HistoryEditor_Push.GetWordNameForRegister

function TkwChatHistoryFormHistoryEditor.HistoryEditor(const aCtx: TtfwContext;
 aChatHistoryForm: TChatHistoryForm): TnscChatMemo;
 {* Реализация слова скрипта .TChatHistoryForm.HistoryEditor }
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
   RunnerError('Ошибка при получении параметра aChatHistoryForm: TChatHistoryForm : ' + E.Message, aCtx);
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
 RunnerError('Нельзя присваивать значение readonly свойству HistoryEditor', aCtx);
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
 {* Регистрация Tkw_Form_ChatHistory }
 Tkw_ChatHistory_Control_HistoryEditor.RegisterInEngine;
 {* Регистрация Tkw_ChatHistory_Control_HistoryEditor }
 Tkw_ChatHistory_Control_HistoryEditor_Push.RegisterInEngine;
 {* Регистрация Tkw_ChatHistory_Control_HistoryEditor_Push }
 TkwChatHistoryFormHistoryEditor.RegisterInEngine;
 {* Регистрация ChatHistoryForm_HistoryEditor }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TChatHistoryForm));
 {* Регистрация типа ChatHistory }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscChatMemo));
 {* Регистрация типа TnscChatMemo }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

end.
