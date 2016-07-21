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
  procedure GetName; stdcall;
  procedure SetName(const aValue); stdcall;
  procedure GetQuery; stdcall;
  procedure SetQuery(const aValue); stdcall;
  function GetId: TPrimeKey; stdcall;
  property Name: 
   read GetName
   write SetName;
  property Query: 
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
  procedure GetList; stdcall;
  procedure Add(const name: IString;
   const query: IQuery;
   out aRet
   {* IPrime }); stdcall; { can raise DuplicateName }
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
  property List: 
   read GetList;
 end;//IPrimeManager

 IPrimeSettingsManager = interface(IBaseSettingsManager)
  {* ��������� ��� ������� ��������� ��������� ���� }
  ['{418BE07D-88DB-419E-A625-51BE867DC212}']
 end;//IPrimeSettingsManager

 IPrimeContractData = interface
  {* ������ ��� �������� ����� ������. }
  ['{DF3E6A6C-4229-4DFB-8ECB-CF4D7FC1DE95}']
  procedure GetInfoKind; stdcall;
  procedure GetThemesName; stdcall;
  procedure GetClientName; stdcall;
  procedure GetProfession; stdcall;
  procedure GetOrganisationType; stdcall;
  procedure GetArea; stdcall;
  procedure GetTaxes; stdcall;
  procedure GetEmail; stdcall;
  procedure GetContractEvdForm(out aRet
   {* IStream }); stdcall; { can raise CanNotFindData }
   {* �������� ������ ��� �������� ����� ������ }
  property InfoKind: 
   read GetInfoKind;
  property ThemesName: 
   read GetThemesName;
  property ClientName: 
   read GetClientName;
  property Profession: 
   read GetProfession;
  property OrganisationType: 
   read GetOrganisationType;
  property Area: 
   read GetArea;
  property Taxes: 
   read GetTaxes;
  property Email: 
   read GetEmail;
 end;//IPrimeContractData

implementation

uses
 l3ImplUses
;

end.
