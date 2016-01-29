unit tfwValueList;

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , tfwScriptingInterfaces
;

 {$Define l3Items_NoSort}
 
type
 TtfwValueList = class(Tl3ProtoDataContainer)
  {* ������ �������������� ��� �������� ����������. }
  function IsSameItems(const A: _ItemType_;
   const B: _ItemType_): Boolean;
   {* ���������� �������� ������ }
  procedure AssignItem(const aTo: _ItemType_;
   const aFrom: _ItemType_);
  function CompareExistingItems(const CI: CompareItemsRec): Integer;
   {* ���������� ��� ������������ ��������. }
 end;//TtfwValueList
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

end.
