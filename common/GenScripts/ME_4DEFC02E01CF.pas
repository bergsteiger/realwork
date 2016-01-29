unit l3LongintListReverseSorter;

interface

uses
 l3IntfUses
 , l3CustomLongintListView
 , l3PureMixIns
;

type
 Tl3LongintListReverseSorter = class(Tl3CustomLongintListView)
  {* Пример списка, который сортирует исходный список в обратном порядке }
  function CompareData(const anItem1: _ItemType_;
   const anItem2: _ItemType_): Integer;
 end;//Tl3LongintListReverseSorter
 
implementation

uses
 l3ImplUses
;

end.
