unit f1NotificationManager;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\f1NotificationManager.pas"
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
;

type
 If1NotificationListener = interface
  ['{6F16A3C8-E77F-4C61-820E-2FECBC8A2999}']
  procedure ServerDownNotification;
 end;//If1NotificationListener

 _ItemType_ = If1NotificationListener;
 _l3InterfaceRefList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include l3InterfaceRefList.imp.pas}
 Tf1NotificationList = class(_l3InterfaceRefList_)
 end;//Tf1NotificationList

 Tf1NotificationManager = class(Tl3ProtoDataContainer)
  private
   f_List: Tf1NotificationList;
    {* Поле для свойства List }
  protected
   function pm_GetList: Tf1NotificationList;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   class procedure AddListener(const aListener: If1NotificationListener);
   class procedure RemoveListener(const aListener: If1NotificationListener);
   class procedure ServerDown;
   class function Exists: Boolean;
   class function Instance: Tf1NotificationManager;
    {* Метод получения экземпляра синглетона Tf1NotificationManager }
  protected
   property List: Tf1NotificationList
    read pm_GetList;
 end;//Tf1NotificationManager

implementation

uses
 l3ImplUses
 , SysUtils
 , l3Base
 , l3MinMax
 , RTLConsts
;

var g_Tf1NotificationManager: Tf1NotificationManager = nil;
 {* Экземпляр синглетона Tf1NotificationManager }

procedure Tf1NotificationManagerFree;
 {* Метод освобождения экземпляра синглетона Tf1NotificationManager }
begin
 l3Free(g_Tf1NotificationManager);
end;//Tf1NotificationManagerFree

type _Instance_R_ = Tf1NotificationList;

{$Include l3InterfaceRefList.imp.pas}

function Tf1NotificationManager.pm_GetList: Tf1NotificationList;
//#UC START# *54F5D8C3022B_54F5D5E002E0get_var*
//#UC END# *54F5D8C3022B_54F5D5E002E0get_var*
begin
//#UC START# *54F5D8C3022B_54F5D5E002E0get_impl*
 if not Assigned(f_List) then
  f_List := Tf1NotificationList.Create;
 Result := f_List;
//#UC END# *54F5D8C3022B_54F5D5E002E0get_impl*
end;//Tf1NotificationManager.pm_GetList

class procedure Tf1NotificationManager.AddListener(const aListener: If1NotificationListener);
//#UC START# *54F5D9540254_54F5D5E002E0_var*
//#UC END# *54F5D9540254_54F5D5E002E0_var*
begin
//#UC START# *54F5D9540254_54F5D5E002E0_impl*
 Instance.List.Add(aListener);
//#UC END# *54F5D9540254_54F5D5E002E0_impl*
end;//Tf1NotificationManager.AddListener

class procedure Tf1NotificationManager.RemoveListener(const aListener: If1NotificationListener);
//#UC START# *54F5D987008A_54F5D5E002E0_var*
//#UC END# *54F5D987008A_54F5D5E002E0_var*
begin
//#UC START# *54F5D987008A_54F5D5E002E0_impl*
 if Exists then
  Instance.List.Remove(aListener);
//#UC END# *54F5D987008A_54F5D5E002E0_impl*
end;//Tf1NotificationManager.RemoveListener

class procedure Tf1NotificationManager.ServerDown;
//#UC START# *54F5D9F70383_54F5D5E002E0_var*
var
 I: Integer;
//#UC END# *54F5D9F70383_54F5D5E002E0_var*
begin
//#UC START# *54F5D9F70383_54F5D5E002E0_impl*
 if Exists then
  for I := 0 to Instance.List.Count - 1 do
   Instance.List[I].ServerDownNotification;
//#UC END# *54F5D9F70383_54F5D5E002E0_impl*
end;//Tf1NotificationManager.ServerDown

class function Tf1NotificationManager.Exists: Boolean;
//#UC START# *54F5E7BD01ED_54F5D5E002E0_var*
//#UC END# *54F5E7BD01ED_54F5D5E002E0_var*
begin
//#UC START# *54F5E7BD01ED_54F5D5E002E0_impl*
 Result := Assigned(g_Tf1NotificationManager);
//#UC END# *54F5E7BD01ED_54F5D5E002E0_impl*
end;//Tf1NotificationManager.Exists

class function Tf1NotificationManager.Instance: Tf1NotificationManager;
 {* Метод получения экземпляра синглетона Tf1NotificationManager }
begin
 if (g_Tf1NotificationManager = nil) then
 begin
  l3System.AddExitProc(Tf1NotificationManagerFree);
  g_Tf1NotificationManager := Create;
 end;
 Result := g_Tf1NotificationManager;
end;//Tf1NotificationManager.Instance

procedure Tf1NotificationManager.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_54F5D5E002E0_var*
//#UC END# *479731C50290_54F5D5E002E0_var*
begin
//#UC START# *479731C50290_54F5D5E002E0_impl*
 FreeAndNil(f_List);
 inherited;
//#UC END# *479731C50290_54F5D5E002E0_impl*
end;//Tf1NotificationManager.Cleanup

end.
