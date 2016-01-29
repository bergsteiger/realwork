unit l3Searcher.imp;

interface

uses
 l3IntfUses
 , l3Types
;

type
 _l3Searcher_ = class
  {* Умеет искать элементы по заданному критерию. }
  function CompareItemWithData(const anItem: _ItemType_;
   const aData: _FindDataType_;
   aSortIndex: Tl3SortIndex;
   aList: _l3Searcher_): Integer;
   {* Сравнивает существующий элемент с искомым. }
  function FindData(const aFindData: _FindDataType_;
   out theIndex: Integer;
   aSortIndex: Tl3SortIndex): Boolean; overload;
   {* Ищет в списке указанные данные. Возвращает true если данные найдены, а в theIndex - индекс найденого элемента, если данные не найдены, то theIndex указывает на предполагаемое место вставки. }
 end;//_l3Searcher_
 
implementation

uses
 l3ImplUses
;

end.
