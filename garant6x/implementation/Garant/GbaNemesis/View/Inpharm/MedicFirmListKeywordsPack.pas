unit MedicFirmListKeywordsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Inpharm/MedicFirmListKeywordsPack.pas"
// Начат: 04.09.2009 12:57
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeywordsPack::Class>> F1 Встроенные продукты::Inpharm::View::Inpharm::Inpharm::MedicFirmListKeywordsPack
//
// Набор слов словаря для доступа к экземплярам контролов формы MedicFirmList$Form
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
  MedicFirmList_Form,
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
  Tkw_Form_MedicFirmList = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора формы MedicFirmList$Form
----
*Пример использования*:
[code]
'aControl' форма::MedicFirmList TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
  end;//Tkw_Form_MedicFirmList

// start class Tkw_Form_MedicFirmList

class function Tkw_Form_MedicFirmList.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'форма::MedicFirmList';
end;//Tkw_Form_MedicFirmList.GetWordNameForRegister

function Tkw_Form_MedicFirmList.GetString: AnsiString;
 {-}
begin
 Result := 'en_MedicFirmList';
end;//Tkw_Form_MedicFirmList.GetString

type
  Tkw_MedicFirmList_Control_BackgroundPanel = {final scriptword} class(TtfwControlString)
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
  end;//Tkw_MedicFirmList_Control_BackgroundPanel

// start class Tkw_MedicFirmList_Control_BackgroundPanel

class function Tkw_MedicFirmList_Control_BackgroundPanel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::BackgroundPanel';
end;//Tkw_MedicFirmList_Control_BackgroundPanel.GetWordNameForRegister

function Tkw_MedicFirmList_Control_BackgroundPanel.GetString: AnsiString;
 {-}
begin
 Result := 'BackgroundPanel';
end;//Tkw_MedicFirmList_Control_BackgroundPanel.GetString

class procedure Tkw_MedicFirmList_Control_BackgroundPanel.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_MedicFirmList_Control_BackgroundPanel.RegisterInEngine

type
  Tkw_MedicFirmList_Control_BackgroundPanel_Push = {final scriptword} class(TkwBynameControlPush)
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
  end;//Tkw_MedicFirmList_Control_BackgroundPanel_Push

// start class Tkw_MedicFirmList_Control_BackgroundPanel_Push

procedure Tkw_MedicFirmList_Control_BackgroundPanel_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('BackgroundPanel');
 inherited;
end;//Tkw_MedicFirmList_Control_BackgroundPanel_Push.DoDoIt

class function Tkw_MedicFirmList_Control_BackgroundPanel_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::BackgroundPanel:push';
end;//Tkw_MedicFirmList_Control_BackgroundPanel_Push.GetWordNameForRegister

type
  Tkw_MedicFirmList_Control_ContextFilter = {final scriptword} class(TtfwControlString)
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
  end;//Tkw_MedicFirmList_Control_ContextFilter

// start class Tkw_MedicFirmList_Control_ContextFilter

class function Tkw_MedicFirmList_Control_ContextFilter.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::ContextFilter';
end;//Tkw_MedicFirmList_Control_ContextFilter.GetWordNameForRegister

function Tkw_MedicFirmList_Control_ContextFilter.GetString: AnsiString;
 {-}
begin
 Result := 'ContextFilter';
end;//Tkw_MedicFirmList_Control_ContextFilter.GetString

class procedure Tkw_MedicFirmList_Control_ContextFilter.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TnscContextFilter);
end;//Tkw_MedicFirmList_Control_ContextFilter.RegisterInEngine

type
  Tkw_MedicFirmList_Control_ContextFilter_Push = {final scriptword} class(TkwBynameControlPush)
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
  end;//Tkw_MedicFirmList_Control_ContextFilter_Push

// start class Tkw_MedicFirmList_Control_ContextFilter_Push

procedure Tkw_MedicFirmList_Control_ContextFilter_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('ContextFilter');
 inherited;
end;//Tkw_MedicFirmList_Control_ContextFilter_Push.DoDoIt

class function Tkw_MedicFirmList_Control_ContextFilter_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::ContextFilter:push';
end;//Tkw_MedicFirmList_Control_ContextFilter_Push.GetWordNameForRegister

type
  Tkw_MedicFirmList_Control_ListTree = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола ListTree
----
*Пример использования*:
[code]
контрол::ListTree TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_MedicFirmList_Control_ListTree

// start class Tkw_MedicFirmList_Control_ListTree

class function Tkw_MedicFirmList_Control_ListTree.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::ListTree';
end;//Tkw_MedicFirmList_Control_ListTree.GetWordNameForRegister

function Tkw_MedicFirmList_Control_ListTree.GetString: AnsiString;
 {-}
begin
 Result := 'ListTree';
end;//Tkw_MedicFirmList_Control_ListTree.GetString

class procedure Tkw_MedicFirmList_Control_ListTree.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TnscTreeViewWithAdapterDragDrop);
end;//Tkw_MedicFirmList_Control_ListTree.RegisterInEngine

type
  Tkw_MedicFirmList_Control_ListTree_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола ListTree
----
*Пример использования*:
[code]
контрол::ListTree:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_MedicFirmList_Control_ListTree_Push

// start class Tkw_MedicFirmList_Control_ListTree_Push

procedure Tkw_MedicFirmList_Control_ListTree_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('ListTree');
 inherited;
end;//Tkw_MedicFirmList_Control_ListTree_Push.DoDoIt

class function Tkw_MedicFirmList_Control_ListTree_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::ListTree:push';
end;//Tkw_MedicFirmList_Control_ListTree_Push.GetWordNameForRegister

type
  TkwEnMedicFirmListBackgroundPanel = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .Ten_MedicFirmList.BackgroundPanel
[panel]Контрол BackgroundPanel формы Ten_MedicFirmList[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aen_MedicFirmList .Ten_MedicFirmList.BackgroundPanel >>> l_TvtPanel
[code]  }
  private
  // private methods
   function BackgroundPanel(const aCtx: TtfwContext;
     aen_MedicFirmList: Ten_MedicFirmList): TvtPanel;
     {* Реализация слова скрипта .Ten_MedicFirmList.BackgroundPanel }
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
  end;//TkwEnMedicFirmListBackgroundPanel

// start class TkwEnMedicFirmListBackgroundPanel

function TkwEnMedicFirmListBackgroundPanel.BackgroundPanel(const aCtx: TtfwContext;
  aen_MedicFirmList: Ten_MedicFirmList): TvtPanel;
 {-}
begin
 Result := aen_MedicFirmList.BackgroundPanel;
end;//TkwEnMedicFirmListBackgroundPanel.BackgroundPanel

procedure TkwEnMedicFirmListBackgroundPanel.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aen_MedicFirmList : Ten_MedicFirmList;
begin
 try
  l_aen_MedicFirmList := Ten_MedicFirmList(aCtx.rEngine.PopObjAs(Ten_MedicFirmList));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aen_MedicFirmList: Ten_MedicFirmList : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((BackgroundPanel(aCtx, l_aen_MedicFirmList)));
end;//TkwEnMedicFirmListBackgroundPanel.DoDoIt

class function TkwEnMedicFirmListBackgroundPanel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.Ten_MedicFirmList.BackgroundPanel';
end;//TkwEnMedicFirmListBackgroundPanel.GetWordNameForRegister

procedure TkwEnMedicFirmListBackgroundPanel.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству BackgroundPanel', aCtx);
end;//TkwEnMedicFirmListBackgroundPanel.SetValuePrim

function TkwEnMedicFirmListBackgroundPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtPanel);
end;//TkwEnMedicFirmListBackgroundPanel.GetResultTypeInfo

function TkwEnMedicFirmListBackgroundPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEnMedicFirmListBackgroundPanel.GetAllParamsCount

function TkwEnMedicFirmListBackgroundPanel.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_MedicFirmList)]);
end;//TkwEnMedicFirmListBackgroundPanel.ParamsTypes

type
  TkwEnMedicFirmListContextFilter = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .Ten_MedicFirmList.ContextFilter
[panel]Контрол ContextFilter формы Ten_MedicFirmList[panel]
*Тип результата:* TnscContextFilter
*Пример:*
[code]
OBJECT VAR l_TnscContextFilter
 aen_MedicFirmList .Ten_MedicFirmList.ContextFilter >>> l_TnscContextFilter
[code]  }
  private
  // private methods
   function ContextFilter(const aCtx: TtfwContext;
     aen_MedicFirmList: Ten_MedicFirmList): TnscContextFilter;
     {* Реализация слова скрипта .Ten_MedicFirmList.ContextFilter }
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
  end;//TkwEnMedicFirmListContextFilter

// start class TkwEnMedicFirmListContextFilter

function TkwEnMedicFirmListContextFilter.ContextFilter(const aCtx: TtfwContext;
  aen_MedicFirmList: Ten_MedicFirmList): TnscContextFilter;
 {-}
begin
 Result := aen_MedicFirmList.ContextFilter;
end;//TkwEnMedicFirmListContextFilter.ContextFilter

procedure TkwEnMedicFirmListContextFilter.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aen_MedicFirmList : Ten_MedicFirmList;
begin
 try
  l_aen_MedicFirmList := Ten_MedicFirmList(aCtx.rEngine.PopObjAs(Ten_MedicFirmList));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aen_MedicFirmList: Ten_MedicFirmList : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((ContextFilter(aCtx, l_aen_MedicFirmList)));
end;//TkwEnMedicFirmListContextFilter.DoDoIt

class function TkwEnMedicFirmListContextFilter.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.Ten_MedicFirmList.ContextFilter';
end;//TkwEnMedicFirmListContextFilter.GetWordNameForRegister

procedure TkwEnMedicFirmListContextFilter.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству ContextFilter', aCtx);
end;//TkwEnMedicFirmListContextFilter.SetValuePrim

function TkwEnMedicFirmListContextFilter.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TnscContextFilter);
end;//TkwEnMedicFirmListContextFilter.GetResultTypeInfo

function TkwEnMedicFirmListContextFilter.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEnMedicFirmListContextFilter.GetAllParamsCount

function TkwEnMedicFirmListContextFilter.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_MedicFirmList)]);
end;//TkwEnMedicFirmListContextFilter.ParamsTypes

type
  TkwEnMedicFirmListListTree = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .Ten_MedicFirmList.ListTree
[panel]Контрол ListTree формы Ten_MedicFirmList[panel]
*Тип результата:* TnscTreeViewWithAdapterDragDrop
*Пример:*
[code]
OBJECT VAR l_TnscTreeViewWithAdapterDragDrop
 aen_MedicFirmList .Ten_MedicFirmList.ListTree >>> l_TnscTreeViewWithAdapterDragDrop
[code]  }
  private
  // private methods
   function ListTree(const aCtx: TtfwContext;
     aen_MedicFirmList: Ten_MedicFirmList): TnscTreeViewWithAdapterDragDrop;
     {* Реализация слова скрипта .Ten_MedicFirmList.ListTree }
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
  end;//TkwEnMedicFirmListListTree

// start class TkwEnMedicFirmListListTree

function TkwEnMedicFirmListListTree.ListTree(const aCtx: TtfwContext;
  aen_MedicFirmList: Ten_MedicFirmList): TnscTreeViewWithAdapterDragDrop;
 {-}
begin
 Result := aen_MedicFirmList.ListTree;
end;//TkwEnMedicFirmListListTree.ListTree

procedure TkwEnMedicFirmListListTree.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aen_MedicFirmList : Ten_MedicFirmList;
begin
 try
  l_aen_MedicFirmList := Ten_MedicFirmList(aCtx.rEngine.PopObjAs(Ten_MedicFirmList));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aen_MedicFirmList: Ten_MedicFirmList : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((ListTree(aCtx, l_aen_MedicFirmList)));
end;//TkwEnMedicFirmListListTree.DoDoIt

class function TkwEnMedicFirmListListTree.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.Ten_MedicFirmList.ListTree';
end;//TkwEnMedicFirmListListTree.GetWordNameForRegister

procedure TkwEnMedicFirmListListTree.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству ListTree', aCtx);
end;//TkwEnMedicFirmListListTree.SetValuePrim

function TkwEnMedicFirmListListTree.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TnscTreeViewWithAdapterDragDrop);
end;//TkwEnMedicFirmListListTree.GetResultTypeInfo

function TkwEnMedicFirmListListTree.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEnMedicFirmListListTree.GetAllParamsCount

function TkwEnMedicFirmListListTree.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_MedicFirmList)]);
end;//TkwEnMedicFirmListListTree.ParamsTypes
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_Form_MedicFirmList
 Tkw_Form_MedicFirmList.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_MedicFirmList_Control_BackgroundPanel
 Tkw_MedicFirmList_Control_BackgroundPanel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_MedicFirmList_Control_BackgroundPanel_Push
 Tkw_MedicFirmList_Control_BackgroundPanel_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_MedicFirmList_Control_ContextFilter
 Tkw_MedicFirmList_Control_ContextFilter.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_MedicFirmList_Control_ContextFilter_Push
 Tkw_MedicFirmList_Control_ContextFilter_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_MedicFirmList_Control_ListTree
 Tkw_MedicFirmList_Control_ListTree.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_MedicFirmList_Control_ListTree_Push
 Tkw_MedicFirmList_Control_ListTree_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация en_MedicFirmList_BackgroundPanel
 TkwEnMedicFirmListBackgroundPanel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация en_MedicFirmList_ContextFilter
 TkwEnMedicFirmListContextFilter.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация en_MedicFirmList_ListTree
 TkwEnMedicFirmListListTree.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа MedicFirmList$Form
 TtfwTypeRegistrator.RegisterType(TypeInfo(Ten_MedicFirmList));
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