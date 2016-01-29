unit nsFiltersListenersDocManager;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Filters"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Filters/nsFiltersListenersDocManager.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Core::Common::Filters::FiltersNotification::TnsFiltersListenersDocManager
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
 TnsFiltersListenersDocManager = class(TnsFiltersListenersManagerPrim)
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
   class function Instance: TnsFiltersListenersDocManager;
    {- возвращает экземпляр синглетона. }
 end;//TnsFiltersListenersDocManager
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  l3Base {a},
  DataAdapter
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}


// start class TnsFiltersListenersDocManager

var g_TnsFiltersListenersDocManager : TnsFiltersListenersDocManager = nil;

procedure TnsFiltersListenersDocManagerFree;
begin
 l3Free(g_TnsFiltersListenersDocManager);
end;

class function TnsFiltersListenersDocManager.Instance: TnsFiltersListenersDocManager;
begin
 if (g_TnsFiltersListenersDocManager = nil) then
 begin
  l3System.AddExitProc(TnsFiltersListenersDocManagerFree);
  g_TnsFiltersListenersDocManager := Create;
 end;
 Result := g_TnsFiltersListenersDocManager;
end;


class function TnsFiltersListenersDocManager.Exists: Boolean;
 {-}
begin
 Result := g_TnsFiltersListenersDocManager <> nil;
end;//TnsFiltersListenersDocManager.Exists

class function TnsFiltersListenersDocManager.GetInstance: TnsFiltersListenersManagerPrim;
//#UC START# *4FFD459003A6_4F98447C0378_var*
//#UC END# *4FFD459003A6_4F98447C0378_var*
begin
//#UC START# *4FFD459003A6_4F98447C0378_impl*
 Result := Instance;
//#UC END# *4FFD459003A6_4F98447C0378_impl*
end;//TnsFiltersListenersDocManager.GetInstance

class function TnsFiltersListenersDocManager.HasInstance: Boolean;
//#UC START# *4FFD45CD0313_4F98447C0378_var*
//#UC END# *4FFD45CD0313_4F98447C0378_var*
begin
//#UC START# *4FFD45CD0313_4F98447C0378_impl*
 Result := Assigned(g_TnsFiltersListenersDocManager);
//#UC END# *4FFD45CD0313_4F98447C0378_impl*
end;//TnsFiltersListenersDocManager.HasInstance

procedure TnsFiltersListenersDocManager.Cleanup;
//#UC START# *479731C50290_4F98447C0378_var*
//#UC END# *479731C50290_4F98447C0378_var*
begin
//#UC START# *479731C50290_4F98447C0378_impl*
 defDataAdapter.NativeAdapter.MakeFiltersManager.SetLegalNotifier(nil);
 inherited;
//#UC END# *479731C50290_4F98447C0378_impl*
end;//TnsFiltersListenersDocManager.Cleanup

procedure TnsFiltersListenersDocManager.InitFields;
//#UC START# *47A042E100E2_4F98447C0378_var*
//#UC END# *47A042E100E2_4F98447C0378_var*
begin
//#UC START# *47A042E100E2_4F98447C0378_impl*
 inherited;
 defDataAdapter.NativeAdapter.MakeFiltersManager.SetLegalNotifier(Self);
//#UC END# *47A042E100E2_4F98447C0378_impl*
end;//TnsFiltersListenersDocManager.InitFields

{$IfEnd} //not Admin AND not Monitorings

end.