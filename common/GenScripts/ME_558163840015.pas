unit vcmTabbedContainerFormDispatcherUtils;

// Модуль: "w:\common\components\gui\Garant\VCM\implementation\Visual\ChromeLike\vcmTabbedContainerFormDispatcherUtils.pas"
// Стереотип: "UtilityPack"

{$Include vcmDefine.inc}

interface

{$If NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)}
uses
 l3IntfUses
 , vcmTabbedContainerForm
 , l3ProtoDataContainer
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 TvcmContainerLockCountItem = object
  public
   rContainer: TvcmTabbedContainerForm;
   rLockCount: Integer;
  public
   function EQ: Boolean;
 end;//TvcmContainerLockCountItem

 _ItemType_ = TvcmContainerLockCountItem;
 _l3RecordWithEQList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include l3RecordWithEQList.imp.pas}
 TvcmContainersLockCountList = class(_l3RecordWithEQList_)
  private
   procedure ChangeLockCount(aContainer: TvcmTabbedContainerForm;
    aDelta: Integer);
  public
   function IsContainerLocked(aContainer: TvcmTabbedContainerForm): Boolean;
   procedure LockContainer(aContainer: TvcmTabbedContainerForm);
   procedure UnlockContainer(aContainer: TvcmTabbedContainerForm);
 end;//TvcmContainersLockCountList

function TvcmContainerLockCountItem_C: TvcmContainerLockCountItem;
{$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)

implementation

{$If NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)}
uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

function TvcmContainerLockCountItem_C: TvcmContainerLockCountItem;
//#UC START# *55824F260248_55824ED3027A_var*
//#UC END# *55824F260248_55824ED3027A_var*
begin
//#UC START# *55824F260248_55824ED3027A_impl*
 Result.rContainer := aContainer;
//#UC END# *55824F260248_55824ED3027A_impl*
end;//TvcmContainerLockCountItem_C

function TvcmContainerLockCountItem.EQ: Boolean;
//#UC START# *55824F0F01C2_55824ED3027A_var*
//#UC END# *55824F0F01C2_55824ED3027A_var*
begin
//#UC START# *55824F0F01C2_55824ED3027A_impl*
 Result := anOther.rContainer = rContainer;
//#UC END# *55824F0F01C2_55824ED3027A_impl*
end;//TvcmContainerLockCountItem.EQ

function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_55815E1A0227_var*
//#UC END# *47B2C42A0163_55815E1A0227_var*
begin
//#UC START# *47B2C42A0163_55815E1A0227_impl*
 Assert(False);
//#UC END# *47B2C42A0163_55815E1A0227_impl*
end;//AssignItem
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)

function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* Сравнивает два существующих элемента. }
//#UC START# *47B99D4503A2_55815E1A0227_var*
//#UC END# *47B99D4503A2_55815E1A0227_var*
begin
//#UC START# *47B99D4503A2_55815E1A0227_impl*
 Result := -1;
//#UC END# *47B99D4503A2_55815E1A0227_impl*
end;//CompareExistingItems

type _Instance_R_ = TvcmContainersLockCountList;

{$Include l3RecordWithEQList.imp.pas}

function TvcmContainersLockCountList.IsContainerLocked(aContainer: TvcmTabbedContainerForm): Boolean;
//#UC START# *5582543B0147_55815E1A0227_var*
var
 l_Item: TvcmContainerLockCountItem;
 l_Index: Integer;
//#UC END# *5582543B0147_55815E1A0227_var*
begin
//#UC START# *5582543B0147_55815E1A0227_impl*
 l_Item := TvcmContainerLockCountItem_C(aContainer);
 l_Index := IndexOf(l_Item);
 Result := (l_Index <> -1) and (Items[l_Index].rLockCount > 0);
//#UC END# *5582543B0147_55815E1A0227_impl*
end;//TvcmContainersLockCountList.IsContainerLocked

procedure TvcmContainersLockCountList.LockContainer(aContainer: TvcmTabbedContainerForm);
//#UC START# *558254440303_55815E1A0227_var*
//#UC END# *558254440303_55815E1A0227_var*
begin
//#UC START# *558254440303_55815E1A0227_impl*
 ChangeLockCount(aContainer, 1);
//#UC END# *558254440303_55815E1A0227_impl*
end;//TvcmContainersLockCountList.LockContainer

procedure TvcmContainersLockCountList.UnlockContainer(aContainer: TvcmTabbedContainerForm);
//#UC START# *558254500372_55815E1A0227_var*
//#UC END# *558254500372_55815E1A0227_var*
begin
//#UC START# *558254500372_55815E1A0227_impl*
 ChangeLockCount(aContainer, -1);
//#UC END# *558254500372_55815E1A0227_impl*
end;//TvcmContainersLockCountList.UnlockContainer

procedure TvcmContainersLockCountList.ChangeLockCount(aContainer: TvcmTabbedContainerForm;
 aDelta: Integer);
//#UC START# *558259BC02E8_55815E1A0227_var*
var
 l_Index: Integer;
 l_Item: TvcmContainerLockCountItem;
//#UC END# *558259BC02E8_55815E1A0227_var*
begin
//#UC START# *558259BC02E8_55815E1A0227_impl*
 l_Item := TvcmContainerLockCountItem_C(aContainer);
 l_Index := IndexOf(l_Item);
 if (l_Index <> -1) then
 begin
  if ((Items[l_Index].rLockCount + aDelta) = 0) then
   Delete(l_Index)
  else
  begin
   l_Item.rLockCount := Items[l_Index].rLockCount + aDelta;
   Items[l_Index] := l_Item;
  end;
 end
 else
 if (aDelta > 0) then
 begin
  Inc(l_Item.rLockCount, aDelta);
  Add(l_Item);
 end;
//#UC END# *558259BC02E8_55815E1A0227_impl*
end;//TvcmContainersLockCountList.ChangeLockCount
{$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)

end.
