unit GardocsUnit; {$Z4}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "ArchiAdapterLib"
// ������: "w:/MDProcess/ArchiAdapterLib/GardocsUnit.pas"
// Delphi ���������� ��� �������� (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> MDProcess::ArchiAdapterLib::Gardocs
//
// Gardoc
//
//
// ��� ����� ����������� ��� ��� "������-������".
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
{ - ��������������� �������� IStringList. }

IImageList = interface;
{ - ��������������� �������� IImageList. }

IGardocList = interface;
{ - ��������������� �������� IGardocList. }

ISearcher = interface;
{ - ��������������� �������� ISearcher. }

IArchiEventsListener = interface;
{ - ��������������� �������� IArchiEventsListener. }

ISearcher2 = interface;
{ - ��������������� �������� ISearcher2. }

IUtils = interface;
{ - ��������������� �������� IUtils. }

ILongList = interface;
{ - ��������������� �������� ILongList. }

IGardocGetter = interface;
{ - ��������������� �������� IGardocGetter. }


// ��� ������
PImageType = ^TImageType;
TImageType = (
	giZIP
	, giTIF
	, giDOC
	, giRTF
	, giNSR
);

// �����
PImage = ^TImage;
TImage = packed record
	rData: IStream; // ������
	rType: TImageType; // ��� ������
	rSrcTitle: IString; // �������� ���������� ������������
	rSrcPage: IString; // ����� �������� � ��������� ������������
	rSrcNumber: IString; // ����� ��������� ������������
	rSrcDateStart: TDateTimeBox; // ���� ��������� ������������ (������)
	rSrcDateEnd: TDateTimeBox; // ���� ��������� ������������ (������)
	rLabels: IStringList; // ������ ���������������� �����, ������������� ��������, ����� ����� �������� ��� ����������� ����� �������� ���-�� �������������. ��� �� ��������.
end;

// ������� ������, ���������� ��������� ����� ����� ������
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
	guInVersion // � ������
	, guQuickly // �������
	, guOrdinary // �������
	, guUnknown // ����������
);

// �������� ��������
PGardoc = ^TGardoc;
TGardoc = packed record
	rType: IString; // ��� (������, ������������ � �.�)
	rNumber: IString; // �����
	rDate: TDateTimeBox; // ���� ���������
	rOgvList: IStringList; // ������ ������� ��������������� ������, ����������� ��������
	rTitle: IString; // ��������
	rMuNumber: IString; // ����� ����������� � ��
	rMuDate: TDateTimeBox; // ���� ����������� � ��
	rBlocks: IStringList; // ����� (��������), ������������� � ����������� ����, ��������: GAR, LAN �.�.
	rTopic: Int64; // ����� ������
	rComment: IString; // �����������, ������ ����� ����� ����� ������� ��� ���� ���������, ������ ���-�� ������������ � �����������
	rImages: IImageList; // ����� � zip-�, �������� ��� �����-������ ������� ���������, ������� ���� � �
	rConfluenceId: Int64; // ����� ������� � �, ������� ����� �������� DPOUVS-
	rTimestamp: TDateTimeBox;
	rState: TGardocStatus;
	rText: IString; // ���� �������� �������, �� ����� ���������� ����� �������, ���� ���, �� �����
	rRelated: Int64; // ����� �������
	rGardocType: TGarDocType; // ��� ���������
	rUrgency: TGarDocUrgency; // ���������
	rIsInternet: Bytebool; // ������, ��� ���� �������� �� ����, ����� ��� ����������� ��������� ����� ����������
end;

// ArchiEvent
PArchiEvent = ^TArchiEvent;
TArchiEvent = packed record
	rType: IString; // ���
	rDoc: TGardoc;
end;

IStringList = interface(IInterface)
['{F453A2F1-0E0A-4C01-AB14-60246CDF74DB}']
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
    procedure  pm_GetItem(anIndex: Integer; out aRet: IString); stdcall;

    procedure pm_SetItem(anIndex: Integer; const anItem: IString); stdcall;
      {-}
  // public methods
    function  Add(const anItem: IString): Integer; stdcall;
      {* - ��������� ������� Item � �����. }
    procedure Insert(anIndex: Integer; const anItem: IString); stdcall;
      {* - ��������� ������� Item �� ������� Index. }
end;//IStringList

IImageList = interface(IInterface)
['{10205A4D-9F0C-48B1-B84E-C10ED6FA2519}']
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
    procedure  pm_GetItem(anIndex: Integer; out aRet: TImage); stdcall;

    procedure pm_SetItem(anIndex: Integer; const anItem: TImage); stdcall;
      {-}
  // public methods
    function  Add(const anItem: TImage): Integer; stdcall;
      {* - ��������� ������� Item � �����. }
    procedure Insert(anIndex: Integer; const anItem: TImage); stdcall;
      {* - ��������� ������� Item �� ������� Index. }
end;//IImageList

IGardocList = interface(IInterface)
['{D491FCC6-CA05-4DC5-A400-B793F196EA6E}']
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
    procedure  pm_GetItem(anIndex: Integer; out aRet: TGardoc); stdcall;

    procedure pm_SetItem(anIndex: Integer; const anItem: TGardoc); stdcall;
      {-}
  // public methods
    function  Add(const anItem: TGardoc): Integer; stdcall;
      {* - ��������� ������� Item � �����. }
    procedure Insert(anIndex: Integer; const anItem: TGardoc); stdcall;
      {* - ��������� ������� Item �� ������� Index. }
end;//IGardocList

// Searcher
ISearcher = interface (IInterface) ['{7B55C61E-E39E-4BEC-8BD2-DDC67DB1218E}']
	function DontUseMe: Pointer;
	procedure GetNotopCreatedSince (
		const aDate: TDateTimeBox;
		aCount: Longint;
		out aRet {: IGardocList}
	); stdcall; // can raise ECommunicationFailure

	// ���������� ������ ����� ����������, ������������������ � � ����� date (date - ����� �
	// ������������� ����� 1 ������ 1970 ����, �.�. �����������)
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
	// ���������������� � � ����������� �������
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
	// ����������� ������ ������� ����������� � ��� ��� �� ������� �������� ��� ��������� � ���������
	// ���� � ���������� Searcher2::get_xxxx, � ����� ���������� ������ (�������� ��������� ��
	// ��������). ���� �����, ������� ������ ������ ������� ������, �� ��������� ����� ��������
	// ��������� �������� �����. ������� ������� ������������ � ������, ���� ��� ��
	// Searcher2::get_xxxx �� �������� �� ���� ��������, ������� update_old_last_created_time �
	// ��������� ��������� � ����.
	// ������ ����� �������� �� �������� ������� 30-�� ����� � ��������� ���������� �������. ����
	// ������������ ����� ������ �������� ���������, �� ������ �������� time.
	procedure UpdateOldLastCreatedTime (
		const aDate: TDateTimeBox;
		out a: TDateTimeBox
	); stdcall; // can raise ECommunicationFailure
end;

ILongList = interface(IInterface)
['{EF5A688C-2615-45FC-96C8-7E1BCB15C5EB}']
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
    function  pm_GetItem(anIndex: Integer): Int64; stdcall;

    procedure pm_SetItem(anIndex: Integer; const anItem: Int64); stdcall;
      {-}
  // public methods
    function  Add(const anItem: Int64): Integer; stdcall;
      {* - ��������� ������� Item � �����. }
    procedure Insert(anIndex: Integer; const anItem: Int64); stdcall;
      {* - ��������� ������� Item �� ������� Index. }
  // public properties
    property  Items[anIndex: Integer]: Int64
      read pm_GetItem
      write pm_SetItem;
      default;
      {* - �������� ������. }
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