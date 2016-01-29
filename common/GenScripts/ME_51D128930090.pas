unit vcmEntitiesDefIteratorForContextMenu;

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , vcmInterfaces
;

type
 TvcmEntitiesDefIteratorForContextMenu = class(_l3InterfaceRefListPrim_, IvcmEntitiesDefIterator)
  procedure Create(const anIter: IvcmEntitiesDefIterator);
  function Make(const anIter: IvcmEntitiesDefIterator): IvcmEntitiesDefIterator;
  function IsSameItems(const A: _ItemType_;
   const B: _ItemType_): Boolean;
   {* ���������� �������� ������ }
  procedure AssignItem(const aTo: _ItemType_;
   const aFrom: _ItemType_);
  function CompareExistingItems(const CI: CompareItemsRec): Integer;
   {* ���������� ��� ������������ ��������. }
  function Next: IvcmEntityDef;
   {* ��������� ��������� �������� }
 end;//TvcmEntitiesDefIteratorForContextMenu
 
implementation

uses
 l3ImplUses
 , vcmEntityDefForContextMenu
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

end.
