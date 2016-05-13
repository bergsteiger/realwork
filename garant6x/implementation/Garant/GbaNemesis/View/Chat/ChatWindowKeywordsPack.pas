unit ChatWindowKeywordsPack;
 {* Набор слов словаря для доступа к экземплярам контролов формы ChatWindow }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Chat\ChatWindowKeywordsPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "ChatWindowKeywordsPack" MUID: (7B1A97167D7A)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , vtProportionalPanel
 , vtSizeablePanel
 {$If Defined(Nemesis)}
 , nscChatMemo
 {$IfEnd} // Defined(Nemesis)
 , vtPanel
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , ChatWindow_Form
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
 Tkw_Form_ChatWindow = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора формы ChatWindow
----
*Пример использования*:
[code]
'aControl' форма::ChatWindow TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Form_ChatWindow

 Tkw_ChatWindow_Control_BackgroundPanel = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола BackgroundPanel
----
*Пример использования*:
[code]
контрол::BackgroundPanel TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_ChatWindow_Control_BackgroundPanel

 Tkw_ChatWindow_Control_BackgroundPanel_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* Слово словаря для контрола BackgroundPanel
----
*Пример использования*:
[code]
контрол::BackgroundPanel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_ChatWindow_Control_BackgroundPanel_Push

 Tkw_ChatWindow_Control_BottomPanel = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола BottomPanel
----
*Пример использования*:
[code]
контрол::BottomPanel TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_ChatWindow_Control_BottomPanel

 Tkw_ChatWindow_Control_BottomPanel_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* Слово словаря для контрола BottomPanel
----
*Пример использования*:
[code]
контрол::BottomPanel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_ChatWindow_Control_BottomPanel_Push

 Tkw_ChatWindow_Control_BottomEditor = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола BottomEditor
----
*Пример использования*:
[code]
контрол::BottomEditor TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_ChatWindow_Control_BottomEditor

 Tkw_ChatWindow_Control_BottomEditor_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* Слово словаря для контрола BottomEditor
----
*Пример использования*:
[code]
контрол::BottomEditor:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_ChatWindow_Control_BottomEditor_Push

 Tkw_ChatWindow_Control_TopPanel = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола TopPanel
----
*Пример использования*:
[code]
контрол::TopPanel TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_ChatWindow_Control_TopPanel

 Tkw_ChatWindow_Control_TopPanel_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* Слово словаря для контрола TopPanel
----
*Пример использования*:
[code]
контрол::TopPanel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_ChatWindow_Control_TopPanel_Push

 Tkw_ChatWindow_Control_HistoryEditor = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола HistoryEditor
----
*Пример использования*:
[code]
контрол::HistoryEditor TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_ChatWindow_Control_HistoryEditor

 Tkw_ChatWindow_Control_HistoryEditor_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* Слово словаря для контрола HistoryEditor
----
*Пример использования*:
[code]
контрол::HistoryEditor:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_ChatWindow_Control_HistoryEditor_Push

 TkwChatWindowFormBackgroundPanel = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TChatWindowForm.BackgroundPanel }
  private
   function BackgroundPanel(const aCtx: TtfwContext;
    aChatWindowForm: TChatWindowForm): TvtProportionalPanel;
    {* Реализация слова скрипта .TChatWindowForm.BackgroundPanel }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwChatWindowFormBackgroundPanel

 TkwChatWindowFormBottomPanel = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TChatWindowForm.BottomPanel }
  private
   function BottomPanel(const aCtx: TtfwContext;
    aChatWindowForm: TChatWindowForm): TvtSizeablePanel;
    {* Реализация слова скрипта .TChatWindowForm.BottomPanel }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwChatWindowFormBottomPanel

 TkwChatWindowFormBottomEditor = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TChatWindowForm.BottomEditor }
  private
   function BottomEditor(const aCtx: TtfwContext;
    aChatWindowForm: TChatWindowForm): TnscChatMemo;
    {* Реализация слова скрипта .TChatWindowForm.BottomEditor }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwChatWindowFormBottomEditor

 TkwChatWindowFormTopPanel = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TChatWindowForm.TopPanel }
  private
   function TopPanel(const aCtx: TtfwContext;
    aChatWindowForm: TChatWindowForm): TvtPanel;
    {* Реализация слова скрипта .TChatWindowForm.TopPanel }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwChatWindowFormTopPanel

 TkwChatWindowFormHistoryEditor = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TChatWindowForm.HistoryEditor }
  private
   function HistoryEditor(const aCtx: TtfwContext;
    aChatWindowForm: TChatWindowForm): TnscChatMemo;
    {* Реализация слова скрипта .TChatWindowForm.HistoryEditor }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwChatWindowFormHistoryEditor

function Tkw_Form_ChatWindow.GetString: AnsiString;
begin
 Result := 'ChatWindowForm';
end;//Tkw_Form_ChatWindow.GetString

class function Tkw_Form_ChatWindow.GetWordNameForRegister: AnsiString;
begin
 Result := 'форма::ChatWindow';
end;//Tkw_Form_ChatWindow.GetWordNameForRegister

function Tkw_ChatWindow_Control_BackgroundPanel.GetString: AnsiString;
begin
 Result := 'BackgroundPanel';
end;//Tkw_ChatWindow_Control_BackgroundPanel.GetString

class procedure Tkw_ChatWindow_Control_BackgroundPanel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtProportionalPanel);
end;//Tkw_ChatWindow_Control_BackgroundPanel.RegisterInEngine

class function Tkw_ChatWindow_Control_BackgroundPanel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::BackgroundPanel';
end;//Tkw_ChatWindow_Control_BackgroundPanel.GetWordNameForRegister

procedure Tkw_ChatWindow_Control_BackgroundPanel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('BackgroundPanel');
 inherited;
end;//Tkw_ChatWindow_Control_BackgroundPanel_Push.DoDoIt

class function Tkw_ChatWindow_Control_BackgroundPanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::BackgroundPanel:push';
end;//Tkw_ChatWindow_Control_BackgroundPanel_Push.GetWordNameForRegister

function Tkw_ChatWindow_Control_BottomPanel.GetString: AnsiString;
begin
 Result := 'BottomPanel';
end;//Tkw_ChatWindow_Control_BottomPanel.GetString

class procedure Tkw_ChatWindow_Control_BottomPanel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtSizeablePanel);
end;//Tkw_ChatWindow_Control_BottomPanel.RegisterInEngine

class function Tkw_ChatWindow_Control_BottomPanel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::BottomPanel';
end;//Tkw_ChatWindow_Control_BottomPanel.GetWordNameForRegister

procedure Tkw_ChatWindow_Control_BottomPanel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('BottomPanel');
 inherited;
end;//Tkw_ChatWindow_Control_BottomPanel_Push.DoDoIt

class function Tkw_ChatWindow_Control_BottomPanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::BottomPanel:push';
end;//Tkw_ChatWindow_Control_BottomPanel_Push.GetWordNameForRegister

function Tkw_ChatWindow_Control_BottomEditor.GetString: AnsiString;
begin
 Result := 'BottomEditor';
end;//Tkw_ChatWindow_Control_BottomEditor.GetString

class procedure Tkw_ChatWindow_Control_BottomEditor.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscChatMemo);
end;//Tkw_ChatWindow_Control_BottomEditor.RegisterInEngine

class function Tkw_ChatWindow_Control_BottomEditor.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::BottomEditor';
end;//Tkw_ChatWindow_Control_BottomEditor.GetWordNameForRegister

procedure Tkw_ChatWindow_Control_BottomEditor_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('BottomEditor');
 inherited;
end;//Tkw_ChatWindow_Control_BottomEditor_Push.DoDoIt

class function Tkw_ChatWindow_Control_BottomEditor_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::BottomEditor:push';
end;//Tkw_ChatWindow_Control_BottomEditor_Push.GetWordNameForRegister

function Tkw_ChatWindow_Control_TopPanel.GetString: AnsiString;
begin
 Result := 'TopPanel';
end;//Tkw_ChatWindow_Control_TopPanel.GetString

class procedure Tkw_ChatWindow_Control_TopPanel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_ChatWindow_Control_TopPanel.RegisterInEngine

class function Tkw_ChatWindow_Control_TopPanel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::TopPanel';
end;//Tkw_ChatWindow_Control_TopPanel.GetWordNameForRegister

procedure Tkw_ChatWindow_Control_TopPanel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('TopPanel');
 inherited;
end;//Tkw_ChatWindow_Control_TopPanel_Push.DoDoIt

class function Tkw_ChatWindow_Control_TopPanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::TopPanel:push';
end;//Tkw_ChatWindow_Control_TopPanel_Push.GetWordNameForRegister

function Tkw_ChatWindow_Control_HistoryEditor.GetString: AnsiString;
begin
 Result := 'HistoryEditor';
end;//Tkw_ChatWindow_Control_HistoryEditor.GetString

class procedure Tkw_ChatWindow_Control_HistoryEditor.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscChatMemo);
end;//Tkw_ChatWindow_Control_HistoryEditor.RegisterInEngine

class function Tkw_ChatWindow_Control_HistoryEditor.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::HistoryEditor';
end;//Tkw_ChatWindow_Control_HistoryEditor.GetWordNameForRegister

procedure Tkw_ChatWindow_Control_HistoryEditor_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('HistoryEditor');
 inherited;
end;//Tkw_ChatWindow_Control_HistoryEditor_Push.DoDoIt

class function Tkw_ChatWindow_Control_HistoryEditor_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::HistoryEditor:push';
end;//Tkw_ChatWindow_Control_HistoryEditor_Push.GetWordNameForRegister

function TkwChatWindowFormBackgroundPanel.BackgroundPanel(const aCtx: TtfwContext;
 aChatWindowForm: TChatWindowForm): TvtProportionalPanel;
 {* Реализация слова скрипта .TChatWindowForm.BackgroundPanel }
begin
 Result := aChatWindowForm.BackgroundPanel;
end;//TkwChatWindowFormBackgroundPanel.BackgroundPanel

class function TkwChatWindowFormBackgroundPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TChatWindowForm.BackgroundPanel';
end;//TkwChatWindowFormBackgroundPanel.GetWordNameForRegister

function TkwChatWindowFormBackgroundPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtProportionalPanel);
end;//TkwChatWindowFormBackgroundPanel.GetResultTypeInfo

function TkwChatWindowFormBackgroundPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwChatWindowFormBackgroundPanel.GetAllParamsCount

function TkwChatWindowFormBackgroundPanel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TChatWindowForm)]);
end;//TkwChatWindowFormBackgroundPanel.ParamsTypes

procedure TkwChatWindowFormBackgroundPanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству BackgroundPanel', aCtx);
end;//TkwChatWindowFormBackgroundPanel.SetValuePrim

procedure TkwChatWindowFormBackgroundPanel.DoDoIt(const aCtx: TtfwContext);
var l_aChatWindowForm: TChatWindowForm;
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
 aCtx.rEngine.PushObj(BackgroundPanel(aCtx, l_aChatWindowForm));
end;//TkwChatWindowFormBackgroundPanel.DoDoIt

function TkwChatWindowFormBottomPanel.BottomPanel(const aCtx: TtfwContext;
 aChatWindowForm: TChatWindowForm): TvtSizeablePanel;
 {* Реализация слова скрипта .TChatWindowForm.BottomPanel }
begin
 Result := aChatWindowForm.BottomPanel;
end;//TkwChatWindowFormBottomPanel.BottomPanel

class function TkwChatWindowFormBottomPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TChatWindowForm.BottomPanel';
end;//TkwChatWindowFormBottomPanel.GetWordNameForRegister

function TkwChatWindowFormBottomPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtSizeablePanel);
end;//TkwChatWindowFormBottomPanel.GetResultTypeInfo

function TkwChatWindowFormBottomPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwChatWindowFormBottomPanel.GetAllParamsCount

function TkwChatWindowFormBottomPanel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TChatWindowForm)]);
end;//TkwChatWindowFormBottomPanel.ParamsTypes

procedure TkwChatWindowFormBottomPanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству BottomPanel', aCtx);
end;//TkwChatWindowFormBottomPanel.SetValuePrim

procedure TkwChatWindowFormBottomPanel.DoDoIt(const aCtx: TtfwContext);
var l_aChatWindowForm: TChatWindowForm;
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
 aCtx.rEngine.PushObj(BottomPanel(aCtx, l_aChatWindowForm));
end;//TkwChatWindowFormBottomPanel.DoDoIt

function TkwChatWindowFormBottomEditor.BottomEditor(const aCtx: TtfwContext;
 aChatWindowForm: TChatWindowForm): TnscChatMemo;
 {* Реализация слова скрипта .TChatWindowForm.BottomEditor }
begin
 Result := aChatWindowForm.BottomEditor;
end;//TkwChatWindowFormBottomEditor.BottomEditor

class function TkwChatWindowFormBottomEditor.GetWordNameForRegister: AnsiString;
begin
 Result := '.TChatWindowForm.BottomEditor';
end;//TkwChatWindowFormBottomEditor.GetWordNameForRegister

function TkwChatWindowFormBottomEditor.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscChatMemo);
end;//TkwChatWindowFormBottomEditor.GetResultTypeInfo

function TkwChatWindowFormBottomEditor.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwChatWindowFormBottomEditor.GetAllParamsCount

function TkwChatWindowFormBottomEditor.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TChatWindowForm)]);
end;//TkwChatWindowFormBottomEditor.ParamsTypes

procedure TkwChatWindowFormBottomEditor.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству BottomEditor', aCtx);
end;//TkwChatWindowFormBottomEditor.SetValuePrim

procedure TkwChatWindowFormBottomEditor.DoDoIt(const aCtx: TtfwContext);
var l_aChatWindowForm: TChatWindowForm;
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
 aCtx.rEngine.PushObj(BottomEditor(aCtx, l_aChatWindowForm));
end;//TkwChatWindowFormBottomEditor.DoDoIt

function TkwChatWindowFormTopPanel.TopPanel(const aCtx: TtfwContext;
 aChatWindowForm: TChatWindowForm): TvtPanel;
 {* Реализация слова скрипта .TChatWindowForm.TopPanel }
begin
 Result := aChatWindowForm.TopPanel;
end;//TkwChatWindowFormTopPanel.TopPanel

class function TkwChatWindowFormTopPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TChatWindowForm.TopPanel';
end;//TkwChatWindowFormTopPanel.GetWordNameForRegister

function TkwChatWindowFormTopPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwChatWindowFormTopPanel.GetResultTypeInfo

function TkwChatWindowFormTopPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwChatWindowFormTopPanel.GetAllParamsCount

function TkwChatWindowFormTopPanel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TChatWindowForm)]);
end;//TkwChatWindowFormTopPanel.ParamsTypes

procedure TkwChatWindowFormTopPanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству TopPanel', aCtx);
end;//TkwChatWindowFormTopPanel.SetValuePrim

procedure TkwChatWindowFormTopPanel.DoDoIt(const aCtx: TtfwContext);
var l_aChatWindowForm: TChatWindowForm;
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
 aCtx.rEngine.PushObj(TopPanel(aCtx, l_aChatWindowForm));
end;//TkwChatWindowFormTopPanel.DoDoIt

function TkwChatWindowFormHistoryEditor.HistoryEditor(const aCtx: TtfwContext;
 aChatWindowForm: TChatWindowForm): TnscChatMemo;
 {* Реализация слова скрипта .TChatWindowForm.HistoryEditor }
begin
 Result := aChatWindowForm.HistoryEditor;
end;//TkwChatWindowFormHistoryEditor.HistoryEditor

class function TkwChatWindowFormHistoryEditor.GetWordNameForRegister: AnsiString;
begin
 Result := '.TChatWindowForm.HistoryEditor';
end;//TkwChatWindowFormHistoryEditor.GetWordNameForRegister

function TkwChatWindowFormHistoryEditor.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscChatMemo);
end;//TkwChatWindowFormHistoryEditor.GetResultTypeInfo

function TkwChatWindowFormHistoryEditor.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwChatWindowFormHistoryEditor.GetAllParamsCount

function TkwChatWindowFormHistoryEditor.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TChatWindowForm)]);
end;//TkwChatWindowFormHistoryEditor.ParamsTypes

procedure TkwChatWindowFormHistoryEditor.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству HistoryEditor', aCtx);
end;//TkwChatWindowFormHistoryEditor.SetValuePrim

procedure TkwChatWindowFormHistoryEditor.DoDoIt(const aCtx: TtfwContext);
var l_aChatWindowForm: TChatWindowForm;
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
 aCtx.rEngine.PushObj(HistoryEditor(aCtx, l_aChatWindowForm));
end;//TkwChatWindowFormHistoryEditor.DoDoIt

initialization
 Tkw_Form_ChatWindow.RegisterInEngine;
 {* Регистрация Tkw_Form_ChatWindow }
 Tkw_ChatWindow_Control_BackgroundPanel.RegisterInEngine;
 {* Регистрация Tkw_ChatWindow_Control_BackgroundPanel }
 Tkw_ChatWindow_Control_BackgroundPanel_Push.RegisterInEngine;
 {* Регистрация Tkw_ChatWindow_Control_BackgroundPanel_Push }
 Tkw_ChatWindow_Control_BottomPanel.RegisterInEngine;
 {* Регистрация Tkw_ChatWindow_Control_BottomPanel }
 Tkw_ChatWindow_Control_BottomPanel_Push.RegisterInEngine;
 {* Регистрация Tkw_ChatWindow_Control_BottomPanel_Push }
 Tkw_ChatWindow_Control_BottomEditor.RegisterInEngine;
 {* Регистрация Tkw_ChatWindow_Control_BottomEditor }
 Tkw_ChatWindow_Control_BottomEditor_Push.RegisterInEngine;
 {* Регистрация Tkw_ChatWindow_Control_BottomEditor_Push }
 Tkw_ChatWindow_Control_TopPanel.RegisterInEngine;
 {* Регистрация Tkw_ChatWindow_Control_TopPanel }
 Tkw_ChatWindow_Control_TopPanel_Push.RegisterInEngine;
 {* Регистрация Tkw_ChatWindow_Control_TopPanel_Push }
 Tkw_ChatWindow_Control_HistoryEditor.RegisterInEngine;
 {* Регистрация Tkw_ChatWindow_Control_HistoryEditor }
 Tkw_ChatWindow_Control_HistoryEditor_Push.RegisterInEngine;
 {* Регистрация Tkw_ChatWindow_Control_HistoryEditor_Push }
 TkwChatWindowFormBackgroundPanel.RegisterInEngine;
 {* Регистрация ChatWindowForm_BackgroundPanel }
 TkwChatWindowFormBottomPanel.RegisterInEngine;
 {* Регистрация ChatWindowForm_BottomPanel }
 TkwChatWindowFormBottomEditor.RegisterInEngine;
 {* Регистрация ChatWindowForm_BottomEditor }
 TkwChatWindowFormTopPanel.RegisterInEngine;
 {* Регистрация ChatWindowForm_TopPanel }
 TkwChatWindowFormHistoryEditor.RegisterInEngine;
 {* Регистрация ChatWindowForm_HistoryEditor }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TChatWindowForm));
 {* Регистрация типа TChatWindowForm }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtProportionalPanel));
 {* Регистрация типа TvtProportionalPanel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtSizeablePanel));
 {* Регистрация типа TvtSizeablePanel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscChatMemo));
 {* Регистрация типа TnscChatMemo }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
 {* Регистрация типа TvtPanel }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

end.
