unit UnderControlUnit; {$Z4}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "GblAdapterLib"
// ������: "w:/garant6x/implementation/Garant/GblAdapterLib/UnderControlUnit.pas"
// Delphi ���������� ��� �������� (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::UnderControl
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

interface

uses
	SysUtils
	, IOUnit
	, DynamicTreeUnit
	//#UC START# *4423F94903C8_45EEAA800226_UNIT_FOR_Stream*
	//#UC END# *4423F94903C8_45EEAA800226_UNIT_FOR_Stream*
	;

type

IControlledObjects = interface;
{ - ��������������� �������� IControlledObjects. }

IControlManager = interface;
{ - ��������������� �������� IControlManager. }


// ���� �������� �� ��������.
PControlledItemType = ^TControlledItemType;
TControlledItemType = (
	CIT_DOCUMENT // ��������
	, CIT_LIST // ������.
	, CIT_QUERY // ������.
);

// ��������� ������� ������ ���� ���������� �� ������� ��������, ��� ����������� �� �� ���������
// �������������� ��������.
IControlledChangeNotifier = interface (IInterface) ['{939DF9FC-3E7C-4092-8B2B-307737F2583B}']
	// �������� � ��� ��� �������������� ������� ����������.
	procedure Fire (); stdcall;
end;

// ���������, ������� ������ ������������� �������� ������� ����� ������� "�� ��������". ����������
// ������ ���� ���������, ��� ��� �� ������ � ������� ������������ ���� ����������� �� ��������� �
// �������� ������ ����� ��������. ��� ���������������� ���� ������� ���������� ����� ����
// ������������� �������� �� �������, � ������� �������� �������������� ��� ������ � ���������
// ����������� ControlManager.
IControllable = interface (IInterface) ['{1E74D154-2B48-4F83-A502-B39E3CA72118}']
	function DontUseMe: Pointer;
	// ���������� true, ���� ��������� ���������� �� ��������
	function GetCanSetToControl (): Bytebool; stdcall;

	// �������� ������������, ��� ������ �������� ��������� �� ��������. ��������� �������� � true
	// �������� � ���������� �������� �� ��������, � false �������������� � ������.
	function GetControlled (): Bytebool; stdcall;
	procedure SetControlled (aControlled: Bytebool); stdcall;

	// ���������� ������� �������� ������� ���������.
	function GetControlStatus (): Longword; stdcall;

	// ��������� �������� �� ��������.
	function IsSameControllable (
		const aOther: IControllable
	): Bytebool; stdcall;

	procedure GetName (out aRet {: IString}); stdcall;

	// �������� ������ �� ��������.
	procedure Open (
		out aRet {: IUnknown}
	); stdcall;

	// ���������� ������ ��������� � ����.
	procedure ResetControlStatus (); stdcall;

	// �������� ������� �� ��������.
	procedure GetShortName (out aRet {: IString}); stdcall;

	function GetType (): TControlledItemType; stdcall;
end;

// ������ �� �� ��������.
ENotUnderControl = class (Exception);

// ������ ��� �� ��������.
EAlreadyControlled = class (Exception);

IControlledObjects = interface(IInterface)
['{9AF178A2-7F24-4517-ACFF-5DD0EBB850D4}']
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
    procedure  pm_GetItem(anIndex: Integer; out aRet: IControllable); stdcall;

    procedure pm_SetItem(anIndex: Integer; const anItem: IControllable); stdcall;
      {-}
  // public methods
    function  Add(const anItem: IControllable): Integer; stdcall;
      {* - ��������� ������� Item � �����. }
    procedure Insert(anIndex: Integer; const anItem: IControllable); stdcall;
      {* - ��������� ������� Item �� ������� Index. }
end;//IControlledObjects

// �������� �������� �� ��������.
IControlManager = interface (IInterface) ['{5EB9D0A5-C7D0-4E98-85D3-4438B5E98AAB}']
	function DontUseMe: Pointer;
	procedure GetChangedDoc (out aRet {: ICatalogBase}); stdcall;


	procedure SetControlledChangeNotifier (const aControlledChangeNotifier: IControlledChangeNotifier); stdcall;

	procedure GetControlledObjects (
		out aRet {: IControlledObjects}
	); stdcall;

	// �������� ������� �������� �� ��������.
	procedure UpdateStatus (
		aForce: Bytebool = false
	); stdcall;
end;

const

 { ������� �������� ������� ���������. }
	CS_DELETED = Longword(32);
 { �������� ������. }
	CS_ACTIVE = Longword(16);
 { �������� ������� � �������� }
	CS_CHANGED = Longword(8);
 { �������� ������� }
	CS_ABOLISHED = Longword(4);
 { �������� ������� ���� }
	CS_REGISTERED = Longword(2);
 { �������� ��������������� � ������� �� }
	CS_NOT_REGISTERED = Longword(1);
 { ��������� �������� � ����������� � ������� �� }
	CS_NONE = Longword(0);
 { �������� �� ��������� }

implementation
end.