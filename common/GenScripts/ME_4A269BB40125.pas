unit evHyperlink;

interface

uses
 l3IntfUses
 , nevNavigation
 , nevTools
 , afwNavigation
 , l3Types
 , evdTypes
 , l3Variant
;

type
 TevHyperlink = class(IevHyperlink)
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
 end;//TevHyperlink
 
implementation

uses
 l3ImplUses
;

end.
