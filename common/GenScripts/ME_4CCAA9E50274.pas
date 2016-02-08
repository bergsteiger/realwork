unit Filters_Module;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Filters\Filters_Module.pas"
// Стереотип: "VCMFormsPack"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , SimpleListInterfaces
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , Classes
 , SearchUnit
 , FiltersUnit
 , PrimFiltersOptions_Form
 , Common_FormDefinitions_Controls
 , PrimCreateFilter_Form
;

type
 TenFilters = {final} class(TPrimFiltersOptionsForm, FiltersFormDef)
  {* Фильтры }
 end;//TenFilters

 TCreateFilterForm = {final} class(TPrimCreateFilterForm)
 end;//TCreateFilterForm

 TFiltersModule = class
  public
   procedure FiltersOpen(const aData: IucpFilters);
   procedure OldSchoolFiltersOpen(const anAggregate: IvcmAggregate;
    const aContainer: IvcmContainer;
    anOwner: TComponent);
   function CreateFilter(const aQuery: IQuery): Integer;
   procedure RenameFilter(const aFilter: IFilterFromQuery);
 end;//TFiltersModule
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , Search_Strange_Controls
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , FiltersKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , CreateFilterKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
 , DataAdapter
 , PrimCreateFilter_cfRename_UserType
 , PrimCreateFilter_cfCreate_UserType
 , dsCreateFilter
 , deFilter
;

procedure TFiltersModule.FiltersOpen(const aData: IucpFilters);
//#UC START# *4AC09F1D0356_4CCAA9E50274_var*
//#UC END# *4AC09F1D0356_4CCAA9E50274_var*
begin
//#UC START# *4AC09F1D0356_4CCAA9E50274_impl*
 Assert(aData <> nil);
 if not defDataAdapter.AdministratorLogin then
  aData.Open;
//#UC END# *4AC09F1D0356_4CCAA9E50274_impl*
end;//TFiltersModule.FiltersOpen

procedure TFiltersModule.OldSchoolFiltersOpen(const anAggregate: IvcmAggregate;
 const aContainer: IvcmContainer;
 anOwner: TComponent);
var l_Filters: IvcmEntityForm;
//#UC START# *4AC09F4F011A_4CCAA9E50274_var*
//#UC END# *4AC09F4F011A_4CCAA9E50274_var*
begin
//#UC START# *4AC09F4F011A_4CCAA9E50274_impl*
 if not defDataAdapter.AdministratorLogin then
 begin
  l_Filters := TenFilters.MakeSingleChild(CheckContainer(aContainer).NativeMainForm,
                   vcmMakeParams(anAggregate, CheckContainer(aContainer), anOwner),
                   vcm_ztNavigator);
  l_Filters.SetActiveInParent;
  op_List_SetNewContent.Call(l_Filters);
 end;//not defDataAdapter.AdministratorLogin
//#UC END# *4AC09F4F011A_4CCAA9E50274_impl*
end;//TFiltersModule.OldSchoolFiltersOpen

function TFiltersModule.CreateFilter(const aQuery: IQuery): Integer;
//#UC START# *4CB6AFA801C1_4CCAA9E50274_var*
 l_Form : IvcmEntityForm;
//#UC END# *4CB6AFA801C1_4CCAA9E50274_var*
begin
//#UC START# *4CB6AFA801C1_4CCAA9E50274_impl*
 l_Form := TCreateFilterForm.Make(TdsCreateFilter.Make(nil, TdeFilter.Make(aQuery)),
                                  vcmCheckAggregate(vcmMakeParams(nil, CheckContainer(nil))),
                                  vcm_ztManualModal,
                                  Ord(cfCreate));

 try
  Result := l_Form.ShowModal;
 finally
  l_Form := nil;
 end;
//#UC END# *4CB6AFA801C1_4CCAA9E50274_impl*
end;//TFiltersModule.CreateFilter

procedure TFiltersModule.RenameFilter(const aFilter: IFilterFromQuery);
//#UC START# *4CB6AFEE024B_4CCAA9E50274_var*
 l_Form : IvcmEntityForm;
//#UC END# *4CB6AFEE024B_4CCAA9E50274_var*
begin
//#UC START# *4CB6AFEE024B_4CCAA9E50274_impl*
 l_Form := TCreateFilterForm.Make(TdsCreateFilter.Make(nil, TdeFilter.Make(aFilter)),
                                  vcmCheckAggregate(vcmMakeParams(nil, CheckContainer(nil))),
                                  vcm_ztManualModal,
                                  Ord(cfRename));
 try
  l_Form.ShowModal;
 finally
  l_Form := nil;
 end;
//#UC END# *4CB6AFEE024B_4CCAA9E50274_impl*
end;//TFiltersModule.RenameFilter

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TenFilters);
 {* Регистрация Filters }
{$IfEnd} // NOT Defined(NoScripts)
 fm_enFilters.SetFactory(TenFilters.Make);
 {* Регистрация фабрики формы Filters }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TCreateFilterForm);
 {* Регистрация CreateFilter$Form }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
