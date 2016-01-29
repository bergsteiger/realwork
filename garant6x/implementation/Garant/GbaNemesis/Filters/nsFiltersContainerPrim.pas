unit nsFiltersContainerPrim;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Filters"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Filters/nsFiltersContainerPrim.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Core::Common::Filters::Impl::TnsFiltersContainerPrim
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
  l3Tree_TLB,
  l3SimpleObject,
  nsFiltersInterfaces,
  FiltersUnit
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TnsFiltersContainerPrim = class(Tl3SimpleObject, InsFiltersContainer)
 private
 // private fields
   f_Tree : Il3Tree;
   f_FilterType : TnsFiltersType;
 protected
 // realized methods
   function pm_GetTree: Il3Tree;
   function pm_GetPermanentFilters: IFiltersFromQuery;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
 public
 // public methods
   constructor Create(aFilterType: TnsFiltersType); reintroduce;
   class function Make(aFilterType: TnsFiltersType): InsFiltersContainer; reintroduce;
     {* Сигнатура фабрики TnsFiltersContainerPrim.Make }
 end;//TnsFiltersContainerPrim
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  DataAdapter,
  nsFiltersTree,
  SysUtils,
  l3Nodes
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TnsFiltersContainerPrim

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
end;

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
//#UC START# *479731C50290_4CAC5B4900ED_var*
//#UC END# *479731C50290_4CAC5B4900ED_var*
begin
//#UC START# *479731C50290_4CAC5B4900ED_impl*
 f_Tree := nil;
 inherited Cleanup;
//#UC END# *479731C50290_4CAC5B4900ED_impl*
end;//TnsFiltersContainerPrim.Cleanup

{$IfEnd} //not Admin AND not Monitorings

end.