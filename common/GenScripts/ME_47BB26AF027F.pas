unit l3ListOperations.imp;

interface

uses
 l3IntfUses
;

type
 _l3ListOperations_ = class
  function DeleteList(const aList: _ListType_): Boolean;
   {* Удаляет из списка элементы содержащиеся в другом списке (aList) }
  function InsertList(const aList: _ListType_): Boolean;
   {* Добавляет в список элементы другого списка (aList) }
  function IntersectList(const aList: _ListType_): Boolean;
   {* Удаляет из списка Элементы НЕ содержащиеся в другом списке (aList) }
 end;//_l3ListOperations_
 
implementation

uses
 l3ImplUses
;

end.
