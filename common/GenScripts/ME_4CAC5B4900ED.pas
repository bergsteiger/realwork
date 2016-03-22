unit nsFiltersContainerPrim;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Filters\nsFiltersContainerPrim.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnsFiltersContainerPrim" MUID: (4CAC5B4900ED)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , l3SimpleObject
 , nsFiltersInterfaces
 , l3Tree_TLB
 , FiltersUnit
;

type
 TnsFiltersContainerPrim = class(Tl3SimpleObject, InsFiltersContainer)
  private
   f_Tree: Il3Tree;
   f_FilterType: TnsFiltersType;
  protected
   function pm_GetTree: Il3Tree;
   function pm_GetPermanentFilters: IFiltersFromQuery;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create(aFilterType: TnsFiltersType); reintroduce;
   class function Make(aFilterType: TnsFiltersType): InsFiltersContainer; reintroduce;
 end;//TnsFiltersContainerPrim
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , DataAdapter
 , nsFiltersTree
 , SysUtils
 , l3Nodes
;

constructor TnsFiltersContainerPrim.Create(aFilterType: TnsFiltersType);
//#UC START# *4CB30B4A0124_4CAC5B4900ED_var*
//#UC END# *4CB30B4A0124_4CAC5B4900ED_var*
begin
//#UC START# *4CB30B4A0124_4CAC5B4900ED_impl*
 inherited Create;
 f_FilterType := aFilterType;
//#UC END# *4CB30B4A0124_4CAC5B4900ED_impl*
end;//TnsFiltersContainerPrim.Create

class function TnsFiltersContainerPrim.Make(aFilterType: TnsFiltersType): InsFiltersContainer;
var
 l_Inst : TnsFiltersContainerPrim;
begin
 l_Inst := Create(aFilterType);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TnsFiltersContainerPrim.Make

function TnsFiltersContainerPrim.pm_GetTree: Il3Tree;
//#UC START# *4991850C0199_4CAC5B4900EDget_var*
//#UC END# *4991850C0199_4CAC5B4900EDget_var*
begin
//#UC START# *4991850C0199_4CAC5B4900EDget_impl*
 if f_Tree = nil then
  f_Tree := TnsFiltersTree.Make(f_FilterType, nil);
 Result := f_Tree;
//#UC END# *4991850C0199_4CAC5B4900EDget_impl*
end;//TnsFiltersContainerPrim.pm_GetTree

function TnsFiltersContainerPrim.pm_GetPermanentFilters: IFiltersFromQuery;
//#UC START# *4991855E01FB_4CAC5B4900EDget_var*
var
 l_Result: IFiltersFromQuery;

 function Collect(const anIntf: Il3Node): Boolean;
 var
  l_IterNode: IFilterFromQuery;
 begin//Collect
  if Supports(anIntf, IFilterFromQuery, l_IterNode) then
   try
    if l_IterNode.GetPermanent then
     l_Result.Add(l_IterNode);
   finally
    l_IterNode := nil;
   end;//try..finally
  Result := False;
 end;//Collect

//#UC END# *4991855E01FB_4CAC5B4900EDget_var*
begin
//#UC START# *4991855E01FB_4CAC5B4900EDget_impl*
 l_Result := DefDataAdapter.NativeAdapter.MakeFiltersFromQuery;
 pm_GetTree.IterateF(l3L2NA(@Collect));
 Result := l_Result;
//#UC END# *4991855E01FB_4CAC5B4900EDget_impl*
end;//TnsFiltersContainerPrim.pm_GetPermanentFilters

procedure TnsFiltersContainerPrim.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4CAC5B4900ED_var*
//#UC END# *479731C50290_4CAC5B4900ED_var*
begin
//#UC START# *479731C50290_4CAC5B4900ED_impl*
 f_Tree := nil;
 inherited Cleanup;
//#UC END# *479731C50290_4CAC5B4900ED_impl*
end;//TnsFiltersContainerPrim.Cleanup
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
