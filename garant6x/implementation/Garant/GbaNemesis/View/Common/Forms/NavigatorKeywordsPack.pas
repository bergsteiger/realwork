unit NavigatorKeywordsPack;
 {* Набор слов словаря для доступа к экземплярам контролов формы Navigator }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Common\Forms\NavigatorKeywordsPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "NavigatorKeywordsPack" MUID: (4ABBB23903D8_Pack)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3IntfUses
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3ImplUses
 , Navigator_Form
 , tfwPropertyLike
 , vtPanel
 , tfwScriptingInterfaces
 , TypInfo
 , tfwTypeInfo
 {$If Defined(Nemesis)}
 , nscContextFilter
 {$IfEnd} // Defined(Nemesis)
 , nscTreeViewWithAdapterDragDrop
 , tfwControlString
 , kwBynameControlPush
 , TtfwClassRef_Proxy
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
 //#UC START# *4ABBB23903D8_Packimpl_uses*
 //#UC END# *4ABBB23903D8_Packimpl_uses*
;

type
 TkwEnNavigatorBackgroundPanel = {final} class(TtfwPropertyLike)
  {* Слово скрипта .Ten_Navigator.BackgroundPanel }
  private
   function BackgroundPanel(const aCtx: TtfwContext;
    aen_Navigator: Ten_Navigator): TvtPanel;
    {* Реализация слова скрипта .Ten_Navigator.BackgroundPanel }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEnNavigatorBackgroundPanel

 TkwEnNavigatorContextFilter = {final} class(TtfwPropertyLike)
  {* Слово скрипта .Ten_Navigator.ContextFilter }
  private
   function ContextFilter(const aCtx: TtfwContext;
    aen_Navigator: Ten_Navigator): TnscContextFilter;
    {* Реализация слова скрипта .Ten_Navigator.ContextFilter }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEnNavigatorContextFilter

 TkwEnNavigatorNavigatorTree = {final} class(TtfwPropertyLike)
  {* Слово скрипта .Ten_Navigator.NavigatorTree }
  private
   function NavigatorTree(const aCtx: TtfwContext;
    aen_Navigator: Ten_Navigator): TnscTreeViewWithAdapterDragDrop;
    {* Реализация слова скрипта .Ten_Navigator.NavigatorTree }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEnNavigatorNavigatorTree

 Tkw_Form_Navigator = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора формы Navigator
----
*Пример использования*:
[code]форма::Navigator TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Form_Navigator

 Tkw_Navigator_Control_BackgroundPanel = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола BackgroundPanel
----
*Пример использования*:
[code]контрол::BackgroundPanel TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Navigator_Control_BackgroundPanel

 Tkw_Navigator_Control_BackgroundPanel_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола BackgroundPanel
----
*Пример использования*:
[code]контрол::BackgroundPanel:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Navigator_Control_BackgroundPanel_Push

 Tkw_Navigator_Control_ContextFilter = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола ContextFilter
----
*Пример использования*:
[code]контрол::ContextFilter TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Navigator_Control_ContextFilter

 Tkw_Navigator_Control_ContextFilter_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола ContextFilter
----
*Пример использования*:
[code]контрол::ContextFilter:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Navigator_Control_ContextFilter_Push

 Tkw_Navigator_Control_NavigatorTree = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола NavigatorTree
----
*Пример использования*:
[code]контрол::NavigatorTree TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Navigator_Control_NavigatorTree

 Tkw_Navigator_Control_NavigatorTree_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола NavigatorTree
----
*Пример использования*:
[code]контрол::NavigatorTree:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Navigator_Control_NavigatorTree_Push

function TkwEnNavigatorBackgroundPanel.BackgroundPanel(const aCtx: TtfwContext;
 aen_Navigator: Ten_Navigator): TvtPanel;
 {* Реализация слова скрипта .Ten_Navigator.BackgroundPanel }
begin
 Result := aen_Navigator.BackgroundPanel;
end;//TkwEnNavigatorBackgroundPanel.BackgroundPanel

class function TkwEnNavigatorBackgroundPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_Navigator.BackgroundPanel';
end;//TkwEnNavigatorBackgroundPanel.GetWordNameForRegister

function TkwEnNavigatorBackgroundPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwEnNavigatorBackgroundPanel.GetResultTypeInfo

function TkwEnNavigatorBackgroundPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnNavigatorBackgroundPanel.GetAllParamsCount

function TkwEnNavigatorBackgroundPanel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_Navigator)]);
end;//TkwEnNavigatorBackgroundPanel.ParamsTypes

procedure TkwEnNavigatorBackgroundPanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству BackgroundPanel', aCtx);
end;//TkwEnNavigatorBackgroundPanel.SetValuePrim

procedure TkwEnNavigatorBackgroundPanel.DoDoIt(const aCtx: TtfwContext);
var l_aen_Navigator: Ten_Navigator;
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
 aCtx.rEngine.PushObj(BackgroundPanel(aCtx, l_aen_Navigator));
end;//TkwEnNavigatorBackgroundPanel.DoDoIt

function TkwEnNavigatorContextFilter.ContextFilter(const aCtx: TtfwContext;
 aen_Navigator: Ten_Navigator): TnscContextFilter;
 {* Реализация слова скрипта .Ten_Navigator.ContextFilter }
begin
 Result := aen_Navigator.ContextFilter;
end;//TkwEnNavigatorContextFilter.ContextFilter

class function TkwEnNavigatorContextFilter.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_Navigator.ContextFilter';
end;//TkwEnNavigatorContextFilter.GetWordNameForRegister

function TkwEnNavigatorContextFilter.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscContextFilter);
end;//TkwEnNavigatorContextFilter.GetResultTypeInfo

function TkwEnNavigatorContextFilter.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnNavigatorContextFilter.GetAllParamsCount

function TkwEnNavigatorContextFilter.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_Navigator)]);
end;//TkwEnNavigatorContextFilter.ParamsTypes

procedure TkwEnNavigatorContextFilter.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству ContextFilter', aCtx);
end;//TkwEnNavigatorContextFilter.SetValuePrim

procedure TkwEnNavigatorContextFilter.DoDoIt(const aCtx: TtfwContext);
var l_aen_Navigator: Ten_Navigator;
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
 aCtx.rEngine.PushObj(ContextFilter(aCtx, l_aen_Navigator));
end;//TkwEnNavigatorContextFilter.DoDoIt

function TkwEnNavigatorNavigatorTree.NavigatorTree(const aCtx: TtfwContext;
 aen_Navigator: Ten_Navigator): TnscTreeViewWithAdapterDragDrop;
 {* Реализация слова скрипта .Ten_Navigator.NavigatorTree }
begin
 Result := aen_Navigator.NavigatorTree;
end;//TkwEnNavigatorNavigatorTree.NavigatorTree

class function TkwEnNavigatorNavigatorTree.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_Navigator.NavigatorTree';
end;//TkwEnNavigatorNavigatorTree.GetWordNameForRegister

function TkwEnNavigatorNavigatorTree.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscTreeViewWithAdapterDragDrop);
end;//TkwEnNavigatorNavigatorTree.GetResultTypeInfo

function TkwEnNavigatorNavigatorTree.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnNavigatorNavigatorTree.GetAllParamsCount

function TkwEnNavigatorNavigatorTree.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_Navigator)]);
end;//TkwEnNavigatorNavigatorTree.ParamsTypes

procedure TkwEnNavigatorNavigatorTree.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству NavigatorTree', aCtx);
end;//TkwEnNavigatorNavigatorTree.SetValuePrim

procedure TkwEnNavigatorNavigatorTree.DoDoIt(const aCtx: TtfwContext);
var l_aen_Navigator: Ten_Navigator;
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
 aCtx.rEngine.PushObj(NavigatorTree(aCtx, l_aen_Navigator));
end;//TkwEnNavigatorNavigatorTree.DoDoIt

function Tkw_Form_Navigator.GetString: AnsiString;
begin
 Result := 'en_Navigator';
end;//Tkw_Form_Navigator.GetString

class procedure Tkw_Form_Navigator.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(Ten_Navigator);
end;//Tkw_Form_Navigator.RegisterInEngine

class function Tkw_Form_Navigator.GetWordNameForRegister: AnsiString;
begin
 Result := 'форма::Navigator';
end;//Tkw_Form_Navigator.GetWordNameForRegister

function Tkw_Navigator_Control_BackgroundPanel.GetString: AnsiString;
begin
 Result := 'BackgroundPanel';
end;//Tkw_Navigator_Control_BackgroundPanel.GetString

class procedure Tkw_Navigator_Control_BackgroundPanel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_Navigator_Control_BackgroundPanel.RegisterInEngine

class function Tkw_Navigator_Control_BackgroundPanel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::BackgroundPanel';
end;//Tkw_Navigator_Control_BackgroundPanel.GetWordNameForRegister

procedure Tkw_Navigator_Control_BackgroundPanel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('BackgroundPanel');
 inherited;
end;//Tkw_Navigator_Control_BackgroundPanel_Push.DoDoIt

class function Tkw_Navigator_Control_BackgroundPanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::BackgroundPanel:push';
end;//Tkw_Navigator_Control_BackgroundPanel_Push.GetWordNameForRegister

function Tkw_Navigator_Control_ContextFilter.GetString: AnsiString;
begin
 Result := 'ContextFilter';
end;//Tkw_Navigator_Control_ContextFilter.GetString

class procedure Tkw_Navigator_Control_ContextFilter.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscContextFilter);
end;//Tkw_Navigator_Control_ContextFilter.RegisterInEngine

class function Tkw_Navigator_Control_ContextFilter.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ContextFilter';
end;//Tkw_Navigator_Control_ContextFilter.GetWordNameForRegister

procedure Tkw_Navigator_Control_ContextFilter_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('ContextFilter');
 inherited;
end;//Tkw_Navigator_Control_ContextFilter_Push.DoDoIt

class function Tkw_Navigator_Control_ContextFilter_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ContextFilter:push';
end;//Tkw_Navigator_Control_ContextFilter_Push.GetWordNameForRegister

function Tkw_Navigator_Control_NavigatorTree.GetString: AnsiString;
begin
 Result := 'NavigatorTree';
end;//Tkw_Navigator_Control_NavigatorTree.GetString

class procedure Tkw_Navigator_Control_NavigatorTree.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscTreeViewWithAdapterDragDrop);
end;//Tkw_Navigator_Control_NavigatorTree.RegisterInEngine

class function Tkw_Navigator_Control_NavigatorTree.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::NavigatorTree';
end;//Tkw_Navigator_Control_NavigatorTree.GetWordNameForRegister

procedure Tkw_Navigator_Control_NavigatorTree_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('NavigatorTree');
 inherited;
end;//Tkw_Navigator_Control_NavigatorTree_Push.DoDoIt

class function Tkw_Navigator_Control_NavigatorTree_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::NavigatorTree:push';
end;//Tkw_Navigator_Control_NavigatorTree_Push.GetWordNameForRegister

initialization
 TkwEnNavigatorBackgroundPanel.RegisterInEngine;
 {* Регистрация en_Navigator_BackgroundPanel }
 TkwEnNavigatorContextFilter.RegisterInEngine;
 {* Регистрация en_Navigator_ContextFilter }
 TkwEnNavigatorNavigatorTree.RegisterInEngine;
 {* Регистрация en_Navigator_NavigatorTree }
 Tkw_Form_Navigator.RegisterInEngine;
 {* Регистрация Tkw_Form_Navigator }
 Tkw_Navigator_Control_BackgroundPanel.RegisterInEngine;
 {* Регистрация Tkw_Navigator_Control_BackgroundPanel }
 Tkw_Navigator_Control_BackgroundPanel_Push.RegisterInEngine;
 {* Регистрация Tkw_Navigator_Control_BackgroundPanel_Push }
 Tkw_Navigator_Control_ContextFilter.RegisterInEngine;
 {* Регистрация Tkw_Navigator_Control_ContextFilter }
 Tkw_Navigator_Control_ContextFilter_Push.RegisterInEngine;
 {* Регистрация Tkw_Navigator_Control_ContextFilter_Push }
 Tkw_Navigator_Control_NavigatorTree.RegisterInEngine;
 {* Регистрация Tkw_Navigator_Control_NavigatorTree }
 Tkw_Navigator_Control_NavigatorTree_Push.RegisterInEngine;
 {* Регистрация Tkw_Navigator_Control_NavigatorTree_Push }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Ten_Navigator));
 {* Регистрация типа Ten_Navigator }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
 {* Регистрация типа TvtPanel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscContextFilter));
 {* Регистрация типа TnscContextFilter }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscTreeViewWithAdapterDragDrop));
 {* Регистрация типа TnscTreeViewWithAdapterDragDrop }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)

end.
