unit k2InterfacesEx;

interface

uses
 l3IntfUses
 , l3PureMixIns
 , l3Variant
;

type
 Ik2TagListPrim = interface
  {* Список тегов. }
 end;//Ik2TagListPrim
 
 Ik2TagList_ForEach_Action = function(anItem: Tl3Variant;
  anIndex: Integer): Boolean;
  {* Тип подитеративной функции для Ik2TagList.ForEach }
 
 Ik2TagList = interface(Ik2TagListPrim)
  procedure ForEach;
   {* Перебирает элементы списка.

<!> Временно. Надо будет перенести на Ml3List. }
 end;//Ik2TagList
 
implementation

uses
 l3ImplUses
 , l3Base
;

end.
