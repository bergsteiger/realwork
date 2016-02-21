unit NavigatorKeywordsPack;
 {* Набор слов словаря для доступа к экземплярам контролов формы Navigator }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Common\NavigatorKeywordsPack.pas"
// Стереотип: "ScriptKeywordsPack"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , PrimF1Common_Module
 , vtPanel
 {$If Defined(Nemesis)}
 , nscContextFilter
 {$IfEnd} // Defined(Nemesis)
 , nscTreeViewWithAdapterDragDrop
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwControlString
 {$If NOT Defined(NoVCL)}
 , kwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 , tfwScriptingInterfaces
 , tfwPropertyLike
 , tfwTypeInfo
 , TypInfo
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , TtfwClassRef_Proxy
 , SysUtils
;

type
 Tkw_Form_Navigator = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора формы Navigator
----
*Пример использования*:
[code]
'aControl' форма::Navigator TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_Navigator

 Tkw_Navigator_Control_BackgroundPanel = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола BackgroundPanel
----
*Пример использования*:
[code]
контрол::BackgroundPanel TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_Navigator_Control_BackgroundPanel

 Tkw_Navigator_Control_BackgroundPanel_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола BackgroundPanel
----
*Пример использования*:
[code]
контрол::BackgroundPanel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Navigator_Control_BackgroundPanel_Push

 Tkw_Navigator_Control_ContextFilter = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола ContextFilter
----
*Пример использования*:
[code]
контрол::ContextFilter TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_Navigator_Control_ContextFilter

 Tkw_Navigator_Control_ContextFilter_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола ContextFilter
----
*Пример использования*:
[code]
контрол::ContextFilter:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Navigator_Control_ContextFilter_Push

 Tkw_Navigator_Control_NavigatorTree = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола NavigatorTree
----
*Пример использования*:
[code]
контрол::NavigatorTree TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_Navigator_Control_NavigatorTree

 Tkw_Navigator_Control_NavigatorTree_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола NavigatorTree
----
*Пример использования*:
[code]
контрол::NavigatorTree:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Navigator_Control_NavigatorTree_Push

 TkwEnNavigatorBackgroundPanel = {final} class(TtfwPropertyLike)
  {* Слово скрипта .Ten_Navigator.BackgroundPanel
[panel]Контрол BackgroundPanel формы Ten_Navigator[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aen_Navigator .Ten_Navigator.BackgroundPanel >>> l_TvtPanel
[code]  }
  private
   function BackgroundPanel(const aCtx: TtfwContext;
    aen_Navigator: Ten_Navigator): TvtPanel;
    {* Реализация слова скрипта .Ten_Navigator.BackgroundPanel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnNavigatorBackgroundPanel

 TkwEnNavigatorContextFilter = {final} class(TtfwPropertyLike)
  {* Слово скрипта .Ten_Navigator.ContextFilter
[panel]Контрол ContextFilter формы Ten_Navigator[panel]
*Тип результата:* TnscContextFilter
*Пример:*
[code]
OBJECT VAR l_TnscContextFilter
 aen_Navigator .Ten_Navigator.ContextFilter >>> l_TnscContextFilter
[code]  }
  private
   function ContextFilter(const aCtx: TtfwContext;
    aen_Navigator: Ten_Navigator): TnscContextFilter;
    {* Реализация слова скрипта .Ten_Navigator.ContextFilter }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnNavigatorContextFilter

 TkwEnNavigatorNavigatorTree = {final} class(TtfwPropertyLike)
  {* Слово скрипта .Ten_Navigator.NavigatorTree
[panel]Контрол NavigatorTree формы Ten_Navigator[panel]
*Тип результата:* TnscTreeViewWithAdapterDragDrop
*Пример:*
[code]
OBJECT VAR l_TnscTreeViewWithAdapterDragDrop
 aen_Navigator .Ten_Navigator.NavigatorTree >>> l_TnscTreeViewWithAdapterDragDrop
[code]  }
  private
   function NavigatorTree(const aCtx: TtfwContext;
    aen_Navigator: Ten_Navigator): TnscTreeViewWithAdapterDragDrop;
    {* Реализация слова скрипта .Ten_Navigator.NavigatorTree }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnNavigatorNavigatorTree

class function Tkw_Form_Navigator.GetWordNameForRegister: AnsiString;
begin
 Result := 'форма::Navigator';
end;//Tkw_Form_Navigator.GetWordNameForRegister

function Tkw_Form_Navigator.GetString: AnsiString;
begin
 Result := 'en_Navigator';
end;//Tkw_Form_Navigator.GetString

class function Tkw_Navigator_Control_BackgroundPanel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::BackgroundPanel';
end;//Tkw_Navigator_Control_BackgroundPanel.GetWordNameForRegister

function Tkw_Navigator_Control_BackgroundPanel.GetString: AnsiString;
begin
 Result := 'BackgroundPanel';
end;//Tkw_Navigator_Control_BackgroundPanel.GetString

class procedure Tkw_Navigator_Control_BackgroundPanel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_Navigator_Control_BackgroundPanel.RegisterInEngine

procedure Tkw_Navigator_Control_BackgroundPanel_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_8A1290B1FFAB_var*
//#UC END# *4DAEEDE10285_8A1290B1FFAB_var*
begin
//#UC START# *4DAEEDE10285_8A1290B1FFAB_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_8A1290B1FFAB_impl*
end;//Tkw_Navigator_Control_BackgroundPanel_Push.DoDoIt

class function Tkw_Navigator_Control_BackgroundPanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::BackgroundPanel:push';
end;//Tkw_Navigator_Control_BackgroundPanel_Push.GetWordNameForRegister

class function Tkw_Navigator_Control_ContextFilter.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ContextFilter';
end;//Tkw_Navigator_Control_ContextFilter.GetWordNameForRegister

function Tkw_Navigator_Control_ContextFilter.GetString: AnsiString;
begin
 Result := 'ContextFilter';
end;//Tkw_Navigator_Control_ContextFilter.GetString

class procedure Tkw_Navigator_Control_ContextFilter.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscContextFilter);
end;//Tkw_Navigator_Control_ContextFilter.RegisterInEngine

procedure Tkw_Navigator_Control_ContextFilter_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_B6A378A35041_var*
//#UC END# *4DAEEDE10285_B6A378A35041_var*
begin
//#UC START# *4DAEEDE10285_B6A378A35041_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_B6A378A35041_impl*
end;//Tkw_Navigator_Control_ContextFilter_Push.DoDoIt

class function Tkw_Navigator_Control_ContextFilter_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ContextFilter:push';
end;//Tkw_Navigator_Control_ContextFilter_Push.GetWordNameForRegister

class function Tkw_Navigator_Control_NavigatorTree.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::NavigatorTree';
end;//Tkw_Navigator_Control_NavigatorTree.GetWordNameForRegister

function Tkw_Navigator_Control_NavigatorTree.GetString: AnsiString;
begin
 Result := 'NavigatorTree';
end;//Tkw_Navigator_Control_NavigatorTree.GetString

class procedure Tkw_Navigator_Control_NavigatorTree.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscTreeViewWithAdapterDragDrop);
end;//Tkw_Navigator_Control_NavigatorTree.RegisterInEngine

procedure Tkw_Navigator_Control_NavigatorTree_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_86F03C36DFB4_var*
//#UC END# *4DAEEDE10285_86F03C36DFB4_var*
begin
//#UC START# *4DAEEDE10285_86F03C36DFB4_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_86F03C36DFB4_impl*
end;//Tkw_Navigator_Control_NavigatorTree_Push.DoDoIt

class function Tkw_Navigator_Control_NavigatorTree_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::NavigatorTree:push';
end;//Tkw_Navigator_Control_NavigatorTree_Push.GetWordNameForRegister

function TkwEnNavigatorBackgroundPanel.BackgroundPanel(const aCtx: TtfwContext;
 aen_Navigator: Ten_Navigator): TvtPanel;
 {* Реализация слова скрипта .Ten_Navigator.BackgroundPanel }
begin
 Result := aen_Navigator.BackgroundPanel;
end;//TkwEnNavigatorBackgroundPanel.BackgroundPanel

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

class function TkwEnNavigatorBackgroundPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_Navigator.BackgroundPanel';
end;//TkwEnNavigatorBackgroundPanel.GetWordNameForRegister

procedure TkwEnNavigatorBackgroundPanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству BackgroundPanel', aCtx);
end;//TkwEnNavigatorBackgroundPanel.SetValuePrim

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

function TkwEnNavigatorContextFilter.ContextFilter(const aCtx: TtfwContext;
 aen_Navigator: Ten_Navigator): TnscContextFilter;
 {* Реализация слова скрипта .Ten_Navigator.ContextFilter }
begin
 Result := aen_Navigator.ContextFilter;
end;//TkwEnNavigatorContextFilter.ContextFilter

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

class function TkwEnNavigatorContextFilter.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_Navigator.ContextFilter';
end;//TkwEnNavigatorContextFilter.GetWordNameForRegister

procedure TkwEnNavigatorContextFilter.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству ContextFilter', aCtx);
end;//TkwEnNavigatorContextFilter.SetValuePrim

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

function TkwEnNavigatorNavigatorTree.NavigatorTree(const aCtx: TtfwContext;
 aen_Navigator: Ten_Navigator): TnscTreeViewWithAdapterDragDrop;
 {* Реализация слова скрипта .Ten_Navigator.NavigatorTree }
begin
 Result := aen_Navigator.NavigatorTree;
end;//TkwEnNavigatorNavigatorTree.NavigatorTree

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

class function TkwEnNavigatorNavigatorTree.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_Navigator.NavigatorTree';
end;//TkwEnNavigatorNavigatorTree.GetWordNameForRegister

procedure TkwEnNavigatorNavigatorTree.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству NavigatorTree', aCtx);
end;//TkwEnNavigatorNavigatorTree.SetValuePrim

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

initialization
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
 TkwEnNavigatorBackgroundPanel.RegisterInEngine;
 {* Регистрация en_Navigator_BackgroundPanel }
 TkwEnNavigatorContextFilter.RegisterInEngine;
 {* Регистрация en_Navigator_ContextFilter }
 TkwEnNavigatorNavigatorTree.RegisterInEngine;
 {* Регистрация en_Navigator_NavigatorTree }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Ten_Navigator));
 {* Регистрация типа Navigator }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
 {* Регистрация типа TvtPanel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscContextFilter));
 {* Регистрация типа TnscContextFilter }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscTreeViewWithAdapterDragDrop));
 {* Регистрация типа TnscTreeViewWithAdapterDragDrop }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

end.
