unit nsFiltersContainer;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\Filters\nsFiltersContainer.pas"
// ���������: "SimpleClass"
// ������� ������: "TnsFiltersContainer" MUID: (4CAC5BD701BF)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , l3SimpleObject
 , nsFiltersInterfaces
 , SearchUnit
 , l3Interfaces
 , FiltersUnit
 , bsTypes
;

type
 TnsFiltersContainer = class(Tl3SimpleObject)
  private
   f_DocFilter: InsFiltersContainer;
   f_DrugFilter: InsFiltersContainer;
  protected
   function pm_GetFilters(ListType: TbsListType): InsFiltersContainer;
   procedure Cleanup; override;
    {* ������� ������� ����� �������. }
  public
   class procedure ConvertToFilter(const aQuery: IQuery;
    const aName: Il3CString);
   class procedure RenameFilter(const aFilter: IFilterFromQuery;
    const aName: Il3CString);
   class function Instance: TnsFiltersContainer;
    {* ����� ��������� ���������� ���������� TnsFiltersContainer }
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
  public
   property Filters[ListType: TbsListType]: InsFiltersContainer
    read pm_GetFilters;
 end;//TnsFiltersContainer
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , nsFiltersContainerPrim
 , DataAdapter
 , nsTypes
 , SysUtils
 , BaseTypesUnit
 , l3Base
;

var g_TnsFiltersContainer: TnsFiltersContainer = nil;
 {* ��������� ���������� TnsFiltersContainer }

procedure TnsFiltersContainerFree;
 {* ����� ������������ ���������� ���������� TnsFiltersContainer }
begin
 l3Free(g_TnsFiltersContainer);
end;//TnsFiltersContainerFree

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

class function TnsFiltersContainer.Instance: TnsFiltersContainer;
 {* ����� ��������� ���������� ���������� TnsFiltersContainer }
begin
 if (g_TnsFiltersContainer = nil) then
 begin
  l3System.AddExitProc(TnsFiltersContainerFree);
  g_TnsFiltersContainer := Create;
 end;
 Result := g_TnsFiltersContainer;
end;//TnsFiltersContainer.Instance

class function TnsFiltersContainer.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_TnsFiltersContainer <> nil;
end;//TnsFiltersContainer.Exists

procedure TnsFiltersContainer.Cleanup;
 {* ������� ������� ����� �������. }
//#UC START# *479731C50290_4CAC5BD701BF_var*
//#UC END# *479731C50290_4CAC5BD701BF_var*
begin
//#UC START# *479731C50290_4CAC5BD701BF_impl*
 f_DocFilter := nil;
 f_DrugFilter := nil;
 inherited;
//#UC END# *479731C50290_4CAC5BD701BF_impl*
end;//TnsFiltersContainer.Cleanup
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
