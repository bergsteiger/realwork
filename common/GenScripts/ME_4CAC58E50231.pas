unit nsFiltersInterfaces;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Filters\nsFiltersInterfaces.pas"
// Стереотип: "Interfaces"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , l3Tree_TLB
 , FiltersUnit
 , bsTypes
 , l3Interfaces
 , l3TreeInterfaces
;

type
 InsFiltersContainer = interface
  {* Конейнер фильтров }
  ['{11FAFA58-1C81-4E9C-A713-34D9A5880AB1}']
  function pm_GetTree: Il3Tree;
  function pm_GetPermanentFilters: IFiltersFromQuery;
  property Tree: Il3Tree
   read pm_GetTree;
  property PermanentFilters: IFiltersFromQuery
   read pm_GetPermanentFilters;
 end;//InsFiltersContainer

 InsFiltersTree = interface
  {* Дерево фильтров }
  ['{0DCE9174-7D56-4EF7-A0A8-24DBEF00F4EA}']
  function pm_GetFiltersType: TbsListType;
  property FiltersType: TbsListType
   read pm_GetFiltersType;
 end;//InsFiltersTree

 InsFilterNode = interface
  {* Узел фильтра }
  ['{3B9B8DD6-7A45-42A6-98CC-77E42A4F5899}']
  function pm_GetUsedStatus: Boolean;
  function pm_GetDeletedStatus: Boolean;
  function pm_GetAutoApplied: Boolean;
  procedure pm_SetAutoApplied(aValue: Boolean);
  function pm_GetID: Longword;
  function CanModify: Boolean;
  procedure MarkToDelete;
  procedure ValidateName;
  property UsedStatus: Boolean
   read pm_GetUsedStatus;
  property DeletedStatus: Boolean
   read pm_GetDeletedStatus;
  property AutoApplied: Boolean
   read pm_GetAutoApplied
   write pm_SetAutoApplied;
   {* постоянный фильтр, используется после каждого поиска }
  property ID: Longword
   read pm_GetID;
 end;//InsFilterNode

 TnsFiltersType = (
  ftDocuments
  , ftDrugs
 );//TnsFiltersType

 InsFiltersListener = interface(IFilterNotifier)
  ['{0556EFE5-9A1B-41AB-8E13-642856BDDD7A}']
 end;//InsFiltersListener

 InsFilterRootNode = interface(Il3RootNode)
  ['{AE369DFF-E3F3-4DD5-8308-EC42AD32E8CD}']
  function Get_FiltersType: TnsFiltersType;
  property FiltersType: TnsFiltersType
   read Get_FiltersType;
 end;//InsFilterRootNode

 InsFiltersEnumerator = interface
  ['{0919FA07-042E-4CB2-9BD1-A4C47103F038}']
  function Get_Current: IFilterFromQuery;
  procedure Reset;
  function MoveNext: Boolean;
  property Current: IFilterFromQuery
   read Get_Current;
 end;//InsFiltersEnumerator
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
