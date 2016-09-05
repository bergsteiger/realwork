unit StatusBarUtils;

// Модуль: "w:\common\components\gui\Garant\Nemesis\StatusBarUtils.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "StatusBarUtils" MUID: (505DCE690055)

{$Include w:\common\components\gui\Garant\Nemesis\nscDefine.inc}

interface

{$If Defined(Nemesis)}
uses
 l3IntfUses
 , nscNewInterfaces
 , l3ProtoDataContainer
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 TnscStatusBarItemNotificationType = (
  sbintVisibleChanged
 );//TnscStatusBarItemNotificationType

 InscStatusBarItem = interface
  ['{F1EFAA8A-2134-43CC-AF3F-0B73FB275A89}']
  function Get_Visible: Boolean;
  function Get_NotificationClients: Pointer;
  function Get_ItemDef: InscStatusBarItemDef;
  procedure Set_ItemDef(const aValue: InscStatusBarItemDef);
  procedure Unsubscribe(const aClient: InscStatusBarItem);
  procedure SendNotificationToClients(aNotificationType: TnscStatusBarItemNotificationType);
  procedure Subscribe(const aClient: InscStatusBarItem);
  procedure Notify(const aSender: InscStatusBarItem;
   aNotificationType: TnscStatusBarItemNotificationType);
  property Visible: Boolean
   read Get_Visible;
  property NotificationClients: Pointer
   read Get_NotificationClients;
   {* TnscStatusBarItemsList }
  property ItemDef: InscStatusBarItemDef
   read Get_ItemDef
   write Set_ItemDef;
 end;//InscStatusBarItem

 _ItemType_ = InscStatusBarItem;
 _l3InterfacePtrList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3InterfacePtrList.imp.pas}
 TnscStatusBarItemsList = class(_l3InterfacePtrList_)
 end;//TnscStatusBarItemsList
{$IfEnd} // Defined(Nemesis)

implementation

{$If Defined(Nemesis)}
uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
 //#UC START# *505DCE690055impl_uses*
 //#UC END# *505DCE690055impl_uses*
;

type _Instance_R_ = TnscStatusBarItemsList;

{$Include w:\common\components\rtl\Garant\L3\l3InterfacePtrList.imp.pas}
{$IfEnd} // Defined(Nemesis)

end.
