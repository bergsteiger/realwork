unit DocumentUnit; {$Z4}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "GblAdapterLib"
// ������: "w:/garant6x/implementation/Garant/GblAdapterLib/DocumentUnit.pas"
// Delphi ���������� ��� �������� (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::Document
//
//
// ��� ����� ����������� ��� ��� "������-������".
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
{ - ��������������� �������� IMissingInfo. }

IPositionList = interface;
{ - ��������������� �������� IPositionList. }

IActiveIntervalList = interface;
{ - ��������������� �������� IActiveIntervalList. }

INotSureIntervalList = interface;
{ - ��������������� �������� INotSureIntervalList. }

IRedactionSourceDocumentInfoList = interface;
{ - ��������������� �������� IRedactionSourceDocumentInfoList. }

IDiffIterator = interface;
{ - ��������������� �������� IDiffIterator. }

IEVDStream = IStream;

IBookmarkList = interface;
{ - ��������������� �������� IBookmarkList. }

IFragmentList = interface;
{ - ��������������� �������� IFragmentList. }

ISubList = interface;
{ - ��������������� �������� ISubList. }

IContextList = interface;
{ - ��������������� �������� IContextList. }

IFoundContext = interface;
{ - ��������������� �������� IFoundContext. }

IDocumentTextProvider = interface;
{ - ��������������� �������� IDocumentTextProvider. }

IDocumentTextProviderList = interface;
{ - ��������������� �������� IDocumentTextProviderList. }

ICommentsParaList = interface;
{ - ��������������� �������� ICommentsParaList. }

IExternalObjectDataList = interface;
{ - ��������������� �������� IExternalObjectDataList. }

IDocumentTextProviderDescriptorList = interface;
{ - ��������������� �������� IDocumentTextProviderDescriptorList. }

IDocPointList = interface;
{ - ��������������� �������� IDocPointList. }

IDiffDocParaList = interface;
{ - ��������������� �������� IDiffDocParaList. }

IRedactionInfoList = interface;
{ - ��������������� �������� IRedactionInfoList. }

IDocument = interface;
{ - ��������������� �������� IDocument. }

IBookmark = interface;
{ - ��������������� �������� IBookmark. }

IDocumentState = interface;
{ - ��������������� �������� IDocumentState. }

IJournalBookmark = interface;
{ - ��������������� �������� IJournalBookmark. }

ILink = interface;
{ - ��������������� �������� ILink. }

IJournalBookmarkList = interface;
{ - ��������������� �������� IJournalBookmarkList. }

IDiffDocDataProvider = interface;
{ - ��������������� �������� IDiffDocDataProvider. }

IObjectFromLink = interface;
{ - ��������������� �������� IObjectFromLink. }


// ��� �������, �� ������� ��������� �������������� ������.
PLinkedObjectType = ^TLinkedObjectType;
TLinkedObjectType = (
	LO_DOCUMENT // ��������.
	, LO_RELATED_DOCUMENT // ������� � ���������.
	, LO_EXTERNAL_OBJECT // ������� ������.
	, LO_MULTILINK // ������������ (������ ����������).
	, LO_EXTERNAL_LINK // ������� ������.
	, LO_QUERY // ������.
	, LO_BOOKMARK // ��������
	, LO_EXTERNAL_OPERATION
	, LO_ENO // ������ �� ENO
	, LO_AUTOREFERAT // �����������
	, LO_SCRIPT // ������ ��� �271754146
	, LO_DELETED_FOLDERS_CONTENT
);

// �������� ������������� ���������
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

// ������������ ��� ������� ��������� �������� � ���������� ��������������� ���������,
// �������������� � ����.
EInvalidTopicId = class (Exception);

PPositionType = ^TPositionType;
TPositionType = (
	PT_SUB
	, PT_PARA
	, PT_BOOKMARK
);

// ����� ����� � ��������.
PPosition = ^TPosition;
TPosition = packed record
	rType: TPositionType; // ���� ������������ �������� ���� point. ���� true �� point ��������� �� ��������, � ��������� ������ �� ��� ��� ����.
	rPoint: Longword; // ����� �����.
end;

// ���������� �������������� �������� ������ ����������.
PTopic = ^TTopic;
TTopic = packed record
	rPid: TPId;
	rPosition: TPosition;
end;

// ������������� ��������� (��� ���� ���������, ������� ������ ���������� ����)
PParaId = ^TParaId;
TParaId = Longword;

// ��� ���������
PDocumentType = ^TDocumentType;
TDocumentType = (
	DT_DOCUMENT
	, DT_EXPLANATORY
	, DT_AUTO_REFERAT
	, DT_BOOK
	, DT_TIP // ����� ���
	, DT_MEDICAL_EXPLANATORY // ������� ������� ���. ��������
	, DT_MEDICAL_FIRM // �������� � ��������� ����� �� ������
	, DT_MEDICAL_DOCUMENT
	, DT_FLASH // ��������-����
	, DT_ACTUAL_ANALYTICS // ���
	, DT_ACTUAL_ANALYTICS_CONTENTS // ���-����������
	, DT_REF // ����� � www ��������
);

// �� ������� ������ �� �������� ������� (�������� �� ��� ������)
EFolderLinkNotFound = class (Exception);

// ������������� �������� ������� (������ ����� ��������� � ObjectId).
PRedactionID = ^TRedactionID;
TRedactionID = Longint;

PNotSureInfo = ^TNotSureInfo;
TNotSureInfo = packed record
	rWarning: IString;
	rInterval: TDateInterval;
end;

// ��� �������� �������.
PRedactionType = ^TRedactionType;
TRedactionType = (
	RT_ACTUAL // ��������
	, RT_ACTUAL_ABOLISHED // �������� �� �������� DS_ABOLISHED (������� ����)
	, RT_ACTUAL_PREACTIVE // �������� �� �������� DS_PREACTIVE (�� ������� � ����)
	, RT_OLD // �������� � ������� �������� �� ����������, � ������� ��� �� DS_ABOLISHED, �� DS_PREACTIVE
	, RT_NEW // �������� � ������� �������� ����� ����������, � ������� ��� �� DS_ABOLISHED, �� DS_PREACTIVE
	, RT_NEW_ABOLISHED
	, RT_NEW_PREACTIVE // �������� �� �������� DS_PREACTIVE (�� ������� � ����)
);

PRedactionSourceDocumentInfo = ^TRedactionSourceDocumentInfo;
TRedactionSourceDocumentInfo = packed record
	rDisplayName: IString; // ���������� �������� (�� ��� ������������)
	rDocTopic: TTopic; // ����� ��� �������� � ���������� ��������
end;

// ������������ � ������ ������� ��������� �������������� �������� �������.
ERedactionNotFound = class (Exception);

// ��� �����
PLinkKind = ^TLinkKind;
TLinkKind = (
	LK_INTERNAL_INVALID
	, LK_REGULAR
	, LK_EXTERNAL
	, LK_ABOLISHED // ������ �� ���������� ���� ��������
	, LK_PREACTIVE // ������ �� �� ���������� � ���� ��������
	, LK_ENO // ������ �� ��
	, LK_EDITION // �������� ���������
	, LK_SCRIPT // ������ �� ������
);

PLinkInfo = ^TLinkInfo;
TLinkInfo = packed record
	rKind: TLinkKind; // ��� �����
	rHint: IString;
end;

EInvalidDate = class (Exception);

// �������� ������� �� ���������� � �������.
// ������������ � ������ ������ �������� "����� ����������" � ���������� � ������� ���������
// �������.
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

// ������ ���������� ���������� � ������� ������ ������� ���������
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

// ����� ����� � �������� (���� DocId SubId)
PDocPoint = ^TDocPoint;
TDocPoint = packed record
	rDocId: TBaseTypesObjectId; // ������������� ���������
	rSubId: TSubId; // ����� ����/�����
end;

ILikeable = interface (IInterface) ['{CD879569-CC93-4E02-B56F-C5C1B3FBBEBC}']
	function DontUseMe: Pointer;
	// ����������� �������� ������
	function GetCanLike (): Bytebool; stdcall;

	// ��������
	procedure Like (); stdcall;

	// �� ��������
	procedure Unlike (); stdcall;
end;

// ���������� � �������� �������.
PRedactionInfo = ^TRedactionInfo;
TRedactionInfo = packed record
	rName: IString; // ��� ��������.
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
	rHeader: IDiffDocParaList; // �������� ����������� ������� � ��������� �� ������������ �����, ��������� � ����������,�������  ������������ ���������� �������� (����)
	rRightTextParaList: IDiffDocParaList; // ���������� �������� ������ ��������
	rLeftTextParaList: IDiffDocParaList; // ���������� �������� ����� ��������
end;

EAllChangesInTables = class (Exception);

PDocumentLayerID = ^TDocumentLayerID;
TDocumentLayerID = TLayerID;

// ���������� �� ������������� ���������.
IMissingInfo = interface (IInterface) ['{5553DE6A-23C5-4B12-8A98-358CF08F6E59}']
	function DontUseMe: Pointer;
	// ����� ������ (���), � ������� ���������� ������������� ������.
	procedure GetBlocksInfo (out aRet {: IString}); stdcall;

	// ������������� ������ ���������� ������ � ����� ����� (����) - ���������� ��� �����������
	// ��������� ��������� � ���, � �����(��) �����(��) ���������� ������������� ������.  ���� �
	// blocks_info ���������� ������ ���� ����, �� ������������ true, � ��������� ������ false.
	function IsOneBlock (): Bytebool; stdcall;

	// ��� �������������� �������.
	procedure GetObjName (out aRet {: IString}); stdcall;
end;

IPositionList = interface(IInterface)
['{4C6C46F0-B4AF-4099-BFA3-21B631F672F6}']
    function  pm_GetCount: Integer; stdcall;
    procedure pm_SetCount(aValue: Integer); stdcall;
      { - ������ ��� ������� � �������� Count. }
    procedure Clear; stdcall;
      {* �������� ������. }
    procedure Delete(anIndex: Integer); stdcall;
      {* ������� ������� �� ������� Index. }
    property Count: Integer
      read pm_GetCount
      write pm_SetCount;
       {* ����� ��������� � ���������. }
  // property methods
    procedure  pm_GetItem(anIndex: Integer; out aRet: TPosition); stdcall;

    procedure pm_SetItem(anIndex: Integer; const anItem: TPosition); stdcall;
      {-}
  // public methods
    function  Add(const anItem: TPosition): Integer; stdcall;
      {* - ��������� ������� Item � �����. }
    procedure Insert(anIndex: Integer; const anItem: TPosition); stdcall;
      {* - ��������� ������� Item �� ������� Index. }
end;//IPositionList

IActiveIntervalList = interface(IInterface)
['{A47493FA-0883-40CB-9D8C-E0100F2FFE69}']
    function  pm_GetCount: Integer; stdcall;
    procedure pm_SetCount(aValue: Integer); stdcall;
      { - ������ ��� ������� � �������� Count. }
    procedure Clear; stdcall;
      {* �������� ������. }
    procedure Delete(anIndex: Integer); stdcall;
      {* ������� ������� �� ������� Index. }
    property Count: Integer
      read pm_GetCount
      write pm_SetCount;
       {* ����� ��������� � ���������. }
  // property methods
    procedure  pm_GetItem(anIndex: Integer; out aRet: TDateInterval); stdcall;

    procedure pm_SetItem(anIndex: Integer; const anItem: TDateInterval); stdcall;
      {-}
  // public methods
    function  Add(const anItem: TDateInterval): Integer; stdcall;
      {* - ��������� ������� Item � �����. }
    procedure Insert(anIndex: Integer; const anItem: TDateInterval); stdcall;
      {* - ��������� ������� Item �� ������� Index. }
end;//IActiveIntervalList

INotSureIntervalList = interface(IInterface)
['{C5D28F6C-4EDE-4083-889D-C5D2A4D476D4}']
    function  pm_GetCount: Integer; stdcall;
    procedure pm_SetCount(aValue: Integer); stdcall;
      { - ������ ��� ������� � �������� Count. }
    procedure Clear; stdcall;
      {* �������� ������. }
    procedure Delete(anIndex: Integer); stdcall;
      {* ������� ������� �� ������� Index. }
    property Count: Integer
      read pm_GetCount
      write pm_SetCount;
       {* ����� ��������� � ���������. }
  // property methods
    procedure  pm_GetItem(anIndex: Integer; out aRet: TNotSureInfo); stdcall;

    procedure pm_SetItem(anIndex: Integer; const anItem: TNotSureInfo); stdcall;
      {-}
  // public methods
    function  Add(const anItem: TNotSureInfo): Integer; stdcall;
      {* - ��������� ������� Item � �����. }
    procedure Insert(anIndex: Integer; const anItem: TNotSureInfo); stdcall;
      {* - ��������� ������� Item �� ������� Index. }
end;//INotSureIntervalList

IRedactionSourceDocumentInfoList = interface(IInterface)
['{B5DAB5E0-ADA1-4FD3-AED4-8847E34EF301}']
    function  pm_GetCount: Integer; stdcall;
    procedure pm_SetCount(aValue: Integer); stdcall;
      { - ������ ��� ������� � �������� Count. }
    procedure Clear; stdcall;
      {* �������� ������. }
    procedure Delete(anIndex: Integer); stdcall;
      {* ������� ������� �� ������� Index. }
    property Count: Integer
      read pm_GetCount
      write pm_SetCount;
       {* ����� ��������� � ���������. }
  // property methods
    procedure  pm_GetItem(anIndex: Integer; out aRet: TRedactionSourceDocumentInfo); stdcall;

    procedure pm_SetItem(anIndex: Integer; const anItem: TRedactionSourceDocumentInfo); stdcall;
      {-}
  // public methods
    function  Add(const anItem: TRedactionSourceDocumentInfo): Integer; stdcall;
      {* - ��������� ������� Item � �����. }
    procedure Insert(anIndex: Integer; const anItem: TRedactionSourceDocumentInfo); stdcall;
      {* - ��������� ������� Item �� ������� Index. }
end;//IRedactionSourceDocumentInfoList

// [$175966492]
// *  �������� "��������� ���������" � "���������� ���������" ������ �������� ������������ �������
// ������� (���� �� �� ������) ��� ������������ �������� ���� ��������� � ������.
// * �������� "��������� ���������" ������ �������� ������ �� ����� ��������� (�� �������� � ������
// �� �����)
// * �������� "���������� ���������" ������ �������� ������ �� ������ ��������� (�� �������� �
// ����� �� �����)
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
      { - ������ ��� ������� � �������� Count. }
    procedure Clear; stdcall;
      {* �������� ������. }
    procedure Delete(anIndex: Integer); stdcall;
      {* ������� ������� �� ������� Index. }
    property Count: Integer
      read pm_GetCount
      write pm_SetCount;
       {* ����� ��������� � ���������. }
  // property methods
    procedure  pm_GetItem(anIndex: Integer; out aRet: TBookmark2); stdcall;

    procedure pm_SetItem(anIndex: Integer; const anItem: TBookmark2); stdcall;
      {-}
  // public methods
    function  Add(const anItem: TBookmark2): Integer; stdcall;
      {* - ��������� ������� Item � �����. }
    procedure Insert(anIndex: Integer; const anItem: TBookmark2); stdcall;
      {* - ��������� ������� Item �� ������� Index. }
end;//IBookmarkList

IFragmentList = interface(IInterface)
['{2DF09B8E-6C87-4B00-996C-00248FC2A12A}']
    function  pm_GetCount: Integer; stdcall;
    procedure pm_SetCount(aValue: Integer); stdcall;
      { - ������ ��� ������� � �������� Count. }
    procedure Clear; stdcall;
      {* �������� ������. }
    procedure Delete(anIndex: Integer); stdcall;
      {* ������� ������� �� ������� Index. }
    property Count: Integer
      read pm_GetCount
      write pm_SetCount;
       {* ����� ��������� � ���������. }
  // property methods
    procedure  pm_GetItem(anIndex: Integer; out aRet: TContext); stdcall;

    procedure pm_SetItem(anIndex: Integer; const anItem: TContext); stdcall;
      {-}
  // public methods
    function  Add(const anItem: TContext): Integer; stdcall;
      {* - ��������� ������� Item � �����. }
    procedure Insert(anIndex: Integer; const anItem: TContext); stdcall;
      {* - ��������� ������� Item �� ������� Index. }
end;//IFragmentList

ISubList = interface(IInterface)
['{A8A99F27-9EFD-4C4C-8764-61798BA1C728}']
    function  pm_GetCount: Integer; stdcall;
    procedure pm_SetCount(aValue: Integer); stdcall;
      { - ������ ��� ������� � �������� Count. }
    procedure Clear; stdcall;
      {* �������� ������. }
    procedure Delete(anIndex: Integer); stdcall;
      {* ������� ������� �� ������� Index. }
    property Count: Integer
      read pm_GetCount
      write pm_SetCount;
       {* ����� ��������� � ���������. }
  // property methods
    function  pm_GetItem(anIndex: Integer): Longword; stdcall;

    procedure pm_SetItem(anIndex: Integer; const anItem: Longword); stdcall;
      {-}
  // public methods
    function  Add(const anItem: Longword): Integer; stdcall;
      {* - ��������� ������� Item � �����. }
    procedure Insert(anIndex: Integer; const anItem: Longword); stdcall;
      {* - ��������� ������� Item �� ������� Index. }
  // public properties
    property  Items[anIndex: Integer]: Longword
      read pm_GetItem
      write pm_SetItem;
      default;
      {* - �������� ������. }
end;//ISubList

IContextList = interface(IInterface)
['{AEBDD974-3308-4D5B-A75F-8B96413A89FF}']
    function  pm_GetCount: Integer; stdcall;
    procedure pm_SetCount(aValue: Integer); stdcall;
      { - ������ ��� ������� � �������� Count. }
    procedure Clear; stdcall;
      {* �������� ������. }
    procedure Delete(anIndex: Integer); stdcall;
      {* ������� ������� �� ������� Index. }
    property Count: Integer
      read pm_GetCount
      write pm_SetCount;
       {* ����� ��������� � ���������. }
  // property methods
    procedure  pm_GetItem(anIndex: Integer; out aRet: IFragmentList); stdcall;

    procedure pm_SetItem(anIndex: Integer; const anItem: IFragmentList); stdcall;
      {-}
  // public methods
    function  Add(const anItem: IFragmentList): Integer; stdcall;
      {* - ��������� ������� Item � �����. }
    procedure Insert(anIndex: Integer; const anItem: IFragmentList); stdcall;
      {* - ��������� ������� Item �� ������� Index. }
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

	// ���� ���� ������� � sub ������ true, ����� false.
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

	// ����� �� ���������� ������ ��� ����� �� ���������
	function ShowSubPanelIcon (
		aId: TExternalID
	): Bytebool; stdcall;
end;

IDocumentTextProviderList = interface(IInterface)
['{D5FCD08C-B18F-4127-AC59-AF4E25A51AC0}']
    function  pm_GetCount: Integer; stdcall;
    procedure pm_SetCount(aValue: Integer); stdcall;
      { - ������ ��� ������� � �������� Count. }
    procedure Clear; stdcall;
      {* �������� ������. }
    procedure Delete(anIndex: Integer); stdcall;
      {* ������� ������� �� ������� Index. }
    property Count: Integer
      read pm_GetCount
      write pm_SetCount;
       {* ����� ��������� � ���������. }
  // property methods
    procedure  pm_GetItem(anIndex: Integer; out aRet: IDocumentTextProvider); stdcall;

    procedure pm_SetItem(anIndex: Integer; const anItem: IDocumentTextProvider); stdcall;
      {-}
  // public methods
    function  Add(const anItem: IDocumentTextProvider): Integer; stdcall;
      {* - ��������� ������� Item � �����. }
    procedure Insert(anIndex: Integer; const anItem: IDocumentTextProvider); stdcall;
      {* - ��������� ������� Item �� ������� Index. }
end;//IDocumentTextProviderList

ICommentsParaList = interface(IInterface)
['{5FA3C62C-8928-49A6-ABCD-E8487813FC8C}']
    function  pm_GetCount: Integer; stdcall;
    procedure pm_SetCount(aValue: Integer); stdcall;
      { - ������ ��� ������� � �������� Count. }
    procedure Clear; stdcall;
      {* �������� ������. }
    procedure Delete(anIndex: Integer); stdcall;
      {* ������� ������� �� ������� Index. }
    property Count: Integer
      read pm_GetCount
      write pm_SetCount;
       {* ����� ��������� � ���������. }
  // property methods
    function  pm_GetItem(anIndex: Integer): TParaId; stdcall;

    procedure pm_SetItem(anIndex: Integer; const anItem: TParaId); stdcall;
      {-}
  // public methods
    function  Add(const anItem: TParaId): Integer; stdcall;
      {* - ��������� ������� Item � �����. }
    procedure Insert(anIndex: Integer; const anItem: TParaId); stdcall;
      {* - ��������� ������� Item �� ������� Index. }
  // public properties
    property  Items[anIndex: Integer]: TParaId
      read pm_GetItem
      write pm_SetItem;
      default;
      {* - �������� ������. }
end;//ICommentsParaList

IExternalObjectDataList = interface(IInterface)
['{FD067004-64CD-4A0C-839A-FAF378D7E03D}']
    function  pm_GetCount: Integer; stdcall;
    procedure pm_SetCount(aValue: Integer); stdcall;
      { - ������ ��� ������� � �������� Count. }
    procedure Clear; stdcall;
      {* �������� ������. }
    procedure Delete(anIndex: Integer); stdcall;
      {* ������� ������� �� ������� Index. }
    property Count: Integer
      read pm_GetCount
      write pm_SetCount;
       {* ����� ��������� � ���������. }
  // property methods
    procedure  pm_GetItem(anIndex: Integer; out aRet: TExternalObjectData); stdcall;

    procedure pm_SetItem(anIndex: Integer; const anItem: TExternalObjectData); stdcall;
      {-}
  // public methods
    function  Add(const anItem: TExternalObjectData): Integer; stdcall;
      {* - ��������� ������� Item � �����. }
    procedure Insert(anIndex: Integer; const anItem: TExternalObjectData); stdcall;
      {* - ��������� ������� Item �� ������� Index. }
end;//IExternalObjectDataList

IDocumentTextProviderDescriptorList = interface(IInterface)
['{1FE6402E-2A8A-4B25-86BE-251B219D8ABF}']
    function  pm_GetCount: Integer; stdcall;
    procedure pm_SetCount(aValue: Integer); stdcall;
      { - ������ ��� ������� � �������� Count. }
    procedure Clear; stdcall;
      {* �������� ������. }
    procedure Delete(anIndex: Integer); stdcall;
      {* ������� ������� �� ������� Index. }
    property Count: Integer
      read pm_GetCount
      write pm_SetCount;
       {* ����� ��������� � ���������. }
  // property methods
    procedure  pm_GetItem(anIndex: Integer; out aRet: TDocumentTextProviderDescriptor); stdcall;

    procedure pm_SetItem(anIndex: Integer; const anItem: TDocumentTextProviderDescriptor); stdcall;
      {-}
  // public methods
    function  Add(const anItem: TDocumentTextProviderDescriptor): Integer; stdcall;
      {* - ��������� ������� Item � �����. }
    procedure Insert(anIndex: Integer; const anItem: TDocumentTextProviderDescriptor); stdcall;
      {* - ��������� ������� Item �� ������� Index. }
end;//IDocumentTextProviderDescriptorList

IDocPointList = interface(IInterface)
['{23E9F1C5-E8C3-40D7-B164-7A8D5ABA5216}']
    function  pm_GetCount: Integer; stdcall;
    procedure pm_SetCount(aValue: Integer); stdcall;
      { - ������ ��� ������� � �������� Count. }
    procedure Clear; stdcall;
      {* �������� ������. }
    procedure Delete(anIndex: Integer); stdcall;
      {* ������� ������� �� ������� Index. }
    property Count: Integer
      read pm_GetCount
      write pm_SetCount;
       {* ����� ��������� � ���������. }
  // property methods
    procedure  pm_GetItem(anIndex: Integer; out aRet: TDocPoint); stdcall;

    procedure pm_SetItem(anIndex: Integer; const anItem: TDocPoint); stdcall;
      {-}
  // public methods
    function  Add(const anItem: TDocPoint): Integer; stdcall;
      {* - ��������� ������� Item � �����. }
    procedure Insert(anIndex: Integer; const anItem: TDocPoint); stdcall;
      {* - ��������� ������� Item �� ������� Index. }
end;//IDocPointList

IDiffDocParaList = interface(IInterface)
['{22033D4B-258E-4B5A-A179-5C2794559448}']
    function  pm_GetCount: Integer; stdcall;
    procedure pm_SetCount(aValue: Integer); stdcall;
      { - ������ ��� ������� � �������� Count. }
    procedure Clear; stdcall;
      {* �������� ������. }
    procedure Delete(anIndex: Integer); stdcall;
      {* ������� ������� �� ������� Index. }
    property Count: Integer
      read pm_GetCount
      write pm_SetCount;
       {* ����� ��������� � ���������. }
  // property methods
    procedure  pm_GetItem(anIndex: Integer; out aRet: TDiffDocPara); stdcall;

    procedure pm_SetItem(anIndex: Integer; const anItem: TDiffDocPara); stdcall;
      {-}
  // public methods
    function  Add(const anItem: TDiffDocPara): Integer; stdcall;
      {* - ��������� ������� Item � �����. }
    procedure Insert(anIndex: Integer; const anItem: TDiffDocPara); stdcall;
      {* - ��������� ������� Item �� ������� Index. }
end;//IDiffDocParaList

IRedactionInfoList = interface(IInterface)
['{8BDE1298-6218-4C49-9024-3F404F6CC809}']
    function  pm_GetCount: Integer; stdcall;
    procedure pm_SetCount(aValue: Integer); stdcall;
      { - ������ ��� ������� � �������� Count. }
    procedure Clear; stdcall;
      {* �������� ������. }
    procedure Delete(anIndex: Integer); stdcall;
      {* ������� ������� �� ������� Index. }
    property Count: Integer
      read pm_GetCount
      write pm_SetCount;
       {* ����� ��������� � ���������. }
  // property methods
    procedure  pm_GetItem(anIndex: Integer; out aRet: TRedactionInfo); stdcall;

    procedure pm_SetItem(anIndex: Integer; const anItem: TRedactionInfo); stdcall;
      {-}
  // public methods
    function  Add(const anItem: TRedactionInfo): Integer; stdcall;
      {* - ��������� ������� Item � �����. }
    procedure Insert(anIndex: Integer; const anItem: TRedactionInfo); stdcall;
      {* - ��������� ������� Item �� ������� Index. }
end;//IRedactionInfoList

// ��������� �������������� ������ � ����������.
IDocument = interface (IEntityBase) ['{2906776F-DD41-403A-AF10-DDD0F9BD6590}']
	procedure GetAnnotation (out aRet {: IDocument}); stdcall;

	procedure GetAttributesRoot (out aRet {: INodeBase}); stdcall;

	procedure GetBookmarkList (out aRet {: IBookmarkList}); stdcall;

	// ������ ��������� ���������
	function GetChangeStatus (): Longword; stdcall;

	procedure GetCommentsParaList (out aRet {: ICommentsParaList}); stdcall;

	procedure GetContentsRoot (out aRet {: INodeBase}); stdcall;

	// ������� ��������� �������� �� �������� ������������� ���������. ����������� �� � ��������
	// �������� �������� ��� ���������. � � �������� full_name ��� ��������� � ��� ���������� (������)
	// ���� ��� ����� (��� � �������).
	procedure CreateBookmark (
		aPara: TParaId;
		aIsPara: Bytebool;
		out aRet {: IBookmark}
	); stdcall;

	// ������� ���������� ��������
	procedure CreateJournalBookmark (
		aPara: TParaId;
		out aRet {: IJournalBookmark}
	); stdcall;

	// ���������� �������� - ��������, ���������� �����  filters.
	// ���� ������� �������� ����� ���������� - ���������� NULL
	procedure CreateView (
		const aFilters: IDocumentState;
		out aRet {: IDocument}
	); stdcall;

	procedure GetCurrentState (out aRet {: IDocumentState}); stdcall;

	function GetDocType (): TDocumentType; stdcall;

	// �� ���������� ������ ��������� ������� ��������� � ������� ������
	procedure DontShowDocumentStatusChangesWarning (); stdcall;

	procedure GetExternalObjectDataList (out aRet {: IExternalObjectDataList}); stdcall;

	procedure GetFilePosition (out aRet {: IString}); stdcall;

	procedure GetAnnotationHeaderEvd (
		aHandle: Longword;
		out aRet {: IStream}
	); stdcall; // can raise EUnsupported

	// ������� ����� ���������� ��� ������������
	function GetAutoReferatDocCount (): Cardinal; stdcall; // can raise EUnsupported

	procedure GetAutoreferatHeaderEvd (
		out aRet {: IStream}
	); stdcall; // can raise EUnsupported

	procedure GetCorrespondents (
		const aCategory: INodeBase;
		out aOutList {: ICatalogBase}
	); stdcall;

	// ���������� ������ ��������������� � ��������� ��������� (������ ����������) ��� ���������
	// ��������� (category).
	// 
	// ��� ��������, ������� �� "�������", ���������� NULL
	procedure GetCorrespondentsToPart (
		const aPosList: IPositionList;
		const aCategory: INodeBase;
		out aOutList {: ICatalogBase}
	); stdcall;

	// �������� ������ ����������� ������ ����������
	procedure GetDrugList (
		out aRet {: ICatalogBase}
	); stdcall; // can raise ECanNotFindData

	// ���������� evd ����� ��������� - ������ ��� ��� evd ����� �������� ��� �������������� � ����
	// ��������� ��� ��������� ������������ � ���������
	procedure GetEvdStream (
		out aRet {: IStream}
	); stdcall;

	// ��������� ����-������
	procedure GetFlash (
		out aRet {: IExternalObject}
	); stdcall;

	// �������� url ��� ���������������� WWW-������ ���������.
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

	// �������� ��������� �������, �� ������� ��������� �������������� ������, �� �����������
	// ��������������.
	// ������������ ��������� �� ������ (obj) � ��� ������� (obj_type).
	// ������������� ����� �������� ��������� (missing_info) � �����������, � ����� ������ (�����)
	// ���������� ������������� ������ (����� get_missing_info)
	// ����� �������������� ��� �������� �� �������������� ������.
	procedure GetLinkedObject (
		aDocId: Longword;
		const aId: TTopic;
		aRid: TRedactionID;
		out aObjType: TLinkedObjectType;
		out aObj {: IUnknown}
	); stdcall; // can raise EInvalidTopicId, EFolderLinkNotFound

	// ���������� ����������� ���������� �� �������������� ������� (pid - ������������� � �����
	// ������� �� ������)
	procedure GetMissingInfoForObject (
		const aPid: TPId;
		out aMissingInfo {: IMissingInfo}
	); stdcall;

	// �������� ������ �� ����n������� � ���� ������ (DocId, SubId)
	procedure GetMultiLinkInfo (
		aDocId: Longword;
		const aId: TTopic;
		out aRet {: IDocPointList}
	); stdcall; // can raise ECanNotFindData, EInternalDatabaseError

	// ���������� ���������� �� ��������� ������������� ���������. ���� ��������� � ��������� date
	// ���� �� �������� � �������� ������� CanNotFindData
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

	// ���������� ������ ������������ � ��������� ��������� (������ ����������) ��� ���������
	// ��������� (category).
	// 
	// ��� ��������, ������� �� "�������", ���������� NULL
	procedure GetRespondentsToPart (
		const aPosList: IPositionList;
		const aCategory: INodeBase;
		out aOutList {: ICatalogBase}
	); stdcall;

	// �������� ������ ������� ����������
	procedure GetSameDocuments (
		out aOutList {: ICatalogBase}
	); stdcall;

	procedure GetSameToPoint (
		aId: TExternalID;
		out aOutList {: ICatalogBase}
	); stdcall;

	// �������� ����������� ���������� �� �������� ��������� (� ������ ��� ���������� - � ����� ������
	// ���� �������� ������������)
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

	// ��� ���������� ���� DT_BOOK ���������� false,
	// ��� ��������� true
	function HasAttributes (): Bytebool; stdcall;

	// ���� �� � ��������� ���������� ������������ ��������� ����
	// K555095873
	function HasChronology (): Bytebool; stdcall;

	// �������� ������� ��������������� (������ ���������) � �������� ���������.
	// ���������� true � ������, ���� ������ ��������������� ��� ��������� �� ��������� CR_ALL �� ����.
	// 
	// ��� ��������, �������� �� "�������", ���������� FALSE
	function HasCorrespondents (
		const aCategory: INodeBase
	): Bytebool; stdcall;

	// �������� ������� WWW-������ � �������� ���������.
	// ���������� true � ������, ���� � �������� ��������� ���� WWW-�����.
	function HasInternetImage (): Bytebool; stdcall;

	// ������� ���������� ������� ��������� �������� ��� �������.
	// ��������� �������� ��������� ������������ �������� ��������� (current_redaction).
	// ���������� True � ������ ������� ������ ����� ����� ������� (��� �������) ��������.
	function HasNextRedaction (): Bytebool; stdcall;

	// ������� ���������� ������� ���������� �������� ��� �������.
	// ���������� �������� ��������� ������������ �������� ��������� (current_redaction).
	// ���������� True � ������ ������� ������ ����� ����� ������ (��� �������) ��������.
	function HasPrevRedaction (): Bytebool; stdcall;

	// �������� ������� ������� � �������� ���������.
	// ���������� true � ������, ���� � �������� ��������� ���� �������.
	// 
	// ��� ��������, �������� �� "�������", ��������� ����� �� ��� � ��� "�������"
	function HasRelatedDoc (): Bytebool; stdcall;

	// �������� ������� ������������ (������ ���������) � �������� ���������.
	// ���������� true � ������, ���� ������ ������������ ��� ��������� �� ��������� CR_ALL �� ����.
	// 
	// ��� ��������, �������� �� "�������", ���������� FALSE
	function HasRespondents (
		const aCategory: INodeBase
	): Bytebool; stdcall;

	// �������� ������� ������� ����������
	function HasSameDocuments (): Bytebool; stdcall;

	// ���� �� � ��������� �������
	function HasTranslation (): Bytebool; stdcall;

	// ����������� ��������������.
	function HasWarning (): Bytebool; stdcall;

	// ���������� ����� ��������� � ����
	function GetInternalId (): Longword; stdcall;

	// ����������� �����, ����������� �������� "���" �� �������� �� ������� ����������. ���� ��������
	// "���" - ������������ `true` (��� ������� ����� �������� �����, ����� �������� ����� ����
	// ������, �������� �� ����� ���������� ����). ���������� ������� ������ �� ���������� ��
	// ��������, �.�. ����� ����� ������ ������ ���������� � ������� ����������.
	function IsAlive (): Bytebool; stdcall;

	// ����� ��������� ���������� �������� �� date � �������� ������������� ���������.
	function IsDateInNotSureInterval (
		const aDate: TDate
	): Bytebool; stdcall;

	// ������������ �� �������� ��� �����������
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

	// ���������� ��������� ���������� � ������ �� ��������� (� ������� �� is_same_entity, �������
	// ���������� ��������� ��� ����� ���������). ���������� ��������� �������� ������������ ������
	// ��������, ����� � ������ ����������.
	function IsSameView (
		const aView: IDocument
	): Bytebool; stdcall;

	// �������� ����������� ����������� ��������� ��������� ��� �������� ���������.
	// ���������� true � ������, ���� ����� ��������� ��������.
	// 
	// ��� �������� ����������� ��������, �������������� �������� (�.�. �������������� ������ ��������
	// )
	function MayShowAttributes (): Bytebool; stdcall;

	// ��� ���������.
	procedure GetName (out aRet {: IString}); stdcall;

	// �������� ����� ������� ��������� (��� �������������� ������)
	function GetNewRevisionAvailable (): Bytebool; stdcall;

	// True - ���� �������� �� ��������� � ������ �������
	function GetNotTm (): Bytebool; stdcall;

	procedure GetRedactionsList (out aRet {: IRedactionInfoList}); stdcall;

	procedure GetRelatedDoc (out aRet {: IDocument}); stdcall;

	// ������� ��� ���������.
	procedure GetShortName (out aRet {: IString}); stdcall;

	// ������ ��������� � ������
	function GetSize (): Longword; stdcall;

	// ������ ���������
	function GetStatus (): TItemStatus; stdcall;

	procedure GetTextLanguages (out aRet {: ILanguagesList}); stdcall;

	procedure GetTranslation (out aRet {: IDocument}); stdcall;

	// �������������� � ���������.
	procedure GetWarning (out aRet {: IString}); stdcall;
end;

// �������� �� ��������. ������������ ��� ���������� ��������� (� �������) � ������.
IBookmark = interface (IEntityBase) ['{830AC32A-C3AC-4AA1-A5A1-0ACAE229DD2A}']
	// ������ ��� ��������� � �����/���� �� ������� ��������� ��������. ������������ � �������� hint
	// � ������.
	procedure GetComment (out aRet {: IString}); stdcall;
	procedure SetComment (const aComment: IString); stdcall;

	procedure GetDocument (out aRet {: IDocument}); stdcall;

	// ��������� ��������. ������������ � �������� caption � ������.
	procedure GetName (out aRet {: IString}); stdcall;
	procedure SetName (const aName: IString); stdcall;

	function GetParagraph (): TParaId; stdcall;

	procedure GetPid (out a: TPId); stdcall;
end;

// ��������� ��� ������ � ���������� �������.
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

	// ���������� true, ���� ��� �������� ����������, �. �. ����� ���:
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

	// �������� ������������� � �������� ������� ��������, ���������� �������� ��� ������� ���������.
	// ���������� True � ������ ���� ������� ��������� ���������� � False, ���� �������� ��� �� �����,
	// ��� � �� ������ ������.
	procedure SetActualRedaction (); stdcall; // can raise ERedactionNotFound

	// �������� ������������� � �������� ������� ��������� �������� �������.
	// ���� ��������� �������� ���, �� ������������ RedactionNotFound.
	procedure SetNextRedaction (); stdcall; // can raise ERedactionNotFound

	// Get��������������������������������. [$178325284]
	procedure SetPrevActiveRedaction (); stdcall; // can raise ERedactionNotFound

	// �������� ������������� � �������� ������� ���������� �������� �������.
	// ���� ���������� �������� ���, �� ������������ RedactionNotFound.
	procedure SetPrevRedaction (); stdcall; // can raise ERedactionNotFound

	procedure SetRedactionOnDate (
		const aDate: TDate
	); stdcall; // can raise ERedactionNotFound

	// �������� ������������� � �������� ������� �������� � �������� ���������������.
	// ���������� True � ������ ���� ������� ��������� ���������� � False, ���� �������� ��� �� �����,
	// ��� � �� ������ ������.
	// ���� ����� �������� ������������� ��������, �� ������������ InvalidRedactionId.
	procedure SetRedactionOnId (
		aId: TRedactionID
	); stdcall; // can raise ERedactionNotFound
end;

// ���������� ��������
IJournalBookmark = interface (IEntityBase) ['{7EC5D2E1-6B5C-4C7E-AE21-C98E21A8D018}']
	procedure GetDocument (out aRet {: IDocument}); stdcall;

	// ������ ��� (����)
	procedure GetFullName (out aRet {: IString}); stdcall;

	// ���
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
      { - ������ ��� ������� � �������� Count. }
    procedure Clear; stdcall;
      {* �������� ������. }
    procedure Delete(anIndex: Integer); stdcall;
      {* ������� ������� �� ������� Index. }
    property Count: Integer
      read pm_GetCount
      write pm_SetCount;
       {* ����� ��������� � ���������. }
  // property methods
    procedure  pm_GetItem(anIndex: Integer; out aRet: IJournalBookmark); stdcall;

    procedure pm_SetItem(anIndex: Integer; const anItem: IJournalBookmark); stdcall;
      {-}
  // public methods
    function  Add(const anItem: IJournalBookmark): Integer; stdcall;
      {* - ��������� ������� Item � �����. }
    procedure Insert(anIndex: Integer; const anItem: IJournalBookmark); stdcall;
      {* - ��������� ������� Item �� ������� Index. }
end;//IJournalBookmarkList

IDiffDocDataProvider = interface (IInterface) ['{E9D2FB7F-1DE5-4C75-8998-72B6C443FF03}']
	function DontUseMe: Pointer;
	function GetAllLeafParaCount (): Longword; stdcall;

	procedure GetChangedBlock (
		aI: Longword;
		out a: TChangedBlock
	); stdcall;

	function GetChangedBlockCount (): Longword; stdcall;

	// �������� � ������ ��������� ��������� ��� ������ ���������
	function GetDateParaLeft (
		out aPara: TDiffDocPara
	): Bytebool; stdcall;

	// �������� � ������ ��������� ��������� ��� ������� ���������
	function GetDateParaRight (
		out aPara: TDiffDocPara
	): Bytebool; stdcall;

	// ��������� ��������� ������� ��:
	// 
	// ����� "����� ��������� ���������"
	// ������� ��� ��������� (!Name)
	// ����� "������������ ���������� �������� "������"
	// ����� "����� ��������� ������������ ��������� ��������:"
	procedure GetHeaderParaList (
		out aRet {: IDiffDocParaList}
	); stdcall;

	// ������ ������� ����� ��������� ���������� ����� �������� (��� ��� �������� ��� ������ ���������)
	procedure GetRedactionNameLeft (
		out a: TDiffDocPara
	); stdcall;

	// ������ ������� ����� ��������� ���������� ����� �������� (��� ��� �������� ��� �������
	// ���������)
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