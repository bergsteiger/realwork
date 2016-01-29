unit CommonDictionKeywordsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Diction/CommonDictionKeywordsPack.pas"
// Начат: 01.09.2009 13:14
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeywordsPack::Class>> F1 Встроенные продукты::Diction::View::Diction::Diction$FP::CommonDictionKeywordsPack
//
// Набор слов словаря для доступа к экземплярам контролов формы CommonDiction
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
  {$If defined(Nemesis)}
  ,
  nscContextFilter
  {$IfEnd} //Nemesis
  ,
  vtPanel,
  CommonDiction_Form,
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
  Tkw_Form_CommonDiction = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора формы CommonDiction
----
*Пример использования*:
[code]
'aControl' форма::CommonDiction TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
  end;//Tkw_Form_CommonDiction

// start class Tkw_Form_CommonDiction

class function Tkw_Form_CommonDiction.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'форма::CommonDiction';
end;//Tkw_Form_CommonDiction.GetWordNameForRegister

function Tkw_Form_CommonDiction.GetString: AnsiString;
 {-}
begin
 Result := 'en_CommonDiction';
end;//Tkw_Form_CommonDiction.GetString

type
  Tkw_CommonDiction_Control_BackgroundPanel = {final scriptword} class(TtfwControlString)
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
  end;//Tkw_CommonDiction_Control_BackgroundPanel

// start class Tkw_CommonDiction_Control_BackgroundPanel

class function Tkw_CommonDiction_Control_BackgroundPanel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::BackgroundPanel';
end;//Tkw_CommonDiction_Control_BackgroundPanel.GetWordNameForRegister

function Tkw_CommonDiction_Control_BackgroundPanel.GetString: AnsiString;
 {-}
begin
 Result := 'BackgroundPanel';
end;//Tkw_CommonDiction_Control_BackgroundPanel.GetString

class procedure Tkw_CommonDiction_Control_BackgroundPanel.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_CommonDiction_Control_BackgroundPanel.RegisterInEngine

type
  Tkw_CommonDiction_Control_BackgroundPanel_Push = {final scriptword} class(TkwBynameControlPush)
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
  end;//Tkw_CommonDiction_Control_BackgroundPanel_Push

// start class Tkw_CommonDiction_Control_BackgroundPanel_Push

procedure Tkw_CommonDiction_Control_BackgroundPanel_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('BackgroundPanel');
 inherited;
end;//Tkw_CommonDiction_Control_BackgroundPanel_Push.DoDoIt

class function Tkw_CommonDiction_Control_BackgroundPanel_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::BackgroundPanel:push';
end;//Tkw_CommonDiction_Control_BackgroundPanel_Push.GetWordNameForRegister

type
  Tkw_CommonDiction_Control_WordsTree = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола WordsTree
----
*Пример использования*:
[code]
контрол::WordsTree TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_CommonDiction_Control_WordsTree

// start class Tkw_CommonDiction_Control_WordsTree

class function Tkw_CommonDiction_Control_WordsTree.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::WordsTree';
end;//Tkw_CommonDiction_Control_WordsTree.GetWordNameForRegister

function Tkw_CommonDiction_Control_WordsTree.GetString: AnsiString;
 {-}
begin
 Result := 'WordsTree';
end;//Tkw_CommonDiction_Control_WordsTree.GetString

class procedure Tkw_CommonDiction_Control_WordsTree.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TnscTreeViewWithAdapterDragDrop);
end;//Tkw_CommonDiction_Control_WordsTree.RegisterInEngine

type
  Tkw_CommonDiction_Control_WordsTree_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола WordsTree
----
*Пример использования*:
[code]
контрол::WordsTree:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_CommonDiction_Control_WordsTree_Push

// start class Tkw_CommonDiction_Control_WordsTree_Push

procedure Tkw_CommonDiction_Control_WordsTree_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('WordsTree');
 inherited;
end;//Tkw_CommonDiction_Control_WordsTree_Push.DoDoIt

class function Tkw_CommonDiction_Control_WordsTree_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::WordsTree:push';
end;//Tkw_CommonDiction_Control_WordsTree_Push.GetWordNameForRegister

type
  Tkw_CommonDiction_Control_ContextFilter = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола ContextFilter
----
*Пример использования*:
[code]
контрол::ContextFilter TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_CommonDiction_Control_ContextFilter

// start class Tkw_CommonDiction_Control_ContextFilter

class function Tkw_CommonDiction_Control_ContextFilter.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::ContextFilter';
end;//Tkw_CommonDiction_Control_ContextFilter.GetWordNameForRegister

function Tkw_CommonDiction_Control_ContextFilter.GetString: AnsiString;
 {-}
begin
 Result := 'ContextFilter';
end;//Tkw_CommonDiction_Control_ContextFilter.GetString

class procedure Tkw_CommonDiction_Control_ContextFilter.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TnscContextFilter);
end;//Tkw_CommonDiction_Control_ContextFilter.RegisterInEngine

type
  Tkw_CommonDiction_Control_ContextFilter_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола ContextFilter
----
*Пример использования*:
[code]
контрол::ContextFilter:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_CommonDiction_Control_ContextFilter_Push

// start class Tkw_CommonDiction_Control_ContextFilter_Push

procedure Tkw_CommonDiction_Control_ContextFilter_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('ContextFilter');
 inherited;
end;//Tkw_CommonDiction_Control_ContextFilter_Push.DoDoIt

class function Tkw_CommonDiction_Control_ContextFilter_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::ContextFilter:push';
end;//Tkw_CommonDiction_Control_ContextFilter_Push.GetWordNameForRegister

type
  TkwEnCommonDictionBackgroundPanel = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .Ten_CommonDiction.BackgroundPanel
[panel]Контрол BackgroundPanel формы Ten_CommonDiction[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aen_CommonDiction .Ten_CommonDiction.BackgroundPanel >>> l_TvtPanel
[code]  }
  private
  // private methods
   function BackgroundPanel(const aCtx: TtfwContext;
     aen_CommonDiction: Ten_CommonDiction): TvtPanel;
     {* Реализация слова скрипта .Ten_CommonDiction.BackgroundPanel }
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
  end;//TkwEnCommonDictionBackgroundPanel

// start class TkwEnCommonDictionBackgroundPanel

function TkwEnCommonDictionBackgroundPanel.BackgroundPanel(const aCtx: TtfwContext;
  aen_CommonDiction: Ten_CommonDiction): TvtPanel;
 {-}
begin
 Result := aen_CommonDiction.BackgroundPanel;
end;//TkwEnCommonDictionBackgroundPanel.BackgroundPanel

procedure TkwEnCommonDictionBackgroundPanel.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aen_CommonDiction : Ten_CommonDiction;
begin
 try
  l_aen_CommonDiction := Ten_CommonDiction(aCtx.rEngine.PopObjAs(Ten_CommonDiction));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aen_CommonDiction: Ten_CommonDiction : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((BackgroundPanel(aCtx, l_aen_CommonDiction)));
end;//TkwEnCommonDictionBackgroundPanel.DoDoIt

class function TkwEnCommonDictionBackgroundPanel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.Ten_CommonDiction.BackgroundPanel';
end;//TkwEnCommonDictionBackgroundPanel.GetWordNameForRegister

procedure TkwEnCommonDictionBackgroundPanel.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству BackgroundPanel', aCtx);
end;//TkwEnCommonDictionBackgroundPanel.SetValuePrim

function TkwEnCommonDictionBackgroundPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtPanel);
end;//TkwEnCommonDictionBackgroundPanel.GetResultTypeInfo

function TkwEnCommonDictionBackgroundPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEnCommonDictionBackgroundPanel.GetAllParamsCount

function TkwEnCommonDictionBackgroundPanel.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_CommonDiction)]);
end;//TkwEnCommonDictionBackgroundPanel.ParamsTypes

type
  TkwEnCommonDictionWordsTree = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .Ten_CommonDiction.WordsTree
[panel]Контрол WordsTree формы Ten_CommonDiction[panel]
*Тип результата:* TnscTreeViewWithAdapterDragDrop
*Пример:*
[code]
OBJECT VAR l_TnscTreeViewWithAdapterDragDrop
 aen_CommonDiction .Ten_CommonDiction.WordsTree >>> l_TnscTreeViewWithAdapterDragDrop
[code]  }
  private
  // private methods
   function WordsTree(const aCtx: TtfwContext;
     aen_CommonDiction: Ten_CommonDiction): TnscTreeViewWithAdapterDragDrop;
     {* Реализация слова скрипта .Ten_CommonDiction.WordsTree }
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
  end;//TkwEnCommonDictionWordsTree

// start class TkwEnCommonDictionWordsTree

function TkwEnCommonDictionWordsTree.WordsTree(const aCtx: TtfwContext;
  aen_CommonDiction: Ten_CommonDiction): TnscTreeViewWithAdapterDragDrop;
 {-}
begin
 Result := aen_CommonDiction.WordsTree;
end;//TkwEnCommonDictionWordsTree.WordsTree

procedure TkwEnCommonDictionWordsTree.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aen_CommonDiction : Ten_CommonDiction;
begin
 try
  l_aen_CommonDiction := Ten_CommonDiction(aCtx.rEngine.PopObjAs(Ten_CommonDiction));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aen_CommonDiction: Ten_CommonDiction : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((WordsTree(aCtx, l_aen_CommonDiction)));
end;//TkwEnCommonDictionWordsTree.DoDoIt

class function TkwEnCommonDictionWordsTree.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.Ten_CommonDiction.WordsTree';
end;//TkwEnCommonDictionWordsTree.GetWordNameForRegister

procedure TkwEnCommonDictionWordsTree.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству WordsTree', aCtx);
end;//TkwEnCommonDictionWordsTree.SetValuePrim

function TkwEnCommonDictionWordsTree.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TnscTreeViewWithAdapterDragDrop);
end;//TkwEnCommonDictionWordsTree.GetResultTypeInfo

function TkwEnCommonDictionWordsTree.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEnCommonDictionWordsTree.GetAllParamsCount

function TkwEnCommonDictionWordsTree.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_CommonDiction)]);
end;//TkwEnCommonDictionWordsTree.ParamsTypes

type
  TkwEnCommonDictionContextFilter = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .Ten_CommonDiction.ContextFilter
[panel]Контрол ContextFilter формы Ten_CommonDiction[panel]
*Тип результата:* TnscContextFilter
*Пример:*
[code]
OBJECT VAR l_TnscContextFilter
 aen_CommonDiction .Ten_CommonDiction.ContextFilter >>> l_TnscContextFilter
[code]  }
  private
  // private methods
   function ContextFilter(const aCtx: TtfwContext;
     aen_CommonDiction: Ten_CommonDiction): TnscContextFilter;
     {* Реализация слова скрипта .Ten_CommonDiction.ContextFilter }
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
  end;//TkwEnCommonDictionContextFilter

// start class TkwEnCommonDictionContextFilter

function TkwEnCommonDictionContextFilter.ContextFilter(const aCtx: TtfwContext;
  aen_CommonDiction: Ten_CommonDiction): TnscContextFilter;
 {-}
begin
 Result := aen_CommonDiction.ContextFilter;
end;//TkwEnCommonDictionContextFilter.ContextFilter

procedure TkwEnCommonDictionContextFilter.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aen_CommonDiction : Ten_CommonDiction;
begin
 try
  l_aen_CommonDiction := Ten_CommonDiction(aCtx.rEngine.PopObjAs(Ten_CommonDiction));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aen_CommonDiction: Ten_CommonDiction : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((ContextFilter(aCtx, l_aen_CommonDiction)));
end;//TkwEnCommonDictionContextFilter.DoDoIt

class function TkwEnCommonDictionContextFilter.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.Ten_CommonDiction.ContextFilter';
end;//TkwEnCommonDictionContextFilter.GetWordNameForRegister

procedure TkwEnCommonDictionContextFilter.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству ContextFilter', aCtx);
end;//TkwEnCommonDictionContextFilter.SetValuePrim

function TkwEnCommonDictionContextFilter.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TnscContextFilter);
end;//TkwEnCommonDictionContextFilter.GetResultTypeInfo

function TkwEnCommonDictionContextFilter.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEnCommonDictionContextFilter.GetAllParamsCount

function TkwEnCommonDictionContextFilter.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_CommonDiction)]);
end;//TkwEnCommonDictionContextFilter.ParamsTypes
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_Form_CommonDiction
 Tkw_Form_CommonDiction.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_CommonDiction_Control_BackgroundPanel
 Tkw_CommonDiction_Control_BackgroundPanel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_CommonDiction_Control_BackgroundPanel_Push
 Tkw_CommonDiction_Control_BackgroundPanel_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_CommonDiction_Control_WordsTree
 Tkw_CommonDiction_Control_WordsTree.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_CommonDiction_Control_WordsTree_Push
 Tkw_CommonDiction_Control_WordsTree_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_CommonDiction_Control_ContextFilter
 Tkw_CommonDiction_Control_ContextFilter.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_CommonDiction_Control_ContextFilter_Push
 Tkw_CommonDiction_Control_ContextFilter_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация en_CommonDiction_BackgroundPanel
 TkwEnCommonDictionBackgroundPanel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация en_CommonDiction_WordsTree
 TkwEnCommonDictionWordsTree.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация en_CommonDiction_ContextFilter
 TkwEnCommonDictionContextFilter.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа CommonDiction
 TtfwTypeRegistrator.RegisterType(TypeInfo(Ten_CommonDiction));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TvtPanel
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TnscTreeViewWithAdapterDragDrop
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscTreeViewWithAdapterDragDrop));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TnscContextFilter
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscContextFilter));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.