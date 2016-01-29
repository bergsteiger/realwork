unit l3BaseRefInterfacedList;

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , l3ProtoObject
 , l3PureMixIns
;

type
 Il3CBaseList = interface
 end;//Il3CBaseList
 
 {$Define l3Items_NeedsSort}
 
 Tl3BaseRefInterfacedList = class(_l3UncomparabeObjectRefList_, Il3CBaseList)
  {* ������ Tl3Base � ������������ �������������� }
  procedure MakeI;
  procedure AssignItem(const aTo: _ItemType_;
   const aFrom: _ItemType_);
  function CompareExistingItems(const CI: CompareItemsRec): Integer;
   {* ���������� ��� ������������ ��������. }
  function Count: Integer;
   {* ����� ���������. }
 end;//Tl3BaseRefInterfacedList
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

end.
