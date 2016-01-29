unit afwNavigation;

interface

uses
 l3IntfUses
 , evdInterfaces
 , afwInterfaces
;

type
 IevMoniker = interface
  {* ������� ��������� ��� ���������� �� ��������� �������. }
 end;//IevMoniker
 
 IevURLMoniker = interface(IevMoniker)
  {* ��������� ��� �������� ����������� �� URL }
 end;//IevURLMoniker
 
 IevIDMoniker = interface(IevMoniker)
  {* ����� �������, �������� ������������� ������������� }
 end;//IevIDMoniker
 
 IevHyperlinkMoniker = interface(IevIDMoniker)
  {* ������, ����������� �� �������������� ������ }
 end;//IevHyperlinkMoniker
 
 TafwAddress = TevdAddress;
 
 TevAddress = object(TafwAddress)
 end;//TevAddress
 
 IevMonikerSink = interface
  {* ��������� ��� ���������� �������� �� ������. }
  function JumpTo(anEffects: TafwJumpToEffects;
   const aMoniker: IevMoniker): Boolean;
   {* ������� �� ������ aMoniker. }
 end;//IevMonikerSink
 
 IevAddressMoniker = interface(IevMoniker)
  {* ����� ����� ����� }
 end;//IevAddressMoniker
 
implementation

uses
 l3ImplUses
;

end.
