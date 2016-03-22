unit dsCreateFilter;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Filters\dsCreateFilter.pas"
// Стереотип: "ViewAreaControllerImp"
// Элемент модели: "TdsCreateFilter" MUID: (4CB6C9B20187)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , FiltersInterfaces
 , SimpleListInterfaces
 , l3Interfaces
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , l3ProtoObjectWithCOMQI
 {$If NOT Defined(NoVCM)}
 , vcmLocalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , l3NotifyPtrList
;

type
 _FormDataSourceType_ = IdsCreateFilter;
 _InitDataType_ = IdeFilter;
 {$Include w:\common\components\gui\Garant\VCM\implementation\vcmFormDataSource.imp.pas}
 TdsCreateFilter = class(_vcmFormDataSource_, IdsCreateFilter)
  protected
   function Get_Name: Il3CString;
   procedure CreateFilter(const aName: Il3CString);
   procedure RenameFilter(const aName: Il3CString);
 end;//TdsCreateFilter
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , nsQueryUtils
 , nsFiltersContainer
 , nsTypes
 , DataAdapter
 , l3InterfacesMisc
 , SysUtils
 , l3Base
;

{$If NOT Defined(NoVCM)}
type _Instance_R_ = TdsCreateFilter;

{$Include w:\common\components\gui\Garant\VCM\implementation\vcmFormDataSource.imp.pas}

function TdsCreateFilter.Get_Name: Il3CString;
//#UC START# *4CB6C9330040_4CB6C9B20187get_var*
//#UC END# *4CB6C9330040_4CB6C9B20187get_var*
begin
//#UC START# *4CB6C9330040_4CB6C9B20187get_impl*
 Result := nsGetQueryName(PartData.Query);
//#UC END# *4CB6C9330040_4CB6C9B20187get_impl*
end;//TdsCreateFilter.Get_Name

procedure TdsCreateFilter.CreateFilter(const aName: Il3CString);
//#UC START# *4CB6C9490358_4CB6C9B20187_var*
//#UC END# *4CB6C9490358_4CB6C9B20187_var*
begin
//#UC START# *4CB6C9490358_4CB6C9B20187_impl*
 //TnsFiltersContainer.ConvertToFilter(PartData.Query, aName);
 defDataAdapter.NativeAdapter.MakeFiltersManager.CreateFilter(PartData.Query, nsIStr(aName));
//#UC END# *4CB6C9490358_4CB6C9B20187_impl*
end;//TdsCreateFilter.CreateFilter

procedure TdsCreateFilter.RenameFilter(const aName: Il3CString);
//#UC START# *4CB6C966029D_4CB6C9B20187_var*
//#UC END# *4CB6C966029D_4CB6C9B20187_var*
begin
//#UC START# *4CB6C966029D_4CB6C9B20187_impl*
 //TnsFiltersContainer.RenameFilter(PartData.Filter, aName);
 PartData.Filter.SetName(nsIStr(aName));
//#UC END# *4CB6C966029D_4CB6C9B20187_impl*
end;//TdsCreateFilter.RenameFilter
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
