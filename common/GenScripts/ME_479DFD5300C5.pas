unit l3DynamicArray;

interface

uses
 l3IntfUses
 , l3SimpleDataContainer
 , l3Memory
;

 {$Define _l3Items_NeedsBeforeFreeItem}
 
type
 Tl3DynamicArray = class(_l3UntypedList_)
  {* ������� ����� ��� ������������ ��������. }
 end;//Tl3DynamicArray
 
implementation

uses
 l3ImplUses
 , l3Base
 , RTLConsts
 , SysUtils
 , l3MinMax
;

end.
