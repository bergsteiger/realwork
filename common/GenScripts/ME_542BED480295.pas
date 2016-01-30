unit nsNotificationManager;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Data\Common\nsNotificationManager.pas"
// Стереотип: "SimpleClass"

{$Include nsDefine.inc}

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
 , l3ProtoObject
;

type
 TnsNotificationType = (
  ntMonitoringUpdate
  , ntMainFormBecomeTopmostAtStartup
 );//TnsNotificationType

 InsNotificationListener = interface
  ['{096F1967-6628-4FD8-92E6-FF2CFD3B8325}']
  procedure nsNotification(aType: TnsNotificationType);
 end;//InsNotificationListener

 _ItemType_ = InsNotificationListener;
 _l3InterfacePtrList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include l3InterfacePtrList.imp.pas}
 TnsNotificationListenersList = class(_l3InterfacePtrList_)
 end;//TnsNotificationListenersList

 TnsNotificationManagerPrim = class(Tl3ProtoObject)
  private
   f_Listeners: TnsNotificationListenersList;
    {* Поле для свойства Listeners }
  protected
   function pm_GetListeners: TnsNotificationListenersList;
   class function Exists: Boolean;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   class function Instance: TnsNotificationManagerPrim;
    {* Метод получения экземпляра синглетона TnsNotificationManagerPrim }
  protected
   property Listeners: TnsNotificationListenersList
    read pm_GetListeners;
 end;//TnsNotificationManagerPrim

 TnsNotificationManager = class
  public
   class procedure AddListener(const aListener: InsNotificationListener);
   class procedure RemoveListener(const aListener: InsNotificationListener);
   class procedure NotifyListeners(aType: TnsNotificationType);
   class function Exists: Boolean;
 end;//TnsNotificationManager

implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

var g_TnsNotificationManagerPrim: TnsNotificationManagerPrim = nil;
 {* Экземпляр синглетона TnsNotificationManagerPrim }

procedure TnsNotificationManagerPrimFree;
 {* Метод освобождения экземпляра синглетона TnsNotificationManagerPrim }
begin
 l3Free(g_TnsNotificationManagerPrim);
end;//TnsNotificationManagerPrimFree

type _Instance_R_ = TnsNotificationListenersList;

{$Include l3InterfacePtrList.imp.pas}

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

class function TnsNotificationManagerPrim.Exists: Boolean;
//#UC START# *542D13A40269_542D0141013E_var*
//#UC END# *542D13A40269_542D0141013E_var*
begin
//#UC START# *542D13A40269_542D0141013E_impl*
 Result := Assigned(g_TnsNotificationManagerPrim);
//#UC END# *542D13A40269_542D0141013E_impl*
end;//TnsNotificationManagerPrim.Exists

class function TnsNotificationManagerPrim.Instance: TnsNotificationManagerPrim;
 {* Метод получения экземпляра синглетона TnsNotificationManagerPrim }
begin
 if (g_TnsNotificationManagerPrim = nil) then
 begin
  l3System.AddExitProc(TnsNotificationManagerPrimFree);
  g_TnsNotificationManagerPrim := Create;
 end;
 Result := g_TnsNotificationManagerPrim;
end;//TnsNotificationManagerPrim.Instance

procedure TnsNotificationManagerPrim.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_542D0141013E_var*
//#UC END# *479731C50290_542D0141013E_var*
begin
//#UC START# *479731C50290_542D0141013E_impl*
 FreeAndNil(f_Listeners);
 inherited;
//#UC END# *479731C50290_542D0141013E_impl*
end;//TnsNotificationManagerPrim.Cleanup

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

end.
