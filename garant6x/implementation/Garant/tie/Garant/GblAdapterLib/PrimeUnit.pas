unit PrimeUnit;

// ������: "w:\garant6x\implementation\Garant\tie\Garant\GblAdapterLib\PrimeUnit.pas"
// ���������: "Interfaces"
// ������� ������: "Prime" MUID: (47BECCB801BE)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , IOUnit
 , BaseTypesUnit
 , SettingsUnit
 , SearchUnit
;

type
 TPrimeKey = Cardinal;

 IPrime = interface
  ['{12FF4660-2E81-43B8-963E-4F3099DB73F1}']
  function GetName: IString; stdcall;
  procedure SetName(const aValue: IString); stdcall;
  function GetQuery: IQuery; stdcall;
  procedure SetQuery(const aValue: IQuery); stdcall;
  function GetId: TPrimeKey; stdcall;
  property Name: IString
   read GetName
   write SetName;
  property Query: IQuery
   read GetQuery
   write SetQuery;
  property Id: TPrimeKey
   read GetId;
 end;//IPrime

 IPrimeList = array of IPrime;

 UnknownExportError = class
 end;//UnknownExportError

 IKeysList = array of TPrimeKey;
  {* ������ ������ �������� }

 IPrimeManager = interface
  ['{A47D57BE-0B61-4917-9929-F2092A1C872F}']
  function GetHasOnlineAccess: ByteBool; stdcall;
  function GetList: IPrimeList; stdcall;
  function Add(const name: IString;
   const query: IQuery): IPrime; stdcall; { can raise DuplicateName }
   {* ��������� �� ������� ����� ��������� ������ ��� �������� }
  procedure Remove(id: TPrimeKey); stdcall;
  procedure SaveMailDeliveryTask(xml_file_path: PAnsiChar); stdcall; { can raise UnknownExportError }
  procedure SharePrimeForFileServer; stdcall; { can raise UnknownExportError }
  procedure SaveListToXml(const keys: IKeysList;
   xml_file_path: PAnsiChar); stdcall; { can raise UnknownExportError }
  procedure Update; stdcall;
   {* �������� ������ � ��������� ������ � ���� ��������. ������ ���� ������ ����� ������� �� �������. }
  procedure SaveAndSendToOnlineServer; stdcall;
   {* �������� � ��������� ���������� � ��������� �� ������ ������� }
  function CheckConnectionToOnlineServer: ByteBool; stdcall;
   {* ��������� ���������� � ������ �������� ������� }
  property HasOnlineAccess: ByteBool
   read GetHasOnlineAccess;
   {* ���� �� ������ � ������ �������������� ����� ������ }
  property List: IPrimeList
   read GetList;
 end;//IPrimeManager

 IPrimeSettingsManager = interface(IBaseSettingsManager)
  {* ��������� ��� ������� ��������� ��������� ���� }
  ['{418BE07D-88DB-419E-A625-51BE867DC212}']
 end;//IPrimeSettingsManager

 IPrimeContractData = interface
  {* ������ ��� �������� ����� ������. }
  ['{DF3E6A6C-4229-4DFB-8ECB-CF4D7FC1DE95}']
  function GetInfoKind: IString; stdcall;
  function GetThemesName: IString; stdcall;
  function GetClientName: IString; stdcall;
  function GetProfession: IString; stdcall;
  function GetOrganisationType: IString; stdcall;
  function GetArea: IString; stdcall;
  function GetTaxes: IString; stdcall;
  function GetEmail: IString; stdcall;
  function GetContractEvdForm: IStream; stdcall; { can raise CanNotFindData }
   {* �������� ������ ��� �������� ����� ������ }
  property InfoKind: IString
   read GetInfoKind;
  property ThemesName: IString
   read GetThemesName;
  property ClientName: IString
   read GetClientName;
  property Profession: IString
   read GetProfession;
  property OrganisationType: IString
   read GetOrganisationType;
  property Area: IString
   read GetArea;
  property Taxes: IString
   read GetTaxes;
  property Email: IString
   read GetEmail;
 end;//IPrimeContractData

implementation

uses
 l3ImplUses
;

end.
