unit l3CustomOtherListView;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , l3CustomSortIntegerList
;

type
 Tl3OtherListSorter = class(Tl3CustomSortIntegerList)
  procedure Create(aView: Tl3CustomOtherListView);
  function CompareItems(A: Integer;
   B: Integer): Integer;
   {* Функция сравнения элементов }
 end;//Tl3OtherListSorter
 
 Tl3CustomOtherListView = class(Tl3ProtoObject)
  function CompareItems(anIndex1: Integer;
   anIndex2: Integer): Integer;
  procedure Sort;
  function OtherListCount: Integer;
 end;//Tl3CustomOtherListView
 
implementation

uses
 l3ImplUses
 , SysUtils
;

end.
