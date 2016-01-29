unit nevNavigation;

interface

uses
 l3IntfUses
 , l3Types
 , nevTools
 , afwNavigation
 , evdTypes
 , l3Variant
;

type
 IevAddressList = interface
  {* ������ ������� }
  function Add(const anAddress: TevAddress): Integer;
   {* ��������� ��� ���� ����� }
  procedure Delete(const anAddress: TevAddress);
   {* ������� ����� }
  procedure Modify(const anOldAddress: TevAddress;
   const aNewAddress: TevAddress);
   {* ������������ ����� }
  procedure Clear;
   {* ������� ������ ������� }
 end;//IevAddressList
 
 IevAddressHolder = interface
 end;//IevAddressHolder
 
 IevHyperlink = interface
  {* �������������� ������ }
  function Exists: Boolean;
   {* ��������� ���������� �� ������ ������ }
  procedure Insert;
   {* ��������� ����� ������ }
  procedure Delete;
   {* ������� �������������� ������ }
  function GetHyperlink: Tl3Tag;
 end;//IevHyperlink
 
implementation

uses
 l3ImplUses
;

end.
