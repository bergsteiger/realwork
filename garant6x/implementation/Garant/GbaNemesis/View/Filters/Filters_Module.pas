unit Filters_Module;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Filters/Filters_Module.pas"
// Начат: 29.10.2010 15:00
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMFormsPack::Class>> F1 Основные прецеденты::Filters::View::Filters::Filters$FP
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  FiltersUnit,
  SearchUnit
  {$If not defined(NoVCM)}
  ,
  vcmInterfaces
  {$IfEnd} //not NoVCM
  ,
  Classes,
  SimpleListInterfaces,
  Common_FormDefinitions_Controls,
  PrimFiltersOptions_Form,
  PrimCreateFilter_Form,
  Filters_Form,
  CreateFilter_Form,
  vcmExternalInterfaces {a},
  vcmModule {a},
  vcmBase {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TFiltersModule = {formspack} class(TvcmModule)
 protected
  class procedure GetEntityForms(aList : TvcmClassList); override;
 public
 // public methods
   class procedure FiltersOpen(const aData: IucpFilters);
   class procedure OldSchoolFiltersOpen(const anAggregate: IvcmAggregate;
     const aContainer: IvcmContainer;
     anOwner: TComponent);
   class function CreateFilter(const aQuery: IQuery): Integer;
   class procedure RenameFilter(const aFilter: IFilterFromQuery);
 end;//TFiltersModule
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  DataAdapter,
  PrimCreateFilter_cfRename_UserType,
  PrimCreateFilter_cfCreate_UserType,
  dsCreateFilter,
  deFilter,
  Search_Strange_Controls,
  vcmFormSetFactory {a},
  StdRes {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TFiltersModule

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
var
 __WasEnter : Boolean;
//#UC START# *4AC09F4F011A_4CCAA9E50274_var*
//#UC END# *4AC09F4F011A_4CCAA9E50274_var*
var
 l_Filters : IvcmEntityForm;
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

class procedure TFiltersModule.GetEntityForms(aList : TvcmClassList);
begin
 inherited;
 aList.Add(TenFilters);
 aList.Add(TCreateFilterForm);
end;

{$IfEnd} //not Admin AND not Monitorings

end.