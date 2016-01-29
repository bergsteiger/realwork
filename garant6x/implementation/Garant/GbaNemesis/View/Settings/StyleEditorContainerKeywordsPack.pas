unit StyleEditorContainerKeywordsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Settings/StyleEditorContainerKeywordsPack.pas"
// Начат: 09.09.2009 16:29
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeywordsPack::Class>> F1 Основные прецеденты::Settings::View::Settings::Settings::StyleEditorContainerKeywordsPack
//
// Набор слов словаря для доступа к экземплярам контролов формы StyleEditorContainer
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
  vtSizeablePanel,
  vtPanel,
  vtProportionalPanel,
  StyleEditorContainer_Form,
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
  Tkw_Form_StyleEditorContainer = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора формы StyleEditorContainer
----
*Пример использования*:
[code]
'aControl' форма::StyleEditorContainer TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
  end;//Tkw_Form_StyleEditorContainer

// start class Tkw_Form_StyleEditorContainer

class function Tkw_Form_StyleEditorContainer.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'форма::StyleEditorContainer';
end;//Tkw_Form_StyleEditorContainer.GetWordNameForRegister

function Tkw_Form_StyleEditorContainer.GetString: AnsiString;
 {-}
begin
 Result := 'StyleEditorContainerForm';
end;//Tkw_Form_StyleEditorContainer.GetString

type
  Tkw_StyleEditorContainer_Control_BackgroundPanel = {final scriptword} class(TtfwControlString)
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
  end;//Tkw_StyleEditorContainer_Control_BackgroundPanel

// start class Tkw_StyleEditorContainer_Control_BackgroundPanel

class function Tkw_StyleEditorContainer_Control_BackgroundPanel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::BackgroundPanel';
end;//Tkw_StyleEditorContainer_Control_BackgroundPanel.GetWordNameForRegister

function Tkw_StyleEditorContainer_Control_BackgroundPanel.GetString: AnsiString;
 {-}
begin
 Result := 'BackgroundPanel';
end;//Tkw_StyleEditorContainer_Control_BackgroundPanel.GetString

class procedure Tkw_StyleEditorContainer_Control_BackgroundPanel.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtProportionalPanel);
end;//Tkw_StyleEditorContainer_Control_BackgroundPanel.RegisterInEngine

type
  Tkw_StyleEditorContainer_Control_BackgroundPanel_Push = {final scriptword} class(TkwBynameControlPush)
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
  end;//Tkw_StyleEditorContainer_Control_BackgroundPanel_Push

// start class Tkw_StyleEditorContainer_Control_BackgroundPanel_Push

procedure Tkw_StyleEditorContainer_Control_BackgroundPanel_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('BackgroundPanel');
 inherited;
end;//Tkw_StyleEditorContainer_Control_BackgroundPanel_Push.DoDoIt

class function Tkw_StyleEditorContainer_Control_BackgroundPanel_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::BackgroundPanel:push';
end;//Tkw_StyleEditorContainer_Control_BackgroundPanel_Push.GetWordNameForRegister

type
  Tkw_StyleEditorContainer_Control_MainZone = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола MainZone
----
*Пример использования*:
[code]
контрол::MainZone TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_StyleEditorContainer_Control_MainZone

// start class Tkw_StyleEditorContainer_Control_MainZone

class function Tkw_StyleEditorContainer_Control_MainZone.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::MainZone';
end;//Tkw_StyleEditorContainer_Control_MainZone.GetWordNameForRegister

function Tkw_StyleEditorContainer_Control_MainZone.GetString: AnsiString;
 {-}
begin
 Result := 'MainZone';
end;//Tkw_StyleEditorContainer_Control_MainZone.GetString

class procedure Tkw_StyleEditorContainer_Control_MainZone.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_StyleEditorContainer_Control_MainZone.RegisterInEngine

type
  Tkw_StyleEditorContainer_Control_MainZone_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола MainZone
----
*Пример использования*:
[code]
контрол::MainZone:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_StyleEditorContainer_Control_MainZone_Push

// start class Tkw_StyleEditorContainer_Control_MainZone_Push

procedure Tkw_StyleEditorContainer_Control_MainZone_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('MainZone');
 inherited;
end;//Tkw_StyleEditorContainer_Control_MainZone_Push.DoDoIt

class function Tkw_StyleEditorContainer_Control_MainZone_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::MainZone:push';
end;//Tkw_StyleEditorContainer_Control_MainZone_Push.GetWordNameForRegister

type
  Tkw_StyleEditorContainer_Control_ParentZone = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола ParentZone
----
*Пример использования*:
[code]
контрол::ParentZone TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_StyleEditorContainer_Control_ParentZone

// start class Tkw_StyleEditorContainer_Control_ParentZone

class function Tkw_StyleEditorContainer_Control_ParentZone.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::ParentZone';
end;//Tkw_StyleEditorContainer_Control_ParentZone.GetWordNameForRegister

function Tkw_StyleEditorContainer_Control_ParentZone.GetString: AnsiString;
 {-}
begin
 Result := 'ParentZone';
end;//Tkw_StyleEditorContainer_Control_ParentZone.GetString

class procedure Tkw_StyleEditorContainer_Control_ParentZone.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtSizeablePanel);
end;//Tkw_StyleEditorContainer_Control_ParentZone.RegisterInEngine

type
  Tkw_StyleEditorContainer_Control_ParentZone_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола ParentZone
----
*Пример использования*:
[code]
контрол::ParentZone:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_StyleEditorContainer_Control_ParentZone_Push

// start class Tkw_StyleEditorContainer_Control_ParentZone_Push

procedure Tkw_StyleEditorContainer_Control_ParentZone_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('ParentZone');
 inherited;
end;//Tkw_StyleEditorContainer_Control_ParentZone_Push.DoDoIt

class function Tkw_StyleEditorContainer_Control_ParentZone_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::ParentZone:push';
end;//Tkw_StyleEditorContainer_Control_ParentZone_Push.GetWordNameForRegister

type
  Tkw_StyleEditorContainer_Control_ChildZone = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола ChildZone
----
*Пример использования*:
[code]
контрол::ChildZone TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_StyleEditorContainer_Control_ChildZone

// start class Tkw_StyleEditorContainer_Control_ChildZone

class function Tkw_StyleEditorContainer_Control_ChildZone.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::ChildZone';
end;//Tkw_StyleEditorContainer_Control_ChildZone.GetWordNameForRegister

function Tkw_StyleEditorContainer_Control_ChildZone.GetString: AnsiString;
 {-}
begin
 Result := 'ChildZone';
end;//Tkw_StyleEditorContainer_Control_ChildZone.GetString

class procedure Tkw_StyleEditorContainer_Control_ChildZone.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_StyleEditorContainer_Control_ChildZone.RegisterInEngine

type
  Tkw_StyleEditorContainer_Control_ChildZone_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола ChildZone
----
*Пример использования*:
[code]
контрол::ChildZone:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_StyleEditorContainer_Control_ChildZone_Push

// start class Tkw_StyleEditorContainer_Control_ChildZone_Push

procedure Tkw_StyleEditorContainer_Control_ChildZone_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('ChildZone');
 inherited;
end;//Tkw_StyleEditorContainer_Control_ChildZone_Push.DoDoIt

class function Tkw_StyleEditorContainer_Control_ChildZone_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::ChildZone:push';
end;//Tkw_StyleEditorContainer_Control_ChildZone_Push.GetWordNameForRegister

type
  Tkw_StyleEditorContainer_Control_NavigatorZone = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола NavigatorZone
----
*Пример использования*:
[code]
контрол::NavigatorZone TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_StyleEditorContainer_Control_NavigatorZone

// start class Tkw_StyleEditorContainer_Control_NavigatorZone

class function Tkw_StyleEditorContainer_Control_NavigatorZone.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::NavigatorZone';
end;//Tkw_StyleEditorContainer_Control_NavigatorZone.GetWordNameForRegister

function Tkw_StyleEditorContainer_Control_NavigatorZone.GetString: AnsiString;
 {-}
begin
 Result := 'NavigatorZone';
end;//Tkw_StyleEditorContainer_Control_NavigatorZone.GetString

class procedure Tkw_StyleEditorContainer_Control_NavigatorZone.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtSizeablePanel);
end;//Tkw_StyleEditorContainer_Control_NavigatorZone.RegisterInEngine

type
  Tkw_StyleEditorContainer_Control_NavigatorZone_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола NavigatorZone
----
*Пример использования*:
[code]
контрол::NavigatorZone:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_StyleEditorContainer_Control_NavigatorZone_Push

// start class Tkw_StyleEditorContainer_Control_NavigatorZone_Push

procedure Tkw_StyleEditorContainer_Control_NavigatorZone_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('NavigatorZone');
 inherited;
end;//Tkw_StyleEditorContainer_Control_NavigatorZone_Push.DoDoIt

class function Tkw_StyleEditorContainer_Control_NavigatorZone_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::NavigatorZone:push';
end;//Tkw_StyleEditorContainer_Control_NavigatorZone_Push.GetWordNameForRegister

type
  TkwStyleEditorContainerFormBackgroundPanel = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TStyleEditorContainerForm.BackgroundPanel
[panel]Контрол BackgroundPanel формы TStyleEditorContainerForm[panel]
*Тип результата:* TvtProportionalPanel
*Пример:*
[code]
OBJECT VAR l_TvtProportionalPanel
 aStyleEditorContainerForm .TStyleEditorContainerForm.BackgroundPanel >>> l_TvtProportionalPanel
[code]  }
  private
  // private methods
   function BackgroundPanel(const aCtx: TtfwContext;
     aStyleEditorContainerForm: TStyleEditorContainerForm): TvtProportionalPanel;
     {* Реализация слова скрипта .TStyleEditorContainerForm.BackgroundPanel }
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
  end;//TkwStyleEditorContainerFormBackgroundPanel

// start class TkwStyleEditorContainerFormBackgroundPanel

function TkwStyleEditorContainerFormBackgroundPanel.BackgroundPanel(const aCtx: TtfwContext;
  aStyleEditorContainerForm: TStyleEditorContainerForm): TvtProportionalPanel;
 {-}
begin
 Result := aStyleEditorContainerForm.BackgroundPanel;
end;//TkwStyleEditorContainerFormBackgroundPanel.BackgroundPanel

procedure TkwStyleEditorContainerFormBackgroundPanel.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aStyleEditorContainerForm : TStyleEditorContainerForm;
begin
 try
  l_aStyleEditorContainerForm := TStyleEditorContainerForm(aCtx.rEngine.PopObjAs(TStyleEditorContainerForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aStyleEditorContainerForm: TStyleEditorContainerForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((BackgroundPanel(aCtx, l_aStyleEditorContainerForm)));
end;//TkwStyleEditorContainerFormBackgroundPanel.DoDoIt

class function TkwStyleEditorContainerFormBackgroundPanel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TStyleEditorContainerForm.BackgroundPanel';
end;//TkwStyleEditorContainerFormBackgroundPanel.GetWordNameForRegister

procedure TkwStyleEditorContainerFormBackgroundPanel.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству BackgroundPanel', aCtx);
end;//TkwStyleEditorContainerFormBackgroundPanel.SetValuePrim

function TkwStyleEditorContainerFormBackgroundPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtProportionalPanel);
end;//TkwStyleEditorContainerFormBackgroundPanel.GetResultTypeInfo

function TkwStyleEditorContainerFormBackgroundPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwStyleEditorContainerFormBackgroundPanel.GetAllParamsCount

function TkwStyleEditorContainerFormBackgroundPanel.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TStyleEditorContainerForm)]);
end;//TkwStyleEditorContainerFormBackgroundPanel.ParamsTypes

type
  TkwStyleEditorContainerFormMainZone = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TStyleEditorContainerForm.MainZone
[panel]Контрол MainZone формы TStyleEditorContainerForm[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aStyleEditorContainerForm .TStyleEditorContainerForm.MainZone >>> l_TvtPanel
[code]  }
  private
  // private methods
   function MainZone(const aCtx: TtfwContext;
     aStyleEditorContainerForm: TStyleEditorContainerForm): TvtPanel;
     {* Реализация слова скрипта .TStyleEditorContainerForm.MainZone }
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
  end;//TkwStyleEditorContainerFormMainZone

// start class TkwStyleEditorContainerFormMainZone

function TkwStyleEditorContainerFormMainZone.MainZone(const aCtx: TtfwContext;
  aStyleEditorContainerForm: TStyleEditorContainerForm): TvtPanel;
 {-}
begin
 Result := aStyleEditorContainerForm.MainZone;
end;//TkwStyleEditorContainerFormMainZone.MainZone

procedure TkwStyleEditorContainerFormMainZone.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aStyleEditorContainerForm : TStyleEditorContainerForm;
begin
 try
  l_aStyleEditorContainerForm := TStyleEditorContainerForm(aCtx.rEngine.PopObjAs(TStyleEditorContainerForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aStyleEditorContainerForm: TStyleEditorContainerForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((MainZone(aCtx, l_aStyleEditorContainerForm)));
end;//TkwStyleEditorContainerFormMainZone.DoDoIt

class function TkwStyleEditorContainerFormMainZone.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TStyleEditorContainerForm.MainZone';
end;//TkwStyleEditorContainerFormMainZone.GetWordNameForRegister

procedure TkwStyleEditorContainerFormMainZone.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству MainZone', aCtx);
end;//TkwStyleEditorContainerFormMainZone.SetValuePrim

function TkwStyleEditorContainerFormMainZone.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtPanel);
end;//TkwStyleEditorContainerFormMainZone.GetResultTypeInfo

function TkwStyleEditorContainerFormMainZone.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwStyleEditorContainerFormMainZone.GetAllParamsCount

function TkwStyleEditorContainerFormMainZone.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TStyleEditorContainerForm)]);
end;//TkwStyleEditorContainerFormMainZone.ParamsTypes

type
  TkwStyleEditorContainerFormParentZone = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TStyleEditorContainerForm.ParentZone
[panel]Контрол ParentZone формы TStyleEditorContainerForm[panel]
*Тип результата:* TvtSizeablePanel
*Пример:*
[code]
OBJECT VAR l_TvtSizeablePanel
 aStyleEditorContainerForm .TStyleEditorContainerForm.ParentZone >>> l_TvtSizeablePanel
[code]  }
  private
  // private methods
   function ParentZone(const aCtx: TtfwContext;
     aStyleEditorContainerForm: TStyleEditorContainerForm): TvtSizeablePanel;
     {* Реализация слова скрипта .TStyleEditorContainerForm.ParentZone }
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
  end;//TkwStyleEditorContainerFormParentZone

// start class TkwStyleEditorContainerFormParentZone

function TkwStyleEditorContainerFormParentZone.ParentZone(const aCtx: TtfwContext;
  aStyleEditorContainerForm: TStyleEditorContainerForm): TvtSizeablePanel;
 {-}
begin
 Result := aStyleEditorContainerForm.ParentZone;
end;//TkwStyleEditorContainerFormParentZone.ParentZone

procedure TkwStyleEditorContainerFormParentZone.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aStyleEditorContainerForm : TStyleEditorContainerForm;
begin
 try
  l_aStyleEditorContainerForm := TStyleEditorContainerForm(aCtx.rEngine.PopObjAs(TStyleEditorContainerForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aStyleEditorContainerForm: TStyleEditorContainerForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((ParentZone(aCtx, l_aStyleEditorContainerForm)));
end;//TkwStyleEditorContainerFormParentZone.DoDoIt

class function TkwStyleEditorContainerFormParentZone.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TStyleEditorContainerForm.ParentZone';
end;//TkwStyleEditorContainerFormParentZone.GetWordNameForRegister

procedure TkwStyleEditorContainerFormParentZone.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству ParentZone', aCtx);
end;//TkwStyleEditorContainerFormParentZone.SetValuePrim

function TkwStyleEditorContainerFormParentZone.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtSizeablePanel);
end;//TkwStyleEditorContainerFormParentZone.GetResultTypeInfo

function TkwStyleEditorContainerFormParentZone.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwStyleEditorContainerFormParentZone.GetAllParamsCount

function TkwStyleEditorContainerFormParentZone.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TStyleEditorContainerForm)]);
end;//TkwStyleEditorContainerFormParentZone.ParamsTypes

type
  TkwStyleEditorContainerFormChildZone = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TStyleEditorContainerForm.ChildZone
[panel]Контрол ChildZone формы TStyleEditorContainerForm[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aStyleEditorContainerForm .TStyleEditorContainerForm.ChildZone >>> l_TvtPanel
[code]  }
  private
  // private methods
   function ChildZone(const aCtx: TtfwContext;
     aStyleEditorContainerForm: TStyleEditorContainerForm): TvtPanel;
     {* Реализация слова скрипта .TStyleEditorContainerForm.ChildZone }
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
  end;//TkwStyleEditorContainerFormChildZone

// start class TkwStyleEditorContainerFormChildZone

function TkwStyleEditorContainerFormChildZone.ChildZone(const aCtx: TtfwContext;
  aStyleEditorContainerForm: TStyleEditorContainerForm): TvtPanel;
 {-}
begin
 Result := aStyleEditorContainerForm.ChildZone;
end;//TkwStyleEditorContainerFormChildZone.ChildZone

procedure TkwStyleEditorContainerFormChildZone.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aStyleEditorContainerForm : TStyleEditorContainerForm;
begin
 try
  l_aStyleEditorContainerForm := TStyleEditorContainerForm(aCtx.rEngine.PopObjAs(TStyleEditorContainerForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aStyleEditorContainerForm: TStyleEditorContainerForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((ChildZone(aCtx, l_aStyleEditorContainerForm)));
end;//TkwStyleEditorContainerFormChildZone.DoDoIt

class function TkwStyleEditorContainerFormChildZone.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TStyleEditorContainerForm.ChildZone';
end;//TkwStyleEditorContainerFormChildZone.GetWordNameForRegister

procedure TkwStyleEditorContainerFormChildZone.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству ChildZone', aCtx);
end;//TkwStyleEditorContainerFormChildZone.SetValuePrim

function TkwStyleEditorContainerFormChildZone.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtPanel);
end;//TkwStyleEditorContainerFormChildZone.GetResultTypeInfo

function TkwStyleEditorContainerFormChildZone.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwStyleEditorContainerFormChildZone.GetAllParamsCount

function TkwStyleEditorContainerFormChildZone.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TStyleEditorContainerForm)]);
end;//TkwStyleEditorContainerFormChildZone.ParamsTypes

type
  TkwStyleEditorContainerFormNavigatorZone = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TStyleEditorContainerForm.NavigatorZone
[panel]Контрол NavigatorZone формы TStyleEditorContainerForm[panel]
*Тип результата:* TvtSizeablePanel
*Пример:*
[code]
OBJECT VAR l_TvtSizeablePanel
 aStyleEditorContainerForm .TStyleEditorContainerForm.NavigatorZone >>> l_TvtSizeablePanel
[code]  }
  private
  // private methods
   function NavigatorZone(const aCtx: TtfwContext;
     aStyleEditorContainerForm: TStyleEditorContainerForm): TvtSizeablePanel;
     {* Реализация слова скрипта .TStyleEditorContainerForm.NavigatorZone }
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
  end;//TkwStyleEditorContainerFormNavigatorZone

// start class TkwStyleEditorContainerFormNavigatorZone

function TkwStyleEditorContainerFormNavigatorZone.NavigatorZone(const aCtx: TtfwContext;
  aStyleEditorContainerForm: TStyleEditorContainerForm): TvtSizeablePanel;
 {-}
begin
 Result := aStyleEditorContainerForm.NavigatorZone;
end;//TkwStyleEditorContainerFormNavigatorZone.NavigatorZone

procedure TkwStyleEditorContainerFormNavigatorZone.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aStyleEditorContainerForm : TStyleEditorContainerForm;
begin
 try
  l_aStyleEditorContainerForm := TStyleEditorContainerForm(aCtx.rEngine.PopObjAs(TStyleEditorContainerForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aStyleEditorContainerForm: TStyleEditorContainerForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((NavigatorZone(aCtx, l_aStyleEditorContainerForm)));
end;//TkwStyleEditorContainerFormNavigatorZone.DoDoIt

class function TkwStyleEditorContainerFormNavigatorZone.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TStyleEditorContainerForm.NavigatorZone';
end;//TkwStyleEditorContainerFormNavigatorZone.GetWordNameForRegister

procedure TkwStyleEditorContainerFormNavigatorZone.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству NavigatorZone', aCtx);
end;//TkwStyleEditorContainerFormNavigatorZone.SetValuePrim

function TkwStyleEditorContainerFormNavigatorZone.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtSizeablePanel);
end;//TkwStyleEditorContainerFormNavigatorZone.GetResultTypeInfo

function TkwStyleEditorContainerFormNavigatorZone.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwStyleEditorContainerFormNavigatorZone.GetAllParamsCount

function TkwStyleEditorContainerFormNavigatorZone.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TStyleEditorContainerForm)]);
end;//TkwStyleEditorContainerFormNavigatorZone.ParamsTypes
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_Form_StyleEditorContainer
 Tkw_Form_StyleEditorContainer.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_StyleEditorContainer_Control_BackgroundPanel
 Tkw_StyleEditorContainer_Control_BackgroundPanel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_StyleEditorContainer_Control_BackgroundPanel_Push
 Tkw_StyleEditorContainer_Control_BackgroundPanel_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_StyleEditorContainer_Control_MainZone
 Tkw_StyleEditorContainer_Control_MainZone.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_StyleEditorContainer_Control_MainZone_Push
 Tkw_StyleEditorContainer_Control_MainZone_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_StyleEditorContainer_Control_ParentZone
 Tkw_StyleEditorContainer_Control_ParentZone.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_StyleEditorContainer_Control_ParentZone_Push
 Tkw_StyleEditorContainer_Control_ParentZone_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_StyleEditorContainer_Control_ChildZone
 Tkw_StyleEditorContainer_Control_ChildZone.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_StyleEditorContainer_Control_ChildZone_Push
 Tkw_StyleEditorContainer_Control_ChildZone_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_StyleEditorContainer_Control_NavigatorZone
 Tkw_StyleEditorContainer_Control_NavigatorZone.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_StyleEditorContainer_Control_NavigatorZone_Push
 Tkw_StyleEditorContainer_Control_NavigatorZone_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация StyleEditorContainerForm_BackgroundPanel
 TkwStyleEditorContainerFormBackgroundPanel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация StyleEditorContainerForm_MainZone
 TkwStyleEditorContainerFormMainZone.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация StyleEditorContainerForm_ParentZone
 TkwStyleEditorContainerFormParentZone.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация StyleEditorContainerForm_ChildZone
 TkwStyleEditorContainerFormChildZone.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация StyleEditorContainerForm_NavigatorZone
 TkwStyleEditorContainerFormNavigatorZone.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа StyleEditorContainer
 TtfwTypeRegistrator.RegisterType(TypeInfo(TStyleEditorContainerForm));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TvtProportionalPanel
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtProportionalPanel));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TvtPanel
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TvtSizeablePanel
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtSizeablePanel));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.