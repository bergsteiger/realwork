unit vcmOperationsDefIteratorForContextMenu;

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , vcmUserControls
;

type
 TvcmOperationsDefIteratorForContextMenu = class(_l3InterfaceRefListPrim_, IvcmOperationsDefIterator)
  procedure Create(const anIter: IvcmOperationsDefIterator);
  function Make(const anIter: IvcmOperationsDefIterator): IvcmOperationsDefIterator;
  function IsSameItems(const A: _ItemType_;
   const B: _ItemType_): Boolean;
   {* ���������� �������� ������ }
  procedure AssignItem(const aTo: _ItemType_;
   const aFrom: _ItemType_);
  function CompareExistingItems(const CI: CompareItemsRec): Integer;
   {* ���������� ��� ������������ ��������. }
  function Next: IvcmOperationDef;
   {* ��������� ��������� �������� }
 end;//TvcmOperationsDefIteratorForContextMenu
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

end.
