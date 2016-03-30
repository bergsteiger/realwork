unit nevNavigation;
 {* Навигация между элементами системы }

// Модуль: "w:\common\components\gui\Garant\Everest\new\nevNavigation.pas"
// Стереотип: "Interfaces"
// Элемент модели: "nevNavigation" MUID: (4A251D6E00BD)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , l3Types
 , evdTypes
 , nevTools
 , afwNavigation
 , l3Variant
;

type
 IevHyperlink = interface;

 IevAddressList = interface
  {* Список адресов }
  ['{FF3E2BB3-B94A-4C87-9725-E6EF1E93079A}']
  function pm_GetCount: Integer;
  function pm_GetItem(anIndex: Integer): TevAddress;
  procedure pm_SetItem(anIndex: Integer;
   const aValue: TevAddress);
  function pm_GetName(anIndex: Integer): Tl3PCharLen;
  procedure pm_SetName(anIndex: Integer;
   const aValue: Tl3PCharLen);
  function Add(const anAddress: TevAddress): Integer;
   {* Добавляет еще один адрес }
  procedure Delete(const anAddress: TevAddress);
   {* Удаляет адрес }
  procedure Modify(const anOldAddress: TevAddress;
   const aNewAddress: TevAddress);
   {* Модифицирует адрес }
  procedure Clear;
   {* Очищает список адресов }
  property Count: Integer
   read pm_GetCount;
   {* Количество адресов ссылки }
  property Item[anIndex: Integer]: TevAddress
   read pm_GetItem
   write pm_SetItem;
   default;
   {* Список адресов по индексу }
  property Name[anIndex: Integer]: Tl3PCharLen
   read pm_GetName
   write pm_SetName;
   {* Cписок имен по индексу }
 end;//IevAddressList

 IevAddressHolder = interface
  ['{C22FA607-035B-44DE-B592-054CB05175DE}']
  function pm_GetAddress: Tl3Tag;
  property Address: Tl3Tag
   read pm_GetAddress;
 end;//IevAddressHolder

 IevHyperlink = interface
  {* Гипертекстовая ссылка }
  ['{337AC4D3-4CE3-43D3-A6F3-72396283293F}']
  function Get_ID: Integer;
  procedure Set_ID(aValue: Integer);
  function Get_FromDocumentExternalHandle: Integer;
  function Get_TargetDocumentID: Integer;
  function Get_Name: Tl3PCharLen;
  function pm_GetPara: InevPara;
  function pm_GetAddressList: IevAddressList;
  function pm_GetAddress: TevAddress;
  procedure pm_SetAddress(const aValue: TevAddress);
  function pm_GetURL: Tl3PCharLen;
  procedure pm_SetURL(const aValue: Tl3PCharLen);
  function pm_GetHint: Tl3PCharLen;
  procedure pm_SetHint(const aValue: Tl3PCharLen);
  function pm_GetKind: TevLinkViewKind;
  procedure pm_SetKind(aValue: TevLinkViewKind);
  function Exists: Boolean;
   {* Проверяет существует ли данная ссылка }
  procedure Insert;
   {* Вставляет новую ссылку }
  procedure Delete;
   {* Удаляет гипертекстовую ссылку }
  function GetHyperlink: Tl3Tag;
  property ID: Integer
   read Get_ID
   write Set_ID;
   {* Идентификатор ссылки }
  property FromDocumentExternalHandle: Integer
   read Get_FromDocumentExternalHandle;
  property TargetDocumentID: Integer
   read Get_TargetDocumentID;
  property Name: Tl3PCharLen
   read Get_Name;
  property Para: InevPara
   read pm_GetPara;
   {* Параграф на котором стоит ссылка }
  property AddressList: IevAddressList
   read pm_GetAddressList;
  property Address: TevAddress
   read pm_GetAddress
   write pm_SetAddress;
   {* Адрес на который указывает ссылка (первый из AddressList) }
  property URL: Tl3PCharLen
   read pm_GetURL
   write pm_SetURL;
   {* Путь к ресурсу на который может указывать ссылка }
  property Hint: Tl3PCharLen
   read pm_GetHint
   write pm_SetHint;
   {* "подсказка" появляющаяся при наведении курсора на ссылку }
  property Kind: TevLinkViewKind
   read pm_GetKind
   write pm_SetKind;
   {* Вид отображения ссылки }
 end;//IevHyperlink

implementation

uses
 l3ImplUses
;

end.
