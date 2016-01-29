unit SettingsUnit;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "GblAdapterLib"
// ������: "w:/garant6x/implementation/Garant/tie/Garant/GblAdapterLib/SettingsUnit.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::Settings
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
  BaseTypesUnit
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
   is_unique : Boolean; // ���������� "������������" �������. ���������� �������� ����� ���������� �������� �� ���� �������������, ������� �������, ���������� �������� ������ ������������ ��� �� � ����� ����������.
���������� ������� ������ �������������� ��� �������� �� ��������� �� ������������.
�������� �� ���������: false
   is_constant : Boolean; // ���������� ����������� ��������� �������� ���������.
�������� �� ���������: false
   type : TPropertyType;
 end;//TPropertyDefinition

 TDefaultValuesChangesState = (
  {* ������  �������� ���������� �������� �������� � ����������������� ������������� }
   NO_CHANGES // �������� �� ����������
 , UPDATED_WITH_COPY_ACTIVE_CONFIGURATION // ������������ � ������ ����� �������� �� ��������� �������� � ����� �� ����������� (�����������������) ������������.    - �������� ����� ������� ������������. ���: <��� ������������> + (�����������). ���� ������������ � ����� ������ ��� c��������� -- ��  (����������� 2).    - ��� ���� ����������� ������������ ��������� ������������ � ��������  �� ���������.
 , UPDATED_WITH_ACTIVATE_PREDEFINED_CONFIGURATION // ������������ � ������ ����� �������� �������� � ����������� ������������� (������ �����������).    - ��� ���� ����������� ������������ ��������� ������������ � �������� �� ���������    - ������������ ������������� � ��� ����������� ������������ �� "�����������" (������ � ������ �����������������)
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

 IBaseSettingsManager = interface(IUnknown)
   ['{6BC8FA39-42F0-45D2-8211-D14043AD16DD}']
   function GetBool(aId: TPropertyStringID;
    out aValue: Boolean): ByteBool; stdcall; // can raise InvalidValueType
     {* ������ �������� ���� Boolean.
��� ������ ���������� true.
���� �������� �� ���������� ���������� false.
���� ��� �������� �� ������������� ���������� ����������� ���������� InvalidValueType }
   function GetInt64(aId: TPropertyStringID;
    out aValue: Int64): ByteBool; stdcall; // can raise InvalidValueType
     {* ������ �������� ���� int64.
��� ������ ���������� true.
���� �������� �� ���������� ���������� false.
���� ��� �������� �� ������������� ���������� ����������� ���������� InvalidValueType }
   function GetLong(aId: TPropertyStringID;
    out aValue: Integer): ByteBool; stdcall; // can raise InvalidValueType
     {* ������ �������� ���� long.
��� ������ ���������� true.
���� �������� �� ���������� ���������� false.
���� ��� �������� �� ������������� ���������� ����������� ���������� InvalidValueType }
   function GetString(aId: TPropertyStringID;
    out aValue: IString): ByteBool; stdcall; // can raise InvalidValueType
     {* ������ �������� ���� String.
��� ������ ���������� true.
���� �������� �� ���������� ���������� false.
���� ��� �������� �� ������������� ���������� ����������� ���������� InvalidValueType }
   function GetUlong(aId: TPropertyStringID;
    out aValue: Cardinal): ByteBool; stdcall; // can raise InvalidValueType
     {* ������ �������� ���� unsigned long.
��� ������ ���������� true.
���� �������� �� ���������� ���������� false.
���� ��� �������� �� ������������� ���������� ����������� ���������� InvalidValueType }
   procedure SetBool(aId: TPropertyStringID;
    aValue: Boolean); stdcall; // can raise InvalidValueType
     {* ������ �������� ���� Boolean.
���� �������� �� ����������, �� ��� ��������� � ������� ������������, value ������������ ��� �������� �� ��������� � ��� ������� ��������.
���� ��� �������� �� ������������� ���������������� ����������� ���������� InvalidValueType }
   procedure SetInt64(aId: TPropertyStringID;
    aValue: Int64); stdcall; // can raise InvalidValueType
     {* ������ �������� ���� int64.
���� �������� �� ����������, �� ��� ��������� � ������� ������������, value ������������ ��� �������� �� ��������� � ��� ������� ��������.
���� ��� �������� �� ������������� ���������������� ����������� ���������� InvalidValueType }
   procedure SetLong(aId: TPropertyStringID;
    aValue: Integer); stdcall; // can raise InvalidValueType
     {* ������ �������� ���� long.
���� �������� �� ����������, �� ��� ��������� � ������� ������������, value ������������ ��� �������� �� ��������� � ��� ������� ��������.
���� ��� �������� �� ������������� ���������������� ����������� ���������� InvalidValueType }
   procedure SetString(aId: TPropertyStringID;
    aValue: PAnsiChar); stdcall; // can raise InvalidValueType
     {* ������ �������� ���� String.
���� �������� �� ����������, �� ��� ��������� � ������� ������������, value ������������ ��� �������� �� ��������� � ��� ������� ��������.
���� ��� �������� �� ������������� ���������������� ����������� ���������� InvalidValueType }
   procedure SetUlong(aId: TPropertyStringID;
    aValue: Cardinal); stdcall; // can raise InvalidValueType
     {* ������ �������� ���� unsigned long.
���� �������� �� ����������, �� ��� ��������� � ������� ������������, value ������������ ��� �������� �� ��������� � ��� ������� ��������.
���� ��� �������� �� ������������� ���������������� ����������� ���������� InvalidValueType }
   function IsExist(aId: TPropertyStringID): ByteBool; stdcall;
     {* ���������� true, ���� �������� � ����� ������ ���������� }
 end;//IBaseSettingsManager

 ISettingsManager = interface(IBaseSettingsManager)
  {* ��������� ������ � �����������. ������������ �������� ����� ������� � �� ���������. �������� ��������������� ��������� ���������������. 
��������� ����� ���� ������� 
1. �� ���������� Common, � ���� ������ �� ������������ ������ � ��������� �������� ������������.
2. �� ���������� Configuration, � ���� ������ �������������� ������ �� ���������� ���������� ������������. }
   ['{C2012FB8-DEC6-408A-8937-3D7E13CBC830}']
   procedure RestoreDefault(aId: TPropertyStringID); stdcall; // can raise CanNotFindData
     {* ������������� ���������� �������� ������� �������� ������� �������� �� ��������� }
   procedure SaveAsDefault(aId: TPropertyStringID); stdcall; // can raise CanNotFindData
     {* ���������� ������� �������� �������� � ��������  ��� �������� �� ��������� }
   function GetDefinition(aId: TPropertyStringID;
    var aDefinition: TPropertyDefinition): ByteBool; stdcall;
     {* ���������� ��������� � ���������� ��������� }
   function IsChanged(aId: TPropertyStringID): ByteBool; stdcall;
     {* ���������� true, ���� ������� �������� �� ����� �������� �� ���������, � ��������� ������ ���������� false }
   function IsChangedSet(const aIdList: IPropertyStringIDList): ByteBool; stdcall;
 end;//ISettingsManager

 ConfigurationIsActiveNow = class
 end;//ConfigurationIsActiveNow

 IConfiguration = interface(IUnknown)
  {* ��������� �������������� ������ � ���������� �������������, �������� ��������� ������ ������������. }
   ['{CB09ACB5-D582-477A-8D4F-98FC3766A1F9}']
   function GetName: IString; stdcall;
   procedure SetName(const aValue: IString); stdcall;
   function GetHint: IString; stdcall;
   procedure SetHint(const aValue: IString); stdcall;
   function GetType: TConfigurationType; stdcall;
   function GetIsReadonly: ByteBool; stdcall;
   function GetId: Cardinal; stdcall;
   procedure RestoreDefaultValues; stdcall;
     {* ������������� ��� ���� ������� ������������ ��������� �������� }
   procedure SaveValuesAsDefault; stdcall;
     {* ���������� ������� �������� ��� ���� ������� � �������� �������� �� ��������� }
   procedure Copy(out aRet {: IConfiguration}); stdcall;
     {* ���������� ����� ������������ }
   procedure GetSettings(out aRet {: ISettingsManager}); stdcall;
   property name: IString
     read GetName
     write SetName;
     {* ��� ������������ }
   property hint: IString
     read GetHint
     write SetHint;
     {* ����������� ��� ��������� � ������������ }
   property type: TConfigurationType
     read GetType;
   property is_readonly: ByteBool
     read GetIsReadonly;
     {* ���������� ����������� ��������� �������� �� ��������� ��� ������������ }
   property id: Cardinal
     read GetId;
 end;//IConfiguration

 ConfigurationsNotDefined = class
 end;//ConfigurationsNotDefined

 IDefaultValuesChangesIndicator = interface(IUnknown)
  {* ��������� �������� ���������� �������� �������� � ����������������� �������������

���� sate == UPDATED_WITH_COPY_ACTIVE_CONFIGURATION, �� configuration �������� ����� ��������� ���������������� ������������ - ����� �������� �����������������

���� state == UPDATED_WITH_ACTIVATE_PREDEFINED_CONFIGURATION, �� configuration �������� �����������������, �� ������� ����������� ������������ }
   ['{168D579E-071E-4626-93BD-7566FCAB780E}']
   function GetState: TDefaultValuesChangesState; stdcall;
   function GetConfiguration: IConfiguration; stdcall;
   property state: TDefaultValuesChangesState
     read GetState;
   property configuration: IConfiguration
     read GetConfiguration;
 end;//IDefaultValuesChangesIndicator

 IConfigurations = array of IConfiguration;

 IConfigurationManager = interface(IUnknown)
  {* ��������� �������������� ������ �� ������� ������������. �������� ����� ��������� Common. }
   ['{C0C7A25C-7378-40EA-9593-32B590CC6D8E}']
   function GetConfigurations: IConfigurations; stdcall;
   procedure SetActive(const aConfiguration: IConfiguration); stdcall;
     {* ������������� �������� ������������� �������� (������� ��� ���������� Settings, ����������� ����� Common) }
   procedure Remove(const aConfiguration: IConfiguration); stdcall; // can raise ConstantModify, ConfigurationIsActiveNow
     {* ������� �������� ������������. � ������ ������� ������� �������� ������������ ���������� ���������� ConfigurationIsActiveNow }
   procedure GetActive(out aRet {: IConfiguration}); stdcall;
     {* ���������� �������� ������������ }
   procedure DefaultValuesUpdateCheck(out aRet {: IDefaultValuesChangesIndicator}); stdcall;
   function GetActiveId: Integer; stdcall;
     {* ���������� ������������� �������� ������������ }
   procedure Logout; stdcall;
     {* ����� �������� ��� ������ �� ������� }
   property configurations: IConfigurations
     read GetConfigurations;
 end;//IConfigurationManager

 IPermanentSettingsManager = interface(IBaseSettingsManager)
  {* ���������, �� ��������� �� ������������ }
   ['{4983A1B9-5021-4CE1-8C13-912831395FB8}']
 end;//IPermanentSettingsManager

implementation

end.