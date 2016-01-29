unit RubricatorKeywordsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Rubricator/RubricatorKeywordsPack.pas"
// Начат: 08.09.2009 19:27
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeywordsPack::Class>> F1 Основные прецеденты::Rubricator::View::Rubricator::Rubricator::RubricatorKeywordsPack
//
// Набор слов словаря для доступа к экземплярам контролов формы Rubricator
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
  Classes
  {$If not defined(NoVCL)}
  ,
  ExtCtrls
  {$IfEnd} //not NoVCL
  
  {$If defined(Nemesis)}
  ,
  nscTextSource
  {$IfEnd} //Nemesis
  ,
  vtPanel,
  Rubricator_Form,
  nscSimpleEditor,
  tfwScriptingInterfaces
  {$If not defined(NoScripts) AND not defined(NoVCL)}
  ,
  kwBynameControlPush
  {$IfEnd} //not NoScripts AND not NoVCL
  ,
  tfwControlString,
  nscTreeViewWithAdapterDragDrop,
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
  Tkw_Form_Rubricator = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора формы Rubricator
----
*Пример использования*:
[code]
'aControl' форма::Rubricator TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
  end;//Tkw_Form_Rubricator

// start class Tkw_Form_Rubricator

class function Tkw_Form_Rubricator.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'форма::Rubricator';
end;//Tkw_Form_Rubricator.GetWordNameForRegister

function Tkw_Form_Rubricator.GetString: AnsiString;
 {-}
begin
 Result := 'efRubricator';
end;//Tkw_Form_Rubricator.GetString

type
  Tkw_Rubricator_Control_RubricatorList = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола RubricatorList
----
*Пример использования*:
[code]
контрол::RubricatorList TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_Rubricator_Control_RubricatorList

// start class Tkw_Rubricator_Control_RubricatorList

class function Tkw_Rubricator_Control_RubricatorList.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::RubricatorList';
end;//Tkw_Rubricator_Control_RubricatorList.GetWordNameForRegister

function Tkw_Rubricator_Control_RubricatorList.GetString: AnsiString;
 {-}
begin
 Result := 'RubricatorList';
end;//Tkw_Rubricator_Control_RubricatorList.GetString

class procedure Tkw_Rubricator_Control_RubricatorList.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TnscTreeViewWithAdapterDragDrop);
end;//Tkw_Rubricator_Control_RubricatorList.RegisterInEngine

type
  Tkw_Rubricator_Control_RubricatorList_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола RubricatorList
----
*Пример использования*:
[code]
контрол::RubricatorList:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_Rubricator_Control_RubricatorList_Push

// start class Tkw_Rubricator_Control_RubricatorList_Push

procedure Tkw_Rubricator_Control_RubricatorList_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('RubricatorList');
 inherited;
end;//Tkw_Rubricator_Control_RubricatorList_Push.DoDoIt

class function Tkw_Rubricator_Control_RubricatorList_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::RubricatorList:push';
end;//Tkw_Rubricator_Control_RubricatorList_Push.GetWordNameForRegister

type
  Tkw_Rubricator_Control_TopPanel = {final scriptword} class(TtfwControlString)
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
  end;//Tkw_Rubricator_Control_TopPanel

// start class Tkw_Rubricator_Control_TopPanel

class function Tkw_Rubricator_Control_TopPanel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::TopPanel';
end;//Tkw_Rubricator_Control_TopPanel.GetWordNameForRegister

function Tkw_Rubricator_Control_TopPanel.GetString: AnsiString;
 {-}
begin
 Result := 'TopPanel';
end;//Tkw_Rubricator_Control_TopPanel.GetString

class procedure Tkw_Rubricator_Control_TopPanel.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_Rubricator_Control_TopPanel.RegisterInEngine

type
  Tkw_Rubricator_Control_TopPanel_Push = {final scriptword} class(TkwBynameControlPush)
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
  end;//Tkw_Rubricator_Control_TopPanel_Push

// start class Tkw_Rubricator_Control_TopPanel_Push

procedure Tkw_Rubricator_Control_TopPanel_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('TopPanel');
 inherited;
end;//Tkw_Rubricator_Control_TopPanel_Push.DoDoIt

class function Tkw_Rubricator_Control_TopPanel_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::TopPanel:push';
end;//Tkw_Rubricator_Control_TopPanel_Push.GetWordNameForRegister

type
  Tkw_Rubricator_Control_PaintBox = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола PaintBox
----
*Пример использования*:
[code]
контрол::PaintBox TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_Rubricator_Control_PaintBox

// start class Tkw_Rubricator_Control_PaintBox

class function Tkw_Rubricator_Control_PaintBox.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::PaintBox';
end;//Tkw_Rubricator_Control_PaintBox.GetWordNameForRegister

function Tkw_Rubricator_Control_PaintBox.GetString: AnsiString;
 {-}
begin
 Result := 'PaintBox';
end;//Tkw_Rubricator_Control_PaintBox.GetString

class procedure Tkw_Rubricator_Control_PaintBox.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TPaintBox);
end;//Tkw_Rubricator_Control_PaintBox.RegisterInEngine

type
  Tkw_Rubricator_Control_PaintBox_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола PaintBox
----
*Пример использования*:
[code]
контрол::PaintBox:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_Rubricator_Control_PaintBox_Push

// start class Tkw_Rubricator_Control_PaintBox_Push

procedure Tkw_Rubricator_Control_PaintBox_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('PaintBox');
 inherited;
end;//Tkw_Rubricator_Control_PaintBox_Push.DoDoIt

class function Tkw_Rubricator_Control_PaintBox_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::PaintBox:push';
end;//Tkw_Rubricator_Control_PaintBox_Push.GetWordNameForRegister

type
  Tkw_Rubricator_Control_NewDocLabel = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола NewDocLabel
----
*Пример использования*:
[code]
контрол::NewDocLabel TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_Rubricator_Control_NewDocLabel

// start class Tkw_Rubricator_Control_NewDocLabel

class function Tkw_Rubricator_Control_NewDocLabel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::NewDocLabel';
end;//Tkw_Rubricator_Control_NewDocLabel.GetWordNameForRegister

function Tkw_Rubricator_Control_NewDocLabel.GetString: AnsiString;
 {-}
begin
 Result := 'NewDocLabel';
end;//Tkw_Rubricator_Control_NewDocLabel.GetString

class procedure Tkw_Rubricator_Control_NewDocLabel.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TnscSimpleEditor);
end;//Tkw_Rubricator_Control_NewDocLabel.RegisterInEngine

type
  Tkw_Rubricator_Control_NewDocLabel_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола NewDocLabel
----
*Пример использования*:
[code]
контрол::NewDocLabel:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_Rubricator_Control_NewDocLabel_Push

// start class Tkw_Rubricator_Control_NewDocLabel_Push

procedure Tkw_Rubricator_Control_NewDocLabel_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('NewDocLabel');
 inherited;
end;//Tkw_Rubricator_Control_NewDocLabel_Push.DoDoIt

class function Tkw_Rubricator_Control_NewDocLabel_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::NewDocLabel:push';
end;//Tkw_Rubricator_Control_NewDocLabel_Push.GetWordNameForRegister

type
  Tkw_Rubricator_Control_DelimiterPanel = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола DelimiterPanel
----
*Пример использования*:
[code]
контрол::DelimiterPanel TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_Rubricator_Control_DelimiterPanel

// start class Tkw_Rubricator_Control_DelimiterPanel

class function Tkw_Rubricator_Control_DelimiterPanel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::DelimiterPanel';
end;//Tkw_Rubricator_Control_DelimiterPanel.GetWordNameForRegister

function Tkw_Rubricator_Control_DelimiterPanel.GetString: AnsiString;
 {-}
begin
 Result := 'DelimiterPanel';
end;//Tkw_Rubricator_Control_DelimiterPanel.GetString

class procedure Tkw_Rubricator_Control_DelimiterPanel.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_Rubricator_Control_DelimiterPanel.RegisterInEngine

type
  Tkw_Rubricator_Control_DelimiterPanel_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола DelimiterPanel
----
*Пример использования*:
[code]
контрол::DelimiterPanel:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_Rubricator_Control_DelimiterPanel_Push

// start class Tkw_Rubricator_Control_DelimiterPanel_Push

procedure Tkw_Rubricator_Control_DelimiterPanel_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('DelimiterPanel');
 inherited;
end;//Tkw_Rubricator_Control_DelimiterPanel_Push.DoDoIt

class function Tkw_Rubricator_Control_DelimiterPanel_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::DelimiterPanel:push';
end;//Tkw_Rubricator_Control_DelimiterPanel_Push.GetWordNameForRegister

type
  Tkw_Rubricator_Component_ExampleTextSource = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола ExampleTextSource
----
*Пример использования*:
[code]
компонент::ExampleTextSource TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_Rubricator_Component_ExampleTextSource

// start class Tkw_Rubricator_Component_ExampleTextSource

class function Tkw_Rubricator_Component_ExampleTextSource.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'компонент::ExampleTextSource';
end;//Tkw_Rubricator_Component_ExampleTextSource.GetWordNameForRegister

function Tkw_Rubricator_Component_ExampleTextSource.GetString: AnsiString;
 {-}
begin
 Result := 'ExampleTextSource';
end;//Tkw_Rubricator_Component_ExampleTextSource.GetString

class procedure Tkw_Rubricator_Component_ExampleTextSource.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TnscTextSource);
end;//Tkw_Rubricator_Component_ExampleTextSource.RegisterInEngine

type
  TkwEfRubricatorRubricatorList = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TefRubricator.RubricatorList
[panel]Контрол RubricatorList формы TefRubricator[panel]
*Тип результата:* TnscTreeViewWithAdapterDragDrop
*Пример:*
[code]
OBJECT VAR l_TnscTreeViewWithAdapterDragDrop
 aefRubricator .TefRubricator.RubricatorList >>> l_TnscTreeViewWithAdapterDragDrop
[code]  }
  private
  // private methods
   function RubricatorList(const aCtx: TtfwContext;
     aefRubricator: TefRubricator): TnscTreeViewWithAdapterDragDrop;
     {* Реализация слова скрипта .TefRubricator.RubricatorList }
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
  end;//TkwEfRubricatorRubricatorList

// start class TkwEfRubricatorRubricatorList

function TkwEfRubricatorRubricatorList.RubricatorList(const aCtx: TtfwContext;
  aefRubricator: TefRubricator): TnscTreeViewWithAdapterDragDrop;
 {-}
begin
 Result := aefRubricator.RubricatorList;
end;//TkwEfRubricatorRubricatorList.RubricatorList

procedure TkwEfRubricatorRubricatorList.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aefRubricator : TefRubricator;
begin
 try
  l_aefRubricator := TefRubricator(aCtx.rEngine.PopObjAs(TefRubricator));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aefRubricator: TefRubricator : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((RubricatorList(aCtx, l_aefRubricator)));
end;//TkwEfRubricatorRubricatorList.DoDoIt

class function TkwEfRubricatorRubricatorList.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TefRubricator.RubricatorList';
end;//TkwEfRubricatorRubricatorList.GetWordNameForRegister

procedure TkwEfRubricatorRubricatorList.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству RubricatorList', aCtx);
end;//TkwEfRubricatorRubricatorList.SetValuePrim

function TkwEfRubricatorRubricatorList.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TnscTreeViewWithAdapterDragDrop);
end;//TkwEfRubricatorRubricatorList.GetResultTypeInfo

function TkwEfRubricatorRubricatorList.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEfRubricatorRubricatorList.GetAllParamsCount

function TkwEfRubricatorRubricatorList.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TefRubricator)]);
end;//TkwEfRubricatorRubricatorList.ParamsTypes

type
  TkwEfRubricatorTopPanel = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TefRubricator.TopPanel
[panel]Контрол TopPanel формы TefRubricator[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aefRubricator .TefRubricator.TopPanel >>> l_TvtPanel
[code]  }
  private
  // private methods
   function TopPanel(const aCtx: TtfwContext;
     aefRubricator: TefRubricator): TvtPanel;
     {* Реализация слова скрипта .TefRubricator.TopPanel }
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
  end;//TkwEfRubricatorTopPanel

// start class TkwEfRubricatorTopPanel

function TkwEfRubricatorTopPanel.TopPanel(const aCtx: TtfwContext;
  aefRubricator: TefRubricator): TvtPanel;
 {-}
begin
 Result := aefRubricator.TopPanel;
end;//TkwEfRubricatorTopPanel.TopPanel

procedure TkwEfRubricatorTopPanel.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aefRubricator : TefRubricator;
begin
 try
  l_aefRubricator := TefRubricator(aCtx.rEngine.PopObjAs(TefRubricator));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aefRubricator: TefRubricator : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((TopPanel(aCtx, l_aefRubricator)));
end;//TkwEfRubricatorTopPanel.DoDoIt

class function TkwEfRubricatorTopPanel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TefRubricator.TopPanel';
end;//TkwEfRubricatorTopPanel.GetWordNameForRegister

procedure TkwEfRubricatorTopPanel.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству TopPanel', aCtx);
end;//TkwEfRubricatorTopPanel.SetValuePrim

function TkwEfRubricatorTopPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtPanel);
end;//TkwEfRubricatorTopPanel.GetResultTypeInfo

function TkwEfRubricatorTopPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEfRubricatorTopPanel.GetAllParamsCount

function TkwEfRubricatorTopPanel.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TefRubricator)]);
end;//TkwEfRubricatorTopPanel.ParamsTypes

type
  TkwEfRubricatorPaintBox = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TefRubricator.PaintBox
[panel]Контрол PaintBox формы TefRubricator[panel]
*Тип результата:* TPaintBox
*Пример:*
[code]
OBJECT VAR l_TPaintBox
 aefRubricator .TefRubricator.PaintBox >>> l_TPaintBox
[code]  }
  private
  // private methods
   function PaintBox(const aCtx: TtfwContext;
     aefRubricator: TefRubricator): TPaintBox;
     {* Реализация слова скрипта .TefRubricator.PaintBox }
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
  end;//TkwEfRubricatorPaintBox

// start class TkwEfRubricatorPaintBox

function TkwEfRubricatorPaintBox.PaintBox(const aCtx: TtfwContext;
  aefRubricator: TefRubricator): TPaintBox;
 {-}
begin
 Result := aefRubricator.PaintBox;
end;//TkwEfRubricatorPaintBox.PaintBox

procedure TkwEfRubricatorPaintBox.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aefRubricator : TefRubricator;
begin
 try
  l_aefRubricator := TefRubricator(aCtx.rEngine.PopObjAs(TefRubricator));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aefRubricator: TefRubricator : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((PaintBox(aCtx, l_aefRubricator)));
end;//TkwEfRubricatorPaintBox.DoDoIt

class function TkwEfRubricatorPaintBox.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TefRubricator.PaintBox';
end;//TkwEfRubricatorPaintBox.GetWordNameForRegister

procedure TkwEfRubricatorPaintBox.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству PaintBox', aCtx);
end;//TkwEfRubricatorPaintBox.SetValuePrim

function TkwEfRubricatorPaintBox.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TPaintBox);
end;//TkwEfRubricatorPaintBox.GetResultTypeInfo

function TkwEfRubricatorPaintBox.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEfRubricatorPaintBox.GetAllParamsCount

function TkwEfRubricatorPaintBox.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TefRubricator)]);
end;//TkwEfRubricatorPaintBox.ParamsTypes

type
  TkwEfRubricatorNewDocLabel = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TefRubricator.NewDocLabel
[panel]Контрол NewDocLabel формы TefRubricator[panel]
*Тип результата:* TnscSimpleEditor
*Пример:*
[code]
OBJECT VAR l_TnscSimpleEditor
 aefRubricator .TefRubricator.NewDocLabel >>> l_TnscSimpleEditor
[code]  }
  private
  // private methods
   function NewDocLabel(const aCtx: TtfwContext;
     aefRubricator: TefRubricator): TnscSimpleEditor;
     {* Реализация слова скрипта .TefRubricator.NewDocLabel }
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
  end;//TkwEfRubricatorNewDocLabel

// start class TkwEfRubricatorNewDocLabel

function TkwEfRubricatorNewDocLabel.NewDocLabel(const aCtx: TtfwContext;
  aefRubricator: TefRubricator): TnscSimpleEditor;
 {-}
begin
 Result := aefRubricator.NewDocLabel;
end;//TkwEfRubricatorNewDocLabel.NewDocLabel

procedure TkwEfRubricatorNewDocLabel.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aefRubricator : TefRubricator;
begin
 try
  l_aefRubricator := TefRubricator(aCtx.rEngine.PopObjAs(TefRubricator));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aefRubricator: TefRubricator : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((NewDocLabel(aCtx, l_aefRubricator)));
end;//TkwEfRubricatorNewDocLabel.DoDoIt

class function TkwEfRubricatorNewDocLabel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TefRubricator.NewDocLabel';
end;//TkwEfRubricatorNewDocLabel.GetWordNameForRegister

procedure TkwEfRubricatorNewDocLabel.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству NewDocLabel', aCtx);
end;//TkwEfRubricatorNewDocLabel.SetValuePrim

function TkwEfRubricatorNewDocLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TnscSimpleEditor);
end;//TkwEfRubricatorNewDocLabel.GetResultTypeInfo

function TkwEfRubricatorNewDocLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEfRubricatorNewDocLabel.GetAllParamsCount

function TkwEfRubricatorNewDocLabel.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TefRubricator)]);
end;//TkwEfRubricatorNewDocLabel.ParamsTypes

type
  TkwEfRubricatorDelimiterPanel = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TefRubricator.DelimiterPanel
[panel]Контрол DelimiterPanel формы TefRubricator[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aefRubricator .TefRubricator.DelimiterPanel >>> l_TvtPanel
[code]  }
  private
  // private methods
   function DelimiterPanel(const aCtx: TtfwContext;
     aefRubricator: TefRubricator): TvtPanel;
     {* Реализация слова скрипта .TefRubricator.DelimiterPanel }
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
  end;//TkwEfRubricatorDelimiterPanel

// start class TkwEfRubricatorDelimiterPanel

function TkwEfRubricatorDelimiterPanel.DelimiterPanel(const aCtx: TtfwContext;
  aefRubricator: TefRubricator): TvtPanel;
 {-}
begin
 Result := aefRubricator.DelimiterPanel;
end;//TkwEfRubricatorDelimiterPanel.DelimiterPanel

procedure TkwEfRubricatorDelimiterPanel.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aefRubricator : TefRubricator;
begin
 try
  l_aefRubricator := TefRubricator(aCtx.rEngine.PopObjAs(TefRubricator));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aefRubricator: TefRubricator : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((DelimiterPanel(aCtx, l_aefRubricator)));
end;//TkwEfRubricatorDelimiterPanel.DoDoIt

class function TkwEfRubricatorDelimiterPanel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TefRubricator.DelimiterPanel';
end;//TkwEfRubricatorDelimiterPanel.GetWordNameForRegister

procedure TkwEfRubricatorDelimiterPanel.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству DelimiterPanel', aCtx);
end;//TkwEfRubricatorDelimiterPanel.SetValuePrim

function TkwEfRubricatorDelimiterPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtPanel);
end;//TkwEfRubricatorDelimiterPanel.GetResultTypeInfo

function TkwEfRubricatorDelimiterPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEfRubricatorDelimiterPanel.GetAllParamsCount

function TkwEfRubricatorDelimiterPanel.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TefRubricator)]);
end;//TkwEfRubricatorDelimiterPanel.ParamsTypes

type
  TkwEfRubricatorExampleTextSource = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TefRubricator.ExampleTextSource
[panel]Контрол ExampleTextSource формы TefRubricator[panel]
*Тип результата:* TnscTextSource
*Пример:*
[code]
OBJECT VAR l_TnscTextSource
 aefRubricator .TefRubricator.ExampleTextSource >>> l_TnscTextSource
[code]  }
  private
  // private methods
   function ExampleTextSource(const aCtx: TtfwContext;
     aefRubricator: TefRubricator): TnscTextSource;
     {* Реализация слова скрипта .TefRubricator.ExampleTextSource }
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
  end;//TkwEfRubricatorExampleTextSource

// start class TkwEfRubricatorExampleTextSource

function TkwEfRubricatorExampleTextSource.ExampleTextSource(const aCtx: TtfwContext;
  aefRubricator: TefRubricator): TnscTextSource;
 {-}
begin
 Result := aefRubricator.ExampleTextSource;
end;//TkwEfRubricatorExampleTextSource.ExampleTextSource

procedure TkwEfRubricatorExampleTextSource.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aefRubricator : TefRubricator;
begin
 try
  l_aefRubricator := TefRubricator(aCtx.rEngine.PopObjAs(TefRubricator));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aefRubricator: TefRubricator : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((ExampleTextSource(aCtx, l_aefRubricator)));
end;//TkwEfRubricatorExampleTextSource.DoDoIt

class function TkwEfRubricatorExampleTextSource.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TefRubricator.ExampleTextSource';
end;//TkwEfRubricatorExampleTextSource.GetWordNameForRegister

procedure TkwEfRubricatorExampleTextSource.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству ExampleTextSource', aCtx);
end;//TkwEfRubricatorExampleTextSource.SetValuePrim

function TkwEfRubricatorExampleTextSource.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TnscTextSource);
end;//TkwEfRubricatorExampleTextSource.GetResultTypeInfo

function TkwEfRubricatorExampleTextSource.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEfRubricatorExampleTextSource.GetAllParamsCount

function TkwEfRubricatorExampleTextSource.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TefRubricator)]);
end;//TkwEfRubricatorExampleTextSource.ParamsTypes
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_Form_Rubricator
 Tkw_Form_Rubricator.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_Rubricator_Control_RubricatorList
 Tkw_Rubricator_Control_RubricatorList.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_Rubricator_Control_RubricatorList_Push
 Tkw_Rubricator_Control_RubricatorList_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_Rubricator_Control_TopPanel
 Tkw_Rubricator_Control_TopPanel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_Rubricator_Control_TopPanel_Push
 Tkw_Rubricator_Control_TopPanel_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_Rubricator_Control_PaintBox
 Tkw_Rubricator_Control_PaintBox.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_Rubricator_Control_PaintBox_Push
 Tkw_Rubricator_Control_PaintBox_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_Rubricator_Control_NewDocLabel
 Tkw_Rubricator_Control_NewDocLabel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_Rubricator_Control_NewDocLabel_Push
 Tkw_Rubricator_Control_NewDocLabel_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_Rubricator_Control_DelimiterPanel
 Tkw_Rubricator_Control_DelimiterPanel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_Rubricator_Control_DelimiterPanel_Push
 Tkw_Rubricator_Control_DelimiterPanel_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_Rubricator_Component_ExampleTextSource
 Tkw_Rubricator_Component_ExampleTextSource.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация efRubricator_RubricatorList
 TkwEfRubricatorRubricatorList.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация efRubricator_TopPanel
 TkwEfRubricatorTopPanel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация efRubricator_PaintBox
 TkwEfRubricatorPaintBox.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация efRubricator_NewDocLabel
 TkwEfRubricatorNewDocLabel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация efRubricator_DelimiterPanel
 TkwEfRubricatorDelimiterPanel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация efRubricator_ExampleTextSource
 TkwEfRubricatorExampleTextSource.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа Rubricator
 TtfwTypeRegistrator.RegisterType(TypeInfo(TefRubricator));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TnscTreeViewWithAdapterDragDrop
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscTreeViewWithAdapterDragDrop));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TvtPanel
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TPaintBox
 TtfwTypeRegistrator.RegisterType(TypeInfo(TPaintBox));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TnscSimpleEditor
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscSimpleEditor));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TnscTextSource
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscTextSource));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.