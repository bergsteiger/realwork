unit StatusBarUtils;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Nemesis"
// Модуль: "w:/common/components/gui/Garant/Nemesis/StatusBarUtils.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi For F1::Nemesis::StatusBarUtils::StatusBarUtils
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Nemesis\nscDefine.inc}

interface

{$If defined(Nemesis)}
uses
  nscNewInterfaces,
  l3ProtoDataContainer,
  l3Types,
  l3Memory,
  l3Interfaces,
  l3Core,
  l3Except,
  Classes
  ;

type
  TnscStatusBarItemNotificationType = (
    sbintVisibleChanged
  );//TnscStatusBarItemNotificationType

 InscStatusBarItem = interface(IUnknown)
   ['{F1EFAA8A-2134-43CC-AF3F-0B73FB275A89}']
   procedure Unsubscribe(const aClient: InscStatusBarItem);
   procedure SendNotificationToClients(aNotificationType: TnscStatusBarItemNotificationType);
   procedure Subscribe(const aClient: InscStatusBarItem);
   procedure Notify(const aSender: InscStatusBarItem;
     aNotificationType: TnscStatusBarItemNotificationType);
   function Get_Visible: Boolean;
   function Get_NotificationClients: Pointer;
   function Get_ItemDef: InscStatusBarItemDef;
   procedure Set_ItemDef(const aValue: InscStatusBarItemDef);
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
{$IfEnd} //Nemesis

implementation

{$If defined(Nemesis)}
uses
  l3Base,
  l3MinMax,
  RTLConsts,
  SysUtils
  ;

type _Instance_R_ = TnscStatusBarItemsList;

{$Include w:\common\components\rtl\Garant\L3\l3InterfacePtrList.imp.pas}

{$IfEnd} //Nemesis
end.