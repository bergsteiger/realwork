unit QueryCardInterfaces;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\Search\QueryCardInterfaces.pas"
// ���������: "ControllerInterfaces"
// ������� ������: "QueryCardInterfaces" MUID: (4AA5503000D7)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
 , SearchUnit
 , SearchInterfaces
 , l3InternalInterfaces
 , l3TreeInterfaces
 , SearchDomainInterfaces
 , SimpleListInterfaces
;

type
 IdeQuery = IQuery;
  {* ������ ��� ������������� ���� ������ }

 IdsQuery = interface
  {* ��� ��� �������� ������� }
  ['{51C5A41E-41B2-463E-8671-275D172E3B48}']
  function pm_GetQuery: IdeQuery;
  function pm_GetIsQuerySaved: Boolean;
  procedure pm_SetIsQuerySaved(aValue: Boolean);
  property Query: IdeQuery
   read pm_GetQuery;
  property IsQuerySaved: Boolean
   read pm_GetIsQuerySaved
   write pm_SetIsQuerySaved;
 end;//IdsQuery

 IdsSaveLoad = interface
  {* ������ ������ ���������� �������� ������ }
  ['{E5584C58-C6DF-42D0-B1AE-ACB317071F37}']
 end;//IdsSaveLoad

 IsdsAttributeSelect = interface
  {* ����� ������ ���������� }
  ['{DE5652A0-CBAC-4E05-863F-16A1F094E89B}']
  function pm_GetSearch: IdeSearch;
  property Search: IdeSearch
   read pm_GetSearch;
   {* ���������� ��� ���������� ������ ��������� }
 end;//IsdsAttributeSelect

 IdsTreeAttributeFirstLevel = interface(IdsSituation)
  {* ������ ������� ����� "enTreeAttributeFirstLevel" }
  ['{5995C2CA-E6BD-4FB7-A029-94E0AB2A037C}']
 end;//IdsTreeAttributeFirstLevel

 IsdsSituation = interface(IsdsAttributeSelect)
  ['{53453074-B221-4E0D-8FB1-538D5C3A930D}']
  function pm_GetdsFilters: IdsFilters;
  function pm_GetdsTreeAttributeFirstLevel: IdsTreeAttributeFirstLevel;
  function pm_GetdsSaveLoad: IdsSaveLoad;
  function pm_GetdsSelectedAttributes: IdsSelectedAttributes;
  function pm_GetdsTreeAttributeSelect: IdsTreeAttributeSelect;
  function pm_GetdsAttributeSelect: IdsAttributeSelect;
  function As_IucpFilters: IucpFilters;
   {* ����� ���������� ������ ���������� � IucpFilters }
  function As_IbsCurrentChangedListener: IbsCurrentChangedListener;
   {* ����� ���������� ������ ���������� � IbsCurrentChangedListener }
  function As_IbsSelectedAttributes: IbsSelectedAttributes;
   {* ����� ���������� ������ ���������� � IbsSelectedAttributes }
  property dsFilters: IdsFilters
   read pm_GetdsFilters;
   {* ��� ����� ������� }
  property dsTreeAttributeFirstLevel: IdsTreeAttributeFirstLevel
   read pm_GetdsTreeAttributeFirstLevel;
   {* ��� ����� "�������� ������� ������" }
  property dsSaveLoad: IdsSaveLoad
   read pm_GetdsSaveLoad;
   {* ��� ����� ��������� �������� ������� }
  property dsSelectedAttributes: IdsSelectedAttributes
   read pm_GetdsSelectedAttributes;
   {* ��� ����� ��������� �������� }
  property dsTreeAttributeSelect: IdsTreeAttributeSelect
   read pm_GetdsTreeAttributeSelect;
   {* ��� ����� ������ ��������� }
  property dsAttributeSelect: IdsAttributeSelect
   read pm_GetdsAttributeSelect;
   {* ������-������ ����� cfAttributeSelect }
 end;//IsdsSituation

 TnsFilterForm = (
  {* ���� �������� ������������ ��� �������������� �������� }
  ns_ffAttributeSearch
   {* ��� 6.� }
  , ns_ffPublishSource
   {* ���� }
  , ns_ffSituation
   {* ��� }
  , ns_ffOldSituation
   {* ������ �������� ��� }
  , ns_ffBaseSearch
   {* ������� ����� }
  , ns_ffInpharmSearch
 );//TnsFilterForm

 TnsSearchListType = (
  {* ���� ������������ ��� ��������� ������ � nsSearchManager }
  ns_sltWithoutClass
  , ns_sltWithoutKey
  , ns_sltWithoutInluded
 );//TnsSearchListType
{$IfEnd} // NOT Defined(Admin)

implementation

{$If NOT Defined(Admin)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(Admin)

end.
