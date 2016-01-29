unit nsNotificationManager;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Data"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Data/Common/nsNotificationManager.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Базовые определения предметной области::LegalDomain::Data::Common::TnsNotificationManager
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
  l3ProtoObject,
  l3ProtoDataContainer,
  l3Types,
  l3Memory,
  l3Interfaces,
  l3Core,
  l3Except,
  Classes
  ;

type
 TnsNotificationType = (
   ntMonitoringUpdate
 , ntMainFormBecomeTopmostAtStartup
 );//TnsNotificationType

 InsNotificationListener = interface(IUnknown)
   ['{096F1967-6628-4FD8-92E6-FF2CFD3B8325}']
   procedure NsNotification(aType: TnsNotificationType);
 end;//InsNotificationListener

 _ItemType_ = InsNotificationListener;
 _l3InterfacePtrList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
{$Include w:\common\components\rtl\Garant\L3\l3InterfacePtrList.imp.pas}
 TnsNotificationListenersList = class(_l3InterfacePtrList_)
 end;//TnsNotificationListenersList

 TnsNotificationManagerPrim = class(Tl3ProtoObject)
 private
 // private fields
   f_Listeners : TnsNotificationListenersList;
    {* Поле для свойства Listeners}
 protected
 // property methods
   function pm_GetListeners: TnsNotificationListenersList;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
 protected
 // protected methods
   class function Exists: Boolean;
 protected
 // protected properties
   property Listeners: TnsNotificationListenersList
     read pm_GetListeners;
 public
 // singleton factory method
   class function Instance: TnsNotificationManagerPrim;
    {- возвращает экземпляр синглетона. }
 end;//TnsNotificationManagerPrim

 TnsNotificationManager = class
 public
 // public methods
   class procedure AddListener(const aListener: InsNotificationListener);
   class procedure RemoveListener(const aListener: InsNotificationListener);
   class procedure NotifyListeners(aType: TnsNotificationType);
   class function Exists: Boolean;
 end;//TnsNotificationManager

implementation

uses
  l3Base,
  l3MinMax,
  RTLConsts,
  SysUtils
  ;

// start class TnsNotificationManager

class procedure TnsNotificationManager.AddListener(const aListener: InsNotificationListener);
//#UC START# *542BF00B0238_542BED480295_var*
//#UC END# *542BF00B0238_542BED480295_var*
begin
//#UC START# *542BF00B0238_542BED480295_impl*
 TnsNotificationManagerPrim.Instance.Listeners.Add(aListener);
//#UC END# *542BF00B0238_542BED480295_impl*
end;//TnsNotificationManager.AddListener

class procedure TnsNotificationManager.RemoveListener(const aListener: InsNotificationListener);
//#UC START# *542BF0310050_542BED480295_var*
//#UC END# *542BF0310050_542BED480295_var*
begin
//#UC START# *542BF0310050_542BED480295_impl*
 if Exists then
  TnsNotificationManagerPrim.Instance.Listeners.Remove(aListener);
//#UC END# *542BF0310050_542BED480295_impl*
end;//TnsNotificationManager.RemoveListener

class procedure TnsNotificationManager.NotifyListeners(aType: TnsNotificationType);
//#UC START# *542BF0AD02E8_542BED480295_var*
var
 I: Integer;
//#UC END# *542BF0AD02E8_542BED480295_var*
begin
//#UC START# *542BF0AD02E8_542BED480295_impl*
 if Exists then
  for I := 0 to TnsNotificationManagerPrim.Instance.Listeners.Count - 1 do
   TnsNotificationManagerPrim.Instance.Listeners[I].NsNotification(aType);
//#UC END# *542BF0AD02E8_542BED480295_impl*
end;//TnsNotificationManager.NotifyListeners

class function TnsNotificationManager.Exists: Boolean;
//#UC START# *542D008601C9_542BED480295_var*
//#UC END# *542D008601C9_542BED480295_var*
begin
//#UC START# *542D008601C9_542BED480295_impl*
 Result := TnsNotificationManagerPrim.Exists;
//#UC END# *542D008601C9_542BED480295_impl*
end;//TnsNotificationManager.Exists
type _Instance_R_ = TnsNotificationListenersList;

{$Include w:\common\components\rtl\Garant\L3\l3InterfacePtrList.imp.pas}


// start class TnsNotificationManagerPrim

var g_TnsNotificationManagerPrim : TnsNotificationManagerPrim = nil;

procedure TnsNotificationManagerPrimFree;
begin
 l3Free(g_TnsNotificationManagerPrim);
end;

class function TnsNotificationManagerPrim.Instance: TnsNotificationManagerPrim;
begin
 if (g_TnsNotificationManagerPrim = nil) then
 begin
  l3System.AddExitProc(TnsNotificationManagerPrimFree);
  g_TnsNotificationManagerPrim := Create;
 end;
 Result := g_TnsNotificationManagerPrim;
end;


class function TnsNotificationManagerPrim.Exists: Boolean;
//#UC START# *542D13A40269_542D0141013E_var*
//#UC END# *542D13A40269_542D0141013E_var*
begin
//#UC START# *542D13A40269_542D0141013E_impl*
 Result := Assigned(g_TnsNotificationManagerPrim);
//#UC END# *542D13A40269_542D0141013E_impl*
end;//TnsNotificationManagerPrim.Exists

function TnsNotificationManagerPrim.pm_GetListeners: TnsNotificationListenersList;
//#UC START# *542BEFCA00C5_542D0141013Eget_var*
//#UC END# *542BEFCA00C5_542D0141013Eget_var*
begin
//#UC START# *542BEFCA00C5_542D0141013Eget_impl*
 if not Assigned(f_Listeners) then
  f_Listeners := TnsNotificationListenersList.Create;
 Result := f_Listeners;
//#UC END# *542BEFCA00C5_542D0141013Eget_impl*
end;//TnsNotificationManagerPrim.pm_GetListeners

procedure TnsNotificationManagerPrim.Cleanup;
//#UC START# *479731C50290_542D0141013E_var*
//#UC END# *479731C50290_542D0141013E_var*
begin
//#UC START# *479731C50290_542D0141013E_impl*
 FreeAndNil(f_Listeners);
 inherited;
//#UC END# *479731C50290_542D0141013E_impl*
end;//TnsNotificationManagerPrim.Cleanup

end.