unit ChatHistoryKeywordsPack;
 {* Набор слов словаря для доступа к экземплярам контролов формы ChatHistory }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Chat\ChatHistoryKeywordsPack.pas"
// Стереотип: "ScriptKeywordsPack"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , BaseChat_Module
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
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
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
//#UC START# *4DDFD2EA0116_82F1C54029D7_var*
//#UC END# *4DDFD2EA0116_82F1C54029D7_var*
begin
//#UC START# *4DDFD2EA0116_82F1C54029D7_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_82F1C54029D7_impl*
end;//Tkw_Form_ChatHistory.GetString

class function Tkw_ChatHistory_Control_HistoryEditor.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::HistoryEditor';
end;//Tkw_ChatHistory_Control_HistoryEditor.GetWordNameForRegister

function Tkw_ChatHistory_Control_HistoryEditor.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_E5862B29503B_var*
//#UC END# *4DDFD2EA0116_E5862B29503B_var*
begin
//#UC START# *4DDFD2EA0116_E5862B29503B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_E5862B29503B_impl*
end;//Tkw_ChatHistory_Control_HistoryEditor.GetString

class procedure Tkw_ChatHistory_Control_HistoryEditor.RegisterInEngine;
//#UC START# *52A086150180_E5862B29503B_var*
//#UC END# *52A086150180_E5862B29503B_var*
begin
//#UC START# *52A086150180_E5862B29503B_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_E5862B29503B_impl*
end;//Tkw_ChatHistory_Control_HistoryEditor.RegisterInEngine

procedure Tkw_ChatHistory_Control_HistoryEditor_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_E926DAC9D726_var*
//#UC END# *4DAEEDE10285_E926DAC9D726_var*
begin
//#UC START# *4DAEEDE10285_E926DAC9D726_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_E926DAC9D726_impl*
end;//Tkw_ChatHistory_Control_HistoryEditor_Push.DoDoIt

class function Tkw_ChatHistory_Control_HistoryEditor_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::HistoryEditor:push';
end;//Tkw_ChatHistory_Control_HistoryEditor_Push.GetWordNameForRegister

function TkwChatHistoryFormHistoryEditor.HistoryEditor(const aCtx: TtfwContext;
 aChatHistoryForm: TChatHistoryForm): TnscChatMemo;
 {* Реализация слова скрипта .TChatHistoryForm.HistoryEditor }
//#UC START# *AF9CC47CF2D1_07D7665942C7_var*
//#UC END# *AF9CC47CF2D1_07D7665942C7_var*
begin
//#UC START# *AF9CC47CF2D1_07D7665942C7_impl*
 !!! Needs to be implemented !!!
//#UC END# *AF9CC47CF2D1_07D7665942C7_impl*
end;//TkwChatHistoryFormHistoryEditor.HistoryEditor

procedure TkwChatHistoryFormHistoryEditor.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_07D7665942C7_var*
//#UC END# *4DAEEDE10285_07D7665942C7_var*
begin
//#UC START# *4DAEEDE10285_07D7665942C7_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_07D7665942C7_impl*
end;//TkwChatHistoryFormHistoryEditor.DoDoIt

class function TkwChatHistoryFormHistoryEditor.GetWordNameForRegister: AnsiString;
begin
 Result := '.TChatHistoryForm.HistoryEditor';
end;//TkwChatHistoryFormHistoryEditor.GetWordNameForRegister

procedure TkwChatHistoryFormHistoryEditor.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_07D7665942C7_var*
//#UC END# *52D00B00031A_07D7665942C7_var*
begin
//#UC START# *52D00B00031A_07D7665942C7_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_07D7665942C7_impl*
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
 Result := OpenTypesToTypes([]);
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
