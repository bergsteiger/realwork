unit vcmTabbedContainerFormDispatcherUtils;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VCM$Visual"
// Модуль: "w:/common/components/gui/Garant/VCM/implementation/Visual/ChromeLike/vcmTabbedContainerFormDispatcherUtils.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi::VCM$Visual::Visual$ChromeLike::vcmTabbedContainerFormDispatcherUtils
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
uses
  l3ProtoDataContainer,
  vcmTabbedContainerForm,
  l3Memory,
  l3Interfaces,
  l3Types,
  l3Core,
  l3Except,
  Classes
  ;

type
 TvcmContainerLockCountItem = {$IfDef XE4}record{$Else}object{$EndIf}
 public
   rContainer : TvcmTabbedContainerForm;
   rLockCount : Integer;
 public
    function EQ(const anOther: TvcmContainerLockCountItem): Boolean;
 end;//TvcmContainerLockCountItem

 _ItemType_ = TvcmContainerLockCountItem;
 _l3RecordWithEQList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3RecordWithEQList.imp.pas}
 TvcmContainersLockCountList = class(_l3RecordWithEQList_)
 private
 // private methods
   procedure ChangeLockCount(aContainer: TvcmTabbedContainerForm;
     aDelta: Integer);
 public
 // public methods
   function IsContainerLocked(aContainer: TvcmTabbedContainerForm): Boolean;
   procedure LockContainer(aContainer: TvcmTabbedContainerForm);
   procedure UnlockContainer(aContainer: TvcmTabbedContainerForm);
 end;//TvcmContainersLockCountList

function TvcmContainerLockCountItem_C(aContainer: TvcmTabbedContainerForm): TvcmContainerLockCountItem;
{$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene

implementation

{$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
uses
  l3Base,
  l3MinMax,
  RTLConsts,
  SysUtils
  ;

// start class TvcmContainerLockCountItem

function TvcmContainerLockCountItem.EQ(const anOther: TvcmContainerLockCountItem): Boolean;
//#UC START# *55824F0F01C2_55824ED3027A_var*
//#UC END# *55824F0F01C2_55824ED3027A_var*
begin
//#UC START# *55824F0F01C2_55824ED3027A_impl*
 Result := anOther.rContainer = rContainer;
//#UC END# *55824F0F01C2_55824ED3027A_impl*
end;//TvcmContainerLockCountItem.EQ

function TvcmContainerLockCountItem_C(aContainer: TvcmTabbedContainerForm): TvcmContainerLockCountItem;
//#UC START# *55824F260248_55824ED3027A_var*
//#UC END# *55824F260248_55824ED3027A_var*
begin
 System.FillChar(Result, SizeOf(Result), 0);
//#UC START# *55824F260248_55824ED3027A_impl*
 Result.rContainer := aContainer;
//#UC END# *55824F260248_55824ED3027A_impl*
end;//TvcmContainerLockCountItem.C

// start class TvcmContainersLockCountList

function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If defined(l3Items_NeedsAssignItem) AND not defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
  const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_55815E1A0227_var*
//#UC END# *47B2C42A0163_55815E1A0227_var*
begin
//#UC START# *47B2C42A0163_55815E1A0227_impl*
 Assert(False);
//#UC END# *47B2C42A0163_55815E1A0227_impl*
end;//AssignItem
{$IfEnd} //l3Items_NeedsAssignItem AND not l3Items_NoSort

function CompareExistingItems(const CI: CompareItemsRec): Integer;
//#UC START# *47B99D4503A2_55815E1A0227_var*
//#UC END# *47B99D4503A2_55815E1A0227_var*
begin
//#UC START# *47B99D4503A2_55815E1A0227_impl*
 Result := -1;
//#UC END# *47B99D4503A2_55815E1A0227_impl*
end;//CompareExistingItems

type _Instance_R_ = TvcmContainersLockCountList;

{$Include w:\common\components\rtl\Garant\L3\l3RecordWithEQList.imp.pas}

// start class TvcmContainersLockCountList

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
{$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene

end.