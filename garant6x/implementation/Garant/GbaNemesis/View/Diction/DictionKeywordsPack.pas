unit DictionKeywordsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Diction/DictionKeywordsPack.pas"
// Начат: 01.09.2009 13:14
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeywordsPack::Class>> F1 Встроенные продукты::Diction::View::Diction::Diction$FP::DictionKeywordsPack
//
// Набор слов словаря для доступа к экземплярам контролов формы Diction
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
  Diction_Form,
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
  Tkw_Form_Diction = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора формы Diction
----
*Пример использования*:
[code]
'aControl' форма::Diction TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
  end;//Tkw_Form_Diction

// start class Tkw_Form_Diction

class function Tkw_Form_Diction.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'форма::Diction';
end;//Tkw_Form_Diction.GetWordNameForRegister

function Tkw_Form_Diction.GetString: AnsiString;
 {-}
begin
 Result := 'enDiction';
end;//Tkw_Form_Diction.GetString

type
  Tkw_Diction_Control_BackgroundPanel = {final scriptword} class(TtfwControlString)
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
  end;//Tkw_Diction_Control_BackgroundPanel

// start class Tkw_Diction_Control_BackgroundPanel

class function Tkw_Diction_Control_BackgroundPanel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::BackgroundPanel';
end;//Tkw_Diction_Control_BackgroundPanel.GetWordNameForRegister

function Tkw_Diction_Control_BackgroundPanel.GetString: AnsiString;
 {-}
begin
 Result := 'BackgroundPanel';
end;//Tkw_Diction_Control_BackgroundPanel.GetString

class procedure Tkw_Diction_Control_BackgroundPanel.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_Diction_Control_BackgroundPanel.RegisterInEngine

type
  Tkw_Diction_Control_BackgroundPanel_Push = {final scriptword} class(TkwBynameControlPush)
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
  end;//Tkw_Diction_Control_BackgroundPanel_Push

// start class Tkw_Diction_Control_BackgroundPanel_Push

procedure Tkw_Diction_Control_BackgroundPanel_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('BackgroundPanel');
 inherited;
end;//Tkw_Diction_Control_BackgroundPanel_Push.DoDoIt

class function Tkw_Diction_Control_BackgroundPanel_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::BackgroundPanel:push';
end;//Tkw_Diction_Control_BackgroundPanel_Push.GetWordNameForRegister

type
  Tkw_Diction_Control_ContextFilter = {final scriptword} class(TtfwControlString)
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
  end;//Tkw_Diction_Control_ContextFilter

// start class Tkw_Diction_Control_ContextFilter

class function Tkw_Diction_Control_ContextFilter.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::ContextFilter';
end;//Tkw_Diction_Control_ContextFilter.GetWordNameForRegister

function Tkw_Diction_Control_ContextFilter.GetString: AnsiString;
 {-}
begin
 Result := 'ContextFilter';
end;//Tkw_Diction_Control_ContextFilter.GetString

class procedure Tkw_Diction_Control_ContextFilter.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TnscContextFilter);
end;//Tkw_Diction_Control_ContextFilter.RegisterInEngine

type
  Tkw_Diction_Control_ContextFilter_Push = {final scriptword} class(TkwBynameControlPush)
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
  end;//Tkw_Diction_Control_ContextFilter_Push

// start class Tkw_Diction_Control_ContextFilter_Push

procedure Tkw_Diction_Control_ContextFilter_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('ContextFilter');
 inherited;
end;//Tkw_Diction_Control_ContextFilter_Push.DoDoIt

class function Tkw_Diction_Control_ContextFilter_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::ContextFilter:push';
end;//Tkw_Diction_Control_ContextFilter_Push.GetWordNameForRegister

type
  Tkw_Diction_Control_WordsTree = {final scriptword} class(TtfwControlString)
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
  end;//Tkw_Diction_Control_WordsTree

// start class Tkw_Diction_Control_WordsTree

class function Tkw_Diction_Control_WordsTree.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::WordsTree';
end;//Tkw_Diction_Control_WordsTree.GetWordNameForRegister

function Tkw_Diction_Control_WordsTree.GetString: AnsiString;
 {-}
begin
 Result := 'WordsTree';
end;//Tkw_Diction_Control_WordsTree.GetString

class procedure Tkw_Diction_Control_WordsTree.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TnscTreeViewWithAdapterDragDrop);
end;//Tkw_Diction_Control_WordsTree.RegisterInEngine

type
  Tkw_Diction_Control_WordsTree_Push = {final scriptword} class(TkwBynameControlPush)
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
  end;//Tkw_Diction_Control_WordsTree_Push

// start class Tkw_Diction_Control_WordsTree_Push

procedure Tkw_Diction_Control_WordsTree_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('WordsTree');
 inherited;
end;//Tkw_Diction_Control_WordsTree_Push.DoDoIt

class function Tkw_Diction_Control_WordsTree_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::WordsTree:push';
end;//Tkw_Diction_Control_WordsTree_Push.GetWordNameForRegister

type
  TkwEnDictionBackgroundPanel = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TenDiction.BackgroundPanel
[panel]Контрол BackgroundPanel формы TenDiction[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aenDiction .TenDiction.BackgroundPanel >>> l_TvtPanel
[code]  }
  private
  // private methods
   function BackgroundPanel(const aCtx: TtfwContext;
     aenDiction: TenDiction): TvtPanel;
     {* Реализация слова скрипта .TenDiction.BackgroundPanel }
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
  end;//TkwEnDictionBackgroundPanel

// start class TkwEnDictionBackgroundPanel

function TkwEnDictionBackgroundPanel.BackgroundPanel(const aCtx: TtfwContext;
  aenDiction: TenDiction): TvtPanel;
 {-}
begin
 Result := aenDiction.BackgroundPanel;
end;//TkwEnDictionBackgroundPanel.BackgroundPanel

procedure TkwEnDictionBackgroundPanel.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aenDiction : TenDiction;
begin
 try
  l_aenDiction := TenDiction(aCtx.rEngine.PopObjAs(TenDiction));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aenDiction: TenDiction : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((BackgroundPanel(aCtx, l_aenDiction)));
end;//TkwEnDictionBackgroundPanel.DoDoIt

class function TkwEnDictionBackgroundPanel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TenDiction.BackgroundPanel';
end;//TkwEnDictionBackgroundPanel.GetWordNameForRegister

procedure TkwEnDictionBackgroundPanel.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству BackgroundPanel', aCtx);
end;//TkwEnDictionBackgroundPanel.SetValuePrim

function TkwEnDictionBackgroundPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtPanel);
end;//TkwEnDictionBackgroundPanel.GetResultTypeInfo

function TkwEnDictionBackgroundPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEnDictionBackgroundPanel.GetAllParamsCount

function TkwEnDictionBackgroundPanel.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TenDiction)]);
end;//TkwEnDictionBackgroundPanel.ParamsTypes

type
  TkwEnDictionContextFilter = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TenDiction.ContextFilter
[panel]Контрол ContextFilter формы TenDiction[panel]
*Тип результата:* TnscContextFilter
*Пример:*
[code]
OBJECT VAR l_TnscContextFilter
 aenDiction .TenDiction.ContextFilter >>> l_TnscContextFilter
[code]  }
  private
  // private methods
   function ContextFilter(const aCtx: TtfwContext;
     aenDiction: TenDiction): TnscContextFilter;
     {* Реализация слова скрипта .TenDiction.ContextFilter }
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
  end;//TkwEnDictionContextFilter

// start class TkwEnDictionContextFilter

function TkwEnDictionContextFilter.ContextFilter(const aCtx: TtfwContext;
  aenDiction: TenDiction): TnscContextFilter;
 {-}
begin
 Result := aenDiction.ContextFilter;
end;//TkwEnDictionContextFilter.ContextFilter

procedure TkwEnDictionContextFilter.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aenDiction : TenDiction;
begin
 try
  l_aenDiction := TenDiction(aCtx.rEngine.PopObjAs(TenDiction));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aenDiction: TenDiction : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((ContextFilter(aCtx, l_aenDiction)));
end;//TkwEnDictionContextFilter.DoDoIt

class function TkwEnDictionContextFilter.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TenDiction.ContextFilter';
end;//TkwEnDictionContextFilter.GetWordNameForRegister

procedure TkwEnDictionContextFilter.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству ContextFilter', aCtx);
end;//TkwEnDictionContextFilter.SetValuePrim

function TkwEnDictionContextFilter.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TnscContextFilter);
end;//TkwEnDictionContextFilter.GetResultTypeInfo

function TkwEnDictionContextFilter.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEnDictionContextFilter.GetAllParamsCount

function TkwEnDictionContextFilter.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TenDiction)]);
end;//TkwEnDictionContextFilter.ParamsTypes

type
  TkwEnDictionWordsTree = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TenDiction.WordsTree
[panel]Контрол WordsTree формы TenDiction[panel]
*Тип результата:* TnscTreeViewWithAdapterDragDrop
*Пример:*
[code]
OBJECT VAR l_TnscTreeViewWithAdapterDragDrop
 aenDiction .TenDiction.WordsTree >>> l_TnscTreeViewWithAdapterDragDrop
[code]  }
  private
  // private methods
   function WordsTree(const aCtx: TtfwContext;
     aenDiction: TenDiction): TnscTreeViewWithAdapterDragDrop;
     {* Реализация слова скрипта .TenDiction.WordsTree }
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
  end;//TkwEnDictionWordsTree

// start class TkwEnDictionWordsTree

function TkwEnDictionWordsTree.WordsTree(const aCtx: TtfwContext;
  aenDiction: TenDiction): TnscTreeViewWithAdapterDragDrop;
 {-}
begin
 Result := aenDiction.WordsTree;
end;//TkwEnDictionWordsTree.WordsTree

procedure TkwEnDictionWordsTree.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aenDiction : TenDiction;
begin
 try
  l_aenDiction := TenDiction(aCtx.rEngine.PopObjAs(TenDiction));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aenDiction: TenDiction : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((WordsTree(aCtx, l_aenDiction)));
end;//TkwEnDictionWordsTree.DoDoIt

class function TkwEnDictionWordsTree.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TenDiction.WordsTree';
end;//TkwEnDictionWordsTree.GetWordNameForRegister

procedure TkwEnDictionWordsTree.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству WordsTree', aCtx);
end;//TkwEnDictionWordsTree.SetValuePrim

function TkwEnDictionWordsTree.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TnscTreeViewWithAdapterDragDrop);
end;//TkwEnDictionWordsTree.GetResultTypeInfo

function TkwEnDictionWordsTree.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEnDictionWordsTree.GetAllParamsCount

function TkwEnDictionWordsTree.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TenDiction)]);
end;//TkwEnDictionWordsTree.ParamsTypes
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_Form_Diction
 Tkw_Form_Diction.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_Diction_Control_BackgroundPanel
 Tkw_Diction_Control_BackgroundPanel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_Diction_Control_BackgroundPanel_Push
 Tkw_Diction_Control_BackgroundPanel_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_Diction_Control_ContextFilter
 Tkw_Diction_Control_ContextFilter.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_Diction_Control_ContextFilter_Push
 Tkw_Diction_Control_ContextFilter_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_Diction_Control_WordsTree
 Tkw_Diction_Control_WordsTree.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_Diction_Control_WordsTree_Push
 Tkw_Diction_Control_WordsTree_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация enDiction_BackgroundPanel
 TkwEnDictionBackgroundPanel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация enDiction_ContextFilter
 TkwEnDictionContextFilter.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация enDiction_WordsTree
 TkwEnDictionWordsTree.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа Diction
 TtfwTypeRegistrator.RegisterType(TypeInfo(TenDiction));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TvtPanel
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TnscContextFilter
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscContextFilter));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TnscTreeViewWithAdapterDragDrop
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscTreeViewWithAdapterDragDrop));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.