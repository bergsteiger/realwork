unit l3PureMixIns;

interface

uses
 l3IntfUses
;

type
 // _ItemType_
 
 (*
 Ml3CountHolder = interface
 end;//Ml3CountHolder
 *)
 
 (*
 Ml3List = interface(Ml3CountHolder)
  {* ������. }
 end;//Ml3List
 *)
 
 (*
 Ml3ListEx = interface(Ml3List)
  function IndexOf(const anItem: _ItemType_): Integer;
  function Add(const anItem: _ItemType_): Integer;
 end;//Ml3ListEx
 *)
 
 (*
 Ml3CheckStamp = interface
  function CheckStamp(const aGUID: TGUID): Boolean;
   {* ��������� ����� ���������� ����������. �������� ��� ����, ����� ������, ��� ���������� ���� "������". }
 end;//Ml3CheckStamp
 *)
 
 (*
 Ml3ChangingChanged = interface
  procedure Changed;
   {* ����������� � ���������� ��������� ��������� �������. ��� ���������� � ������������� � ��������. }
  procedure Changing;
   {* ����������� � ������ ��������� ��������� �������. ��� ���������� � ������������� � ��������. }
 end;//Ml3ChangingChanged
 *)
 
implementation

uses
 l3ImplUses
;

end.
