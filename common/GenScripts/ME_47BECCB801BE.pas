unit PrimeUnit;

// Модуль: "w:\garant6x\implementation\Garant\tie\Garant\GblAdapterLib\PrimeUnit.pas"
// Стереотип: "Interfaces"
// Элемент модели: "Prime" MUID: (47BECCB801BE)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , IOUnit
 , SearchUnit
 , BaseTypesUnit
 , SettingsUnit
;

type
 TPrimeKey = Cardinal;

 IPrime = interface
  ['{12FF4660-2E81-43B8-963E-4F3099DB73F1}']
  function Get_name: IString;
  procedure Set_name(const aValue: IString);
  function Get_query: IQuery;
  procedure Set_query(const aValue: IQuery);
  function Get_id: TPrimeKey;
  property name: IString
   read Get_name
   write Set_name;
  property query: IQuery
   read Get_query
   write Set_query;
  property id: TPrimeKey
   read Get_id;
 end;//IPrime

 IPrimeList = array of IPrime;

 UnknownExportError = class
 end;//UnknownExportError

 IKeysList = array of TPrimeKey;
  {* список ключей рассылок }

 IPrimeManager = interface
  ['{A47D57BE-0B61-4917-9929-F2092A1C872F}']
  function Get_has_online_access: Boolean;
  function Get_list: IPrimeList;
  function add(const name: IString;
   const query: IQuery): IPrime; { can raise DuplicateName }
   {* сохраняет на сервере свеже созданный запрос для рассылок }
  procedure remove(id: TPrimeKey);
  procedure save_mail_delivery_task(xml_file_path: PAnsiChar); { can raise UnknownExportError }
  procedure share_prime_for_file_server; { can raise UnknownExportError }
  procedure save_list_to_xml(const keys: IKeysList;
   xml_file_path: PAnsiChar); { can raise UnknownExportError }
  procedure update;
   {* обновить данные о новостных лентах у всех клиентов. Должен быть вызван перед выходом из утилиты. }
  procedure save_and_send_to_online_server;
   {* рассылку в локальных настройках и отправить на сервер праймов }
  function check_connection_to_online_server: Boolean;
   {* проверить соединение с онлайн сервисом праймов }
  property has_online_access: Boolean
   read Get_has_online_access;
   {* есть ли доступ к онлайн редактированию анкет прайма }
  property list: IPrimeList
   read Get_list;
 end;//IPrimeManager

 IPrimeSettingsManager = interface(IBaseSettingsManager)
  {* настройки для утилиты настройки новостных лент }
  ['{418BE07D-88DB-419E-A625-51BE867DC212}']
 end;//IPrimeSettingsManager

 IPrimeContractData = interface
  {* данные для печатной формы прайма. }
  ['{DF3E6A6C-4229-4DFB-8ECB-CF4D7FC1DE95}']
  function Get_info_kind: IString;
  function Get_themes_name: IString;
  function Get_client_name: IString;
  function Get_profession: IString;
  function Get_organisation_type: IString;
  function Get_area: IString;
  function Get_taxes: IString;
  function Get_email: IString;
  function get_contract_evd_form: IStream; { can raise CanNotFindData }
   {* получить шаблон для печатной формы Прайма }
  property info_kind: IString
   read Get_info_kind;
  property themes_name: IString
   read Get_themes_name;
  property client_name: IString
   read Get_client_name;
  property profession: IString
   read Get_profession;
  property organisation_type: IString
   read Get_organisation_type;
  property area: IString
   read Get_area;
  property taxes: IString
   read Get_taxes;
  property email: IString
   read Get_email;
 end;//IPrimeContractData

class function make(key: TPrimeKey;
 name: PAnsiChar;
 const query): BadFactoryType;
class function make: BadFactoryType;
class function make: BadFactoryType;
 {* фабрика }
class function get_contract_data(var query: IQuery): BadFactoryType;
 {* получить данные для заполнения печатной формы Прайма }

implementation

uses
 l3ImplUses
;

class function make(key: TPrimeKey;
 name: PAnsiChar;
 const query): BadFactoryType;
var
 l_Inst : IPrime;
begin
 l_Inst := Create(key, name, query);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//make

class function make: BadFactoryType;
var
 l_Inst : IPrimeManager;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//make

class function make: BadFactoryType;
 {* фабрика }
var
 l_Inst : IPrimeSettingsManager;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//make

class function get_contract_data(var query: IQuery): BadFactoryType;
 {* получить данные для заполнения печатной формы Прайма }
var
 l_Inst : IPrimeContractData;
begin
 l_Inst := Create(query);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//get_contract_data

end.
