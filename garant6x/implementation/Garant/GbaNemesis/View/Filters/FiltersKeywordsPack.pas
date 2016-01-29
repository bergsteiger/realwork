unit FiltersKeywordsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Filters/FiltersKeywordsPack.pas"
// Начат: 29.10.2010 15:00
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeywordsPack::Class>> F1 Основные прецеденты::Filters::View::Filters::Filters$FP::FiltersKeywordsPack
//
// Набор слов словаря для доступа к экземплярам контролов формы Filters
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
  Filters_Form,
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
  Tkw_Form_Filters = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора формы Filters
----
*Пример использования*:
[code]
'aControl' форма::Filters TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
  end;//Tkw_Form_Filters

// start class Tkw_Form_Filters

class function Tkw_Form_Filters.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'форма::Filters';
end;//Tkw_Form_Filters.GetWordNameForRegister

function Tkw_Form_Filters.GetString: AnsiString;
 {-}
begin
 Result := 'enFilters';
end;//Tkw_Form_Filters.GetString

type
  Tkw_Filters_Control_FiltersList = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола FiltersList
----
*Пример использования*:
[code]
контрол::FiltersList TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_Filters_Control_FiltersList

// start class Tkw_Filters_Control_FiltersList

class function Tkw_Filters_Control_FiltersList.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::FiltersList';
end;//Tkw_Filters_Control_FiltersList.GetWordNameForRegister

function Tkw_Filters_Control_FiltersList.GetString: AnsiString;
 {-}
begin
 Result := 'FiltersList';
end;//Tkw_Filters_Control_FiltersList.GetString

class procedure Tkw_Filters_Control_FiltersList.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TnscTreeViewWithAdapterDragDrop);
end;//Tkw_Filters_Control_FiltersList.RegisterInEngine

type
  Tkw_Filters_Control_FiltersList_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола FiltersList
----
*Пример использования*:
[code]
контрол::FiltersList:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_Filters_Control_FiltersList_Push

// start class Tkw_Filters_Control_FiltersList_Push

procedure Tkw_Filters_Control_FiltersList_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('FiltersList');
 inherited;
end;//Tkw_Filters_Control_FiltersList_Push.DoDoIt

class function Tkw_Filters_Control_FiltersList_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::FiltersList:push';
end;//Tkw_Filters_Control_FiltersList_Push.GetWordNameForRegister

type
  TkwEnFiltersFiltersList = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TenFilters.FiltersList
[panel]Контрол FiltersList формы TenFilters[panel]
*Тип результата:* TnscTreeViewWithAdapterDragDrop
*Пример:*
[code]
OBJECT VAR l_TnscTreeViewWithAdapterDragDrop
 aenFilters .TenFilters.FiltersList >>> l_TnscTreeViewWithAdapterDragDrop
[code]  }
  private
  // private methods
   function FiltersList(const aCtx: TtfwContext;
     aenFilters: TenFilters): TnscTreeViewWithAdapterDragDrop;
     {* Реализация слова скрипта .TenFilters.FiltersList }
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
  end;//TkwEnFiltersFiltersList

// start class TkwEnFiltersFiltersList

function TkwEnFiltersFiltersList.FiltersList(const aCtx: TtfwContext;
  aenFilters: TenFilters): TnscTreeViewWithAdapterDragDrop;
 {-}
begin
 Result := aenFilters.FiltersList;
end;//TkwEnFiltersFiltersList.FiltersList

procedure TkwEnFiltersFiltersList.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aenFilters : TenFilters;
begin
 try
  l_aenFilters := TenFilters(aCtx.rEngine.PopObjAs(TenFilters));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aenFilters: TenFilters : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((FiltersList(aCtx, l_aenFilters)));
end;//TkwEnFiltersFiltersList.DoDoIt

class function TkwEnFiltersFiltersList.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TenFilters.FiltersList';
end;//TkwEnFiltersFiltersList.GetWordNameForRegister

procedure TkwEnFiltersFiltersList.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству FiltersList', aCtx);
end;//TkwEnFiltersFiltersList.SetValuePrim

function TkwEnFiltersFiltersList.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TnscTreeViewWithAdapterDragDrop);
end;//TkwEnFiltersFiltersList.GetResultTypeInfo

function TkwEnFiltersFiltersList.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEnFiltersFiltersList.GetAllParamsCount

function TkwEnFiltersFiltersList.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TenFilters)]);
end;//TkwEnFiltersFiltersList.ParamsTypes
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_Form_Filters
 Tkw_Form_Filters.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_Filters_Control_FiltersList
 Tkw_Filters_Control_FiltersList.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_Filters_Control_FiltersList_Push
 Tkw_Filters_Control_FiltersList_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация enFilters_FiltersList
 TkwEnFiltersFiltersList.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа Filters
 TtfwTypeRegistrator.RegisterType(TypeInfo(TenFilters));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TnscTreeViewWithAdapterDragDrop
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscTreeViewWithAdapterDragDrop));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.