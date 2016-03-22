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
;

type
 IFilterFromQuery = interface
  ['{A81EFF04-FAB6-4D1B-846B-66C301594470}']
  function Get_name: IString;
  procedure Set_name(const aValue: IString);
  function Get_query: IEntityBase;
  function Get_changeable: Boolean;
  function Get_permanent: Boolean;
  procedure Set_permanent(aValue: Boolean);
  function Get_id: Cardinal;
  function Get_flags: Cardinal;
  procedure mark_to_erase;
   {* ������� ������ ����� ����, ��� �� ���������� �������������� }
  function is_same(const other: IFilterFromQuery): Boolean;
   {* ���������� true, ���� ������������ � ���������� ������� ��������� }
  procedure get_server_query;
  procedure save_to_server(const query);
  function check: Boolean;
   {* ��������� �������� � ������� }
  function marked_to_erase: Boolean;
  function is_used: Boolean;
   {* ������� �� ������ }
  property name: IString
   read Get_name
   write Set_name;
  property query: IEntityBase
   read Get_query;
   {* ���� ������ query Search::Query, ������� �� � ��������, �� ������ ���������� ������ ����������� ������, ������� �������� ����� ��������� }
  property changeable: Boolean
   read Get_changeable;
  property permanent: Boolean
   read Get_permanent
   write Set_permanent;
  property id: Cardinal
   read Get_id;
   {* ������������� ����� ��������, ����� ���������������� ������������� ������� (�274848126) }
  property flags: Cardinal
   read Get_flags;
 end;//IFilterFromQuery

 NotAllAttributesRestored = class
  {* �� ��� �������� ���������� ������� ������������ �� ���� }
 end;//NotAllAttributesRestored

 IFiltersFromQuery = array of IFilterFromQuery;
  {* ��������� ��������. }

 IFilterable = interface
  {* ��������� �������������. ������ �������������� ���������, ��������� ������������� ������ ��������. ������ ������������ ��� �������. }
  ['{4C08EC41-3957-462B-B9C1-FB91B86469BA}']
  function Get_has_active_filters: Boolean;
  function Get_active_filters: IFiltersFromQuery;
  procedure add_filter(var filter: IFilterFromQuery;
   auto_refresh: Boolean); { can raise AllContentIsFiltered, NotAllAttributesRestored }
   {* ��������� INode (�� ������ �����) ��� ������. 
���� auto_refresh = true (�������� �� ���������), ��
�������� �������� � �������������� �������. }
  procedure delete_filter(const filter: IFilterFromQuery;
   auto_refresh: Boolean); { can raise CanNotFindData, AllContentIsFiltered }
   {* ������� ������ �� ������ �������� �������� �������. ���� auto_refresh = true (�������� �� ���������), �� �������� �������� � �������������� �������. }
  procedure clear_filters; { can raise CanNotFindData }
   {* ������� ��� �������. � ���������� �������� ������ ��������� � ���������, ������������� ���������� �������� }
  procedure refresh_filters; { can raise CanNotFindData, AllContentIsFiltered }
  procedure apply_filters(const filters: IFiltersFromQuery); { can raise CanNotFindData, AllContentIsFiltered }
   {* ��������� ����� �������� � ������������� �� �����������. ��� ���� ��� ����� ���� ������� �����������, ���� (� ������, ���� ��� ��������� �������������) ������� �����������.

���� ����������, ��� �� ������� ��� ������ ��� ���������� ������, �.�. ������ ��� �������� ��� (��. �244711732), ����� CanNotFindData. }
  property has_active_filters: Boolean
   read Get_has_active_filters;
  property active_filters: IFiltersFromQuery
   read Get_active_filters;
 end;//IFilterable

 IFilterNotifier = interface
  ['{F41C0D69-A5BC-4836-9F33-85807FCAC1A7}']
  procedure filters_changed;
  procedure filter_name_changed;
  procedure filter_permanence_changed;
 end;//IFilterNotifier

 IFiltersManager = interface
  ['{854B1550-A048-4551-AB1C-6FD08FDAF723}']
  function get_legal_filters: IFiltersFromQuery;
   {* �������� ������ �������� ��� �������� ���������� }
  function get_pharm_filters: IFiltersFromQuery;
  procedure create_filter(const query: IEntityBase;
   const name: IString);
   {* ������� ����� ������ }
  procedure set_legal_notifier(var notifier: IFilterNotifier);
  procedure set_pharm_notifier(var notifier: IFilterNotifier);
  procedure filter_name_changed(pharm: Boolean);
  procedure filter_permanence_changed(pharm: Boolean);
  procedure filter_removed(pharm: Boolean);
  procedure clear_cache(pharm: Boolean);
 end;//IFiltersManager

class function make(const filter): BadFactoryType;
class function make: BadFactoryType;

implementation

uses
 l3ImplUses
;

class function make(const filter): BadFactoryType;
var
 l_Inst : IFilterFromQuery;
begin
 l_Inst := Create(filter);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//make

class function make: BadFactoryType;
var
 l_Inst : IFiltersManager;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//make

end.
