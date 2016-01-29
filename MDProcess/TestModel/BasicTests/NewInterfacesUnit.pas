unit NewInterfacesUnit; {$Z4}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "BasicTests"
// ������: "w:/MDProcess/TestModel/BasicTests/NewInterfacesUnit.pas"
// Delphi ���������� ��� �������� (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> TestModel::BasicTests::NewInterfaces
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

interface



type

IBaseInterface = interface;
{ - ��������������� �������� IBaseInterface. }

IMySyperData = interface;
{ - ��������������� �������� IMySyperData. }

IDerivedInterface = interface;
{ - ��������������� �������� IDerivedInterface. }


INewFacet = interface (IInterface) ['{2CFA8895-40F1-4601-B8E9-52147ADB59DC}']
	function DontUseMe: Pointer;

end;

PNewStruct = ^TNewStruct;
TNewStruct = packed record
	rNewAttribute: Longint;
end;

IBaseInterface = interface (IInterface) ['{268B0A46-3C2C-4279-9154-EE5F93F50CD1}']
	function DontUseMe: Pointer;
	function GetAgrLongP (): Longint; stdcall;
	procedure SetAgrLongP (aAgrLongP: Longint); stdcall;

	procedure GetAgrStructP (out a: TNewStruct); stdcall;
	procedure SetAgrStructP (const aAgrStructP: TNewStruct); stdcall;

	function GetLnkLongP (): Longint; stdcall;
	procedure SetLnkLongP (aLnkLongP: Longint); stdcall;

	procedure GetLnkStructP (out a: TNewStruct); stdcall;
	procedure SetLnkStructP (const aLnkStructP: TNewStruct); stdcall;
end;

IMySyperData = interface(IInterface)
['{535DCDCC-E3CD-4921-AE63-3E65F3AE5DA0}']
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
    function  pm_GetItem(anIndex: Integer): Int64; stdcall;

    procedure pm_SetItem(anIndex: Integer; const anItem: Int64); stdcall;
      {-}
  // public methods
    function  Add(const anItem: Int64): Integer; stdcall;
      {* - ��������� ������� Item � �����. }
    procedure Insert(anIndex: Integer; const anItem: Int64); stdcall;
      {* - ��������� ������� Item �� ������� Index. }
  // public properties
    property  Items[anIndex: Integer]: Int64
      read pm_GetItem
      write pm_SetItem;
      default;
      {* - �������� ������. }
end;//IMySyperData

IDerivedInterface = interface (IBaseInterface) ['{19342E98-DAAF-4338-806F-19FA17807BD7}']
	procedure MyFunc (
		const aA: IMySyperData
	); stdcall;
end;

implementation
end.