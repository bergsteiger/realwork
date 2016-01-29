unit PrimeUnit; {$Z4}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "GblAdapterLib"
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/PrimeUnit.pas"
// Delphi интерфейсы для адаптера (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::Prime
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

interface

uses
	SysUtils
	, IOUnit
	, BaseTypesUnit
	, SettingsUnit
	, SearchUnit
	//#UC START# *4423F94903C8_47BECCB801BE_UNIT_FOR_Stream*
	//#UC END# *4423F94903C8_47BECCB801BE_UNIT_FOR_Stream*
	;

type

IPrime = interface;
{ - предварительное описание IPrime. }

IPrimeList = interface;
{ - предварительное описание IPrimeList. }

IKeysList = interface;
{ - предварительное описание IKeysList. }

IPrimeManager = interface;
{ - предварительное описание IPrimeManager. }

IPrimeSettingsManager = interface;
{ - предварительное описание IPrimeSettingsManager. }

IPrimeContractData = interface;
{ - предварительное описание IPrimeContractData. }


PPrimeKey = ^TPrimeKey;
TPrimeKey = Longword;

EUnknownExportError = class (Exception);

IPrime = interface (IInterface) ['{12FF4660-2E81-43B8-963E-4F3099DB73F1}']
	function DontUseMe: Pointer;
	function GetId (): TPrimeKey; stdcall;

	procedure GetName (out aRet {: IString}); stdcall;
	procedure SetName (const aName: IString); stdcall;

	procedure GetQuery (out aRet {: IQuery}); stdcall;
	procedure SetQuery (const aQuery: IQuery); stdcall;
end;

IPrimeList = interface(IInterface)
['{C91FCFAD-1774-4E01-9C3D-EDA600469D85}']
    function  pm_GetCount: Integer; stdcall;
    procedure pm_SetCount(aValue: Integer); stdcall;
      { - методы для доступа к свойству Count. }
    procedure Clear; stdcall;
      {* очистить список. }
    procedure Delete(anIndex: Integer); stdcall;
      {* удаляет элемент по индексу Index. }
    property Count: Integer
      read pm_GetCount
      write pm_SetCount;
       {* число элементов в хранилище. }
  // property methods
    procedure  pm_GetItem(anIndex: Integer; out aRet: IPrime); stdcall;

    procedure pm_SetItem(anIndex: Integer; const anItem: IPrime); stdcall;
      {-}
  // public methods
    function  Add(const anItem: IPrime): Integer; stdcall;
      {* - добавляет элемент Item в конец. }
    procedure Insert(anIndex: Integer; const anItem: IPrime); stdcall;
      {* - вставляет элемент Item по индексу Index. }
end;//IPrimeList

IKeysList = interface(IInterface)
['{85ABCF6B-01B9-43B1-8E1B-354DCFA4A47C}']
    function  pm_GetCount: Integer; stdcall;
    procedure pm_SetCount(aValue: Integer); stdcall;
      { - методы для доступа к свойству Count. }
    procedure Clear; stdcall;
      {* очистить список. }
    procedure Delete(anIndex: Integer); stdcall;
      {* удаляет элемент по индексу Index. }
    property Count: Integer
      read pm_GetCount
      write pm_SetCount;
       {* число элементов в хранилище. }
  // property methods
    function  pm_GetItem(anIndex: Integer): TPrimeKey; stdcall;

    procedure pm_SetItem(anIndex: Integer; const anItem: TPrimeKey); stdcall;
      {-}
  // public methods
    function  Add(const anItem: TPrimeKey): Integer; stdcall;
      {* - добавляет элемент Item в конец. }
    procedure Insert(anIndex: Integer; const anItem: TPrimeKey); stdcall;
      {* - вставляет элемент Item по индексу Index. }
  // public properties
    property  Items[anIndex: Integer]: TPrimeKey
      read pm_GetItem
      write pm_SetItem;
      default;
      {* - элементы списка. }
end;//IKeysList

IPrimeManager = interface (IInterface) ['{A47D57BE-0B61-4917-9929-F2092A1C872F}']
	function DontUseMe: Pointer;
	// сохраняет на сервере свеже созданный запрос для рассылок
	procedure Add (
		const aName: IString;
		const aQuery: IQuery;
		out aRet {: IPrime}
	); stdcall; // can raise EDuplicateName

	// проверить соединение с онлайн сервисом праймов
	function CheckConnectionToOnlineServer (): Bytebool; stdcall;

	// есть ли доступ к онлайн редактированию анкет прайма
	function GetHasOnlineAccess (): Bytebool; stdcall;

	procedure GetList (out aRet {: IPrimeList}); stdcall;

	procedure Remove (
		aId: TPrimeKey
	); stdcall;

	// рассылку в локальных настройках и отправить на сервер праймов
	procedure SaveAndSendToOnlineServer (); stdcall;

	procedure SaveListToXml (
		const aKeys: IKeysList;
		const aXmlFilePath: PAnsiChar
	); stdcall; // can raise EUnknownExportError

	procedure SaveMailDeliveryTask (
		const aXmlFilePath: PAnsiChar
	); stdcall; // can raise EUnknownExportError

	procedure SharePrimeForFileServer (); stdcall; // can raise EUnknownExportError

	// обновить данные о новостных лентах у всех клиентов. Должен быть вызван перед выходом из утилиты.
	procedure Update (); stdcall;
end;

// настройки для утилиты настройки новостных лент
IPrimeSettingsManager = interface (IBaseSettingsManager) ['{418BE07D-88DB-419E-A625-51BE867DC212}']

end;

// данные для печатной формы прайма.
IPrimeContractData = interface (IInterface) ['{DF3E6A6C-4229-4DFB-8ECB-CF4D7FC1DE95}']
	function DontUseMe: Pointer;
	procedure GetArea (out aRet {: IString}); stdcall;

	procedure GetClientName (out aRet {: IString}); stdcall;

	procedure GetEmail (out aRet {: IString}); stdcall;

	// получить шаблон для печатной формы Прайма
	procedure GetContractEvdForm (
		out aRet {: IStream}
	); stdcall; // can raise ECanNotFindData

	procedure GetInfoKind (out aRet {: IString}); stdcall;

	procedure GetOrganisationType (out aRet {: IString}); stdcall;

	procedure GetProfession (out aRet {: IString}); stdcall;

	procedure GetTaxes (out aRet {: IString}); stdcall;

	procedure GetThemesName (out aRet {: IString}); stdcall;
end;

implementation
end.