unit DocumentUnit; {$Z4}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "GblAdapterLib"
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/DocumentUnit.pas"
// Delphi интерфейсы для адаптера (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::Document
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
	, FoldersUnit
	, DynamicTreeUnit
	, ExternalObjectUnit
	, UnderControlUnit
	//#UC START# *4423F94903C8_4570511E038A_UNIT_FOR_Stream*
        , ActiveX
	//#UC END# *4423F94903C8_4570511E038A_UNIT_FOR_Stream*
	;

type

IMissingInfo = interface;
{ - предварительное описание IMissingInfo. }

IPositionList = interface;
{ - предварительное описание IPositionList. }

IActiveIntervalList = interface;
{ - предварительное описание IActiveIntervalList. }

INotSureIntervalList = interface;
{ - предварительное описание INotSureIntervalList. }

IRedactionSourceDocumentInfoList = interface;
{ - предварительное описание IRedactionSourceDocumentInfoList. }

IDiffIterator = interface;
{ - предварительное описание IDiffIterator. }

IEVDStream = IStream;

IBookmarkList = interface;
{ - предварительное описание IBookmarkList. }

IFragmentList = interface;
{ - предварительное описание IFragmentList. }

ISubList = interface;
{ - предварительное описание ISubList. }

IContextList = interface;
{ - предварительное описание IContextList. }

IFoundContext = interface;
{ - предварительное описание IFoundContext. }

IDocumentTextProvider = interface;
{ - предварительное описание IDocumentTextProvider. }

IDocumentTextProviderList = interface;
{ - предварительное описание IDocumentTextProviderList. }

ICommentsParaList = interface;
{ - предварительное описание ICommentsParaList. }

IExternalObjectDataList = interface;
{ - предварительное описание IExternalObjectDataList. }

IDocumentTextProviderDescriptorList = interface;
{ - предварительное описание IDocumentTextProviderDescriptorList. }

IDocPointList = interface;
{ - предварительное описание IDocPointList. }

IDiffDocParaList = interface;
{ - предварительное описание IDiffDocParaList. }

IRedactionInfoList = interface;
{ - предварительное описание IRedactionInfoList. }

IDocument = interface;
{ - предварительное описание IDocument. }

IBookmark = interface;
{ - предварительное описание IBookmark. }

IDocumentState = interface;
{ - предварительное описание IDocumentState. }

IJournalBookmark = interface;
{ - предварительное описание IJournalBookmark. }

ILink = interface;
{ - предварительное описание ILink. }

IJournalBookmarkList = interface;
{ - предварительное описание IJournalBookmarkList. }

IDiffDocDataProvider = interface;
{ - предварительное описание IDiffDocDataProvider. }

IObjectFromLink = interface;
{ - предварительное описание IObjectFromLink. }


// Тип объекта, на который указывает гипертекстовая ссылка.
PLinkedObjectType = ^TLinkedObjectType;
TLinkedObjectType = (
	LO_DOCUMENT // Документ.
	, LO_RELATED_DOCUMENT // Справка к документу.
	, LO_EXTERNAL_OBJECT // Внешний объект.
	, LO_MULTILINK // Мультиссылка (список документов).
	, LO_EXTERNAL_LINK // Внешняя ссылка.
	, LO_QUERY // Запрос.
	, LO_BOOKMARK // Закладка
	, LO_EXTERNAL_OPERATION
	, LO_ENO // Ссылка на ENO
	, LO_AUTOREFERAT // Автореферат
	, LO_SCRIPT // скрипт для К271754146
	, LO_DELETED_FOLDERS_CONTENT
);

// Неверный идентификатор параграфа
EInvalidParaId = class (Exception);

PTimeMachineWarningType = ^TTimeMachineWarningType;
TTimeMachineWarningType = (
	TMWT_RED
	, TMWT_YELLOW
);

PTimeMachineWarning = ^TTimeMachineWarning;
TTimeMachineWarning = packed record
	rWarning: IString;
	rType: TTimeMachineWarningType;
end;

// Возвращается при попытке выполнить операцию с внутренним идентификатором документа,
// несуществующим в базе.
EInvalidTopicId = class (Exception);

PPositionType = ^TPositionType;
TPositionType = (
	PT_SUB
	, PT_PARA
	, PT_BOOKMARK
);

// Точка входа в документ.
PPosition = ^TPosition;
TPosition = packed record
	rType: TPositionType; // Флаг определяющий значение поля point. Если true то point указывает на параграф, в противном случае на саб или блок.
	rPoint: Longword; // Точка входа.
end;

// Внутренние идентификаторы элемента списка документов.
PTopic = ^TTopic;
TTopic = packed record
	rPid: TPId;
	rPosition: TPosition;
end;

// Идентификатор параграфа (тот самы волшебный, который должен прикрутить Влад)
PParaId = ^TParaId;
TParaId = Longword;

// тип документа
PDocumentType = ^TDocumentType;
TDocumentType = (
	DT_DOCUMENT
	, DT_EXPLANATORY
	, DT_AUTO_REFERAT
	, DT_BOOK
	, DT_TIP // Совет дня
	, DT_MEDICAL_EXPLANATORY // элемент словаря мед. терминов
	, DT_MEDICAL_FIRM // документ с описанием фирмы из инфарм
	, DT_MEDICAL_DOCUMENT
	, DT_FLASH // Документ-флеш
	, DT_ACTUAL_ANALYTICS // ААК
	, DT_ACTUAL_ANALYTICS_CONTENTS // ААК-Содержание
	, DT_REF // Топик с www ссылками
);

// Не найдена ссылка на папочный элемент (возможно он был удален)
EFolderLinkNotFound = class (Exception);

// Идентификатор редакции объекта (сейчас будет совпадать с ObjectId).
PRedactionID = ^TRedactionID;
TRedactionID = Longint;

PNotSureInfo = ^TNotSureInfo;
TNotSureInfo = packed record
	rWarning: IString;
	rInterval: TDateInterval;
end;

// Тип редакции объекта.
PRedactionType = ^TRedactionType;
TRedactionType = (
	RT_ACTUAL // Документ
	, RT_ACTUAL_ABOLISHED // документ со статусом DS_ABOLISHED (утратил силу)
	, RT_ACTUAL_PREACTIVE // документ со статусом DS_PREACTIVE (не вступил в силу)
	, RT_OLD // редакция в цепочке редакций до актуальной, у которой нет ни DS_ABOLISHED, ни DS_PREACTIVE
	, RT_NEW // редакция в цепочке редакций после актуальной, у которой нет ни DS_ABOLISHED, ни DS_PREACTIVE
	, RT_NEW_ABOLISHED
	, RT_NEW_PREACTIVE // редакция со статусом DS_PREACTIVE (не вступил в силу)
);

PRedactionSourceDocumentInfo = ^TRedactionSourceDocumentInfo;
TRedactionSourceDocumentInfo = packed record
	rDisplayName: IString; // изменяющий документ (то что показывается)
	rDocTopic: TTopic; // топик для перехода в изменяющий документ
end;

// Возвращается в случае попытки получения несуществующей редакции объекта.
ERedactionNotFound = class (Exception);

// Вид хинта
PLinkKind = ^TLinkKind;
TLinkKind = (
	LK_INTERNAL_INVALID
	, LK_REGULAR
	, LK_EXTERNAL
	, LK_ABOLISHED // Ссылка на утративший силу документ
	, LK_PREACTIVE // Ссылка на не вступивший в силу документ
	, LK_ENO // Ссылка на ЭО
	, LK_EDITION // Редакция документа
	, LK_SCRIPT // ссылка на скрипт
);

PLinkInfo = ^TLinkInfo;
TLinkInfo = packed record
	rKind: TLinkKind; // вид хинта
	rHint: IString;
end;

EInvalidDate = class (Exception);

// Толковый словарь не установлен в системе.
// Возвращается в случае вызова операции "поиск толкования" и отсутствии в системе толкового
// словаря.
EExplanationDictionaryNotInstalled = class (Exception);

PFactoryKey = ^TFactoryKey;
TFactoryKey = (
	FK_DOCUMENT_MASTER
	, FK_DOCUMENT_DELEGATE
	, FK_DICT_DOCUMENT
	, FK_PHARM_DICT_DOCUMENT
	, FK_PHARM_DOCUMENT
	, FK_PHARM_FIRM_DOCUMENT
	, FK_TIP_DOCUMENT
	, FK_TRANSLATED_DOCUMENT
	, FK_SIMPLE_DOCUMENT
	, FK_FLASH_DOCUMENT
	, FK_AUTOREFERAT_DOCUMENT
	, FK_ACTUAL_ANALYTICS_CONTENTS_DOCUMENT
	, FK_ACTUAL_ANALYTICS_DOCUMENT
	, FK_REF
	, FK_BOOK
);

// список измененных параграфов в порядке выдачи машиной сравнения
PParaNum = ^TParaNum;
TParaNum = Longint;

PLayerID = ^TLayerID;
TLayerID = Longword;

EInvalidObjectClass = class (Exception);

ENoPrevRedaction = class (Exception);

PChildID = ^TChildID;
TChildID = Longword;

PEntryPoint = ^TEntryPoint;
TEntryPoint = packed record
	rLayer: TLayerID;
	rChild: TChildID;
end;

PContext = ^TContext;
TContext = packed record
	rPath: INodeIndexPath;
	rStart: Longint;
	rFinish: Longint;
end;

PEVDType = ^TEVDType;
TEVDType = AnsiChar;

PExternalID = ^TExternalID;
TExternalID = Longint;

EInvalidEntryPoint = class (Exception);

EInvalidLayerID = class (Exception);

PBookmark2 = ^TBookmark2;
TBookmark2 = packed record
	rParaId: TExternalID;
	rEid: Longword;
	rName: IString;
end;

PExternalObjectData = ^TExternalObjectData;
TExternalObjectData = packed record
	rType: TExternalObjectType;
	rParaId: TParaId;
	rName: IString;
end;

PDiffData = ^TDiffData;
TDiffData = packed record
	rDiffIterator: IDiffIterator;
	rCur: IDocumentTextProvider;
	rPrev: IDocumentTextProvider;
end;

PDocumentTextProviderDescriptor = ^TDocumentTextProviderDescriptor;
TDocumentTextProviderDescriptor = packed record
	rHandle: Longword;
	rHeaderLeafCount: Longword;
	rAnnoLeafCount: Longword;
end;

PSubId = ^TSubId;
TSubId = Longword;

// Точка входа в документ (пара DocId SubId)
PDocPoint = ^TDocPoint;
TDocPoint = packed record
	rDocId: TBaseTypesObjectId; // Идентификатор документа
	rSubId: TSubId; // Номер саба/блока
end;

ILikeable = interface (IInterface) ['{CD879569-CC93-4E02-B56F-C5C1B3FBBEBC}']
	function DontUseMe: Pointer;
	// Доступность операции оценки
	function GetCanLike (): Bytebool; stdcall;

	// Нравится
	procedure Like (); stdcall;

	// Не нравится
	procedure Unlike (); stdcall;
end;

// Информация о редакции объекта.
PRedactionInfo = ^TRedactionInfo;
TRedactionInfo = packed record
	rName: IString; // Имя редакции.
	rTimeMachineDate: TDate;
	rDocDate: TDate;
	rIsComparable: Bytebool;
	rActualType: TRedactionType;
	rNotSureIntervals: INotSureIntervalList;
	rActiveIntervals: IActiveIntervalList;
	rId: TRedactionID;
	rChangingDocuments: IRedactionSourceDocumentInfoList;
end;

PDiffDocPara = ^TDiffDocPara;
TDiffDocPara = packed record
	rText: IString;
	rStyle: IEVDStream;
	rData: IStream;
	rType: TEVDType;
	rId: Longint;
end;

PChangedBlock = ^TChangedBlock;
TChangedBlock = packed record
	rId: Longword;
	rHeader: IDiffDocParaList; // Название структурной единицы с точностью до минимального блока, входящего в оглавление,которым  предваряется измененный фрагмент (блок)
	rRightTextParaList: IDiffDocParaList; // Измененный фрагмент правой редакции
	rLeftTextParaList: IDiffDocParaList; // Измененный фрагмент левой редакции
end;

EAllChangesInTables = class (Exception);

PDocumentLayerID = ^TDocumentLayerID;
TDocumentLayerID = TLayerID;

// Информация об отсутствующем документе.
IMissingInfo = interface (IInterface) ['{5553DE6A-23C5-4B12-8A98-358CF08F6E59}']
	function DontUseMe: Pointer;
	// Имена блоков (баз), в которых содержится отсутствующий объект.
	procedure GetBlocksInfo (out aRet {: IString}); stdcall;

	// Отсутствующий объект содержится только в одном блоке (базе) - необходимо для правильного
	// постоения сообщения о том, в каком(их) блоке(ах) содержится отсутствующий объект.  Если в
	// blocks_info содержится только один блок, то возвращается true, в противном случае false.
	function IsOneBlock (): Bytebool; stdcall;

	// Имя отсутствующего объекта.
	procedure GetObjName (out aRet {: IString}); stdcall;
end;

IPositionList = interface(IInterface)
['{4C6C46F0-B4AF-4099-BFA3-21B631F672F6}']
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
    procedure  pm_GetItem(anIndex: Integer; out aRet: TPosition); stdcall;

    procedure pm_SetItem(anIndex: Integer; const anItem: TPosition); stdcall;
      {-}
  // public methods
    function  Add(const anItem: TPosition): Integer; stdcall;
      {* - добавляет элемент Item в конец. }
    procedure Insert(anIndex: Integer; const anItem: TPosition); stdcall;
      {* - вставляет элемент Item по индексу Index. }
end;//IPositionList

IActiveIntervalList = interface(IInterface)
['{A47493FA-0883-40CB-9D8C-E0100F2FFE69}']
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
    procedure  pm_GetItem(anIndex: Integer; out aRet: TDateInterval); stdcall;

    procedure pm_SetItem(anIndex: Integer; const anItem: TDateInterval); stdcall;
      {-}
  // public methods
    function  Add(const anItem: TDateInterval): Integer; stdcall;
      {* - добавляет элемент Item в конец. }
    procedure Insert(anIndex: Integer; const anItem: TDateInterval); stdcall;
      {* - вставляет элемент Item по индексу Index. }
end;//IActiveIntervalList

INotSureIntervalList = interface(IInterface)
['{C5D28F6C-4EDE-4083-889D-C5D2A4D476D4}']
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
    procedure  pm_GetItem(anIndex: Integer; out aRet: TNotSureInfo); stdcall;

    procedure pm_SetItem(anIndex: Integer; const anItem: TNotSureInfo); stdcall;
      {-}
  // public methods
    function  Add(const anItem: TNotSureInfo): Integer; stdcall;
      {* - добавляет элемент Item в конец. }
    procedure Insert(anIndex: Integer; const anItem: TNotSureInfo); stdcall;
      {* - вставляет элемент Item по индексу Index. }
end;//INotSureIntervalList

IRedactionSourceDocumentInfoList = interface(IInterface)
['{B5DAB5E0-ADA1-4FD3-AED4-8847E34EF301}']
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
    procedure  pm_GetItem(anIndex: Integer; out aRet: TRedactionSourceDocumentInfo); stdcall;

    procedure pm_SetItem(anIndex: Integer; const anItem: TRedactionSourceDocumentInfo); stdcall;
      {-}
  // public methods
    function  Add(const anItem: TRedactionSourceDocumentInfo): Integer; stdcall;
      {* - добавляет элемент Item в конец. }
    procedure Insert(anIndex: Integer; const anItem: TRedactionSourceDocumentInfo); stdcall;
      {* - вставляет элемент Item по индексу Index. }
end;//IRedactionSourceDocumentInfoList

// [$175966492]
// *  Операции "Следующее изменение" и "Предыдущее изменение" должны работать относительно позиции
// курсора (если он на экране) или относительно верхнего края документа в фокусе.
// * Операция "Следующее изменение" должна работать только до конца документа (не переходя в начало
// по циклу)
// * Операция "Предыдущее изменение" должна работать только до начала документа (не переходя в
// конец по циклу)
IDiffIterator = interface (IInterface) ['{A9AA18D9-F87F-4A47-988B-789AA069EEE0}']
	function DontUseMe: Pointer;
	function AcquireNext (): TParaNum; stdcall;

	function AcquirePrev (): TParaNum; stdcall;

	function HasNext (): Bytebool; stdcall;

	function HasPrev (): Bytebool; stdcall;

	procedure MoveTo (
		aPara: TParaNum
	); stdcall; // can raise ECanNotFindData

	function Next (): TParaNum; stdcall; // can raise ECanNotFindData

	function Prev (): TParaNum; stdcall; // can raise ECanNotFindData
end;

IBookmarkList = interface(IInterface)
['{C3264FF1-7781-4EF6-A20B-35D697C014B9}']
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
    procedure  pm_GetItem(anIndex: Integer; out aRet: TBookmark2); stdcall;

    procedure pm_SetItem(anIndex: Integer; const anItem: TBookmark2); stdcall;
      {-}
  // public methods
    function  Add(const anItem: TBookmark2): Integer; stdcall;
      {* - добавляет элемент Item в конец. }
    procedure Insert(anIndex: Integer; const anItem: TBookmark2); stdcall;
      {* - вставляет элемент Item по индексу Index. }
end;//IBookmarkList

IFragmentList = interface(IInterface)
['{2DF09B8E-6C87-4B00-996C-00248FC2A12A}']
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
    procedure  pm_GetItem(anIndex: Integer; out aRet: TContext); stdcall;

    procedure pm_SetItem(anIndex: Integer; const anItem: TContext); stdcall;
      {-}
  // public methods
    function  Add(const anItem: TContext): Integer; stdcall;
      {* - добавляет элемент Item в конец. }
    procedure Insert(anIndex: Integer; const anItem: TContext); stdcall;
      {* - вставляет элемент Item по индексу Index. }
end;//IFragmentList

ISubList = interface(IInterface)
['{A8A99F27-9EFD-4C4C-8764-61798BA1C728}']
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
    function  pm_GetItem(anIndex: Integer): Longword; stdcall;

    procedure pm_SetItem(anIndex: Integer; const anItem: Longword); stdcall;
      {-}
  // public methods
    function  Add(const anItem: Longword): Integer; stdcall;
      {* - добавляет элемент Item в конец. }
    procedure Insert(anIndex: Integer; const anItem: Longword); stdcall;
      {* - вставляет элемент Item по индексу Index. }
  // public properties
    property  Items[anIndex: Integer]: Longword
      read pm_GetItem
      write pm_SetItem;
      default;
      {* - элементы списка. }
end;//ISubList

IContextList = interface(IInterface)
['{AEBDD974-3308-4D5B-A75F-8B96413A89FF}']
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
    procedure  pm_GetItem(anIndex: Integer; out aRet: IFragmentList); stdcall;

    procedure pm_SetItem(anIndex: Integer; const anItem: IFragmentList); stdcall;
      {-}
  // public methods
    function  Add(const anItem: IFragmentList): Integer; stdcall;
      {* - добавляет элемент Item в конец. }
    procedure Insert(anIndex: Integer; const anItem: IFragmentList); stdcall;
      {* - вставляет элемент Item по индексу Index. }
end;//IContextList

IFoundContext = interface (IInterface) ['{2852766C-A9A5-4A40-8C9F-FD957D1D856E}']
	function DontUseMe: Pointer;
	procedure GetList (out aRet {: IContextList}); stdcall;
end;

IDocumentTextProvider = interface (IInterface) ['{EDE34F9F-F36F-48FA-82BA-FD755CE46B4B}']
	function DontUseMe: Pointer;
	function AllLeafParaCount (
		aLayerId: TLayerID
	): Longword; stdcall; // can raise EInvalidLayerID

	function ChildrenCount (
		aLayerId: TLayerID
	): Longword; stdcall; // can raise EInvalidLayerID

	procedure FindBlockOrSub (
		aId: TExternalID;
		out aRet {: INodeIndexPath}
	); stdcall; // can raise ECanNotFindData

	procedure FindContext (
		const aContext: IString;
		aFromId: TExternalID;
		out aRet {: IFoundContext}
	); stdcall; // can raise ECanNotFindData

	procedure FindPara (
		aId: TExternalID;
		out aRet {: INodeIndexPath}
	); stdcall; // can raise ECanNotFindData

	procedure GetChildBookmarks (
		const aId: TEntryPoint;
		out aRet {: IBookmarkList}
	); stdcall; // can raise EEmptyResult, EInvalidEntryPoint

	procedure GetChildComment (
		const aId: TEntryPoint;
		out aRet {: IEVDStream}
	); stdcall; // can raise EInvalidEntryPoint

	procedure GetChildEvdStyle (
		const aId: TEntryPoint;
		out aRet {: IEVDStream}
	); stdcall; // can raise EInvalidEntryPoint

	function GetChildExternalId (
		const aId: TEntryPoint
	): TExternalID; stdcall; // can raise EInvalidEntryPoint

	function GetChildLayerId (
		const aId: TEntryPoint
	): TLayerID; stdcall; // can raise EInvalidEntryPoint

	procedure GetChildTechComment (
		const aId: TEntryPoint;
		out aRet {: IString}
	); stdcall; // can raise EInvalidEntryPoint

	procedure GetChildText (
		const aId: TEntryPoint;
		out aRet {: IString}
	); stdcall; // can raise EInvalidEntryPoint

	function GetChildType (
		const aId: TEntryPoint
	): TEVDType; stdcall; // can raise EInvalidEntryPoint

	procedure GetPrefixTree (
		aId: TExternalID;
		out aRet {: INodeBase}
	); stdcall;

	procedure GetSubList (
		const aId: TEntryPoint;
		out aRet {: ISubList}
	); stdcall;

	// Если есть похожие к sub вернет true, иначе false.
	function HasSame (
		aId: TExternalID
	): Bytebool; stdcall;

	procedure RemoveChildComment (
		const aId: TEntryPoint
	); stdcall;

	procedure SetChildComment (
		const aId: TEntryPoint;
		const aComment: IEVDStream
	); stdcall; // can raise EInvalidEntryPoint

	// Нужно ли показывать иконку для блока на сабпанели
	function ShowSubPanelIcon (
		aId: TExternalID
	): Bytebool; stdcall;
end;

IDocumentTextProviderList = interface(IInterface)
['{D5FCD08C-B18F-4127-AC59-AF4E25A51AC0}']
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
    procedure  pm_GetItem(anIndex: Integer; out aRet: IDocumentTextProvider); stdcall;

    procedure pm_SetItem(anIndex: Integer; const anItem: IDocumentTextProvider); stdcall;
      {-}
  // public methods
    function  Add(const anItem: IDocumentTextProvider): Integer; stdcall;
      {* - добавляет элемент Item в конец. }
    procedure Insert(anIndex: Integer; const anItem: IDocumentTextProvider); stdcall;
      {* - вставляет элемент Item по индексу Index. }
end;//IDocumentTextProviderList

ICommentsParaList = interface(IInterface)
['{5FA3C62C-8928-49A6-ABCD-E8487813FC8C}']
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
    function  pm_GetItem(anIndex: Integer): TParaId; stdcall;

    procedure pm_SetItem(anIndex: Integer; const anItem: TParaId); stdcall;
      {-}
  // public methods
    function  Add(const anItem: TParaId): Integer; stdcall;
      {* - добавляет элемент Item в конец. }
    procedure Insert(anIndex: Integer; const anItem: TParaId); stdcall;
      {* - вставляет элемент Item по индексу Index. }
  // public properties
    property  Items[anIndex: Integer]: TParaId
      read pm_GetItem
      write pm_SetItem;
      default;
      {* - элементы списка. }
end;//ICommentsParaList

IExternalObjectDataList = interface(IInterface)
['{FD067004-64CD-4A0C-839A-FAF378D7E03D}']
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
    procedure  pm_GetItem(anIndex: Integer; out aRet: TExternalObjectData); stdcall;

    procedure pm_SetItem(anIndex: Integer; const anItem: TExternalObjectData); stdcall;
      {-}
  // public methods
    function  Add(const anItem: TExternalObjectData): Integer; stdcall;
      {* - добавляет элемент Item в конец. }
    procedure Insert(anIndex: Integer; const anItem: TExternalObjectData); stdcall;
      {* - вставляет элемент Item по индексу Index. }
end;//IExternalObjectDataList

IDocumentTextProviderDescriptorList = interface(IInterface)
['{1FE6402E-2A8A-4B25-86BE-251B219D8ABF}']
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
    procedure  pm_GetItem(anIndex: Integer; out aRet: TDocumentTextProviderDescriptor); stdcall;

    procedure pm_SetItem(anIndex: Integer; const anItem: TDocumentTextProviderDescriptor); stdcall;
      {-}
  // public methods
    function  Add(const anItem: TDocumentTextProviderDescriptor): Integer; stdcall;
      {* - добавляет элемент Item в конец. }
    procedure Insert(anIndex: Integer; const anItem: TDocumentTextProviderDescriptor); stdcall;
      {* - вставляет элемент Item по индексу Index. }
end;//IDocumentTextProviderDescriptorList

IDocPointList = interface(IInterface)
['{23E9F1C5-E8C3-40D7-B164-7A8D5ABA5216}']
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
    procedure  pm_GetItem(anIndex: Integer; out aRet: TDocPoint); stdcall;

    procedure pm_SetItem(anIndex: Integer; const anItem: TDocPoint); stdcall;
      {-}
  // public methods
    function  Add(const anItem: TDocPoint): Integer; stdcall;
      {* - добавляет элемент Item в конец. }
    procedure Insert(anIndex: Integer; const anItem: TDocPoint); stdcall;
      {* - вставляет элемент Item по индексу Index. }
end;//IDocPointList

IDiffDocParaList = interface(IInterface)
['{22033D4B-258E-4B5A-A179-5C2794559448}']
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
    procedure  pm_GetItem(anIndex: Integer; out aRet: TDiffDocPara); stdcall;

    procedure pm_SetItem(anIndex: Integer; const anItem: TDiffDocPara); stdcall;
      {-}
  // public methods
    function  Add(const anItem: TDiffDocPara): Integer; stdcall;
      {* - добавляет элемент Item в конец. }
    procedure Insert(anIndex: Integer; const anItem: TDiffDocPara); stdcall;
      {* - вставляет элемент Item по индексу Index. }
end;//IDiffDocParaList

IRedactionInfoList = interface(IInterface)
['{8BDE1298-6218-4C49-9024-3F404F6CC809}']
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
    procedure  pm_GetItem(anIndex: Integer; out aRet: TRedactionInfo); stdcall;

    procedure pm_SetItem(anIndex: Integer; const anItem: TRedactionInfo); stdcall;
      {-}
  // public methods
    function  Add(const anItem: TRedactionInfo): Integer; stdcall;
      {* - добавляет элемент Item в конец. }
    procedure Insert(anIndex: Integer; const anItem: TRedactionInfo); stdcall;
      {* - вставляет элемент Item по индексу Index. }
end;//IRedactionInfoList

// Интерфейс обеспечивающий работу с документом.
IDocument = interface (IEntityBase) ['{2906776F-DD41-403A-AF10-DDD0F9BD6590}']
	procedure GetAnnotation (out aRet {: IDocument}); stdcall;

	procedure GetAttributesRoot (out aRet {: INodeBase}); stdcall;

	procedure GetBookmarkList (out aRet {: IBookmarkList}); stdcall;

	// Статус изменения документа
	function GetChangeStatus (): Longword; stdcall;

	procedure GetCommentsParaList (out aRet {: ICommentsParaList}); stdcall;

	procedure GetContentsRoot (out aRet {: INodeBase}); stdcall;

	// Создает экземпляр Закладки на заданный идентификатор параграфа. Присваивает ей в качестве
	// названия короткое имя документа. А в качестве full_name имя документа и имя ближайшего (сверху)
	// саба или блока (как в списках).
	procedure CreateBookmark (
		aPara: TParaId;
		aIsPara: Bytebool;
		out aRet {: IBookmark}
	); stdcall;

	// Создать журнальную закладку
	procedure CreateJournalBookmark (
		aPara: TParaId;
		out aRet {: IJournalBookmark}
	); stdcall;

	// Возвращает документ - редакцию, заказанную через  filters.
	// Если текущая редакция равна заказанной - возвращает NULL
	procedure CreateView (
		const aFilters: IDocumentState;
		out aRet {: IDocument}
	); stdcall;

	procedure GetCurrentState (out aRet {: IDocumentState}); stdcall;

	function GetDocType (): TDocumentType; stdcall;

	// Не показывать статус изменения данного документа в текущей сессии
	procedure DontShowDocumentStatusChangesWarning (); stdcall;

	procedure GetExternalObjectDataList (out aRet {: IExternalObjectDataList}); stdcall;

	procedure GetFilePosition (out aRet {: IString}); stdcall;

	procedure GetAnnotationHeaderEvd (
		aHandle: Longword;
		out aRet {: IStream}
	); stdcall; // can raise EUnsupported

	// вернуть число документов для автореферата
	function GetAutoReferatDocCount (): Cardinal; stdcall; // can raise EUnsupported

	procedure GetAutoreferatHeaderEvd (
		out aRet {: IStream}
	); stdcall; // can raise EUnsupported

	procedure GetCorrespondents (
		const aCategory: INodeBase;
		out aOutList {: ICatalogBase}
	); stdcall;

	// Возвращает список корреспондентов к фрагменту документа (список параграфов) для указанной
	// категории (category).
	// 
	// для редакций, отлчных от "главной", возвращает NULL
	procedure GetCorrespondentsToPart (
		const aPosList: IPositionList;
		const aCategory: INodeBase;
		out aOutList {: ICatalogBase}
	); stdcall;

	// Получить список выпускаемых фирмой препаратов
	procedure GetDrugList (
		out aRet {: ICatalogBase}
	); stdcall; // can raise ECanNotFindData

	// возвращает evd поток документа - совета дня или evd поток заглушки для отсутствующего в базе
	// документа или документа запрещенного к просмотру
	procedure GetEvdStream (
		out aRet {: IStream}
	); stdcall;

	// Получение флеш-ролика
	procedure GetFlash (
		out aRet {: IExternalObject}
	); stdcall;

	// Получить url для отсканированного WWW-образа документа.
	procedure GetInternetImageUrl (
		aBlockId: Longint;
		out aRet {: IExternalLink}
	); stdcall;

	procedure GetLink (
		aDocId: Longword;
		const aId: TTopic;
		aRid: TRedactionID;
		out aRet {: ILink}
	); stdcall;

	procedure GetLinkInfo (
		aDocId: Longword;
		const aId: TTopic;
		aRid: TRedactionID;
		out a: TLinkInfo
	); stdcall;

	// Получить интерфейс объекта, на который указывает гипертекстовая ссылка, по внутреннему
	// идентификатору.
	// Возвращается интерфейс на объект (obj) и тип объекта (obj_type).
	// Дополнительно можно получить интерфейс (missing_info) с информацией, в каких блоках (базах)
	// содержится отсутствующий объект (метод get_missing_info)
	// Будет использоваться для перехода по гипертекстовой ссылке.
	procedure GetLinkedObject (
		aDocId: Longword;
		const aId: TTopic;
		aRid: TRedactionID;
		out aObjType: TLinkedObjectType;
		out aObj {: IUnknown}
	); stdcall; // can raise EInvalidTopicId, EFolderLinkNotFound

	// Возвращает расширенную информацию по отсутствующему объекту (pid - идентификатор и класс
	// объекта по ссылке)
	procedure GetMissingInfoForObject (
		const aPid: TPId;
		out aMissingInfo {: IMissingInfo}
	); stdcall;

	// Получить данные по мульnиссылке в виде списка (DocId, SubId)
	procedure GetMultiLinkInfo (
		aDocId: Longword;
		const aId: TTopic;
		out aRet {: IDocPointList}
	); stdcall; // can raise ECanNotFindData, EInternalDatabaseError

	// Возвращает информацию об интервале неуверенности документа. Если указанная в параметра date
	// дата не попадает в интревал бросает CanNotFindData
	procedure GetNotSureInfo (
		const aDate: TDate;
		const aStart: TDate;
		const aFinish: TDate;
		out aInfo {: IDocument};
		out aWarning {: IString}
	); stdcall;

	procedure GetRespondents (
		const aCategory: INodeBase;
		out aOutList {: ICatalogBase}
	); stdcall;

	// Возвращает список респондентов к фрагменту документа (список параграфов) для указанной
	// категории (category).
	// 
	// для редакций, отлчных от "главной", возвращает NULL
	procedure GetRespondentsToPart (
		const aPosList: IPositionList;
		const aCategory: INodeBase;
		out aOutList {: ICatalogBase}
	); stdcall;

	// Получить список похожих документов
	procedure GetSameDocuments (
		out aOutList {: ICatalogBase}
	); stdcall;

	procedure GetSameToPoint (
		aId: TExternalID;
		out aOutList {: ICatalogBase}
	); stdcall;

	// Получить расширенную информацию по текущему документу (в случае его отсутствия - в каких блоках
	// этот документ присутствует)
	procedure GetSelfMissingInfo (
		out aMissingInfo {: IMissingInfo}
	); stdcall;

	procedure GetTextProvider (
		aAllAtOnce: Bytebool;
		out aRet {: IDocumentTextProvider}
	); stdcall; // can raise EUnsupported, ECanNotFindData

	procedure GetTextProviderByDesc (
		aHandle: Longword;
		out aRet {: IDocumentTextProvider}
	); stdcall; // can raise EUnsupported

	procedure GetTextProviderDescList (
		out aRet {: IDocumentTextProviderDescriptorList}
	); stdcall; // can raise EUnsupported

	procedure GetTextProviderList (
		aAllAtOnce: Bytebool;
		out aRet {: IDocumentTextProviderList}
	); stdcall; // can raise EUnsupported

	procedure GetTimeMachineWarning (
		const aDate: TDate;
		out a: TTimeMachineWarning
	); stdcall;

	function HasAnnotation (): Bytebool; stdcall;

	// для документов типа DT_BOOK возвращает false,
	// для остальных true
	function HasAttributes (): Bytebool; stdcall;

	// есть ли у документа хронология рассмотрения судебного дела
	// K555095873
	function HasChronology (): Bytebool; stdcall;

	// Проверка наличия корреспондентов (любогй категории) у текущего документа.
	// Возвращает true в случае, если список корреспондентов для документа по категории CR_ALL не пуст.
	// 
	// для редакций, отличных от "главной", возвращает FALSE
	function HasCorrespondents (
		const aCategory: INodeBase
	): Bytebool; stdcall;

	// Проверка наличия WWW-образа у текущего документа.
	// Возвращает true в случае, если у текущего документа есть WWW-образ.
	function HasInternetImage (): Bytebool; stdcall;

	// Функция показывает наличие следующей редакции для объекта.
	// Следующая редакция считается относительно текущего состояния (current_redaction).
	// Возвращает True в случае наличия хотябы одной более поздней (чем текущая) редакции.
	function HasNextRedaction (): Bytebool; stdcall;

	// Функция показывает наличие предыдущей редакции для объекта.
	// Предыдущая редакция считается относительно текущего состояния (current_redaction).
	// Возвращает True в случае наличия хотябы одной более ранней (чем текущая) редакции.
	function HasPrevRedaction (): Bytebool; stdcall;

	// Проверка наличия справки у текущего документа.
	// Возвращает true в случае, если у текущего документа есть справка.
	// 
	// для редакций, отличных от "главной", поведение такое же как и для "главной"
	function HasRelatedDoc (): Bytebool; stdcall;

	// Проверка наличия респондентов (любогй категории) у текущего документа.
	// Возвращает true в случае, если список респондентов для документа по категории CR_ALL не пуст.
	// 
	// для редакций, отличных от "главной", возвращает FALSE
	function HasRespondents (
		const aCategory: INodeBase
	): Bytebool; stdcall;

	// Проверка наличия похожих документов
	function HasSameDocuments (): Bytebool; stdcall;

	// Есть ли у документа перевод
	function HasTranslation (): Bytebool; stdcall;

	// Присутствие предупреждения.
	function HasWarning (): Bytebool; stdcall;

	// внутренний номер документа в базе
	function GetInternalId (): Longword; stdcall;

	// Специальный метод, позволяющий выяснить "жив" ли документ на сервере приложений. Если документ
	// "жив" - возвращается `true` (как правило такая проверка нужна, когда документ может быть
	// удален, например во время обновления базы). Результаты данного метода не кешируются на
	// адаптере, т.е. вызов этого метода всегда обращается к серверу приложений.
	function IsAlive (): Bytebool; stdcall;

	// Метод позволяет определить попадает ли date в интервал неуверенности документа.
	function IsDateInNotSureInterval (
		const aDate: TDate
	): Bytebool; stdcall;

	// индексирован ли документ для морфопоиска
	function IsMorphoSearchSupported (): Bytebool; stdcall;

	function IsMyBookmark (
		const aBookmark: IBookmark
	): Bytebool; stdcall;

	function IsSameDocument (
		const aDoc: IDocument
	): Bytebool; stdcall;

	function IsSameRedaction (
		const aView: IDocument
	): Bytebool; stdcall;

	// Возвращает равенство документов с учетом их состояния (в отличии от is_same_entity, который
	// возвращает равенство без учета состояния). Состоянием документа является суперпозиция номера
	// редакции, языка и списка извлечений.
	function IsSameView (
		const aView: IDocument
	): Bytebool; stdcall;

	// Проверка возможности отображения атрибутов документа для текущего документа.
	// Возвращает true в случае, если показ атрибутов разрешен.
	// 
	// для редакций проверяются атрибуты, соответсвующие редакции (т.е. соответсвующие топику редакции
	// )
	function MayShowAttributes (): Bytebool; stdcall;

	// Имя документа.
	procedure GetName (out aRet {: IString}); stdcall;

	// Доступна новая ревизия документа (для супермобильной версии)
	function GetNewRevisionAvailable (): Bytebool; stdcall;

	// True - если документ не подключен к машине времени
	function GetNotTm (): Bytebool; stdcall;

	procedure GetRedactionsList (out aRet {: IRedactionInfoList}); stdcall;

	procedure GetRelatedDoc (out aRet {: IDocument}); stdcall;

	// Краткое имя документа.
	procedure GetShortName (out aRet {: IString}); stdcall;

	// размер документа в байтах
	function GetSize (): Longword; stdcall;

	// Статус документа
	function GetStatus (): TItemStatus; stdcall;

	procedure GetTextLanguages (out aRet {: ILanguagesList}); stdcall;

	procedure GetTranslation (out aRet {: IDocument}); stdcall;

	// Предупреждение к документу.
	procedure GetWarning (out aRet {: IString}); stdcall;
end;

// Закладка на документ. Используется для сохранения документа (и позиции) в папках.
IBookmark = interface (IEntityBase) ['{830AC32A-C3AC-4AA1-A5A1-0ACAE229DD2A}']
	// полное имя документа и блока/саба на который указывает закладка. Используется в качестве hint
	// в Папках.
	procedure GetComment (out aRet {: IString}); stdcall;
	procedure SetComment (const aComment: IString); stdcall;

	procedure GetDocument (out aRet {: IDocument}); stdcall;

	// Названите закладки. Используется в качестве caption в Папках.
	procedure GetName (out aRet {: IString}); stdcall;
	procedure SetName (const aName: IString); stdcall;

	function GetParagraph (): TParaId; stdcall;

	procedure GetPid (out a: TPId); stdcall;
end;

// Интерфейс для работы с редакциями объекта.
IDocumentState = interface (IInterface) ['{71C2A950-3D61-44A9-A0FA-845C4A9F5B97}']
	function DontUseMe: Pointer;
	// [$178325284]
	function CanCompareWithAnyOtherRedaction (): Bytebool; stdcall;

	procedure Clone (
		out aRet {: IDocumentState}
	); stdcall;

	// [$178324034]
	procedure GetCurAndNextRedactionsList (out aRet {: IRedactionInfoList}); stdcall;

	procedure DiffWithRedactionById (
		aId: TRedactionID;
		out a: TDiffData
	); stdcall;

	procedure GetCurrentRedaction (
		out a: TRedactionInfo
	); stdcall;

	// возвращает true, если эта редакция актуальная, т. е. имеет тип:
	// - RT_ACTUAL
	// - RT_ACTUAL_ABOLISHED
	// - RT_ACTUAL_PREACTIVE
	function IsActual (): Bytebool; stdcall;

	function IsSameRedactions (
		const aOther: IDocumentState
	): Bytebool; stdcall;

	function GetLanguage (): TLanguages; stdcall;
	procedure SetLanguage (aLanguage: TLanguages); stdcall;

	procedure GetPrevRedactionsList (out aRet {: IRedactionInfoList}); stdcall;

	function Redaction (): TRedactionID; stdcall;

	// Операция устанавливает в качестве текущей редакцию, актуальную редакцию для данного документа.
	// Возвращает True в случае если текущая редакиция изменилась и False, если осталась той же самой,
	// что и до вызова метода.
	procedure SetActualRedaction (); stdcall; // can raise ERedactionNotFound

	// Операция устанавливает в качестве текущей следующую редакцию объекта.
	// Если следующей редакции нет, то возвращается RedactionNotFound.
	procedure SetNextRedaction (); stdcall; // can raise ERedactionNotFound

	// GetБлижайшаяДействующаяРедакцияВниз. [$178325284]
	procedure SetPrevActiveRedaction (); stdcall; // can raise ERedactionNotFound

	// Операция устанавливает в качестве текущей предыдущую редакцию объекта.
	// Если предыдущей редакции нет, то возвращается RedactionNotFound.
	procedure SetPrevRedaction (); stdcall; // can raise ERedactionNotFound

	procedure SetRedactionOnDate (
		const aDate: TDate
	); stdcall; // can raise ERedactionNotFound

	// Операция устанавливает в качестве текущей редакцию с заданным идентификатором.
	// Возвращает True в случае если текущая редакиция изменилась и False, если осталась той же самой,
	// что и до вызова метода.
	// Если задан неверный идентификатор редакции, то возвращается InvalidRedactionId.
	procedure SetRedactionOnId (
		aId: TRedactionID
	); stdcall; // can raise ERedactionNotFound
end;

// Журнальная закладка
IJournalBookmark = interface (IEntityBase) ['{7EC5D2E1-6B5C-4C7E-AE21-C98E21A8D018}']
	procedure GetDocument (out aRet {: IDocument}); stdcall;

	// Полное имя (хинт)
	procedure GetFullName (out aRet {: IString}); stdcall;

	// Имя
	procedure GetName (out aRet {: IString}); stdcall;

	function GetParaId (): Longword; stdcall;
end;

ILink = interface (IInterface) ['{FBA5DE98-0FAD-4647-B2DE-AB788A6DDFE6}']
	function DontUseMe: Pointer;
	function GetKind (): TLinkKind; stdcall;

	procedure GetLinkInfo (
		out a: TLinkInfo
	); stdcall;

	procedure GetLinkedHint (
		out aRet {: IString}
	); stdcall;

	procedure GetObject (
		out aRet {: IUnknown}
	); stdcall; // can raise EInvalidTopicId, EFolderLinkNotFound

	function GetObjectType (): TLinkedObjectType; stdcall;
end;

IJournalBookmarkList = interface(IInterface)
['{26233056-C81A-4156-9643-0E195545125B}']
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
    procedure  pm_GetItem(anIndex: Integer; out aRet: IJournalBookmark); stdcall;

    procedure pm_SetItem(anIndex: Integer; const anItem: IJournalBookmark); stdcall;
      {-}
  // public methods
    function  Add(const anItem: IJournalBookmark): Integer; stdcall;
      {* - добавляет элемент Item в конец. }
    procedure Insert(anIndex: Integer; const anItem: IJournalBookmark); stdcall;
      {* - вставляет элемент Item по индексу Index. }
end;//IJournalBookmarkList

IDiffDocDataProvider = interface (IInterface) ['{E9D2FB7F-1DE5-4C75-8998-72B6C443FF03}']
	function DontUseMe: Pointer;
	function GetAllLeafParaCount (): Longword; stdcall;

	procedure GetChangedBlock (
		aI: Longword;
		out a: TChangedBlock
	); stdcall;

	function GetChangedBlockCount (): Longword; stdcall;

	// параграф с датами изменений документа для левого документа
	function GetDateParaLeft (
		out aPara: TDiffDocPara
	): Bytebool; stdcall;

	// параграф с датами изменений документа для правого документа
	function GetDateParaRight (
		out aPara: TDiffDocPara
	): Bytebool; stdcall;

	// Заголовок документа состоит из:
	// 
	// Фраза "Обзор изменений документа"
	// Длинное имя документа (!Name)
	// Фраза "Подготовлено экспертами компании "Гарант"
	// Фраза "Далее приведены изменившиеся фрагменты редакций:"
	procedure GetHeaderParaList (
		out aRet {: IDiffDocParaList}
	); stdcall;

	// Каждая таблица имеет заголовок содержащий имена редакций (это имя редакции для левого документа)
	procedure GetRedactionNameLeft (
		out a: TDiffDocPara
	); stdcall;

	// Каждая таблица имеет заголовок содержащий имена редакций (это имя редакции для правого
	// документа)
	procedure GetRedactionNameRight (
		out a: TDiffDocPara
	); stdcall;
end;

IObjectFromLink = interface (IInterface) ['{51778307-FE15-45BF-9A86-62A66BF81725}']
	function DontUseMe: Pointer;
	procedure GetObject (
		out aRet {: IUnknown}
	); stdcall;

	function GetObjectType (): TLinkedObjectType; stdcall;
end;

const

 { PositionInDocument }
	POSITION_TYPE_MASK = Longword(2147483648);
	POSITION_TYPE_SUB_ID = Longword(0);
	POSITION_TYPE_PARA_ID = Longword(2147483648);

 { TextProviderConstants }
	ROOT_CHILD = TChildID(0);
	ROOT_LAYER = TLayerID(4294967295);
 { 0xFFFFFFFF }

implementation
end.