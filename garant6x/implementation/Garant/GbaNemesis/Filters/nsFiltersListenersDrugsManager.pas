unit nsFiltersListenersDrugsManager;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Filters"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Filters/nsFiltersListenersDrugsManager.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Core::Common::Filters::FiltersNotification::TnsFiltersListenersDrugsManager
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  nsFiltersListenersManagerPrim
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TnsFiltersListenersDrugsManager = class(TnsFiltersListenersManagerPrim)
 public
 // realized methods
   class function GetInstance: TnsFiltersListenersManagerPrim; override;
   class function HasInstance: Boolean; override;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   procedure InitFields; override;
 public
 // public methods
   class function Exists: Boolean;
     {* Проверяет создан экземпляр синглетона или нет }
 public
 // singleton factory method
   class function Instance: TnsFiltersListenersDrugsManager;
    {- возвращает экземпляр синглетона. }
 end;//TnsFiltersListenersDrugsManager
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  l3Base {a},
  DataAdapter
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}


// start class TnsFiltersListenersDrugsManager

var g_TnsFiltersListenersDrugsManager : TnsFiltersListenersDrugsManager = nil;

procedure TnsFiltersListenersDrugsManagerFree;
begin
 l3Free(g_TnsFiltersListenersDrugsManager);
end;

class function TnsFiltersListenersDrugsManager.Instance: TnsFiltersListenersDrugsManager;
begin
 if (g_TnsFiltersListenersDrugsManager = nil) then
 begin
  l3System.AddExitProc(TnsFiltersListenersDrugsManagerFree);
  g_TnsFiltersListenersDrugsManager := Create;
 end;
 Result := g_TnsFiltersListenersDrugsManager;
end;


class function TnsFiltersListenersDrugsManager.Exists: Boolean;
 {-}
begin
 Result := g_TnsFiltersListenersDrugsManager <> nil;
end;//TnsFiltersListenersDrugsManager.Exists

class function TnsFiltersListenersDrugsManager.GetInstance: TnsFiltersListenersManagerPrim;
//#UC START# *4FFD459003A6_4F98440301D2_var*
//#UC END# *4FFD459003A6_4F98440301D2_var*
begin
//#UC START# *4FFD459003A6_4F98440301D2_impl*
 Result := Instance;
//#UC END# *4FFD459003A6_4F98440301D2_impl*
end;//TnsFiltersListenersDrugsManager.GetInstance

class function TnsFiltersListenersDrugsManager.HasInstance: Boolean;
//#UC START# *4FFD45CD0313_4F98440301D2_var*
//#UC END# *4FFD45CD0313_4F98440301D2_var*
begin
//#UC START# *4FFD45CD0313_4F98440301D2_impl*
 Result := Assigned(g_TnsFiltersListenersDrugsManager);
//#UC END# *4FFD45CD0313_4F98440301D2_impl*
end;//TnsFiltersListenersDrugsManager.HasInstance

procedure TnsFiltersListenersDrugsManager.Cleanup;
//#UC START# *479731C50290_4F98440301D2_var*
//#UC END# *479731C50290_4F98440301D2_var*
begin
//#UC START# *479731C50290_4F98440301D2_impl*
 defDataAdapter.NativeAdapter.MakeFiltersManager.SetPharmNotifier(nil);
 inherited;
//#UC END# *479731C50290_4F98440301D2_impl*
end;//TnsFiltersListenersDrugsManager.Cleanup

procedure TnsFiltersListenersDrugsManager.InitFields;
//#UC START# *47A042E100E2_4F98440301D2_var*
//#UC END# *47A042E100E2_4F98440301D2_var*
begin
//#UC START# *47A042E100E2_4F98440301D2_impl*
 inherited;
 defDataAdapter.NativeAdapter.MakeFiltersManager.SetPharmNotifier(Self);
//#UC END# *47A042E100E2_4F98440301D2_impl*
end;//TnsFiltersListenersDrugsManager.InitFields

{$IfEnd} //not Admin AND not Monitorings

end.