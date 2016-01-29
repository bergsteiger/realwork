unit ChatHistoryKeywordsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Chat/ChatHistoryKeywordsPack.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeywordsPack::Class>> F1 Встроенные продукты::Chat::View::Chat::BaseChat::ChatHistoryKeywordsPack
//
// Набор слов словаря для доступа к экземплярам контролов формы ChatHistory
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

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
   {* Слово словаря для идентификатора формы ChatHistory
----
*Пример использования*:
[code]
'aControl' форма::ChatHistory TryFocus ASSERT
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
 Result := 'форма::ChatHistory';
end;//Tkw_Form_ChatHistory.GetWordNameForRegister

function Tkw_Form_ChatHistory.GetString: AnsiString;
 {-}
begin
 Result := 'ChatHistoryForm';
end;//Tkw_Form_ChatHistory.GetString

type
  Tkw_ChatHistory_Control_HistoryEditor = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола HistoryEditor
----
*Пример использования*:
[code]
контрол::HistoryEditor TryFocus ASSERT
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
 Result := 'контрол::HistoryEditor';
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
   {* Слово словаря для контрола HistoryEditor
----
*Пример использования*:
[code]
контрол::HistoryEditor:push pop:control:SetFocus ASSERT
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
 Result := 'контрол::HistoryEditor:push';
end;//Tkw_ChatHistory_Control_HistoryEditor_Push.GetWordNameForRegister

type
  TkwChatHistoryFormHistoryEditor = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TChatHistoryForm.HistoryEditor
[panel]Контрол HistoryEditor формы TChatHistoryForm[panel]
*Тип результата:* TnscChatMemo
*Пример:*
[code]
OBJECT VAR l_TnscChatMemo
 aChatHistoryForm .TChatHistoryForm.HistoryEditor >>> l_TnscChatMemo
[code]  }
  private
  // private methods
   function HistoryEditor(const aCtx: TtfwContext;
     aChatHistoryForm: TChatHistoryForm): TnscChatMemo;
     {* Реализация слова скрипта .TChatHistoryForm.HistoryEditor }
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
   RunnerError('Ошибка при получении параметра aChatHistoryForm: TChatHistoryForm : ' + E.Message, aCtx);
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
 RunnerError('Нельзя присваивать значение readonly свойству HistoryEditor', aCtx);
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
// Регистрация Tkw_Form_ChatHistory
 Tkw_Form_ChatHistory.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_ChatHistory_Control_HistoryEditor
 Tkw_ChatHistory_Control_HistoryEditor.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_ChatHistory_Control_HistoryEditor_Push
 Tkw_ChatHistory_Control_HistoryEditor_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация ChatHistoryForm_HistoryEditor
 TkwChatHistoryFormHistoryEditor.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа ChatHistory
 TtfwTypeRegistrator.RegisterType(TypeInfo(TChatHistoryForm));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TnscChatMemo
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscChatMemo));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.