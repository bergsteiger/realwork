unit l3StandardTypedList.imp;

interface

uses
 l3IntfUses
 , l3Memory
 , l3Types
;

type
 _l3StandardTypedList_ = class(_l3FourByteItemList_)
  {* ����������� �������������� ������ � �������� �������� � 4 ����� }
  procedure MakeSorted(aDuplicates: Tl3Duplicates;
   aSortIndex: Tl3SortIndex);
   {* ������� ������������� ������ }
  procedure Make;
 end;//_l3StandardTypedList_
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

end.
