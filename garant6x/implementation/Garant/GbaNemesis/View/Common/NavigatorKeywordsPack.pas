unit NavigatorKeywordsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Common/NavigatorKeywordsPack.pas"
// Начат: 24.08.2009 20:35
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeywordsPack::Class>> F1 Core::Common::View::Common::PrimF1Common::NavigatorKeywordsPack
//
// Набор слов словаря для доступа к экземплярам контролов формы Navigator
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
  Navigator_Form,
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
  Tkw_Form_Navigator = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора формы Navigator
----
*Пример использования*:
[code]
'aControl' форма::Navigator TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
  end;//Tkw_Form_Navigator

// start class Tkw_Form_Navigator

class function Tkw_Form_Navigator.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'форма::Navigator';
end;//Tkw_Form_Navigator.GetWordNameForRegister

function Tkw_Form_Navigator.GetString: AnsiString;
 {-}
begin
 Result := 'en_Navigator';
end;//Tkw_Form_Navigator.GetString

type
  Tkw_Navigator_Control_BackgroundPanel = {final scriptword} class(TtfwControlString)
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
  end;//Tkw_Navigator_Control_BackgroundPanel

// start class Tkw_Navigator_Control_BackgroundPanel

class function Tkw_Navigator_Control_BackgroundPanel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::BackgroundPanel';
end;//Tkw_Navigator_Control_BackgroundPanel.GetWordNameForRegister

function Tkw_Navigator_Control_BackgroundPanel.GetString: AnsiString;
 {-}
begin
 Result := 'BackgroundPanel';
end;//Tkw_Navigator_Control_BackgroundPanel.GetString

class procedure Tkw_Navigator_Control_BackgroundPanel.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_Navigator_Control_BackgroundPanel.RegisterInEngine

type
  Tkw_Navigator_Control_BackgroundPanel_Push = {final scriptword} class(TkwBynameControlPush)
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
  end;//Tkw_Navigator_Control_BackgroundPanel_Push

// start class Tkw_Navigator_Control_BackgroundPanel_Push

procedure Tkw_Navigator_Control_BackgroundPanel_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('BackgroundPanel');
 inherited;
end;//Tkw_Navigator_Control_BackgroundPanel_Push.DoDoIt

class function Tkw_Navigator_Control_BackgroundPanel_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::BackgroundPanel:push';
end;//Tkw_Navigator_Control_BackgroundPanel_Push.GetWordNameForRegister

type
  Tkw_Navigator_Control_ContextFilter = {final scriptword} class(TtfwControlString)
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
  end;//Tkw_Navigator_Control_ContextFilter

// start class Tkw_Navigator_Control_ContextFilter

class function Tkw_Navigator_Control_ContextFilter.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::ContextFilter';
end;//Tkw_Navigator_Control_ContextFilter.GetWordNameForRegister

function Tkw_Navigator_Control_ContextFilter.GetString: AnsiString;
 {-}
begin
 Result := 'ContextFilter';
end;//Tkw_Navigator_Control_ContextFilter.GetString

class procedure Tkw_Navigator_Control_ContextFilter.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TnscContextFilter);
end;//Tkw_Navigator_Control_ContextFilter.RegisterInEngine

type
  Tkw_Navigator_Control_ContextFilter_Push = {final scriptword} class(TkwBynameControlPush)
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
  end;//Tkw_Navigator_Control_ContextFilter_Push

// start class Tkw_Navigator_Control_ContextFilter_Push

procedure Tkw_Navigator_Control_ContextFilter_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('ContextFilter');
 inherited;
end;//Tkw_Navigator_Control_ContextFilter_Push.DoDoIt

class function Tkw_Navigator_Control_ContextFilter_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::ContextFilter:push';
end;//Tkw_Navigator_Control_ContextFilter_Push.GetWordNameForRegister

type
  Tkw_Navigator_Control_NavigatorTree = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола NavigatorTree
----
*Пример использования*:
[code]
контрол::NavigatorTree TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_Navigator_Control_NavigatorTree

// start class Tkw_Navigator_Control_NavigatorTree

class function Tkw_Navigator_Control_NavigatorTree.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::NavigatorTree';
end;//Tkw_Navigator_Control_NavigatorTree.GetWordNameForRegister

function Tkw_Navigator_Control_NavigatorTree.GetString: AnsiString;
 {-}
begin
 Result := 'NavigatorTree';
end;//Tkw_Navigator_Control_NavigatorTree.GetString

class procedure Tkw_Navigator_Control_NavigatorTree.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TnscTreeViewWithAdapterDragDrop);
end;//Tkw_Navigator_Control_NavigatorTree.RegisterInEngine

type
  Tkw_Navigator_Control_NavigatorTree_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола NavigatorTree
----
*Пример использования*:
[code]
контрол::NavigatorTree:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_Navigator_Control_NavigatorTree_Push

// start class Tkw_Navigator_Control_NavigatorTree_Push

procedure Tkw_Navigator_Control_NavigatorTree_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('NavigatorTree');
 inherited;
end;//Tkw_Navigator_Control_NavigatorTree_Push.DoDoIt

class function Tkw_Navigator_Control_NavigatorTree_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::NavigatorTree:push';
end;//Tkw_Navigator_Control_NavigatorTree_Push.GetWordNameForRegister

type
  TkwEnNavigatorBackgroundPanel = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .Ten_Navigator.BackgroundPanel
[panel]Контрол BackgroundPanel формы Ten_Navigator[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aen_Navigator .Ten_Navigator.BackgroundPanel >>> l_TvtPanel
[code]  }
  private
  // private methods
   function BackgroundPanel(const aCtx: TtfwContext;
     aen_Navigator: Ten_Navigator): TvtPanel;
     {* Реализация слова скрипта .Ten_Navigator.BackgroundPanel }
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
  end;//TkwEnNavigatorBackgroundPanel

// start class TkwEnNavigatorBackgroundPanel

function TkwEnNavigatorBackgroundPanel.BackgroundPanel(const aCtx: TtfwContext;
  aen_Navigator: Ten_Navigator): TvtPanel;
 {-}
begin
 Result := aen_Navigator.BackgroundPanel;
end;//TkwEnNavigatorBackgroundPanel.BackgroundPanel

procedure TkwEnNavigatorBackgroundPanel.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aen_Navigator : Ten_Navigator;
begin
 try
  l_aen_Navigator := Ten_Navigator(aCtx.rEngine.PopObjAs(Ten_Navigator));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aen_Navigator: Ten_Navigator : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((BackgroundPanel(aCtx, l_aen_Navigator)));
end;//TkwEnNavigatorBackgroundPanel.DoDoIt

class function TkwEnNavigatorBackgroundPanel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.Ten_Navigator.BackgroundPanel';
end;//TkwEnNavigatorBackgroundPanel.GetWordNameForRegister

procedure TkwEnNavigatorBackgroundPanel.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству BackgroundPanel', aCtx);
end;//TkwEnNavigatorBackgroundPanel.SetValuePrim

function TkwEnNavigatorBackgroundPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtPanel);
end;//TkwEnNavigatorBackgroundPanel.GetResultTypeInfo

function TkwEnNavigatorBackgroundPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEnNavigatorBackgroundPanel.GetAllParamsCount

function TkwEnNavigatorBackgroundPanel.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_Navigator)]);
end;//TkwEnNavigatorBackgroundPanel.ParamsTypes

type
  TkwEnNavigatorContextFilter = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .Ten_Navigator.ContextFilter
[panel]Контрол ContextFilter формы Ten_Navigator[panel]
*Тип результата:* TnscContextFilter
*Пример:*
[code]
OBJECT VAR l_TnscContextFilter
 aen_Navigator .Ten_Navigator.ContextFilter >>> l_TnscContextFilter
[code]  }
  private
  // private methods
   function ContextFilter(const aCtx: TtfwContext;
     aen_Navigator: Ten_Navigator): TnscContextFilter;
     {* Реализация слова скрипта .Ten_Navigator.ContextFilter }
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
  end;//TkwEnNavigatorContextFilter

// start class TkwEnNavigatorContextFilter

function TkwEnNavigatorContextFilter.ContextFilter(const aCtx: TtfwContext;
  aen_Navigator: Ten_Navigator): TnscContextFilter;
 {-}
begin
 Result := aen_Navigator.ContextFilter;
end;//TkwEnNavigatorContextFilter.ContextFilter

procedure TkwEnNavigatorContextFilter.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aen_Navigator : Ten_Navigator;
begin
 try
  l_aen_Navigator := Ten_Navigator(aCtx.rEngine.PopObjAs(Ten_Navigator));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aen_Navigator: Ten_Navigator : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((ContextFilter(aCtx, l_aen_Navigator)));
end;//TkwEnNavigatorContextFilter.DoDoIt

class function TkwEnNavigatorContextFilter.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.Ten_Navigator.ContextFilter';
end;//TkwEnNavigatorContextFilter.GetWordNameForRegister

procedure TkwEnNavigatorContextFilter.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству ContextFilter', aCtx);
end;//TkwEnNavigatorContextFilter.SetValuePrim

function TkwEnNavigatorContextFilter.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TnscContextFilter);
end;//TkwEnNavigatorContextFilter.GetResultTypeInfo

function TkwEnNavigatorContextFilter.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEnNavigatorContextFilter.GetAllParamsCount

function TkwEnNavigatorContextFilter.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_Navigator)]);
end;//TkwEnNavigatorContextFilter.ParamsTypes

type
  TkwEnNavigatorNavigatorTree = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .Ten_Navigator.NavigatorTree
[panel]Контрол NavigatorTree формы Ten_Navigator[panel]
*Тип результата:* TnscTreeViewWithAdapterDragDrop
*Пример:*
[code]
OBJECT VAR l_TnscTreeViewWithAdapterDragDrop
 aen_Navigator .Ten_Navigator.NavigatorTree >>> l_TnscTreeViewWithAdapterDragDrop
[code]  }
  private
  // private methods
   function NavigatorTree(const aCtx: TtfwContext;
     aen_Navigator: Ten_Navigator): TnscTreeViewWithAdapterDragDrop;
     {* Реализация слова скрипта .Ten_Navigator.NavigatorTree }
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
  end;//TkwEnNavigatorNavigatorTree

// start class TkwEnNavigatorNavigatorTree

function TkwEnNavigatorNavigatorTree.NavigatorTree(const aCtx: TtfwContext;
  aen_Navigator: Ten_Navigator): TnscTreeViewWithAdapterDragDrop;
 {-}
begin
 Result := aen_Navigator.NavigatorTree;
end;//TkwEnNavigatorNavigatorTree.NavigatorTree

procedure TkwEnNavigatorNavigatorTree.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aen_Navigator : Ten_Navigator;
begin
 try
  l_aen_Navigator := Ten_Navigator(aCtx.rEngine.PopObjAs(Ten_Navigator));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aen_Navigator: Ten_Navigator : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((NavigatorTree(aCtx, l_aen_Navigator)));
end;//TkwEnNavigatorNavigatorTree.DoDoIt

class function TkwEnNavigatorNavigatorTree.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.Ten_Navigator.NavigatorTree';
end;//TkwEnNavigatorNavigatorTree.GetWordNameForRegister

procedure TkwEnNavigatorNavigatorTree.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству NavigatorTree', aCtx);
end;//TkwEnNavigatorNavigatorTree.SetValuePrim

function TkwEnNavigatorNavigatorTree.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TnscTreeViewWithAdapterDragDrop);
end;//TkwEnNavigatorNavigatorTree.GetResultTypeInfo

function TkwEnNavigatorNavigatorTree.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEnNavigatorNavigatorTree.GetAllParamsCount

function TkwEnNavigatorNavigatorTree.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_Navigator)]);
end;//TkwEnNavigatorNavigatorTree.ParamsTypes
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_Form_Navigator
 Tkw_Form_Navigator.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_Navigator_Control_BackgroundPanel
 Tkw_Navigator_Control_BackgroundPanel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_Navigator_Control_BackgroundPanel_Push
 Tkw_Navigator_Control_BackgroundPanel_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_Navigator_Control_ContextFilter
 Tkw_Navigator_Control_ContextFilter.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_Navigator_Control_ContextFilter_Push
 Tkw_Navigator_Control_ContextFilter_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_Navigator_Control_NavigatorTree
 Tkw_Navigator_Control_NavigatorTree.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_Navigator_Control_NavigatorTree_Push
 Tkw_Navigator_Control_NavigatorTree_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация en_Navigator_BackgroundPanel
 TkwEnNavigatorBackgroundPanel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация en_Navigator_ContextFilter
 TkwEnNavigatorContextFilter.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация en_Navigator_NavigatorTree
 TkwEnNavigatorNavigatorTree.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа Navigator
 TtfwTypeRegistrator.RegisterType(TypeInfo(Ten_Navigator));
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