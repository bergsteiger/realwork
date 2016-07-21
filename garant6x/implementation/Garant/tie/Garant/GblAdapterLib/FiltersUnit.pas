unit FiltersUnit;

// ������: "w:\garant6x\implementation\Garant\tie\Garant\GblAdapterLib\FiltersUnit.pas"
// ���������: "Interfaces"
// ������� ������: "Filters" MUID: (45EEA48F011F)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , IOUnit
 , BaseTypesUnit
 , BaseTreeSupportUnit
;

type
 IFilterFromQuery = interface
  ['{A81EFF04-FAB6-4D1B-846B-66C301594470}']
  procedure GetName; stdcall;
  procedure SetName(const aValue); stdcall;
  procedure GetQuery; stdcall;
  function GetChangeable: ByteBool; stdcall;
  function GetPermanent: ByteBool; stdcall;
  procedure SetPermanent(const aValue: ByteBool); stdcall;
  function GetId: Cardinal; stdcall;
  function GetFlags: Cardinal; stdcall;
  procedure MarkToErase; stdcall;
   {* ������� ������ ����� ����, ��� �� ���������� �������������� }
  function IsSame(const other: IFilterFromQuery): ByteBool; stdcall;
   {* ���������� true, ���� ������������ � ���������� ������� ��������� }
  procedure GetServerQuery; stdcall;
  procedure SaveToServer(const query); stdcall;
  function Check: ByteBool; stdcall;
   {* ��������� �������� � ������� }
  function MarkedToErase: ByteBool; stdcall;
  function IsUsed: ByteBool; stdcall;
   {* ������� �� ������ }
  property Name: 
   read GetName
   write SetName;
  property Query: 
   read GetQuery;
   {* ���� ������ query Search::Query, ������� �� � ��������, �� ������ ���������� ������ ����������� ������, ������� �������� ����� ��������� }
  property Changeable: ByteBool
   read GetChangeable;
  property Permanent: ByteBool
   read GetPermanent
   write SetPermanent;
  property Id: Cardinal
   read GetId;
   {* ������������� ����� ��������, ����� ���������������� ������������� ������� (�274848126) }
  property Flags: Cardinal
   read GetFlags;
 end;//IFilterFromQuery

 NotAllAttributesRestored = class
  {* �� ��� �������� ���������� ������� ������������ �� ���� }
 end;//NotAllAttributesRestored

 IFiltersFromQuery = array of IFilterFromQuery;
  {* ��������� ��������. }

 IFilterable = interface
  {* ��������� �������������. ������ �������������� ���������, ��������� ������������� ������ ��������. ������ ������������ ��� �������. }
  ['{4C08EC41-3957-462B-B9C1-FB91B86469BA}']
  function GetHasActiveFilters: ByteBool; stdcall;
  procedure GetActiveFilters; stdcall;
  procedure AddFilter(var filter: IFilterFromQuery;
   auto_refresh: Boolean); stdcall; { can raise AllContentIsFiltered, NotAllAttributesRestored }
   {* ��������� INode (�� ������ �����) ��� ������. 
���� auto_refresh = true (�������� �� ���������), ��
�������� �������� � �������������� �������. }
  procedure DeleteFilter(const filter: IFilterFromQuery;
   auto_refresh: Boolean); stdcall; { can raise CanNotFindData, AllContentIsFiltered }
   {* ������� ������ �� ������ �������� �������� �������. ���� auto_refresh = true (�������� �� ���������), �� �������� �������� � �������������� �������. }
  procedure ClearFilters; stdcall; { can raise CanNotFindData }
   {* ������� ��� �������. � ���������� �������� ������ ��������� � ���������, ������������� ���������� �������� }
  procedure RefreshFilters; stdcall; { can raise CanNotFindData, AllContentIsFiltered }
  procedure ApplyFilters(const filters: IFiltersFromQuery); stdcall; { can raise CanNotFindData, AllContentIsFiltered }
   {* ��������� ����� �������� � ������������� �� �����������. ��� ���� ��� ����� ���� ������� �����������, ���� (� ������, ���� ��� ��������� �������������) ������� �����������.

���� ����������, ��� �� ������� ��� ������ ��� ���������� ������, �.�. ������ ��� �������� ��� (��. �244711732), ����� CanNotFindData. }
  property HasActiveFilters: ByteBool
   read GetHasActiveFilters;
  property ActiveFilters: 
   read GetActiveFilters;
 end;//IFilterable

 IFilterNotifier = interface
  ['{F41C0D69-A5BC-4836-9F33-85807FCAC1A7}']
  procedure FiltersChanged; stdcall;
  procedure FilterNameChanged; stdcall;
  procedure FilterPermanenceChanged; stdcall;
 end;//IFilterNotifier

 IFiltersManager = interface
  ['{854B1550-A048-4551-AB1C-6FD08FDAF723}']
  procedure GetLegalFilters(out aRet
   {* IFiltersFromQuery }); stdcall;
   {* �������� ������ �������� ��� �������� ���������� }
  procedure GetPharmFilters(out aRet
   {* IFiltersFromQuery }); stdcall;
  procedure CreateFilter(const query: IEntityBase;
   const name: IString); stdcall;
   {* ������� ����� ������ }
  procedure SetLegalNotifier(var notifier: IFilterNotifier); stdcall;
  procedure SetPharmNotifier(var notifier: IFilterNotifier); stdcall;
  procedure FilterNameChanged(pharm: Boolean); stdcall;
  procedure FilterPermanenceChanged(pharm: Boolean); stdcall;
  procedure FilterRemoved(pharm: Boolean); stdcall;
  procedure ClearCache(pharm: Boolean); stdcall;
 end;//IFiltersManager

implementation

uses
 l3ImplUses
;

end.
