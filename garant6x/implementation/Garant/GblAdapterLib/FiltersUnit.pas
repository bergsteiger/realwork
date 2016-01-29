unit FiltersUnit; {$Z4}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "GblAdapterLib"
// ������: "w:/garant6x/implementation/Garant/GblAdapterLib/FiltersUnit.pas"
// Delphi ���������� ��� �������� (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::Filters
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

interface

uses
	SysUtils
	, IOUnit
	, BaseTypesUnit
	, BaseTreeSupportUnit
	//#UC START# *4423F94903C8_45EEA48F011F_UNIT_FOR_Stream*
	//#UC END# *4423F94903C8_45EEA48F011F_UNIT_FOR_Stream*
	;

type

IFilterFromQuery = interface;
{ - ��������������� �������� IFilterFromQuery. }

IFiltersFromQuery = interface;
{ - ��������������� �������� IFiltersFromQuery. }

IFiltersManager = interface;
{ - ��������������� �������� IFiltersManager. }


// �� ��� �������� ���������� ������� ������������ �� ����
ENotAllAttributesRestored = class (Exception);

// ��������� �������������. ������ �������������� ���������, ��������� ������������� ������
// ��������. ������ ������������ ��� �������.
IFilterable = interface (IInterface) ['{4C08EC41-3957-462B-B9C1-FB91B86469BA}']
	function DontUseMe: Pointer;
	procedure GetActiveFilters (out aRet {: IFiltersFromQuery}); stdcall;

	// ��������� INode (�� ������ �����) ��� ������.
	// ���� auto_refresh = true (�������� �� ���������), ��
	// �������� �������� � �������������� �������.
	procedure AddFilter (
		const aFilter: IFilterFromQuery;
		aAutoRefresh: Bytebool
	); stdcall; // can raise EAllContentIsFiltered, ENotAllAttributesRestored

	// ��������� ����� �������� � ������������� �� �����������. ��� ���� ��� ����� ���� �������
	// �����������, ���� (� ������, ���� ��� ��������� �������������) ������� �����������.
	// 
	// ���� ����������, ��� �� ������� ��� ������ ��� ���������� ������, �.�. ������ ��� �������� ���
	// (��. �244711732), ����� CanNotFindData.
	procedure ApplyFilters (
		const aFilters: IFiltersFromQuery
	); stdcall; // can raise ECanNotFindData, EAllContentIsFiltered

	// ������� ��� �������. � ���������� �������� ������ ��������� � ���������, �������������
	// ���������� ��������
	procedure ClearFilters (); stdcall; // can raise ECanNotFindData

	// ������� ������ �� ������ �������� �������� �������. ���� auto_refresh = true (�������� ��
	// ���������), �� �������� �������� � �������������� �������.
	procedure DeleteFilter (
		const aFilter: IFilterFromQuery;
		aAutoRefresh: Bytebool
	); stdcall; // can raise ECanNotFindData, EAllContentIsFiltered

	function GetHasActiveFilters (): Bytebool; stdcall;

	procedure RefreshFilters (); stdcall; // can raise ECanNotFindData, EAllContentIsFiltered
end;

IFilterNotifier = interface (IInterface) ['{F41C0D69-A5BC-4836-9F33-85807FCAC1A7}']
	procedure FilterNameChanged (); stdcall;

	procedure FilterPermanenceChanged (); stdcall;

	procedure FiltersChanged (); stdcall;
end;

IFilterFromQuery = interface (IInterface) ['{A81EFF04-FAB6-4D1B-846B-66C301594470}']
	function DontUseMe: Pointer;
	function GetChangeable (): Bytebool; stdcall;

	// ������������� ����� ��������, ����� ���������������� ������������� ������� (�274848126)
	function GetId (): Longword; stdcall;

	// ���������� true, ���� ������������ � ���������� ������� ���������
	function IsSame (
		const aOther: IFilterFromQuery
	): Bytebool; stdcall;

	// ������� �� ������
	function IsUsed (): Bytebool; stdcall;

	// ������� ������ ����� ����, ��� �� ���������� ��������������
	procedure MarkToErase (); stdcall;

	function MarkedToErase (): Bytebool; stdcall;

	procedure GetName (out aRet {: IString}); stdcall;
	procedure SetName (const aName: IString); stdcall;

	function GetPermanent (): Bytebool; stdcall;
	procedure SetPermanent (aPermanent: Bytebool); stdcall;

	// ���� ������ query Search::Query, ������� �� � ��������, �� ������ ���������� ������ �����������
	// ������, ������� �������� ����� ���������
	procedure GetQuery (out aRet {: IEntityBase}); stdcall;
end;

IFiltersFromQuery = interface(IInterface)
['{85F5B5FA-3FFE-470E-9F0B-157765264E5D}']
    function  pm_GetCount: Integer; stdcall;
    procedure pm_SetCount(aValue: Integer); stdcall;
      { - ������ ��� ������� � �������� Count. }
    procedure Clear; stdcall;
      {* �������� ������. }
    procedure Delete(anIndex: Integer); stdcall;
      {* ������� ������� �� ������� Index. }
    property Count: Integer
      read pm_GetCount
      write pm_SetCount;
       {* ����� ��������� � ���������. }
  // property methods
    procedure  pm_GetItem(anIndex: Integer; out aRet: IFilterFromQuery); stdcall;

    procedure pm_SetItem(anIndex: Integer; const anItem: IFilterFromQuery); stdcall;
      {-}
  // public methods
    function  Add(const anItem: IFilterFromQuery): Integer; stdcall;
      {* - ��������� ������� Item � �����. }
    procedure Insert(anIndex: Integer; const anItem: IFilterFromQuery); stdcall;
      {* - ��������� ������� Item �� ������� Index. }
end;//IFiltersFromQuery

IFiltersManager = interface (IInterface) ['{854B1550-A048-4551-AB1C-6FD08FDAF723}']
	function DontUseMe: Pointer;
	// ������� ����� ������
	procedure CreateFilter (
		const aQuery: IEntityBase;
		const aName: IString
	); stdcall;

	// �������� ������ �������� ��� �������� ����������
	procedure GetLegalFilters (
		out aRet {: IFiltersFromQuery}
	); stdcall;

	procedure GetPharmFilters (
		out aRet {: IFiltersFromQuery}
	); stdcall;

	procedure SetLegalNotifier (
		const aNotifier: IFilterNotifier
	); stdcall;

	procedure SetPharmNotifier (
		const aNotifier: IFilterNotifier
	); stdcall;
end;

implementation
end.