unit ContextSearchSupportUnit; {$Z4}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "GblAdapterLib"
// ������: "w:/garant6x/implementation/Garant/GblAdapterLib/ContextSearchSupportUnit.pas"
// Delphi ���������� ��� �������� (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::ContextSearchSupport
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

interface



type

IHighlightPositionList = interface;
{ - ��������������� �������� IHighlightPositionList. }


// ������� ��� ��������� ��������� ����.
PHighlightPosition = ^THighlightPosition;
THighlightPosition = packed record
	rStart: Longword; // ������ ���������
	rFinish: Longword; // ����� ���������
end;

// ��������� ������ �� ���������.
PContextSearchResult = ^TContextSearchResult;
TContextSearchResult = packed record
	rItemIndex: Longword; // ������ ���������� ��������.
	rPositions: IHighlightPositionList; // �������, ��������� � ���������� ������
end;

// ���� ������.
PSearchStatus = ^TSearchStatus;
TSearchStatus = (
	SS_GLOBAL // ����� �� ����� �������.
	, SS_CURENT // ����� �� �������� ��������.
);

// ����������� ������.
PSearchDirection = ^TSearchDirection;
TSearchDirection = (
	SD_UP // ���� �����.
	, SD_DOWN // ����� ����.
);

// ������������ ���, ������������ ������ ������ � �������� ���������� (�������, ������� � �.�.).
// ��������� ss_Global + sd_Up - ����� � ����� �����.
// ��������� ss_Global + sd_Down - ����� ������� ����.
// ��������� c ss_Current - ����� �� �������� �������� ����� ��� ����.
PSearchMode = ^TSearchMode;
TSearchMode = packed record
	rStatus: TSearchStatus; // ��������� ������
	rDirection: TSearchDirection; // ����������� ������
end;

IHighlightPositionList = interface(IInterface)
['{0311883B-7352-4AA9-8B38-B853D9B37FF8}']
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
    procedure  pm_GetItem(anIndex: Integer; out aRet: THighlightPosition); stdcall;

    procedure pm_SetItem(anIndex: Integer; const anItem: THighlightPosition); stdcall;
      {-}
  // public methods
    function  Add(const anItem: THighlightPosition): Integer; stdcall;
      {* - ��������� ������� Item � �����. }
    procedure Insert(anIndex: Integer; const anItem: THighlightPosition); stdcall;
      {* - ��������� ������� Item �� ������� Index. }
end;//IHighlightPositionList

implementation
end.