unit l3AtomicList.imp;

interface

uses
 l3IntfUses
;

type
 _l3AtomicList_ = class(_l3AtomicListPrim_)
  {* Список АТОМАРНЫХ элементов, без всякого подсчёта ссылок и управления временем жизни }
  function CompareExistingItems(const CI: CompareItemsRec): Integer;
   {* Сравнивает два существующих элемента. }
 end;//_l3AtomicList_
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

end.
