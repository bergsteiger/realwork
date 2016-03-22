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
  is_unique: Boolean;
   {* ���������� "������������" �������. ���������� �������� ����� ���������� �������� �� ���� �������������, ������� �������, ���������� �������� ������ ������������ ��� �� � ����� ����������.
���������� ������� ������ �������������� ��� �������� �� ��������� �� ������������.
�������� �� ���������: false }
  is_constant: Boolean;
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
  function get_bool(id: TPropertyStringID;
   out value: Boolean): Boolean; { can raise InvalidValueType }
   {* ������ �������� ���� Boolean.
��� ������ ���������� true.
���� �������� �� ���������� ���������� false.
���� ��� �������� �� ������������� ���������� ����������� ���������� InvalidValueType }
  function get_int64(id: TPropertyStringID;
   out value: Int64): Boolean; { can raise InvalidValueType }
   {* ������ �������� ���� int64.
��� ������ ���������� true.
���� �������� �� ���������� ���������� false.
���� ��� �������� �� ������������� ���������� ����������� ���������� InvalidValueType }
  function get_long(id: TPropertyStringID;
   out value: Integer): Boolean; { can raise InvalidValueType }
   {* ������ �������� ���� long.
��� ������ ���������� true.
���� �������� �� ���������� ���������� false.
���� ��� �������� �� ������������� ���������� ����������� ���������� InvalidValueType }
  function get_string(id: TPropertyStringID;
   out value: IString): Boolean; { can raise InvalidValueType }
   {* ������ �������� ���� String.
��� ������ ���������� true.
���� �������� �� ���������� ���������� false.
���� ��� �������� �� ������������� ���������� ����������� ���������� InvalidValueType }
  function get_ulong(id: TPropertyStringID;
   out value: Cardinal): Boolean; { can raise InvalidValueType }
   {* ������ �������� ���� unsigned long.
��� ������ ���������� true.
���� �������� �� ���������� ���������� false.
���� ��� �������� �� ������������� ���������� ����������� ���������� InvalidValueType }
  procedure set_bool(id: TPropertyStringID;
   value: Boolean); { can raise InvalidValueType }
   {* ������ �������� ���� Boolean.
���� �������� �� ����������, �� ��� ��������� � ������� ������������, value ������������ ��� �������� �� ��������� � ��� ������� ��������.
���� ��� �������� �� ������������� ���������������� ����������� ���������� InvalidValueType }
  procedure set_int64(id: TPropertyStringID;
   value: Int64); { can raise InvalidValueType }
   {* ������ �������� ���� int64.
���� �������� �� ����������, �� ��� ��������� � ������� ������������, value ������������ ��� �������� �� ��������� � ��� ������� ��������.
���� ��� �������� �� ������������� ���������������� ����������� ���������� InvalidValueType }
  procedure set_long(id: TPropertyStringID;
   value: Integer); { can raise InvalidValueType }
   {* ������ �������� ���� long.
���� �������� �� ����������, �� ��� ��������� � ������� ������������, value ������������ ��� �������� �� ��������� � ��� ������� ��������.
���� ��� �������� �� ������������� ���������������� ����������� ���������� InvalidValueType }
  procedure set_string(id: TPropertyStringID;
   value: PAnsiChar); { can raise InvalidValueType }
   {* ������ �������� ���� String.
���� �������� �� ����������, �� ��� ��������� � ������� ������������, value ������������ ��� �������� �� ��������� � ��� ������� ��������.
���� ��� �������� �� ������������� ���������������� ����������� ���������� InvalidValueType }
  procedure set_ulong(id: TPropertyStringID;
   value: Cardinal); { can raise InvalidValueType }
   {* ������ �������� ���� unsigned long.
���� �������� �� ����������, �� ��� ��������� � ������� ������������, value ������������ ��� �������� �� ��������� � ��� ������� ��������.
���� ��� �������� �� ������������� ���������������� ����������� ���������� InvalidValueType }
  function is_exist(id: TPropertyStringID): Boolean;
   {* ���������� true, ���� �������� � ����� ������ ���������� }
 end;//IBaseSettingsManager

 ISettingsManager = interface(IBaseSettingsManager)
  {* ��������� ������ � �����������. ������������ �������� ����� ������� � �� ���������. �������� ��������������� ��������� ���������������. 
��������� ����� ���� ������� 
1. �� ���������� Common, � ���� ������ �� ������������ ������ � ��������� �������� ������������.
2. �� ���������� Configuration, � ���� ������ �������������� ������ �� ���������� ���������� ������������. }
  ['{C2012FB8-DEC6-408A-8937-3D7E13CBC830}']
  procedure restore_default(id: TPropertyStringID); { can raise CanNotFindData }
   {* ������������� ���������� �������� ������� �������� ������� �������� �� ��������� }
  procedure save_as_default(id: TPropertyStringID); { can raise CanNotFindData }
   {* ���������� ������� �������� �������� � ��������  ��� �������� �� ��������� }
  function get_definition(id: TPropertyStringID;
   var definition: TPropertyDefinition): Boolean;
   {* ���������� ��������� � ���������� ��������� }
  function is_changed(id: TPropertyStringID): Boolean;
   {* ���������� true, ���� ������� �������� �� ����� �������� �� ���������, � ��������� ������ ���������� false }
  function is_changed_set(const id_list: IPropertyStringIDList): Boolean;
 end;//ISettingsManager

 ConfigurationIsActiveNow = class
 end;//ConfigurationIsActiveNow

 IConfiguration = interface
  {* ��������� �������������� ������ � ���������� �������������, �������� ��������� ������ ������������. }
  ['{CB09ACB5-D582-477A-8D4F-98FC3766A1F9}']
  function Get_name: IString;
  procedure Set_name(const aValue: IString);
  function Get_hint: IString;
  procedure Set_hint(const aValue: IString);
  function Get_type: TConfigurationType;
  function Get_is_readonly: Boolean;
  function Get_id: Cardinal;
  procedure restore_default_values;
   {* ������������� ��� ���� ������� ������������ ��������� �������� }
  procedure save_values_as_default;
   {* ���������� ������� �������� ��� ���� ������� � �������� �������� �� ��������� }
  function copy: IConfiguration;
   {* ���������� ����� ������������ }
  function get_settings: ISettingsManager;
  property name: IString
   read Get_name
   write Set_name;
   {* ��� ������������ }
  property hint: IString
   read Get_hint
   write Set_hint;
   {* ����������� ��� ��������� � ������������ }
  property type: TConfigurationType
   read Get_type;
  property is_readonly: Boolean
   read Get_is_readonly;
   {* ���������� ����������� ��������� �������� �� ��������� ��� ������������ }
  property id: Cardinal
   read Get_id;
 end;//IConfiguration

 ConfigurationsNotDefined = class
 end;//ConfigurationsNotDefined

 IDefaultValuesChangesIndicator = interface
  {* ��������� �������� ���������� �������� �������� � ����������������� �������������

���� sate == UPDATED_WITH_COPY_ACTIVE_CONFIGURATION, �� configuration �������� ����� ��������� ���������������� ������������ - ����� �������� �����������������

���� state == UPDATED_WITH_ACTIVATE_PREDEFINED_CONFIGURATION, �� configuration �������� �����������������, �� ������� ����������� ������������ }
  ['{168D579E-071E-4626-93BD-7566FCAB780E}']
  function Get_state: TDefaultValuesChangesState;
  function Get_configuration: IConfiguration;
  property state: TDefaultValuesChangesState
   read Get_state;
  property configuration: IConfiguration
   read Get_configuration;
 end;//IDefaultValuesChangesIndicator

 IConfigurations = array of IConfiguration;

 IConfigurationManager = interface
  {* ��������� �������������� ������ �� ������� ������������. �������� ����� ��������� Common. }
  ['{C0C7A25C-7378-40EA-9593-32B590CC6D8E}']
  function Get_configurations: IConfigurations;
  procedure set_active(const configuration: IConfiguration);
   {* ������������� �������� ������������� �������� (������� ��� ���������� Settings, ����������� ����� Common) }
  procedure remove(const configuration: IConfiguration); { can raise ConstantModify, ConfigurationIsActiveNow }
   {* ������� �������� ������������. � ������ ������� ������� �������� ������������ ���������� ���������� ConfigurationIsActiveNow }
  function get_active: IConfiguration;
   {* ���������� �������� ������������ }
  function default_values_update_check: IDefaultValuesChangesIndicator;
  function get_active_id: Integer;
   {* ���������� ������������� �������� ������������ }
  procedure logout;
   {* ����� �������� ��� ������ �� ������� }
  property configurations: IConfigurations
   read Get_configurations;
 end;//IConfigurationManager

 IPermanentSettingsManager = interface(IBaseSettingsManager)
  {* ���������, �� ��������� �� ������������ }
  ['{4983A1B9-5021-4CE1-8C13-912831395FB8}']
 end;//IPermanentSettingsManager

class function make: BadFactoryType; { can raise NoSession }
class function make(id: Integer;
 const name: IString;
 const hint: IString;
 readonly: Boolean): BadFactoryType;
class function make(state: TDefaultValuesChangesState;
 const configuration: IConfiguration): BadFactoryType;
class function make: BadFactoryType;
class function make: BadFactoryType;

implementation

uses
 l3ImplUses
;

class function make: BadFactoryType; { can raise NoSession }
var
 l_Inst : ISettingsManager;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//make

class function make(id: Integer;
 const name: IString;
 const hint: IString;
 readonly: Boolean): BadFactoryType;
var
 l_Inst : IConfiguration;
begin
 l_Inst := Create(id, name, hint, readonly);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//make

class function make(state: TDefaultValuesChangesState;
 const configuration: IConfiguration): BadFactoryType;
var
 l_Inst : IDefaultValuesChangesIndicator;
begin
 l_Inst := Create(state, configuration);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//make

class function make: BadFactoryType;
var
 l_Inst : IConfigurationManager;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//make

class function make: BadFactoryType;
var
 l_Inst : IPermanentSettingsManager;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//make

end.
