unit l3ObjectRefList.imp;

interface

uses
 l3IntfUses
;

type
 _l3ObjectRefList_ = class(_l3UncomparabeObjectRefList_)
  {* Список ссылок на объекты. }
  procedure AssignItem(const aTo: _ItemType_;
   const aFrom: _ItemType_);
  function CompareExistingItems(const CI: CompareItemsRec): Integer;
   {* Сравнивает два существующих элемента. }
 end;//_l3ObjectRefList_
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

end.
