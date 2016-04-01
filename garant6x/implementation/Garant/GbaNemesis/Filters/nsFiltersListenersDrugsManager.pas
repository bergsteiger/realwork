unit nsFiltersListenersDrugsManager;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Filters\nsFiltersListenersDrugsManager.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnsFiltersListenersDrugsManager" MUID: (4F98440301D2)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , nsFiltersListenersManagerPrim
;

type
 TnsFiltersListenersDrugsManager = class(TnsFiltersListenersManagerPrim)
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure InitFields; override;
  public
   class function GetInstance: TnsFiltersListenersManagerPrim; override;
   class function HasInstance: Boolean; override;
   class function Instance: TnsFiltersListenersDrugsManager;
    {* Метод получения экземпляра синглетона TnsFiltersListenersDrugsManager }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
 end;//TnsFiltersListenersDrugsManager
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , DataAdapter
 , SysUtils
 , l3Base
;

var g_TnsFiltersListenersDrugsManager: TnsFiltersListenersDrugsManager = nil;
 {* Экземпляр синглетона TnsFiltersListenersDrugsManager }

procedure TnsFiltersListenersDrugsManagerFree;
 {* Метод освобождения экземпляра синглетона TnsFiltersListenersDrugsManager }
begin
 l3Free(g_TnsFiltersListenersDrugsManager);
end;//TnsFiltersListenersDrugsManagerFree

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

class function TnsFiltersListenersDrugsManager.Instance: TnsFiltersListenersDrugsManager;
 {* Метод получения экземпляра синглетона TnsFiltersListenersDrugsManager }
begin
 if (g_TnsFiltersListenersDrugsManager = nil) then
 begin
  l3System.AddExitProc(TnsFiltersListenersDrugsManagerFree);
  g_TnsFiltersListenersDrugsManager := Create;
 end;
 Result := g_TnsFiltersListenersDrugsManager;
end;//TnsFiltersListenersDrugsManager.Instance

class function TnsFiltersListenersDrugsManager.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TnsFiltersListenersDrugsManager <> nil;
end;//TnsFiltersListenersDrugsManager.Exists

procedure TnsFiltersListenersDrugsManager.Cleanup;
 {* Функция очистки полей объекта. }
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
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
