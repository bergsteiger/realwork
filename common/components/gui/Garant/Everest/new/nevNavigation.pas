unit nevNavigation;
 {* ��������� ����� ���������� ������� }

// ������: "w:\common\components\gui\Garant\Everest\new\nevNavigation.pas"
// ���������: "Interfaces"
// ������� ������: "nevNavigation" MUID: (4A251D6E00BD)

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
  {* ������ ������� }
  ['{FF3E2BB3-B94A-4C87-9725-E6EF1E93079A}']
  function pm_GetCount: Integer;
  function pm_GetItem(anIndex: Integer): TevAddress;
  procedure pm_SetItem(anIndex: Integer;
   const aValue: TevAddress);
  function pm_GetName(anIndex: Integer): Tl3PCharLen;
  procedure pm_SetName(anIndex: Integer;
   const aValue: Tl3PCharLen);
  function Add(const anAddress: TevAddress): Integer;
   {* ��������� ��� ���� ����� }
  procedure Delete(const anAddress: TevAddress);
   {* ������� ����� }
  procedure Modify(const anOldAddress: TevAddress;
   const aNewAddress: TevAddress);
   {* ������������ ����� }
  procedure Clear;
   {* ������� ������ ������� }
  property Count: Integer
   read pm_GetCount;
   {* ���������� ������� ������ }
  property Item[anIndex: Integer]: TevAddress
   read pm_GetItem
   write pm_SetItem;
   default;
   {* ������ ������� �� ������� }
  property Name[anIndex: Integer]: Tl3PCharLen
   read pm_GetName
   write pm_SetName;
   {* C����� ���� �� ������� }
 end;//IevAddressList

 IevAddressHolder = interface
  ['{C22FA607-035B-44DE-B592-054CB05175DE}']
  function pm_GetAddress: Tl3Tag;
  property Address: Tl3Tag
   read pm_GetAddress;
 end;//IevAddressHolder

 IevHyperlink = interface
  {* �������������� ������ }
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
   {* ��������� ���������� �� ������ ������ }
  procedure Insert;
   {* ��������� ����� ������ }
  procedure Delete;
   {* ������� �������������� ������ }
  function GetHyperlink: Tl3Tag;
  property ID: Integer
   read Get_ID
   write Set_ID;
   {* ������������� ������ }
  property FromDocumentExternalHandle: Integer
   read Get_FromDocumentExternalHandle;
  property TargetDocumentID: Integer
   read Get_TargetDocumentID;
  property Name: Tl3PCharLen
   read Get_Name;
  property Para: InevPara
   read pm_GetPara;
   {* �������� �� ������� ����� ������ }
  property AddressList: IevAddressList
   read pm_GetAddressList;
  property Address: TevAddress
   read pm_GetAddress
   write pm_SetAddress;
   {* ����� �� ������� ��������� ������ (������ �� AddressList) }
  property URL: Tl3PCharLen
   read pm_GetURL
   write pm_SetURL;
   {* ���� � ������� �� ������� ����� ��������� ������ }
  property Hint: Tl3PCharLen
   read pm_GetHint
   write pm_SetHint;
   {* "���������" ������������ ��� ��������� ������� �� ������ }
  property Kind: TevLinkViewKind
   read pm_GetKind
   write pm_SetKind;
   {* ��� ����������� ������ }
 end;//IevHyperlink

implementation

uses
 l3ImplUses
;

end.
