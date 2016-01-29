unit SettingsUnit; {$Z4}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "GblAdapterLib"
// ������: "w:/garant6x/implementation/Garant/GblAdapterLib/SettingsUnit.pas"
// Delphi ���������� ��� �������� (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::Settings
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
	//#UC START# *4423F94903C8_45EEAA69036E_UNIT_FOR_Stream*
	//#UC END# *4423F94903C8_45EEAA69036E_UNIT_FOR_Stream*
	;

type

IPropertyStringIDList = interface;
{ - ��������������� �������� IPropertyStringIDList. }

IBaseSettingsManager = interface;
{ - ��������������� �������� IBaseSettingsManager. }

ISettingsManager = interface;
{ - ��������������� �������� ISettingsManager. }

IConfiguration = interface;
{ - ��������������� �������� IConfiguration. }

IDefaultValuesChangesIndicator = interface;
{ - ��������������� �������� IDefaultValuesChangesIndicator. }

IConfigurations = interface;
{ - ��������������� �������� IConfigurations. }

IConfigurationManager = interface;
{ - ��������������� �������� IConfigurationManager. }

IPermanentSettingsManager = interface;
{ - ��������������� �������� IPermanentSettingsManager. }


PPropertyStringID = ^TPropertyStringID;
TPropertyStringID = PAnsiChar;

PPropertyType = ^TPropertyType;
TPropertyType = (
	PT_LONG
	, PT_STRING
	, PT_INT64
	, PT_ULONG
	, PT_BOOLEAN
);

// ��������� ������� � ���������� ���������.
PPropertyDefinition = ^TPropertyDefinition;
TPropertyDefinition = packed record
	rIsUnique: Bytebool; // ���������� "������������" �������. ���������� �������� ����� ���������� �������� �� ���� �������������, ������� �������, ���������� �������� ������ ������������ ��� �� � ����� ����������.���������� ������� ������ �������������� ��� �������� �� ��������� �� ������������.�������� �� ���������: false
	rIsConstant: Bytebool; // ���������� ����������� ��������� �������� ���������.�������� �� ���������: false
	rType: TPropertyType;
end;

// ������  �������� ���������� �������� �������� � ����������������� �������������
PDefaultValuesChangesState = ^TDefaultValuesChangesState;
TDefaultValuesChangesState = (
	NO_CHANGES // �������� �� ����������
	, UPDATED_WITH_COPY_ACTIVE_CONFIGURATION // ������������ � ������ ����� �������� �� ��������� �������� � ����� �� ����������� (�����������������) ������������.    - �������� ����� ������� ������������. ���: <��� ������������> + (�����������). ���� ������������ � ����� ������ ��� c��������� -- ��  (����������� 2).    - ��� ���� ����������� ������������ ��������� ������������ � ��������  �� ���������.
	, UPDATED_WITH_ACTIVATE_PREDEFINED_CONFIGURATION // ������������ � ������ ����� �������� �������� � ����������� ������������� (������ �����������).    - ��� ���� ����������� ������������ ��������� ������������ � �������� �� ���������    - ������������ ������������� � ��� ����������� ������������ �� "�����������" (������ � ������ �����������������)
);

// ������������ ��� ������� ��������� ��� ��������� ����� ��������� ParameterValues �������� ��
// ����, ������� �� ��������� � �������� ����� �������� (�������� ��� ����� �������� ����� ��������
// value_type).
EInvalidValueType = class (Exception);

// ��� ������������, ��������� ��� �����������������: ����������� � ������ 5x, ��� ��������� -
// ����������������
PConfigurationType = ^TConfigurationType;
TConfigurationType = (
	CT_STANDARD
	, CT_GARANT5X
	, CT_USER
);

EConfigurationIsActiveNow = class (Exception);

EConfigurationsNotDefined = class (Exception);

IPropertyStringIDList = interface(IInterface)
['{DCCE2630-0409-48AF-A7B9-567B081CB9DE}']
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
    procedure  pm_GetItem(anIndex: Integer; out aRet: IString); stdcall;

    procedure pm_SetItem(anIndex: Integer; const anItem: IString); stdcall;
      {-}
  // public methods
    function  Add(const anItem: IString): Integer; stdcall;
      {* - ��������� ������� Item � �����. }
    procedure Insert(anIndex: Integer; const anItem: IString); stdcall;
      {* - ��������� ������� Item �� ������� Index. }
end;//IPropertyStringIDList

IBaseSettingsManager = interface (IInterface) ['{6BC8FA39-42F0-45D2-8211-D14043AD16DD}']
	function DontUseMe: Pointer;
	// ������ �������� ���� Boolean.
	// ��� ������ ���������� true.
	// ���� �������� �� ���������� ���������� false.
	// ���� ��� �������� �� ������������� ���������� ����������� ���������� InvalidValueType
	function GetBool (
		const aId: TPropertyStringID;
		out aValue: Bytebool
	): Bytebool; stdcall; // can raise EInvalidValueType

	// ������ �������� ���� int64.
	// ��� ������ ���������� true.
	// ���� �������� �� ���������� ���������� false.
	// ���� ��� �������� �� ������������� ���������� ����������� ���������� InvalidValueType
	function GetInt64 (
		const aId: TPropertyStringID;
		out aValue: Int64
	): Bytebool; stdcall; // can raise EInvalidValueType

	// ������ �������� ���� long.
	// ��� ������ ���������� true.
	// ���� �������� �� ���������� ���������� false.
	// ���� ��� �������� �� ������������� ���������� ����������� ���������� InvalidValueType
	function GetLong (
		const aId: TPropertyStringID;
		out aValue: Longint
	): Bytebool; stdcall; // can raise EInvalidValueType

	// ������ �������� ���� String.
	// ��� ������ ���������� true.
	// ���� �������� �� ���������� ���������� false.
	// ���� ��� �������� �� ������������� ���������� ����������� ���������� InvalidValueType
	function GetString (
		const aId: TPropertyStringID;
		out aValue {: IString}
	): Bytebool; stdcall; // can raise EInvalidValueType

	// ������ �������� ���� unsigned long.
	// ��� ������ ���������� true.
	// ���� �������� �� ���������� ���������� false.
	// ���� ��� �������� �� ������������� ���������� ����������� ���������� InvalidValueType
	function GetUlong (
		const aId: TPropertyStringID;
		out aValue: Longword
	): Bytebool; stdcall; // can raise EInvalidValueType

	// ���������� true, ���� �������� � ����� ������ ����������
	function IsExist (
		const aId: TPropertyStringID
	): Bytebool; stdcall;

	// ������ �������� ���� Boolean.
	// ���� �������� �� ����������, �� ��� ��������� � ������� ������������, value ������������ ���
	// �������� �� ��������� � ��� ������� ��������.
	// ���� ��� �������� �� ������������� ���������������� ����������� ���������� InvalidValueType
	procedure SetBool (
		const aId: TPropertyStringID;
		aValue: Bytebool
	); stdcall; // can raise EInvalidValueType

	// ������ �������� ���� int64.
	// ���� �������� �� ����������, �� ��� ��������� � ������� ������������, value ������������ ���
	// �������� �� ��������� � ��� ������� ��������.
	// ���� ��� �������� �� ������������� ���������������� ����������� ���������� InvalidValueType
	procedure SetInt64 (
		const aId: TPropertyStringID;
		aValue: Int64
	); stdcall; // can raise EInvalidValueType

	// ������ �������� ���� long.
	// ���� �������� �� ����������, �� ��� ��������� � ������� ������������, value ������������ ���
	// �������� �� ��������� � ��� ������� ��������.
	// ���� ��� �������� �� ������������� ���������������� ����������� ���������� InvalidValueType
	procedure SetLong (
		const aId: TPropertyStringID;
		aValue: Longint
	); stdcall; // can raise EInvalidValueType

	// ������ �������� ���� String.
	// ���� �������� �� ����������, �� ��� ��������� � ������� ������������, value ������������ ���
	// �������� �� ��������� � ��� ������� ��������.
	// ���� ��� �������� �� ������������� ���������������� ����������� ���������� InvalidValueType
	procedure SetString (
		const aId: TPropertyStringID;
		const aValue: PAnsiChar
	); stdcall; // can raise EInvalidValueType

	// ������ �������� ���� unsigned long.
	// ���� �������� �� ����������, �� ��� ��������� � ������� ������������, value ������������ ���
	// �������� �� ��������� � ��� ������� ��������.
	// ���� ��� �������� �� ������������� ���������������� ����������� ���������� InvalidValueType
	procedure SetUlong (
		const aId: TPropertyStringID;
		aValue: Longword
	); stdcall; // can raise EInvalidValueType
end;

// ��������� ������ � �����������. ������������ �������� ����� ������� � �� ���������. ��������
// ��������������� ��������� ���������������.
// ��������� ����� ���� �������
// 1. �� ���������� Common, � ���� ������ �� ������������ ������ � ��������� �������� ������������.
// 2. �� ���������� Configuration, � ���� ������ �������������� ������ �� ���������� ����������
// ������������.
ISettingsManager = interface (IBaseSettingsManager) ['{C2012FB8-DEC6-408A-8937-3D7E13CBC830}']
	// ���������� ��������� � ���������� ���������
	function GetDefinition (
		const aId: TPropertyStringID;
		const aDefinition: TPropertyDefinition
	): Bytebool; stdcall;

	// ���������� true, ���� ������� �������� �� ����� �������� �� ���������, � ��������� ������
	// ���������� false
	function IsChanged (
		const aId: TPropertyStringID
	): Bytebool; stdcall;

	function IsChangedSet (
		const aIdList: IPropertyStringIDList
	): Bytebool; stdcall;

	// ������������� ���������� �������� ������� �������� ������� �������� �� ���������
	procedure RestoreDefault (
		const aId: TPropertyStringID
	); stdcall; // can raise ECanNotFindData

	// ���������� ������� �������� �������� � ��������  ��� �������� �� ���������
	procedure SaveAsDefault (
		const aId: TPropertyStringID
	); stdcall; // can raise ECanNotFindData
end;

// ��������� �������������� ������ � ���������� �������������, �������� ��������� ������
// ������������.
IConfiguration = interface (IInterface) ['{CB09ACB5-D582-477A-8D4F-98FC3766A1F9}']
	function DontUseMe: Pointer;
	// ���������� ����� ������������
	procedure Copy (
		out aRet {: IConfiguration}
	); stdcall;

	procedure GetSettings (
		out aRet {: ISettingsManager}
	); stdcall;

	// ����������� ��� ��������� � ������������
	procedure GetHint (out aRet {: IString}); stdcall;
	procedure SetHint (const aHint: IString); stdcall;

	function GetId (): Longword; stdcall;

	// ���������� ����������� ��������� �������� �� ��������� ��� ������������
	function GetIsReadonly (): Bytebool; stdcall;

	// ��� ������������
	procedure GetName (out aRet {: IString}); stdcall;
	procedure SetName (const aName: IString); stdcall;

	// ������������� ��� ���� ������� ������������ ��������� ��������
	procedure RestoreDefaultValues (); stdcall;

	// ���������� ������� �������� ��� ���� ������� � �������� �������� �� ���������
	procedure SaveValuesAsDefault (); stdcall;

	function GetType (): TConfigurationType; stdcall;
end;

// ��������� �������� ���������� �������� �������� � ����������������� �������������
// 
// ���� sate == UPDATED_WITH_COPY_ACTIVE_CONFIGURATION, �� configuration �������� ����� ���������
// ���������������� ������������ - ����� �������� �����������������
// 
// ���� state == UPDATED_WITH_ACTIVATE_PREDEFINED_CONFIGURATION, �� configuration ��������
// �����������������, �� ������� ����������� ������������
IDefaultValuesChangesIndicator = interface (IInterface) ['{168D579E-071E-4626-93BD-7566FCAB780E}']
	function DontUseMe: Pointer;
	procedure GetConfiguration (out aRet {: IConfiguration}); stdcall;

	function GetState (): TDefaultValuesChangesState; stdcall;
end;

IConfigurations = interface(IInterface)
['{CD0617AF-269F-4D25-9A15-52659D329272}']
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
    procedure  pm_GetItem(anIndex: Integer; out aRet: IConfiguration); stdcall;

    procedure pm_SetItem(anIndex: Integer; const anItem: IConfiguration); stdcall;
      {-}
  // public methods
    function  Add(const anItem: IConfiguration): Integer; stdcall;
      {* - ��������� ������� Item � �����. }
    procedure Insert(anIndex: Integer; const anItem: IConfiguration); stdcall;
      {* - ��������� ������� Item �� ������� Index. }
end;//IConfigurations

// ��������� �������������� ������ �� ������� ������������. �������� ����� ��������� Common.
IConfigurationManager = interface (IInterface) ['{C0C7A25C-7378-40EA-9593-32B590CC6D8E}']
	function DontUseMe: Pointer;
	procedure GetConfigurations (out aRet {: IConfigurations}); stdcall;

	procedure DefaultValuesUpdateCheck (
		out aRet {: IDefaultValuesChangesIndicator}
	); stdcall;

	// ���������� �������� ������������
	procedure GetActive (
		out aRet {: IConfiguration}
	); stdcall;

	// ������� �������� ������������. � ������ ������� ������� �������� ������������ ����������
	// ���������� ConfigurationIsActiveNow
	procedure Remove (
		const aConfiguration: IConfiguration
	); stdcall; // can raise EConstantModify, EConfigurationIsActiveNow

	// ������������� �������� ������������� �������� (������� ��� ���������� Settings, �����������
	// ����� Common)
	procedure SetActive (
		const aConfiguration: IConfiguration
	); stdcall;
end;

// ���������, �� ��������� �� ������������
IPermanentSettingsManager = interface (IBaseSettingsManager) ['{4983A1B9-5021-4CE1-8C13-912831395FB8}']

end;

implementation
end.