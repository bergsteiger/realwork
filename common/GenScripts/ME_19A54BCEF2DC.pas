unit FiltersKeywordsPack;
 {* Набор слов словаря для доступа к экземплярам контролов формы Filters }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Filters\FiltersKeywordsPack.pas"
// Стереотип: "ScriptKeywordsPack"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , Filters_Module
 , nscTreeViewWithAdapterDragDrop
 , tfwControlString
 {$If NOT Defined(NoVCL)}
 , kwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 , tfwScriptingInterfaces
 , tfwPropertyLike
 , tfwTypeInfo
 , TypInfo
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , TtfwClassRef_Proxy
 , SysUtils
;

type
 Tkw_Form_Filters = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора формы Filters
----
*Пример использования*:
[code]
'aControl' форма::Filters TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_Filters

 Tkw_Filters_Control_FiltersList = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола FiltersList
----
*Пример использования*:
[code]
контрол::FiltersList TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_Filters_Control_FiltersList

 Tkw_Filters_Control_FiltersList_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола FiltersList
----
*Пример использования*:
[code]
контрол::FiltersList:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Filters_Control_FiltersList_Push

 TkwEnFiltersFiltersList = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TenFilters.FiltersList
[panel]Контрол FiltersList формы TenFilters[panel]
*Тип результата:* TnscTreeViewWithAdapterDragDrop
*Пример:*
[code]
OBJECT VAR l_TnscTreeViewWithAdapterDragDrop
 aenFilters .TenFilters.FiltersList >>> l_TnscTreeViewWithAdapterDragDrop
[code]  }
  private
   function FiltersList(const aCtx: TtfwContext;
    aenFilters: TenFilters): TnscTreeViewWithAdapterDragDrop;
    {* Реализация слова скрипта .TenFilters.FiltersList }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnFiltersFiltersList

class function Tkw_Form_Filters.GetWordNameForRegister: AnsiString;
begin
 Result := 'форма::Filters';
end;//Tkw_Form_Filters.GetWordNameForRegister

function Tkw_Form_Filters.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_D5CE8D7E34D4_var*
//#UC END# *4DDFD2EA0116_D5CE8D7E34D4_var*
begin
//#UC START# *4DDFD2EA0116_D5CE8D7E34D4_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_D5CE8D7E34D4_impl*
end;//Tkw_Form_Filters.GetString

class function Tkw_Filters_Control_FiltersList.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::FiltersList';
end;//Tkw_Filters_Control_FiltersList.GetWordNameForRegister

function Tkw_Filters_Control_FiltersList.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_B20CBB26D548_var*
//#UC END# *4DDFD2EA0116_B20CBB26D548_var*
begin
//#UC START# *4DDFD2EA0116_B20CBB26D548_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_B20CBB26D548_impl*
end;//Tkw_Filters_Control_FiltersList.GetString

class procedure Tkw_Filters_Control_FiltersList.RegisterInEngine;
//#UC START# *52A086150180_B20CBB26D548_var*
//#UC END# *52A086150180_B20CBB26D548_var*
begin
//#UC START# *52A086150180_B20CBB26D548_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_B20CBB26D548_impl*
end;//Tkw_Filters_Control_FiltersList.RegisterInEngine

procedure Tkw_Filters_Control_FiltersList_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_922109FC93A4_var*
//#UC END# *4DAEEDE10285_922109FC93A4_var*
begin
//#UC START# *4DAEEDE10285_922109FC93A4_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_922109FC93A4_impl*
end;//Tkw_Filters_Control_FiltersList_Push.DoDoIt

class function Tkw_Filters_Control_FiltersList_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::FiltersList:push';
end;//Tkw_Filters_Control_FiltersList_Push.GetWordNameForRegister

function TkwEnFiltersFiltersList.FiltersList(const aCtx: TtfwContext;
 aenFilters: TenFilters): TnscTreeViewWithAdapterDragDrop;
 {* Реализация слова скрипта .TenFilters.FiltersList }
//#UC START# *C66656F0D57B_F040B0369BA3_var*
//#UC END# *C66656F0D57B_F040B0369BA3_var*
begin
//#UC START# *C66656F0D57B_F040B0369BA3_impl*
 !!! Needs to be implemented !!!
//#UC END# *C66656F0D57B_F040B0369BA3_impl*
end;//TkwEnFiltersFiltersList.FiltersList

procedure TkwEnFiltersFiltersList.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_F040B0369BA3_var*
//#UC END# *4DAEEDE10285_F040B0369BA3_var*
begin
//#UC START# *4DAEEDE10285_F040B0369BA3_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_F040B0369BA3_impl*
end;//TkwEnFiltersFiltersList.DoDoIt

class function TkwEnFiltersFiltersList.GetWordNameForRegister: AnsiString;
begin
 Result := '.TenFilters.FiltersList';
end;//TkwEnFiltersFiltersList.GetWordNameForRegister

procedure TkwEnFiltersFiltersList.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству ', aCtx);
end;//TkwEnFiltersFiltersList.SetValuePrim

function TkwEnFiltersFiltersList.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscTreeViewWithAdapterDragDrop);
end;//TkwEnFiltersFiltersList.GetResultTypeInfo

function TkwEnFiltersFiltersList.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnFiltersFiltersList.GetAllParamsCount

function TkwEnFiltersFiltersList.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwEnFiltersFiltersList.ParamsTypes

initialization
 Tkw_Form_Filters.RegisterInEngine;
 {* Регистрация Tkw_Form_Filters }
 Tkw_Filters_Control_FiltersList.RegisterInEngine;
 {* Регистрация Tkw_Filters_Control_FiltersList }
 Tkw_Filters_Control_FiltersList_Push.RegisterInEngine;
 {* Регистрация Tkw_Filters_Control_FiltersList_Push }
 TkwEnFiltersFiltersList.RegisterInEngine;
 {* Регистрация enFilters_FiltersList }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TenFilters));
 {* Регистрация типа Filters }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscTreeViewWithAdapterDragDrop));
 {* Регистрация типа TnscTreeViewWithAdapterDragDrop }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

end.
