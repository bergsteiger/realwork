unit k2InterfacesEx;
 {* Дополнительные интерфейсы. }

// Модуль: "w:\common\components\rtl\Garant\K2\k2InterfacesEx.pas"
// Стереотип: "Interfaces"
// Элемент модели: "k2InterfacesEx" MUID: (47E37BB6016B)

{$Include w:\common\components\rtl\Garant\K2\k2Define.inc}

interface

uses
 l3IntfUses
 , k2Interfaces
 , l3PureMixIns
 , l3Variant
;

type
 //_ItemType_ = Tl3Variant;
 Ik2TagListPrim = interface
  {* Список тегов. }
  ['{D87DEF16-D91F-4EAB-B5B0-36BFDA811F51}']
  function pm_GetEmpty: Boolean;
  function pm_GetFirst: Tl3Variant;
  function pm_GetLast: Tl3Variant;
  function pm_GetItems(anIndex: Integer): Tl3Variant;
  function pm_GetCount: Integer;
  property Empty: Boolean
   read pm_GetEmpty;
  property First: Tl3Variant
   read pm_GetFirst;
   {* Первый элемент. }
  property Last: Tl3Variant
   read pm_GetLast;
   {* Последний элемент. }
  property Items[anIndex: Integer]: Tl3Variant
   read pm_GetItems;
   default;
  property Count: Integer
   read pm_GetCount;
   {* Число элементов. }
 end;//Ik2TagListPrim

 Ik2TagList_ForEach_Action = function(anItem: Tl3Variant;
  anIndex: Integer): Boolean;
  {* Тип подитеративной функции для Ik2TagList.ForEach }

 Ik2TagList = interface(Ik2TagListPrim)
  ['{7AC54659-1B8C-4ADA-800F-F62CB90E5A64}']
  function ForEach(anAction: Ik2TagList_ForEach_Action): Integer;
   {* Перебирает элементы списка.

<!> Временно. Надо будет перенести на Ml3List. }
  function ForEachF(anAction: Ik2TagList_ForEach_Action): Integer;
   {* Перебирает элементы списка.

<!> Временно. Надо будет перенести на Ml3List. }
 end;//Ik2TagList

function L2Ik2TagListForEachAction(anAction: Pointer): Ik2TagList_ForEach_Action;
 {* Функция формирования заглушки для ЛОКАЛЬНОЙ подитеративной функции для Ik2TagList.ForEach }

implementation

uses
 l3ImplUses
 , l3Base
;

function L2Ik2TagListForEachAction(anAction: Pointer): Ik2TagList_ForEach_Action;
 {* Функция формирования заглушки для ЛОКАЛЬНОЙ подитеративной функции для Ik2TagList.ForEach }
asm
 jmp l3LocalStub
end;//L2Ik2TagListForEachAction

end.
