unit PrimeUnit; {$Z4}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "GblAdapterLib"
// ������: "w:/garant6x/implementation/Garant/GblAdapterLib/PrimeUnit.pas"
// Delphi ���������� ��� �������� (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::Prime
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
	, SettingsUnit
	, SearchUnit
	//#UC START# *4423F94903C8_47BECCB801BE_UNIT_FOR_Stream*
	//#UC END# *4423F94903C8_47BECCB801BE_UNIT_FOR_Stream*
	;

type

IPrime = interface;
{ - ��������������� �������� IPrime. }

IPrimeList = interface;
{ - ��������������� �������� IPrimeList. }

IKeysList = interface;
{ - ��������������� �������� IKeysList. }

IPrimeManager = interface;
{ - ��������������� �������� IPrimeManager. }

IPrimeSettingsManager = interface;
{ - ��������������� �������� IPrimeSettingsManager. }

IPrimeContractData = interface;
{ - ��������������� �������� IPrimeContractData. }


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
    procedure  pm_GetItem(anIndex: Integer; out aRet: IPrime); stdcall;

    procedure pm_SetItem(anIndex: Integer; const anItem: IPrime); stdcall;
      {-}
  // public methods
    function  Add(const anItem: IPrime): Integer; stdcall;
      {* - ��������� ������� Item � �����. }
    procedure Insert(anIndex: Integer; const anItem: IPrime); stdcall;
      {* - ��������� ������� Item �� ������� Index. }
end;//IPrimeList

IKeysList = interface(IInterface)
['{85ABCF6B-01B9-43B1-8E1B-354DCFA4A47C}']
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
    function  pm_GetItem(anIndex: Integer): TPrimeKey; stdcall;

    procedure pm_SetItem(anIndex: Integer; const anItem: TPrimeKey); stdcall;
      {-}
  // public methods
    function  Add(const anItem: TPrimeKey): Integer; stdcall;
      {* - ��������� ������� Item � �����. }
    procedure Insert(anIndex: Integer; const anItem: TPrimeKey); stdcall;
      {* - ��������� ������� Item �� ������� Index. }
  // public properties
    property  Items[anIndex: Integer]: TPrimeKey
      read pm_GetItem
      write pm_SetItem;
      default;
      {* - �������� ������. }
end;//IKeysList

IPrimeManager = interface (IInterface) ['{A47D57BE-0B61-4917-9929-F2092A1C872F}']
	function DontUseMe: Pointer;
	// ��������� �� ������� ����� ��������� ������ ��� ��������
	procedure Add (
		const aName: IString;
		const aQuery: IQuery;
		out aRet {: IPrime}
	); stdcall; // can raise EDuplicateName

	// ��������� ���������� � ������ �������� �������
	function CheckConnectionToOnlineServer (): Bytebool; stdcall;

	// ���� �� ������ � ������ �������������� ����� ������
	function GetHasOnlineAccess (): Bytebool; stdcall;

	procedure GetList (out aRet {: IPrimeList}); stdcall;

	procedure Remove (
		aId: TPrimeKey
	); stdcall;

	// �������� � ��������� ���������� � ��������� �� ������ �������
	procedure SaveAndSendToOnlineServer (); stdcall;

	procedure SaveListToXml (
		const aKeys: IKeysList;
		const aXmlFilePath: PAnsiChar
	); stdcall; // can raise EUnknownExportError

	procedure SaveMailDeliveryTask (
		const aXmlFilePath: PAnsiChar
	); stdcall; // can raise EUnknownExportError

	procedure SharePrimeForFileServer (); stdcall; // can raise EUnknownExportError

	// �������� ������ � ��������� ������ � ���� ��������. ������ ���� ������ ����� ������� �� �������.
	procedure Update (); stdcall;
end;

// ��������� ��� ������� ��������� ��������� ����
IPrimeSettingsManager = interface (IBaseSettingsManager) ['{418BE07D-88DB-419E-A625-51BE867DC212}']

end;

// ������ ��� �������� ����� ������.
IPrimeContractData = interface (IInterface) ['{DF3E6A6C-4229-4DFB-8ECB-CF4D7FC1DE95}']
	function DontUseMe: Pointer;
	procedure GetArea (out aRet {: IString}); stdcall;

	procedure GetClientName (out aRet {: IString}); stdcall;

	procedure GetEmail (out aRet {: IString}); stdcall;

	// �������� ������ ��� �������� ����� ������
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