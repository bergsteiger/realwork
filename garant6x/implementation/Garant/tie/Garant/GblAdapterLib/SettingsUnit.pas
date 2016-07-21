unit SettingsUnit;

// ������: "w:\garant6x\implementation\Garant\tie\Garant\GblAdapterLib\SettingsUnit.pas"
// ���������: "Interfaces"
// ������� ������: "Settings" MUID: (45EEAA69036E)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , IOUnit
 , BaseTypesUnit
;

type
 TPropertyStringID = PAnsiChar;

 TPropertyType = (
  PT_LONG
  , PT_STRING
  , PT_INT64
  , PT_ULONG
  , PT_BOOLEAN
 );//TPropertyType

 TPropertyDefinition = record
  {* ��������� ������� � ���������� ���������. }
  is_unique: ByteBool;
   {* ���������� "������������" �������. ���������� �������� ����� ���������� �������� �� ���� �������������, ������� �������, ���������� �������� ������ ������������ ��� �� � ����� ����������.
���������� ������� ������ �������������� ��� �������� �� ��������� �� ������������.
�������� �� ���������: false }
  is_constant: ByteBool;
   {* ���������� ����������� ��������� �������� ���������.
�������� �� ���������: false }
  type: TPropertyType;
 end;//TPropertyDefinition

 TDefaultValuesChangesState = (
  {* ������  �������� ���������� �������� �������� � ����������������� ������������� }
  NO_CHANGES
   {* �������� �� ���������� }
  , UPDATED_WITH_COPY_ACTIVE_CONFIGURATION
   {* ������������ � ������ ����� �������� �� ��������� �������� � ����� �� ����������� (�����������������) ������������.

  - �������� ����� ������� ������������. ���: <��� ������������> + (�����������). ���� ������������ � ����� ������ ��� c��������� -- ��  (����������� 2).

  - ��� ���� ����������� ������������ ��������� ������������ � ��������  �� ���������. }
  , UPDATED_WITH_ACTIVATE_PREDEFINED_CONFIGURATION
   {* ������������ � ������ ����� �������� �������� � ����������� ������������� (������ �����������). 
  - ��� ���� ����������� ������������ ��������� ������������ � �������� �� ��������� 
  - ������������ ������������� � ��� ����������� ������������ �� "�����������" (������ � ������ �����������������) }
 );//TDefaultValuesChangesState

 InvalidValueType = class
  {* ������������ ��� ������� ��������� ��� ��������� ����� ��������� ParameterValues �������� �� ����, ������� �� ��������� � �������� ����� �������� (�������� ��� ����� �������� ����� �������� value_type). }
 end;//InvalidValueType

 TConfigurationType = (
  {* ��� ������������, ��������� ��� �����������������: ����������� � ������ 5x, ��� ��������� - ���������������� }
  CT_STANDARD
  , CT_GARANT5X
  , CT_USER
 );//TConfigurationType

 IPropertyStringIDList = array of IString;

 IBaseSettingsManager = interface
  ['{6BC8FA39-42F0-45D2-8211-D14043AD16DD}']
  function GetBool(id: TPropertyStringID;
   out value: Boolean): ByteBool; stdcall; { can raise InvalidValueType }
   {* ������ �������� ���� Boolean.
��� ������ ���������� true.
���� �������� �� ���������� ���������� false.
���� ��� �������� �� ������������� ���������� ����������� ���������� InvalidValueType }
  function GetInt64(id: TPropertyStringID;
   out value: Int64): ByteBool; stdcall; { can raise InvalidValueType }
   {* ������ �������� ���� int64.
��� ������ ���������� true.
���� �������� �� ���������� ���������� false.
���� ��� �������� �� ������������� ���������� ����������� ���������� InvalidValueType }
  function GetLong(id: TPropertyStringID;
   out value: Integer): ByteBool; stdcall; { can raise InvalidValueType }
   {* ������ �������� ���� long.
��� ������ ���������� true.
���� �������� �� ���������� ���������� false.
���� ��� �������� �� ������������� ���������� ����������� ���������� InvalidValueType }
  function GetString(id: TPropertyStringID;
   out value: IString): ByteBool; stdcall; { can raise InvalidValueType }
   {* ������ �������� ���� String.
��� ������ ���������� true.
���� �������� �� ���������� ���������� false.
���� ��� �������� �� ������������� ���������� ����������� ���������� InvalidValueType }
  function GetUlong(id: TPropertyStringID;
   out value: Cardinal): ByteBool; stdcall; { can raise InvalidValueType }
   {* ������ �������� ���� unsigned long.
��� ������ ���������� true.
���� �������� �� ���������� ���������� false.
���� ��� �������� �� ������������� ���������� ����������� ���������� InvalidValueType }
  procedure SetBool(id: TPropertyStringID;
   value: Boolean); stdcall; { can raise InvalidValueType }
   {* ������ �������� ���� Boolean.
���� �������� �� ����������, �� ��� ��������� � ������� ������������, value ������������ ��� �������� �� ��������� � ��� ������� ��������.
���� ��� �������� �� ������������� ���������������� ����������� ���������� InvalidValueType }
  procedure SetInt64(id: TPropertyStringID;
   value: Int64); stdcall; { can raise InvalidValueType }
   {* ������ �������� ���� int64.
���� �������� �� ����������, �� ��� ��������� � ������� ������������, value ������������ ��� �������� �� ��������� � ��� ������� ��������.
���� ��� �������� �� ������������� ���������������� ����������� ���������� InvalidValueType }
  procedure SetLong(id: TPropertyStringID;
   value: Integer); stdcall; { can raise InvalidValueType }
   {* ������ �������� ���� long.
���� �������� �� ����������, �� ��� ��������� � ������� ������������, value ������������ ��� �������� �� ��������� � ��� ������� ��������.
���� ��� �������� �� ������������� ���������������� ����������� ���������� InvalidValueType }
  procedure SetString(id: TPropertyStringID;
   value: PAnsiChar); stdcall; { can raise InvalidValueType }
   {* ������ �������� ���� String.
���� �������� �� ����������, �� ��� ��������� � ������� ������������, value ������������ ��� �������� �� ��������� � ��� ������� ��������.
���� ��� �������� �� ������������� ���������������� ����������� ���������� InvalidValueType }
  procedure SetUlong(id: TPropertyStringID;
   value: Cardinal); stdcall; { can raise InvalidValueType }
   {* ������ �������� ���� unsigned long.
���� �������� �� ����������, �� ��� ��������� � ������� ������������, value ������������ ��� �������� �� ��������� � ��� ������� ��������.
���� ��� �������� �� ������������� ���������������� ����������� ���������� InvalidValueType }
  function IsExist(id: TPropertyStringID): ByteBool; stdcall;
   {* ���������� true, ���� �������� � ����� ������ ���������� }
 end;//IBaseSettingsManager

 ISettingsManager = interface(IBaseSettingsManager)
  {* ��������� ������ � �����������. ������������ �������� ����� ������� � �� ���������. �������� ��������������� ��������� ���������������. 
��������� ����� ���� ������� 
1. �� ���������� Common, � ���� ������ �� ������������ ������ � ��������� �������� ������������.
2. �� ���������� Configuration, � ���� ������ �������������� ������ �� ���������� ���������� ������������. }
  ['{C2012FB8-DEC6-408A-8937-3D7E13CBC830}']
  procedure RestoreDefault(id: TPropertyStringID); stdcall; { can raise CanNotFindData }
   {* ������������� ���������� �������� ������� �������� ������� �������� �� ��������� }
  procedure SaveAsDefault(id: TPropertyStringID); stdcall; { can raise CanNotFindData }
   {* ���������� ������� �������� �������� � ��������  ��� �������� �� ��������� }
  function GetDefinition(id: TPropertyStringID;
   var definition: TPropertyDefinition): ByteBool; stdcall;
   {* ���������� ��������� � ���������� ��������� }
  function IsChanged(id: TPropertyStringID): ByteBool; stdcall;
   {* ���������� true, ���� ������� �������� �� ����� �������� �� ���������, � ��������� ������ ���������� false }
  function IsChangedSet(const id_list: IPropertyStringIDList): ByteBool; stdcall;
 end;//ISettingsManager

 ConfigurationIsActiveNow = class
 end;//ConfigurationIsActiveNow

 IConfiguration = interface
  {* ��������� �������������� ������ � ���������� �������������, �������� ��������� ������ ������������. }
  ['{CB09ACB5-D582-477A-8D4F-98FC3766A1F9}']
  procedure GetName; stdcall;
  procedure SetName(const aValue); stdcall;
  procedure GetHint; stdcall;
  procedure SetHint(const aValue); stdcall;
  function GetType: TConfigurationType; stdcall;
  function GetIsReadonly: ByteBool; stdcall;
  function GetId: Cardinal; stdcall;
  procedure RestoreDefaultValues; stdcall;
   {* ������������� ��� ���� ������� ������������ ��������� �������� }
  procedure SaveValuesAsDefault; stdcall;
   {* ���������� ������� �������� ��� ���� ������� � �������� �������� �� ��������� }
  procedure Copy(out aRet
   {* IConfiguration }); stdcall;
   {* ���������� ����� ������������ }
  procedure GetSettings(out aRet
   {* ISettingsManager }); stdcall;
  property Name: 
   read GetName
   write SetName;
   {* ��� ������������ }
  property Hint: 
   read GetHint
   write SetHint;
   {* ����������� ��� ��������� � ������������ }
  property Type: TConfigurationType
   read GetType;
  property IsReadonly: ByteBool
   read GetIsReadonly;
   {* ���������� ����������� ��������� �������� �� ��������� ��� ������������ }
  property Id: Cardinal
   read GetId;
 end;//IConfiguration

 ConfigurationsNotDefined = class
 end;//ConfigurationsNotDefined

 IDefaultValuesChangesIndicator = interface
  {* ��������� �������� ���������� �������� �������� � ����������������� �������������

���� sate == UPDATED_WITH_COPY_ACTIVE_CONFIGURATION, �� configuration �������� ����� ��������� ���������������� ������������ - ����� �������� �����������������

���� state == UPDATED_WITH_ACTIVATE_PREDEFINED_CONFIGURATION, �� configuration �������� �����������������, �� ������� ����������� ������������ }
  ['{168D579E-071E-4626-93BD-7566FCAB780E}']
  function GetState: TDefaultValuesChangesState; stdcall;
  procedure GetConfiguration; stdcall;
  property State: TDefaultValuesChangesState
   read GetState;
  property Configuration: 
   read GetConfiguration;
 end;//IDefaultValuesChangesIndicator

 IConfigurations = array of IConfiguration;

 IConfigurationManager = interface
  {* ��������� �������������� ������ �� ������� ������������. �������� ����� ��������� Common. }
  ['{C0C7A25C-7378-40EA-9593-32B590CC6D8E}']
  procedure GetConfigurations; stdcall;
  procedure SetActive(const configuration: IConfiguration); stdcall;
   {* ������������� �������� ������������� �������� (������� ��� ���������� Settings, ����������� ����� Common) }
  procedure Remove(const configuration: IConfiguration); stdcall; { can raise ConstantModify, ConfigurationIsActiveNow }
   {* ������� �������� ������������. � ������ ������� ������� �������� ������������ ���������� ���������� ConfigurationIsActiveNow }
  procedure GetActive(out aRet
   {* IConfiguration }); stdcall;
   {* ���������� �������� ������������ }
  procedure DefaultValuesUpdateCheck(out aRet
   {* IDefaultValuesChangesIndicator }); stdcall;
  function GetActiveId: Integer; stdcall;
   {* ���������� ������������� �������� ������������ }
  procedure Logout; stdcall;
   {* ����� �������� ��� ������ �� ������� }
  property Configurations: 
   read GetConfigurations;
 end;//IConfigurationManager

 IPermanentSettingsManager = interface(IBaseSettingsManager)
  {* ���������, �� ��������� �� ������������ }
  ['{4983A1B9-5021-4CE1-8C13-912831395FB8}']
 end;//IPermanentSettingsManager

implementation

uses
 l3ImplUses
;

end.
