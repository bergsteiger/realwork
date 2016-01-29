unit l3InterfaceRefList.imp;

interface

uses
 l3IntfUses
;

type
 _l3InterfaceRefList_ = class(_l3InterfaceRefListPrim_)
  {* Список ссылок на интерфейсы. }
  function IsSameItems(const A: _ItemType_;
   const B: _ItemType_): Boolean;
   {* Сравнивает элементы списка }
  procedure AssignItem(const aTo: _ItemType_;
   const aFrom: _ItemType_);
  function CompareExistingItems(const CI: CompareItemsRec): Integer;
   {* Сравнивает два существующих элемента. }
 end;//_l3InterfaceRefList_
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

end.
