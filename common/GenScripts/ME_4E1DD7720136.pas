unit evHyperlinkProxy;

interface

uses
 l3IntfUses
 , l3CProtoObject
 , nevNavigation
 , evdTypes
 , nevTools
 , afwNavigation
 , l3Types
 , l3Variant
 , l3Interfaces
;

type
 TevHyperlinkProxy = class(Tl3CProtoObject, IevHyperlink)
  procedure Create(const aLink: IevHyperlink);
  function Make(const aLink: IevHyperlink): IevHyperlink;
  function DoFromDocumentExternalHandle: Integer;
  function DoGetKind: TevLinkViewKind;
  function Exists: Boolean;
   {* ��������� ���������� �� ������ ������ }
  procedure Insert;
   {* ��������� ����� ������ }
  procedure Delete;
   {* ������� �������������� ������ }
  function ID: Integer;
   {* ������������� ������ }
  function Para: InevPara;
   {* �������� �� ������� ����� ������ }
  function AddressList: IevAddressList;
  function Address: TevAddress;
   {* ����� �� ������� ��������� ������ (������ �� AddressList) }
  function URL: Tl3PCharLen;
   {* ���� � ������� �� ������� ����� ��������� ������ }
  function Hint: Tl3PCharLen;
   {* "���������" ������������ ��� ��������� ������� �� ������ }
  function Kind: TevLinkViewKind;
   {* ��� ����������� ������ }
  function FromDocumentExternalHandle: Integer;
  function TargetDocumentID: Integer;
  function Name: Tl3PCharLen;
  function GetHyperlink: Tl3Tag;
 end;//TevHyperlinkProxy
 
implementation

uses
 l3ImplUses
 , l3InterfacesMisc
;

end.
