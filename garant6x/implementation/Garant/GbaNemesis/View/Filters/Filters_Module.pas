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
 end;//TFiltersModule
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , l3ProtoObject
 , Base_Operations_F1Services_Contracts
 , SearchUnit
 , SimpleListInterfaces
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , Classes
 , FiltersUnit
 , Search_Strange_Controls
 , PrimCreateFilter_cfRename_UserType
 , PrimCreateFilter_cfCreate_UserType
 , dsCreateFilter
 , deFilter
 , DataAdapter
 , SysUtils
 , l3Base
 , Filters_Form
 , CreateFilter_Form
 , Common_FormDefinitions_Controls
 //#UC START# *4CCAA9E50274impl_uses*
 //#UC END# *4CCAA9E50274impl_uses*
;

{$If NOT Defined(NoVCM)}
type
 TFiltersServiceImpl = {final} class(Tl3ProtoObject, IFiltersService)
  public
   function CreateFilter(const aQuery: IQuery): Integer;
   procedure FiltersOpen(const aData: IucpFilters);
   procedure OldSchoolFiltersOpen(const anAggregate: IvcmAggregate;
    const aContainer: IvcmContainer;
    anOwner: TComponent);
   procedure RenameFilter(const aFilter: IFilterFromQuery);
   class function Instance: TFiltersServiceImpl;
    {* Метод получения экземпляра синглетона TFiltersServiceImpl }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
 end;//TFiltersServiceImpl

var g_TFiltersServiceImpl: TFiltersServiceImpl = nil;
 {* Экземпляр синглетона TFiltersServiceImpl }

procedure TFiltersServiceImplFree;
 {* Метод освобождения экземпляра синглетона TFiltersServiceImpl }
begin
 l3Free(g_TFiltersServiceImpl);
end;//TFiltersServiceImplFree

function TFiltersServiceImpl.CreateFilter(const aQuery: IQuery): Integer;
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
end;//TFiltersServiceImpl.CreateFilter

procedure TFiltersServiceImpl.FiltersOpen(const aData: IucpFilters);
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
end;//TFiltersServiceImpl.FiltersOpen

procedure TFiltersServiceImpl.OldSchoolFiltersOpen(const anAggregate: IvcmAggregate;
 const aContainer: IvcmContainer;
 anOwner: TComponent);
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
end;//TFiltersServiceImpl.OldSchoolFiltersOpen

procedure TFiltersServiceImpl.RenameFilter(const aFilter: IFilterFromQuery);
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
end;//TFiltersServiceImpl.RenameFilter

class function TFiltersServiceImpl.Instance: TFiltersServiceImpl;
 {* Метод получения экземпляра синглетона TFiltersServiceImpl }
begin
 if (g_TFiltersServiceImpl = nil) then
 begin
  l3System.AddExitProc(TFiltersServiceImplFree);
  g_TFiltersServiceImpl := Create;
 end;
 Result := g_TFiltersServiceImpl;
end;//TFiltersServiceImpl.Instance

class function TFiltersServiceImpl.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TFiltersServiceImpl <> nil;
end;//TFiltersServiceImpl.Exists

class procedure TFiltersModule.GetEntityForms(aList: TvcmClassList);
begin
 inherited;
 aList.Add(TenFilters);
 aList.Add(TCreateFilterForm);
end;//TFiltersModule.GetEntityForms

initialization
 TFiltersService.Instance.Alien := TFiltersServiceImpl.Instance;
 {* Регистрация TFiltersServiceImpl }
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
