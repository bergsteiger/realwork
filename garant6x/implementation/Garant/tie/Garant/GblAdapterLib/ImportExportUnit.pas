unit ImportExportUnit;

// ���������� "GblAdapterLib"
// ������: ImportExportUnit

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include nsDefine.inc}

interface

uses
  IOUnit,
  BaseTypesUnit
  ;

type
 AuthorizationNeed = class
  {* ��� ���������� �������� ��������������� ���������� �������������� }
 end;//AuthorizationNeed

 UnknownExportError = class
  {* ��������� ����������� ������ �� ����� �������� �������� }
 end;//UnknownExportError

 DataLoadFailed = class
  {* ��������� ��� ������ �������� ������ �� XML ����� }
 end;//DataLoadFailed

 XercesAdapterNotFound = class
 end;//XercesAdapterNotFound

 IUserProfile5x = interface
  {* ��������� ������� ������������ ������� 5� }
   ['{D90D29AB-4C5F-4F71-8367-1A6B1D51D7FB}']
   function GetName: IString; stdcall;
   class function Make(aUserHomeData); reintroduce; stdcall;
   property name: IString
     read GetName;
 end;//IUserProfile5x

 UserProfile5xList = array of UserProfile5x;

 IImport5x = interface
  {* ��������� ��� ������ � �������� ������ �� 5� }
   ['{2B69C115-7D7D-47D7-8087-C49498949A9B}']
   function GetUserProfile: IUserProfile5xList; stdcall;
     {* ����������� ������ �������������� ���������������� �������� �� 5� }
   procedure ExportData(const aProfile: IUserProfile5x); stdcall; // can raise AuthorizationNeed, UnknownExportError, XercesAdapterNotFound
     {* ������������ � ������� ��������� ������� 5� � ��� ��������� � ��� ������ (���������, �����/��������). � ������ ������ �������� ��� ��� ������������. ���������� �������� ������� ��������������� ����������� �� �������. }
   procedure LoadDataFromXML(aFileName: PChar); stdcall; // can raise InvalidXMLType, DataLoadFailed, XercesAdapterNotFound
     {* ��������� � ������� ��������� XML-����, ���������� ���������,  �����/��������. ���������� �������� ������� ��������������� �����������  �� �������. ���� XML-���� �� �������� ���������� ������, �� ���������  - EInvalidXMLType, ���� �������� �� �������, �� ��������� - EDataLoadFailed }
   class function Make; reintroduce; stdcall;
 end;//IImport5x

implementation

end.