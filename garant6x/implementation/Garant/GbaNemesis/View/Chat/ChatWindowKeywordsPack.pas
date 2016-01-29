unit ChatWindowKeywordsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Chat/ChatWindowKeywordsPack.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeywordsPack::Class>> F1 Встроенные продукты::Chat::View::Chat::BaseChat::ChatWindowKeywordsPack
//
// Набор слов словаря для доступа к экземплярам контролов формы ChatWindow
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
  ChatWindow_Form,
  vtSizeablePanel,
  vtPanel,
  vtProportionalPanel
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
  Tkw_Form_ChatWindow = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора формы ChatWindow
----
*Пример использования*:
[code]
'aControl' форма::ChatWindow TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
  end;//Tkw_Form_ChatWindow

// start class Tkw_Form_ChatWindow

class function Tkw_Form_ChatWindow.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'форма::ChatWindow';
end;//Tkw_Form_ChatWindow.GetWordNameForRegister

function Tkw_Form_ChatWindow.GetString: AnsiString;
 {-}
begin
 Result := 'ChatWindowForm';
end;//Tkw_Form_ChatWindow.GetString

type
  Tkw_ChatWindow_Control_BackgroundPanel = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола BackgroundPanel
----
*Пример использования*:
[code]
контрол::BackgroundPanel TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_ChatWindow_Control_BackgroundPanel

// start class Tkw_ChatWindow_Control_BackgroundPanel

class function Tkw_ChatWindow_Control_BackgroundPanel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::BackgroundPanel';
end;//Tkw_ChatWindow_Control_BackgroundPanel.GetWordNameForRegister

function Tkw_ChatWindow_Control_BackgroundPanel.GetString: AnsiString;
 {-}
begin
 Result := 'BackgroundPanel';
end;//Tkw_ChatWindow_Control_BackgroundPanel.GetString

class procedure Tkw_ChatWindow_Control_BackgroundPanel.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtProportionalPanel);
end;//Tkw_ChatWindow_Control_BackgroundPanel.RegisterInEngine

type
  Tkw_ChatWindow_Control_BackgroundPanel_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола BackgroundPanel
----
*Пример использования*:
[code]
контрол::BackgroundPanel:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_ChatWindow_Control_BackgroundPanel_Push

// start class Tkw_ChatWindow_Control_BackgroundPanel_Push

procedure Tkw_ChatWindow_Control_BackgroundPanel_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('BackgroundPanel');
 inherited;
end;//Tkw_ChatWindow_Control_BackgroundPanel_Push.DoDoIt

class function Tkw_ChatWindow_Control_BackgroundPanel_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::BackgroundPanel:push';
end;//Tkw_ChatWindow_Control_BackgroundPanel_Push.GetWordNameForRegister

type
  Tkw_ChatWindow_Control_BottomPanel = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола BottomPanel
----
*Пример использования*:
[code]
контрол::BottomPanel TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_ChatWindow_Control_BottomPanel

// start class Tkw_ChatWindow_Control_BottomPanel

class function Tkw_ChatWindow_Control_BottomPanel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::BottomPanel';
end;//Tkw_ChatWindow_Control_BottomPanel.GetWordNameForRegister

function Tkw_ChatWindow_Control_BottomPanel.GetString: AnsiString;
 {-}
begin
 Result := 'BottomPanel';
end;//Tkw_ChatWindow_Control_BottomPanel.GetString

class procedure Tkw_ChatWindow_Control_BottomPanel.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtSizeablePanel);
end;//Tkw_ChatWindow_Control_BottomPanel.RegisterInEngine

type
  Tkw_ChatWindow_Control_BottomPanel_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола BottomPanel
----
*Пример использования*:
[code]
контрол::BottomPanel:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_ChatWindow_Control_BottomPanel_Push

// start class Tkw_ChatWindow_Control_BottomPanel_Push

procedure Tkw_ChatWindow_Control_BottomPanel_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('BottomPanel');
 inherited;
end;//Tkw_ChatWindow_Control_BottomPanel_Push.DoDoIt

class function Tkw_ChatWindow_Control_BottomPanel_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::BottomPanel:push';
end;//Tkw_ChatWindow_Control_BottomPanel_Push.GetWordNameForRegister

type
  Tkw_ChatWindow_Control_BottomEditor = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола BottomEditor
----
*Пример использования*:
[code]
контрол::BottomEditor TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_ChatWindow_Control_BottomEditor

// start class Tkw_ChatWindow_Control_BottomEditor

class function Tkw_ChatWindow_Control_BottomEditor.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::BottomEditor';
end;//Tkw_ChatWindow_Control_BottomEditor.GetWordNameForRegister

function Tkw_ChatWindow_Control_BottomEditor.GetString: AnsiString;
 {-}
begin
 Result := 'BottomEditor';
end;//Tkw_ChatWindow_Control_BottomEditor.GetString

class procedure Tkw_ChatWindow_Control_BottomEditor.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TnscChatMemo);
end;//Tkw_ChatWindow_Control_BottomEditor.RegisterInEngine

type
  Tkw_ChatWindow_Control_BottomEditor_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола BottomEditor
----
*Пример использования*:
[code]
контрол::BottomEditor:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_ChatWindow_Control_BottomEditor_Push

// start class Tkw_ChatWindow_Control_BottomEditor_Push

procedure Tkw_ChatWindow_Control_BottomEditor_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('BottomEditor');
 inherited;
end;//Tkw_ChatWindow_Control_BottomEditor_Push.DoDoIt

class function Tkw_ChatWindow_Control_BottomEditor_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::BottomEditor:push';
end;//Tkw_ChatWindow_Control_BottomEditor_Push.GetWordNameForRegister

type
  Tkw_ChatWindow_Control_TopPanel = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола TopPanel
----
*Пример использования*:
[code]
контрол::TopPanel TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_ChatWindow_Control_TopPanel

// start class Tkw_ChatWindow_Control_TopPanel

class function Tkw_ChatWindow_Control_TopPanel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::TopPanel';
end;//Tkw_ChatWindow_Control_TopPanel.GetWordNameForRegister

function Tkw_ChatWindow_Control_TopPanel.GetString: AnsiString;
 {-}
begin
 Result := 'TopPanel';
end;//Tkw_ChatWindow_Control_TopPanel.GetString

class procedure Tkw_ChatWindow_Control_TopPanel.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_ChatWindow_Control_TopPanel.RegisterInEngine

type
  Tkw_ChatWindow_Control_TopPanel_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола TopPanel
----
*Пример использования*:
[code]
контрол::TopPanel:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_ChatWindow_Control_TopPanel_Push

// start class Tkw_ChatWindow_Control_TopPanel_Push

procedure Tkw_ChatWindow_Control_TopPanel_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('TopPanel');
 inherited;
end;//Tkw_ChatWindow_Control_TopPanel_Push.DoDoIt

class function Tkw_ChatWindow_Control_TopPanel_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::TopPanel:push';
end;//Tkw_ChatWindow_Control_TopPanel_Push.GetWordNameForRegister

type
  Tkw_ChatWindow_Control_HistoryEditor = {final scriptword} class(TtfwControlString)
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
  end;//Tkw_ChatWindow_Control_HistoryEditor

// start class Tkw_ChatWindow_Control_HistoryEditor

class function Tkw_ChatWindow_Control_HistoryEditor.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::HistoryEditor';
end;//Tkw_ChatWindow_Control_HistoryEditor.GetWordNameForRegister

function Tkw_ChatWindow_Control_HistoryEditor.GetString: AnsiString;
 {-}
begin
 Result := 'HistoryEditor';
end;//Tkw_ChatWindow_Control_HistoryEditor.GetString

class procedure Tkw_ChatWindow_Control_HistoryEditor.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TnscChatMemo);
end;//Tkw_ChatWindow_Control_HistoryEditor.RegisterInEngine

type
  Tkw_ChatWindow_Control_HistoryEditor_Push = {final scriptword} class(TkwBynameControlPush)
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
  end;//Tkw_ChatWindow_Control_HistoryEditor_Push

// start class Tkw_ChatWindow_Control_HistoryEditor_Push

procedure Tkw_ChatWindow_Control_HistoryEditor_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('HistoryEditor');
 inherited;
end;//Tkw_ChatWindow_Control_HistoryEditor_Push.DoDoIt

class function Tkw_ChatWindow_Control_HistoryEditor_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::HistoryEditor:push';
end;//Tkw_ChatWindow_Control_HistoryEditor_Push.GetWordNameForRegister

type
  TkwChatWindowFormBackgroundPanel = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TChatWindowForm.BackgroundPanel
[panel]Контрол BackgroundPanel формы TChatWindowForm[panel]
*Тип результата:* TvtProportionalPanel
*Пример:*
[code]
OBJECT VAR l_TvtProportionalPanel
 aChatWindowForm .TChatWindowForm.BackgroundPanel >>> l_TvtProportionalPanel
[code]  }
  private
  // private methods
   function BackgroundPanel(const aCtx: TtfwContext;
     aChatWindowForm: TChatWindowForm): TvtProportionalPanel;
     {* Реализация слова скрипта .TChatWindowForm.BackgroundPanel }
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
  end;//TkwChatWindowFormBackgroundPanel

// start class TkwChatWindowFormBackgroundPanel

function TkwChatWindowFormBackgroundPanel.BackgroundPanel(const aCtx: TtfwContext;
  aChatWindowForm: TChatWindowForm): TvtProportionalPanel;
 {-}
begin
 Result := aChatWindowForm.BackgroundPanel;
end;//TkwChatWindowFormBackgroundPanel.BackgroundPanel

procedure TkwChatWindowFormBackgroundPanel.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aChatWindowForm : TChatWindowForm;
begin
 try
  l_aChatWindowForm := TChatWindowForm(aCtx.rEngine.PopObjAs(TChatWindowForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aChatWindowForm: TChatWindowForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((BackgroundPanel(aCtx, l_aChatWindowForm)));
end;//TkwChatWindowFormBackgroundPanel.DoDoIt

class function TkwChatWindowFormBackgroundPanel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TChatWindowForm.BackgroundPanel';
end;//TkwChatWindowFormBackgroundPanel.GetWordNameForRegister

procedure TkwChatWindowFormBackgroundPanel.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству BackgroundPanel', aCtx);
end;//TkwChatWindowFormBackgroundPanel.SetValuePrim

function TkwChatWindowFormBackgroundPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtProportionalPanel);
end;//TkwChatWindowFormBackgroundPanel.GetResultTypeInfo

function TkwChatWindowFormBackgroundPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwChatWindowFormBackgroundPanel.GetAllParamsCount

function TkwChatWindowFormBackgroundPanel.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TChatWindowForm)]);
end;//TkwChatWindowFormBackgroundPanel.ParamsTypes

type
  TkwChatWindowFormBottomPanel = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TChatWindowForm.BottomPanel
[panel]Контрол BottomPanel формы TChatWindowForm[panel]
*Тип результата:* TvtSizeablePanel
*Пример:*
[code]
OBJECT VAR l_TvtSizeablePanel
 aChatWindowForm .TChatWindowForm.BottomPanel >>> l_TvtSizeablePanel
[code]  }
  private
  // private methods
   function BottomPanel(const aCtx: TtfwContext;
     aChatWindowForm: TChatWindowForm): TvtSizeablePanel;
     {* Реализация слова скрипта .TChatWindowForm.BottomPanel }
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
  end;//TkwChatWindowFormBottomPanel

// start class TkwChatWindowFormBottomPanel

function TkwChatWindowFormBottomPanel.BottomPanel(const aCtx: TtfwContext;
  aChatWindowForm: TChatWindowForm): TvtSizeablePanel;
 {-}
begin
 Result := aChatWindowForm.BottomPanel;
end;//TkwChatWindowFormBottomPanel.BottomPanel

procedure TkwChatWindowFormBottomPanel.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aChatWindowForm : TChatWindowForm;
begin
 try
  l_aChatWindowForm := TChatWindowForm(aCtx.rEngine.PopObjAs(TChatWindowForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aChatWindowForm: TChatWindowForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((BottomPanel(aCtx, l_aChatWindowForm)));
end;//TkwChatWindowFormBottomPanel.DoDoIt

class function TkwChatWindowFormBottomPanel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TChatWindowForm.BottomPanel';
end;//TkwChatWindowFormBottomPanel.GetWordNameForRegister

procedure TkwChatWindowFormBottomPanel.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству BottomPanel', aCtx);
end;//TkwChatWindowFormBottomPanel.SetValuePrim

function TkwChatWindowFormBottomPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtSizeablePanel);
end;//TkwChatWindowFormBottomPanel.GetResultTypeInfo

function TkwChatWindowFormBottomPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwChatWindowFormBottomPanel.GetAllParamsCount

function TkwChatWindowFormBottomPanel.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TChatWindowForm)]);
end;//TkwChatWindowFormBottomPanel.ParamsTypes

type
  TkwChatWindowFormBottomEditor = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TChatWindowForm.BottomEditor
[panel]Контрол BottomEditor формы TChatWindowForm[panel]
*Тип результата:* TnscChatMemo
*Пример:*
[code]
OBJECT VAR l_TnscChatMemo
 aChatWindowForm .TChatWindowForm.BottomEditor >>> l_TnscChatMemo
[code]  }
  private
  // private methods
   function BottomEditor(const aCtx: TtfwContext;
     aChatWindowForm: TChatWindowForm): TnscChatMemo;
     {* Реализация слова скрипта .TChatWindowForm.BottomEditor }
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
  end;//TkwChatWindowFormBottomEditor

// start class TkwChatWindowFormBottomEditor

function TkwChatWindowFormBottomEditor.BottomEditor(const aCtx: TtfwContext;
  aChatWindowForm: TChatWindowForm): TnscChatMemo;
 {-}
begin
 Result := aChatWindowForm.BottomEditor;
end;//TkwChatWindowFormBottomEditor.BottomEditor

procedure TkwChatWindowFormBottomEditor.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aChatWindowForm : TChatWindowForm;
begin
 try
  l_aChatWindowForm := TChatWindowForm(aCtx.rEngine.PopObjAs(TChatWindowForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aChatWindowForm: TChatWindowForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((BottomEditor(aCtx, l_aChatWindowForm)));
end;//TkwChatWindowFormBottomEditor.DoDoIt

class function TkwChatWindowFormBottomEditor.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TChatWindowForm.BottomEditor';
end;//TkwChatWindowFormBottomEditor.GetWordNameForRegister

procedure TkwChatWindowFormBottomEditor.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству BottomEditor', aCtx);
end;//TkwChatWindowFormBottomEditor.SetValuePrim

function TkwChatWindowFormBottomEditor.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TnscChatMemo);
end;//TkwChatWindowFormBottomEditor.GetResultTypeInfo

function TkwChatWindowFormBottomEditor.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwChatWindowFormBottomEditor.GetAllParamsCount

function TkwChatWindowFormBottomEditor.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TChatWindowForm)]);
end;//TkwChatWindowFormBottomEditor.ParamsTypes

type
  TkwChatWindowFormTopPanel = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TChatWindowForm.TopPanel
[panel]Контрол TopPanel формы TChatWindowForm[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aChatWindowForm .TChatWindowForm.TopPanel >>> l_TvtPanel
[code]  }
  private
  // private methods
   function TopPanel(const aCtx: TtfwContext;
     aChatWindowForm: TChatWindowForm): TvtPanel;
     {* Реализация слова скрипта .TChatWindowForm.TopPanel }
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
  end;//TkwChatWindowFormTopPanel

// start class TkwChatWindowFormTopPanel

function TkwChatWindowFormTopPanel.TopPanel(const aCtx: TtfwContext;
  aChatWindowForm: TChatWindowForm): TvtPanel;
 {-}
begin
 Result := aChatWindowForm.TopPanel;
end;//TkwChatWindowFormTopPanel.TopPanel

procedure TkwChatWindowFormTopPanel.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aChatWindowForm : TChatWindowForm;
begin
 try
  l_aChatWindowForm := TChatWindowForm(aCtx.rEngine.PopObjAs(TChatWindowForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aChatWindowForm: TChatWindowForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((TopPanel(aCtx, l_aChatWindowForm)));
end;//TkwChatWindowFormTopPanel.DoDoIt

class function TkwChatWindowFormTopPanel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TChatWindowForm.TopPanel';
end;//TkwChatWindowFormTopPanel.GetWordNameForRegister

procedure TkwChatWindowFormTopPanel.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству TopPanel', aCtx);
end;//TkwChatWindowFormTopPanel.SetValuePrim

function TkwChatWindowFormTopPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtPanel);
end;//TkwChatWindowFormTopPanel.GetResultTypeInfo

function TkwChatWindowFormTopPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwChatWindowFormTopPanel.GetAllParamsCount

function TkwChatWindowFormTopPanel.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TChatWindowForm)]);
end;//TkwChatWindowFormTopPanel.ParamsTypes

type
  TkwChatWindowFormHistoryEditor = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TChatWindowForm.HistoryEditor
[panel]Контрол HistoryEditor формы TChatWindowForm[panel]
*Тип результата:* TnscChatMemo
*Пример:*
[code]
OBJECT VAR l_TnscChatMemo
 aChatWindowForm .TChatWindowForm.HistoryEditor >>> l_TnscChatMemo
[code]  }
  private
  // private methods
   function HistoryEditor(const aCtx: TtfwContext;
     aChatWindowForm: TChatWindowForm): TnscChatMemo;
     {* Реализация слова скрипта .TChatWindowForm.HistoryEditor }
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
  end;//TkwChatWindowFormHistoryEditor

// start class TkwChatWindowFormHistoryEditor

function TkwChatWindowFormHistoryEditor.HistoryEditor(const aCtx: TtfwContext;
  aChatWindowForm: TChatWindowForm): TnscChatMemo;
 {-}
begin
 Result := aChatWindowForm.HistoryEditor;
end;//TkwChatWindowFormHistoryEditor.HistoryEditor

procedure TkwChatWindowFormHistoryEditor.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aChatWindowForm : TChatWindowForm;
begin
 try
  l_aChatWindowForm := TChatWindowForm(aCtx.rEngine.PopObjAs(TChatWindowForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aChatWindowForm: TChatWindowForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((HistoryEditor(aCtx, l_aChatWindowForm)));
end;//TkwChatWindowFormHistoryEditor.DoDoIt

class function TkwChatWindowFormHistoryEditor.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TChatWindowForm.HistoryEditor';
end;//TkwChatWindowFormHistoryEditor.GetWordNameForRegister

procedure TkwChatWindowFormHistoryEditor.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству HistoryEditor', aCtx);
end;//TkwChatWindowFormHistoryEditor.SetValuePrim

function TkwChatWindowFormHistoryEditor.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TnscChatMemo);
end;//TkwChatWindowFormHistoryEditor.GetResultTypeInfo

function TkwChatWindowFormHistoryEditor.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwChatWindowFormHistoryEditor.GetAllParamsCount

function TkwChatWindowFormHistoryEditor.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TChatWindowForm)]);
end;//TkwChatWindowFormHistoryEditor.ParamsTypes
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_Form_ChatWindow
 Tkw_Form_ChatWindow.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_ChatWindow_Control_BackgroundPanel
 Tkw_ChatWindow_Control_BackgroundPanel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_ChatWindow_Control_BackgroundPanel_Push
 Tkw_ChatWindow_Control_BackgroundPanel_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_ChatWindow_Control_BottomPanel
 Tkw_ChatWindow_Control_BottomPanel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_ChatWindow_Control_BottomPanel_Push
 Tkw_ChatWindow_Control_BottomPanel_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_ChatWindow_Control_BottomEditor
 Tkw_ChatWindow_Control_BottomEditor.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_ChatWindow_Control_BottomEditor_Push
 Tkw_ChatWindow_Control_BottomEditor_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_ChatWindow_Control_TopPanel
 Tkw_ChatWindow_Control_TopPanel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_ChatWindow_Control_TopPanel_Push
 Tkw_ChatWindow_Control_TopPanel_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_ChatWindow_Control_HistoryEditor
 Tkw_ChatWindow_Control_HistoryEditor.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_ChatWindow_Control_HistoryEditor_Push
 Tkw_ChatWindow_Control_HistoryEditor_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация ChatWindowForm_BackgroundPanel
 TkwChatWindowFormBackgroundPanel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация ChatWindowForm_BottomPanel
 TkwChatWindowFormBottomPanel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация ChatWindowForm_BottomEditor
 TkwChatWindowFormBottomEditor.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация ChatWindowForm_TopPanel
 TkwChatWindowFormTopPanel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация ChatWindowForm_HistoryEditor
 TkwChatWindowFormHistoryEditor.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа ChatWindow
 TtfwTypeRegistrator.RegisterType(TypeInfo(TChatWindowForm));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TvtProportionalPanel
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtProportionalPanel));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TvtSizeablePanel
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtSizeablePanel));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TnscChatMemo
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscChatMemo));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TvtPanel
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.