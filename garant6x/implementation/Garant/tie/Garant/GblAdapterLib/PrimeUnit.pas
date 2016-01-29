unit PrimeUnit;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "GblAdapterLib"
// Модуль: "w:/garant6x/implementation/Garant/tie/Garant/GblAdapterLib/PrimeUnit.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::Prime
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
  IOUnit,
  BaseTypesUnit,
  SettingsUnit,
  SearchUnit
  ;

type
 TPrimeKey = Cardinal;

 IPrime = interface(IUnknown)
   ['{12FF4660-2E81-43B8-963E-4F3099DB73F1}']
   function GetName: IString; stdcall;
   procedure SetName(const aValue: IString); stdcall;
   function GetQuery: IQuery; stdcall;
   procedure SetQuery(const aValue: IQuery); stdcall;
   function GetId: TPrimeKey; stdcall;
   property name: IString
     read GetName
     write SetName;
   property query: IQuery
     read GetQuery
     write SetQuery;
   property id: TPrimeKey
     read GetId;
 end;//IPrime

 IPrimeList = array of IPrime;

 UnknownExportError = class
 end;//UnknownExportError

 IKeysList = array of TPrimeKey;
  {* список ключей рассылок }

 IPrimeManager = interface(IUnknown)
   ['{A47D57BE-0B61-4917-9929-F2092A1C872F}']
   function GetHasOnlineAccess: ByteBool; stdcall;
   function GetList: IPrimeList; stdcall;
   procedure Add(const aName: IString;
    const aQuery: IQuery; out aRet {: IPrime}); stdcall; // can raise DuplicateName
     {* сохраняет на сервере свеже созданный запрос для рассылок }
   procedure Remove(aId: TPrimeKey); stdcall;
   procedure SaveMailDeliveryTask(aXmlFilePath: PAnsiChar); stdcall; // can raise UnknownExportError
   procedure SharePrimeForFileServer; stdcall; // can raise UnknownExportError
   procedure SaveListToXml(const aKeys: IKeysList;
    aXmlFilePath: PAnsiChar); stdcall; // can raise UnknownExportError
   procedure Update; stdcall;
     {* обновить данные о новостных лентах у всех клиентов. Должен быть вызван перед выходом из утилиты. }
   procedure SaveAndSendToOnlineServer; stdcall;
     {* рассылку в локальных настройках и отправить на сервер праймов }
   function CheckConnectionToOnlineServer: ByteBool; stdcall;
     {* проверить соединение с онлайн сервисом праймов }
   property has_online_access: ByteBool
     read GetHasOnlineAccess;
     {* есть ли доступ к онлайн редактированию анкет прайма }
   property list: IPrimeList
     read GetList;
 end;//IPrimeManager

 IPrimeSettingsManager = interface(IBaseSettingsManager)
  {* настройки для утилиты настройки новостных лент }
   ['{418BE07D-88DB-419E-A625-51BE867DC212}']
 end;//IPrimeSettingsManager

 IPrimeContractData = interface(IUnknown)
  {* данные для печатной формы прайма. }
   ['{DF3E6A6C-4229-4DFB-8ECB-CF4D7FC1DE95}']
   function GetInfoKind: IString; stdcall;
   function GetThemesName: IString; stdcall;
   function GetClientName: IString; stdcall;
   function GetProfession: IString; stdcall;
   function GetOrganisationType: IString; stdcall;
   function GetArea: IString; stdcall;
   function GetTaxes: IString; stdcall;
   function GetEmail: IString; stdcall;
   procedure GetContractEvdForm(out aRet {: IStream}); stdcall; // can raise CanNotFindData
     {* получить шаблон для печатной формы Прайма }
   property info_kind: IString
     read GetInfoKind;
   property themes_name: IString
     read GetThemesName;
   property client_name: IString
     read GetClientName;
   property profession: IString
     read GetProfession;
   property organisation_type: IString
     read GetOrganisationType;
   property area: IString
     read GetArea;
   property taxes: IString
     read GetTaxes;
   property email: IString
     read GetEmail;
 end;//IPrimeContractData

implementation

end.