unit GardocsUnit; {$Z4}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "ArchiAdapterLib"
// Модуль: "w:/MDProcess/ArchiAdapterLib/GardocsUnit.pas"
// Delphi интерфейсы для адаптера (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> MDProcess::ArchiAdapterLib::Gardocs
//
// Gardoc
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

interface

uses
	SysUtils
	, IOUnit
	//#UC START# *4423F94903C8_4E14466D0293_UNIT_FOR_Stream*
  , ActiveX
	//#UC END# *4423F94903C8_4E14466D0293_UNIT_FOR_Stream*
	;

type

IStringList = interface;
{ - предварительное описание IStringList. }

IImageList = interface;
{ - предварительное описание IImageList. }

IGardocList = interface;
{ - предварительное описание IGardocList. }

ISearcher = interface;
{ - предварительное описание ISearcher. }

IArchiEventsListener = interface;
{ - предварительное описание IArchiEventsListener. }

ISearcher2 = interface;
{ - предварительное описание ISearcher2. }

IUtils = interface;
{ - предварительное описание IUtils. }

ILongList = interface;
{ - предварительное описание ILongList. }

IGardocGetter = interface;
{ - предварительное описание IGardocGetter. }


// тип образа
PImageType = ^TImageType;
TImageType = (
	giZIP
	, giTIF
	, giDOC
	, giRTF
	, giNSR
);

// образ
PImage = ^TImage;
TImage = packed record
	rData: IStream; // данные
	rType: TImageType; // тип образа
	rSrcTitle: IString; // название исчточника публикования
	rSrcPage: IString; // номер страницы в источнике публикования
	rSrcNumber: IString; // номер исчтоника публикования
	rSrcDateStart: TDateTimeBox; // дата источника публикования (период)
	rSrcDateEnd: TDateTimeBox; // дата источника публикования (период)
	rLabels: IStringList; // список пользовательских меток, проставленных юристами, метки могут означать что архивариусу нужно поделать что-то дополнительно. Или не означать.
end;

// сетевая ошибка, попробуйте повторить минут через десять
ECommunicationFailure = class (Exception);

PGardocStatus = ^TGardocStatus;
TGardocStatus = (
	gsNEW
	, gsUPDATED
);

PGarDocType = ^TGarDocType;
TGarDocType = (
	gtDoc
	, gtRelated
);

PGarDocUrgency = ^TGarDocUrgency;
TGarDocUrgency = (
	guInVersion // в версию
	, guQuickly // срочный
	, guOrdinary // обычный
	, guUnknown // неизвестно
);

// карточка документ
PGardoc = ^TGardoc;
TGardoc = packed record
	rType: IString; // тип (приказ, распоряжение и т.д)
	rNumber: IString; // номер
	rDate: TDateTimeBox; // дата документа
	rOgvList: IStringList; // список Органов Государственной Власти, принимавших документ
	rTitle: IString; // название
	rMuNumber: IString; // номер регистрации в МЮ
	rMuDate: TDateTimeBox; // дата регистрации в МЮ
	rBlocks: IStringList; // блоки (белонгсы), перечесляются в сокращенном виде, например: GAR, LAN т.д.
	rTopic: Int64; // номер топика
	rComment: IString; // комментарий, юристы здесь пишут много разного для себя полезного, должно где-то показываться в Архивариусе
	rImages: IImageList; // образ в zip-е, содержит ВСЕ файлы-образы данного документа, которые есть в К
	rConfluenceId: Int64; // номер запроса в К, который после префикса DPOUVS-
	rTimestamp: TDateTimeBox;
	rState: TGardocStatus;
	rText: IString; // если документ справка, то здесь передается текст справки, если нет, то пусто
	rRelated: Int64; // топик справки
	rGardocType: TGarDocType; // тип документа
	rUrgency: TGarDocUrgency; // срочность
	rIsInternet: Bytebool; // флажок, что надо выложить на сайт, нужен для оперативной обработки таких документов
end;

// ArchiEvent
PArchiEvent = ^TArchiEvent;
TArchiEvent = packed record
	rType: IString; // тип
	rDoc: TGardoc;
end;

IStringList = interface(IInterface)
['{F453A2F1-0E0A-4C01-AB14-60246CDF74DB}']
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
    procedure  pm_GetItem(anIndex: Integer; out aRet: IString); stdcall;

    procedure pm_SetItem(anIndex: Integer; const anItem: IString); stdcall;
      {-}
  // public methods
    function  Add(const anItem: IString): Integer; stdcall;
      {* - добавляет элемент Item в конец. }
    procedure Insert(anIndex: Integer; const anItem: IString); stdcall;
      {* - вставляет элемент Item по индексу Index. }
end;//IStringList

IImageList = interface(IInterface)
['{10205A4D-9F0C-48B1-B84E-C10ED6FA2519}']
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
    procedure  pm_GetItem(anIndex: Integer; out aRet: TImage); stdcall;

    procedure pm_SetItem(anIndex: Integer; const anItem: TImage); stdcall;
      {-}
  // public methods
    function  Add(const anItem: TImage): Integer; stdcall;
      {* - добавляет элемент Item в конец. }
    procedure Insert(anIndex: Integer; const anItem: TImage); stdcall;
      {* - вставляет элемент Item по индексу Index. }
end;//IImageList

IGardocList = interface(IInterface)
['{D491FCC6-CA05-4DC5-A400-B793F196EA6E}']
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
    procedure  pm_GetItem(anIndex: Integer; out aRet: TGardoc); stdcall;

    procedure pm_SetItem(anIndex: Integer; const anItem: TGardoc); stdcall;
      {-}
  // public methods
    function  Add(const anItem: TGardoc): Integer; stdcall;
      {* - добавляет элемент Item в конец. }
    procedure Insert(anIndex: Integer; const anItem: TGardoc); stdcall;
      {* - вставляет элемент Item по индексу Index. }
end;//IGardocList

// Searcher
ISearcher = interface (IInterface) ['{7B55C61E-E39E-4BEC-8BD2-DDC67DB1218E}']
	function DontUseMe: Pointer;
	procedure GetNotopCreatedSince (
		const aDate: TDateTimeBox;
		aCount: Longint;
		out aRet {: IGardocList}
	); stdcall; // can raise ECommunicationFailure

	// возвращает список новых документов, зарегистрированных в К после date (date - время в
	// миллисекундах после 1 января 1970 года, т.е. стандартное)
	procedure GetRecentlyCreatedSince (
		const aDate: TDateTimeBox;
		const aPartnerId: PAnsiChar;
		out aRet {: IGardocList}
	); stdcall; // can raise ECommunicationFailure

	procedure GetTopCreatedSince (
		const aDate: TDateTimeBox;
		aCount: Longint;
		out aRet {: IGardocList}
	); stdcall; // can raise ECommunicationFailure
end;

// ArchiEventsListener
IArchiEventsListener = interface (IInterface) ['{2BA31725-A2F3-491E-B6B9-088243579D0F}']
	function DontUseMe: Pointer;
	// проинформировать К о наступлении события
	procedure OnEvent (
		const aEvent: TArchiEvent
	); stdcall; // can raise ECommunicationFailure
end;

ISearcher2 = interface (IInterface) ['{64367610-772E-48B6-A95A-6903B77A11D8}']
	function DontUseMe: Pointer;
	procedure GetNotopCreatedSince (
		const aDate: TDateTimeBox;
		aCount: Longint;
		const aPartnerId: PAnsiChar;
		out aRet {: IGardocList}
	); stdcall; // can raise ECommunicationFailure

	procedure GetTopCreatedSince (
		const aDate: TDateTimeBox;
		aCount: Longint;
		const aPartnerId: PAnsiChar;
		out aRet {: IGardocList}
	); stdcall; // can raise ECommunicationFailure
end;

IUtils = interface (IInterface) ['{731214F7-3EF9-463C-89CF-8027D4D82C0B}']
	function DontUseMe: Pointer;
	// Особенность работы сервера заключается в том что он сначало получает все документы с указанной
	// даты в реализации Searcher2::get_xxxx, а потом выкидывает лишнее (например фильтрует по
	// партнеру). Если время, которое подает клиент слишком старое, то фильрация может занимать
	// несколько десятков минут. Поэтому клиенту предлагается в случае, если ему на
	// Searcher2::get_xxxx не вернулся ни один документ, дернуть update_old_last_created_time и
	// результат запомнить у себя.
	// Сервер будет отнимать от текущего времени 30-ть минут и результат возвращать клиенту. Если
	// получившееся время старше входного параметра, то просто отдается time.
	procedure UpdateOldLastCreatedTime (
		const aDate: TDateTimeBox;
		out a: TDateTimeBox
	); stdcall; // can raise ECommunicationFailure
end;

ILongList = interface(IInterface)
['{EF5A688C-2615-45FC-96C8-7E1BCB15C5EB}']
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
    function  pm_GetItem(anIndex: Integer): Int64; stdcall;

    procedure pm_SetItem(anIndex: Integer; const anItem: Int64); stdcall;
      {-}
  // public methods
    function  Add(const anItem: Int64): Integer; stdcall;
      {* - добавляет элемент Item в конец. }
    procedure Insert(anIndex: Integer; const anItem: Int64); stdcall;
      {* - вставляет элемент Item по индексу Index. }
  // public properties
    property  Items[anIndex: Integer]: Int64
      read pm_GetItem
      write pm_SetItem;
      default;
      {* - элементы списка. }
end;//ILongList

IGardocGetter = interface (IInterface) ['{1E68C7A1-F6B8-4A60-8E20-A8860F1DBBB5}']
	function DontUseMe: Pointer;
	procedure GardocsByConfluenceidList (
		const aConfluenceidList: ILongList;
		out aRet {: IGardocList}
	); stdcall; // can raise ECommunicationFailure

	procedure GardocsByTopicList (
		const aTopicList: ILongList;
		out aRet {: IGardocList}
	); stdcall; // can raise ECommunicationFailure
end;

implementation
end.