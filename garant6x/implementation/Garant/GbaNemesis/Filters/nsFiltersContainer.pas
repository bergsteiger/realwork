unit nsFiltersContainer;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Filters"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Filters/nsFiltersContainer.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Core::Common::Filters::Impl::TnsFiltersContainer
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
  SearchUnit,
  l3Interfaces,
  l3SimpleObject,
  bsTypes,
  nsFiltersInterfaces
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TnsFiltersContainer = class(Tl3SimpleObject)
 private
 // private fields
   f_DocFilter : InsFiltersContainer;
   f_DrugFilter : InsFiltersContainer;
 protected
 // property methods
   function pm_GetFilters(ListType: TbsListType): InsFiltersContainer;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
 public
 // public methods
   class procedure ConvertToFilter(const aQuery: IQuery;
    const aName: Il3CString);
   class procedure RenameFilter(const aFilter: IFilterFromQuery;
    const aName: Il3CString);
   class function Exists: Boolean;
     {* Проверяет создан экземпляр синглетона или нет }
 public
 // public properties
   property Filters[ListType: TbsListType]: InsFiltersContainer
     read pm_GetFilters;
 public
 // singleton factory method
   class function Instance: TnsFiltersContainer;
    {- возвращает экземпляр синглетона. }
 end;//TnsFiltersContainer
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  l3Base {a},
  nsFiltersContainerPrim,
  DataAdapter,
  nsTypes,
  SysUtils,
  BaseTypesUnit
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}


// start class TnsFiltersContainer

var g_TnsFiltersContainer : TnsFiltersContainer = nil;

procedure TnsFiltersContainerFree;
begin
 l3Free(g_TnsFiltersContainer);
end;

class function TnsFiltersContainer.Instance: TnsFiltersContainer;
begin
 if (g_TnsFiltersContainer = nil) then
 begin
  l3System.AddExitProc(TnsFiltersContainerFree);
  g_TnsFiltersContainer := Create;
 end;
 Result := g_TnsFiltersContainer;
end;


function TnsFiltersContainer.pm_GetFilters(ListType: TbsListType): InsFiltersContainer;
//#UC START# *4CAD6F700075_4CAC5BD701BFget_var*
//#UC END# *4CAD6F700075_4CAC5BD701BFget_var*
begin
//#UC START# *4CAD6F700075_4CAC5BD701BFget_impl*
 case ListType of
  bs_ltDocument:
   begin
    if f_DocFilter = nil then
     f_DocFilter := TnsFiltersContainerPrim.Make(ftDocuments);
    Result := f_DocFilter;
   end;
  bs_ltDrug:
   begin
    if f_DrugFilter = nil then
     f_DrugFilter := TnsFiltersContainerPrim.Make(ftDrugs);
    Result := f_DrugFilter;
   end;
 else
  Result := nil 
 end;
//#UC END# *4CAD6F700075_4CAC5BD701BFget_impl*
end;//TnsFiltersContainer.pm_GetFilters

class procedure TnsFiltersContainer.ConvertToFilter(const aQuery: IQuery;
  const aName: Il3CString);
//#UC START# *4CB5545B0148_4CAC5BD701BF_var*
//#UC END# *4CB5545B0148_4CAC5BD701BF_var*
begin
//#UC START# *4CB5545B0148_4CAC5BD701BF_impl*
 defDataAdapter.NativeAdapter.MakeFiltersManager.CreateFilter(aQuery, nsIStr(aName));
//#UC END# *4CB5545B0148_4CAC5BD701BF_impl*
end;//TnsFiltersContainer.ConvertToFilter

class procedure TnsFiltersContainer.RenameFilter(const aFilter: IFilterFromQuery;
  const aName: Il3CString);
//#UC START# *4CB5549500AD_4CAC5BD701BF_var*
//#UC END# *4CB5549500AD_4CAC5BD701BF_var*
begin
//#UC START# *4CB5549500AD_4CAC5BD701BF_impl*
 aFilter.SetName(nsIStr(aName));
//#UC END# *4CB5549500AD_4CAC5BD701BF_impl*
end;//TnsFiltersContainer.RenameFilter

class function TnsFiltersContainer.Exists: Boolean;
 {-}
begin
 Result := g_TnsFiltersContainer <> nil;
end;//TnsFiltersContainer.Exists

procedure TnsFiltersContainer.Cleanup;
//#UC START# *479731C50290_4CAC5BD701BF_var*
//#UC END# *479731C50290_4CAC5BD701BF_var*
begin
//#UC START# *479731C50290_4CAC5BD701BF_impl*
 f_DocFilter := nil;
 f_DrugFilter := nil;
 inherited;
//#UC END# *479731C50290_4CAC5BD701BF_impl*
end;//TnsFiltersContainer.Cleanup

{$IfEnd} //not Admin AND not Monitorings

end.