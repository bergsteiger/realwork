unit f1NotificationManager;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/f1NotificationManager.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Базовые определения предметной области::F1 Application Template::View::CommonNotifications::Tf1NotificationManager
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
  l3ProtoDataContainer,
  l3Types,
  l3Memory,
  l3Interfaces,
  l3Core,
  l3Except,
  Classes
  ;

type
 If1NotificationListener = interface(IUnknown)
   ['{6F16A3C8-E77F-4C61-820E-2FECBC8A2999}']
   procedure ServerDownNotification;
     {* Сигнатура метода ServerDownNotification }
 end;//If1NotificationListener

 _ItemType_ = If1NotificationListener;
 _l3InterfaceRefList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
{$Include w:\common\components\rtl\Garant\L3\l3InterfaceRefList.imp.pas}
 Tf1NotificationList = class(_l3InterfaceRefList_)
 end;//Tf1NotificationList

 Tf1NotificationManager = class(Tl3ProtoDataContainer)
 private
 // private fields
   f_List : Tf1NotificationList;
    {* Поле для свойства List}
 protected
 // property methods
   function pm_GetList: Tf1NotificationList;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
 public
 // public methods
   class procedure AddListener(const aListener: If1NotificationListener);
   class procedure RemoveListener(const aListener: If1NotificationListener);
   class procedure ServerDown;
     {* Сигнатура метода ServerDown }
   class function Exists: Boolean;
 protected
 // protected properties
   property List: Tf1NotificationList
     read pm_GetList;
 public
 // singleton factory method
   class function Instance: Tf1NotificationManager;
    {- возвращает экземпляр синглетона. }
 end;//Tf1NotificationManager

implementation

uses
  l3Base {a},
  l3MinMax,
  RTLConsts,
  SysUtils
  ;


// start class Tf1NotificationManager

var g_Tf1NotificationManager : Tf1NotificationManager = nil;

procedure Tf1NotificationManagerFree;
begin
 l3Free(g_Tf1NotificationManager);
end;

class function Tf1NotificationManager.Instance: Tf1NotificationManager;
begin
 if (g_Tf1NotificationManager = nil) then
 begin
  l3System.AddExitProc(Tf1NotificationManagerFree);
  g_Tf1NotificationManager := Create;
 end;
 Result := g_Tf1NotificationManager;
end;


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
type _Instance_R_ = Tf1NotificationList;

{$Include w:\common\components\rtl\Garant\L3\l3InterfaceRefList.imp.pas}

// start class Tf1NotificationManager

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

procedure Tf1NotificationManager.Cleanup;
//#UC START# *479731C50290_54F5D5E002E0_var*
//#UC END# *479731C50290_54F5D5E002E0_var*
begin
//#UC START# *479731C50290_54F5D5E002E0_impl*
 FreeAndNil(f_List);
 inherited;
//#UC END# *479731C50290_54F5D5E002E0_impl*
end;//Tf1NotificationManager.Cleanup

end.