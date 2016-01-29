unit FiltersUnit;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "GblAdapterLib"
// ������: "w:/garant6x/implementation/Garant/tie/Garant/GblAdapterLib/FiltersUnit.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::Filters
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
  IOUnit,
  BaseTypesUnit,
  BaseTreeSupportUnit
  ;

type
 IFilterFromQuery = interface(IUnknown)
   ['{A81EFF04-FAB6-4D1B-846B-66C301594470}']
   function GetName: IString; stdcall;
   procedure SetName(const aValue: IString); stdcall;
   function GetQuery: IEntityBase; stdcall;
   function GetChangeable: ByteBool; stdcall;
   function GetPermanent: ByteBool; stdcall;
   procedure SetPermanent(aValue: Boolean); stdcall;
   function GetId: Cardinal; stdcall;
   function GetFlags: Cardinal; stdcall;
   procedure MarkToErase; stdcall;
     {* ������� ������ ����� ����, ��� �� ���������� �������������� }
   function IsSame(const aOther: IFilterFromQuery): ByteBool; stdcall;
     {* ���������� true, ���� ������������ � ���������� ������� ��������� }
   procedure GetServerQuery; stdcall;
   procedure SaveToServer(aQuery); stdcall;
   function Check: ByteBool; stdcall;
     {* ��������� �������� � ������� }
   function MarkedToErase: ByteBool; stdcall;
   function IsUsed: ByteBool; stdcall;
     {* ������� �� ������ }
   property name: IString
     read GetName
     write SetName;
   property query: IEntityBase
     read GetQuery;
     {* ���� ������ query Search::Query, ������� �� � ��������, �� ������ ���������� ������ ����������� ������, ������� �������� ����� ��������� }
   property changeable: ByteBool
     read GetChangeable;
   property permanent: ByteBool
     read GetPermanent
     write SetPermanent;
   property id: Cardinal
     read GetId;
     {* ������������� ����� ��������, ����� ���������������� ������������� ������� (�274848126) }
   property flags: Cardinal
     read GetFlags;
 end;//IFilterFromQuery

 NotAllAttributesRestored = class
  {* �� ��� �������� ���������� ������� ������������ �� ���� }
 end;//NotAllAttributesRestored

 IFiltersFromQuery = array of IFilterFromQuery;
  {* ��������� ��������. }

 IFilterable = interface(IUnknown)
  {* ��������� �������������. ������ �������������� ���������, ��������� ������������� ������ ��������. ������ ������������ ��� �������. }
   ['{4C08EC41-3957-462B-B9C1-FB91B86469BA}']
   function GetHasActiveFilters: ByteBool; stdcall;
   function GetActiveFilters: IFiltersFromQuery; stdcall;
   procedure AddFilter(var aFilter: IFilterFromQuery;
    aAutoRefresh: Boolean); stdcall; // can raise AllContentIsFiltered, NotAllAttributesRestored
     {* ��������� INode (�� ������ �����) ��� ������. 
���� auto_refresh = true (�������� �� ���������), ��
�������� �������� � �������������� �������. }
   procedure DeleteFilter(const aFilter: IFilterFromQuery;
    aAutoRefresh: Boolean); stdcall; // can raise CanNotFindData
     {* ������� ������ �� ������ �������� �������� �������. ���� auto_refresh = true (�������� �� ���������), �� �������� �������� � �������������� �������. }
   procedure ClearFilters; stdcall; // can raise CanNotFindData
     {* ������� ��� �������. � ���������� �������� ������ ��������� � ���������, ������������� ���������� �������� }
   procedure RefreshFilters; stdcall; // can raise CanNotFindData, AllContentIsFiltered
   procedure ApplyFilters(const aFilters: IFiltersFromQuery); stdcall; // can raise CanNotFindData
     {* ��������� ����� �������� � ������������� �� �����������. ��� ���� ��� ����� ���� ������� �����������, ���� (� ������, ���� ��� ��������� �������������) ������� �����������.

���� ����������, ��� �� ������� ��� ������ ��� ���������� ������, �.�. ������ ��� �������� ��� (��. �244711732), ����� CanNotFindData. }
   property has_active_filters: ByteBool
     read GetHasActiveFilters;
   property active_filters: IFiltersFromQuery
     read GetActiveFilters;
 end;//IFilterable

 IFilterNotifier = interface(IUnknown)
   ['{F41C0D69-A5BC-4836-9F33-85807FCAC1A7}']
   procedure FiltersChanged; stdcall;
   procedure FilterNameChanged; stdcall;
   procedure FilterPermanenceChanged; stdcall;
 end;//IFilterNotifier

 IFiltersManager = interface(IUnknown)
   ['{854B1550-A048-4551-AB1C-6FD08FDAF723}']
   procedure GetLegalFilters(out aRet {: IFiltersFromQuery}); stdcall;
     {* �������� ������ �������� ��� �������� ���������� }
   procedure GetPharmFilters(out aRet {: IFiltersFromQuery}); stdcall;
   procedure CreateFilter(const aQuery: IEntityBase;
    const aName: IString); stdcall;
     {* ������� ����� ������ }
   procedure SetLegalNotifier(var aNotifier: IFilterNotifier); stdcall;
   procedure SetPharmNotifier(var aNotifier: IFilterNotifier); stdcall;
   procedure FilterNameChanged(aPharm: Boolean); stdcall;
   procedure FilterPermanenceChanged(aPharm: Boolean); stdcall;
   procedure FilterRemoved(aPharm: Boolean); stdcall;
   procedure ClearCache(aPharm: Boolean); stdcall;
 end;//IFiltersManager

implementation

end.