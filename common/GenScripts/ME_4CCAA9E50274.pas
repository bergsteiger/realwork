unit Filters_Module;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Filters\Filters_Module.pas"
// Стереотип: "VCMFormsPack"
// Элемент модели: "Filters" MUID: (4CCAA9E50274)
// Имя типа: "TFiltersModule"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

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
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmModule
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TFiltersModule = class({$If NOT Defined(NoVCM)}
 TvcmModule
 {$IfEnd} // NOT Defined(NoVCM)
 )
  protected
   {$If NOT Defined(NoVCM)}
   class procedure GetEntityForms(aList: TvcmClassList); override;
   {$IfEnd} // NOT Defined(NoVCM)
  public
   class procedure FiltersOpen(const aData: IucpFilters);
   class procedure OldSchoolFiltersOpen(const anAggregate: IvcmAggregate;
    const aContainer: IvcmContainer;
    anOwner: TComponent);
   class function CreateFilter(const aQuery: IQuery): Integer;
   class procedure RenameFilter(const aFilter: IFilterFromQuery);
 end;//TFiltersModule
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , Search_Strange_Controls
 , DataAdapter
 , PrimCreateFilter_cfRename_UserType
 , PrimCreateFilter_cfCreate_UserType
 , dsCreateFilter
 , deFilter
 , Filters_Form
 , CreateFilter_Form
 , Common_FormDefinitions_Controls
 //#UC START# *4CCAA9E50274impl_uses*
 //#UC END# *4CCAA9E50274impl_uses*
;

{$If NOT Defined(NoVCM)}
class procedure TFiltersModule.FiltersOpen(const aData: IucpFilters);
var
 __WasEnter : Boolean;
//#UC START# *4AC09F1D0356_4CCAA9E50274_var*
//#UC END# *4AC09F1D0356_4CCAA9E50274_var*
begin
 __WasEnter := vcmEnterFactory;
 try
//#UC START# *4AC09F1D0356_4CCAA9E50274_impl*
 Assert(aData <> nil);
 if not defDataAdapter.AdministratorLogin then
  aData.Open;
//#UC END# *4AC09F1D0356_4CCAA9E50274_impl*
 finally
  if __WasEnter then
   vcmLeaveFactory;
 end;//try..finally
end;//TFiltersModule.FiltersOpen

class procedure TFiltersModule.OldSchoolFiltersOpen(const anAggregate: IvcmAggregate;
 const aContainer: IvcmContainer;
 anOwner: TComponent);
var l_Filters: IvcmEntityForm;
var
 __WasEnter : Boolean;
//#UC START# *4AC09F4F011A_4CCAA9E50274_var*
//#UC END# *4AC09F4F011A_4CCAA9E50274_var*
begin
 __WasEnter := vcmEnterFactory;
 try
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
 finally
  if __WasEnter then
   vcmLeaveFactory;
 end;//try..finally
end;//TFiltersModule.OldSchoolFiltersOpen

class function TFiltersModule.CreateFilter(const aQuery: IQuery): Integer;
var
 __WasEnter : Boolean;
//#UC START# *4CB6AFA801C1_4CCAA9E50274_var*
 l_Form : IvcmEntityForm;
//#UC END# *4CB6AFA801C1_4CCAA9E50274_var*
begin
 __WasEnter := vcmEnterFactory;
 try
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
 finally
  if __WasEnter then
   vcmLeaveFactory;
 end;//try..finally
end;//TFiltersModule.CreateFilter

class procedure TFiltersModule.RenameFilter(const aFilter: IFilterFromQuery);
var
 __WasEnter : Boolean;
//#UC START# *4CB6AFEE024B_4CCAA9E50274_var*
 l_Form : IvcmEntityForm;
//#UC END# *4CB6AFEE024B_4CCAA9E50274_var*
begin
 __WasEnter := vcmEnterFactory;
 try
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
 finally
  if __WasEnter then
   vcmLeaveFactory;
 end;//try..finally
end;//TFiltersModule.RenameFilter

class procedure TFiltersModule.GetEntityForms(aList: TvcmClassList);
begin
 inherited;
 aList.Add(TenFilters);
 aList.Add(TCreateFilterForm);
end;//TFiltersModule.GetEntityForms
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
