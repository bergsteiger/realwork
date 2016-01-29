unit vcmTabbedContainerFormDispatcherUtils;

interface

uses
 l3IntfUses
 , vcmTabbedContainerForm
 , l3ProtoDataContainer
;

type
 TvcmContainerLockCountItem = object
 end;//TvcmContainerLockCountItem
 
 TvcmContainersLockCountList = class(Tl3ProtoDataContainer)
  function IsContainerLocked(aContainer: TvcmTabbedContainerForm): Boolean;
  procedure LockContainer(aContainer: TvcmTabbedContainerForm);
  procedure UnlockContainer(aContainer: TvcmTabbedContainerForm);
  procedure ChangeLockCount(aContainer: TvcmTabbedContainerForm;
   aDelta: Integer);
  procedure AssignItem(const aTo: _ItemType_;
   const aFrom: _ItemType_);
  function CompareExistingItems(const CI: CompareItemsRec): Integer;
   {* Сравнивает два существующих элемента. }
 end;//TvcmContainersLockCountList
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

end.
