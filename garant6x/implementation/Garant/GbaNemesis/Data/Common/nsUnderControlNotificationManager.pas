unit nsUnderControlNotificationManager;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Data\Common\nsUnderControlNotificationManager.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnsUnderControlNotificationManager" MUID: (55D429A70008)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , l3ProtoObject
 , l3ProtoDataContainer
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 InsUnderControlNotificationListener = interface
  ['{08AD2F57-9D63-48F2-9D1D-6B7873FD8DBF}']
  procedure UnderControlNotificationChanged;
 end;//InsUnderControlNotificationListener

 _ItemType_ = InsUnderControlNotificationListener;
 _l3InterfacePtrList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3InterfacePtrList.imp.pas}
 TnsUnderControlNotificationListenersList = class(_l3InterfacePtrList_)
 end;//TnsUnderControlNotificationListenersList

 TnsUnderControlNotificationManager = {final} class(Tl3ProtoObject)
  private
   f_Listeners: TnsUnderControlNotificationListenersList;
   f_HasChanged: Boolean;
    {* Поле для свойства HasChanged }
  private
   procedure NotifyListeners;
  protected
   function pm_GetHasChanged: Boolean; virtual;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure InitFields; override;
  public
   procedure ResetChangedNotification;
   procedure Subscribe(const aListener: InsUnderControlNotificationListener);
   procedure Unsubscribe(const aListener: InsUnderControlNotificationListener);
   procedure SetChangedNotification;
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
   class function Instance: TnsUnderControlNotificationManager;
    {* Метод получения экземпляра синглетона TnsUnderControlNotificationManager }
  public
   property HasChanged: Boolean
    read pm_GetHasChanged;
 end;//TnsUnderControlNotificationManager

implementation

uses
 l3ImplUses
 , SysUtils
 , l3Base
 , l3MinMax
 , RTLConsts
;

var g_TnsUnderControlNotificationManager: TnsUnderControlNotificationManager = nil;
 {* Экземпляр синглетона TnsUnderControlNotificationManager }

procedure TnsUnderControlNotificationManagerFree;
 {* Метод освобождения экземпляра синглетона TnsUnderControlNotificationManager }
begin
 l3Free(g_TnsUnderControlNotificationManager);
end;//TnsUnderControlNotificationManagerFree

type _Instance_R_ = TnsUnderControlNotificationListenersList;

{$Include w:\common\components\rtl\Garant\L3\l3InterfacePtrList.imp.pas}

function TnsUnderControlNotificationManager.pm_GetHasChanged: Boolean;
//#UC START# *55D4325E03DF_55D429A70008get_var*
//#UC END# *55D4325E03DF_55D429A70008get_var*
begin
//#UC START# *55D4325E03DF_55D429A70008get_impl*
 Result := f_HasChanged;
//#UC END# *55D4325E03DF_55D429A70008get_impl*
end;//TnsUnderControlNotificationManager.pm_GetHasChanged

procedure TnsUnderControlNotificationManager.ResetChangedNotification;
//#UC START# *55D4315E001F_55D429A70008_var*
//#UC END# *55D4315E001F_55D429A70008_var*
begin
//#UC START# *55D4315E001F_55D429A70008_impl*
 f_HasChanged := False;
 NotifyListeners;
//#UC END# *55D4315E001F_55D429A70008_impl*
end;//TnsUnderControlNotificationManager.ResetChangedNotification

procedure TnsUnderControlNotificationManager.Subscribe(const aListener: InsUnderControlNotificationListener);
//#UC START# *55D43170011B_55D429A70008_var*
//#UC END# *55D43170011B_55D429A70008_var*
begin
//#UC START# *55D43170011B_55D429A70008_impl*
 Assert(f_Listeners.IndexOf(aListener) = -1);
 f_Listeners.Add(aListener);
//#UC END# *55D43170011B_55D429A70008_impl*
end;//TnsUnderControlNotificationManager.Subscribe

procedure TnsUnderControlNotificationManager.Unsubscribe(const aListener: InsUnderControlNotificationListener);
//#UC START# *55D4317E026C_55D429A70008_var*
//#UC END# *55D4317E026C_55D429A70008_var*
begin
//#UC START# *55D4317E026C_55D429A70008_impl*
 Assert(f_Listeners.IndexOf(aListener) <> -1);
 f_Listeners.Remove(aListener);
//#UC END# *55D4317E026C_55D429A70008_impl*
end;//TnsUnderControlNotificationManager.Unsubscribe

procedure TnsUnderControlNotificationManager.NotifyListeners;
//#UC START# *55D438CC0369_55D429A70008_var*
var
 l_Index: Integer;
//#UC END# *55D438CC0369_55D429A70008_var*
begin
//#UC START# *55D438CC0369_55D429A70008_impl*
 for l_Index := 0 to Pred(f_Listeners.Count) do
  f_Listeners[l_Index].UnderControlNotificationChanged;
//#UC END# *55D438CC0369_55D429A70008_impl*
end;//TnsUnderControlNotificationManager.NotifyListeners

procedure TnsUnderControlNotificationManager.SetChangedNotification;
//#UC START# *55D43E670378_55D429A70008_var*
//#UC END# *55D43E670378_55D429A70008_var*
begin
//#UC START# *55D43E670378_55D429A70008_impl*
 f_HasChanged := True;
 NotifyListeners;
//#UC END# *55D43E670378_55D429A70008_impl*
end;//TnsUnderControlNotificationManager.SetChangedNotification

class function TnsUnderControlNotificationManager.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TnsUnderControlNotificationManager <> nil;
end;//TnsUnderControlNotificationManager.Exists

class function TnsUnderControlNotificationManager.Instance: TnsUnderControlNotificationManager;
 {* Метод получения экземпляра синглетона TnsUnderControlNotificationManager }
begin
 if (g_TnsUnderControlNotificationManager = nil) then
 begin
  l3System.AddExitProc(TnsUnderControlNotificationManagerFree);
  g_TnsUnderControlNotificationManager := Create;
 end;
 Result := g_TnsUnderControlNotificationManager;
end;//TnsUnderControlNotificationManager.Instance

procedure TnsUnderControlNotificationManager.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_55D429A70008_var*
//#UC END# *479731C50290_55D429A70008_var*
begin
//#UC START# *479731C50290_55D429A70008_impl*
 FreeAndNil(f_Listeners);
 inherited;
//#UC END# *479731C50290_55D429A70008_impl*
end;//TnsUnderControlNotificationManager.Cleanup

procedure TnsUnderControlNotificationManager.InitFields;
//#UC START# *47A042E100E2_55D429A70008_var*
//#UC END# *47A042E100E2_55D429A70008_var*
begin
//#UC START# *47A042E100E2_55D429A70008_impl*
 inherited;
 f_Listeners := TnsUnderControlNotificationListenersList.Create; 
//#UC END# *47A042E100E2_55D429A70008_impl*
end;//TnsUnderControlNotificationManager.InitFields

end.
