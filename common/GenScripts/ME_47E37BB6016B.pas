unit k2InterfacesEx;

interface

uses
 l3IntfUses
 , l3PureMixIns
 , l3Variant
;

type
 Ik2TagListPrim = interface
  {* ������ �����. }
 end;//Ik2TagListPrim
 
 Ik2TagList_ForEach_Action = function(anItem: Tl3Variant;
  anIndex: Integer): Boolean;
  {* ��� �������������� ������� ��� Ik2TagList.ForEach }
 
 Ik2TagList = interface(Ik2TagListPrim)
  procedure ForEach;
   {* ���������� �������� ������.

<!> ��������. ���� ����� ��������� �� Ml3List. }
 end;//Ik2TagList
 
implementation

uses
 l3ImplUses
 , l3Base
;

end.
