unit nsFiltersListenersDocManager;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Filters\nsFiltersListenersDocManager.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnsFiltersListenersDocManager" MUID: (4F98447C0378)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , nsFiltersListenersManagerPrim
;

type
 TnsFiltersListenersDocManager = class(TnsFiltersListenersManagerPrim)
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure InitFields; override;
  public
   class function GetInstance: TnsFiltersListenersManagerPrim; override;
   class function HasInstance: Boolean; override;
   class function Instance: TnsFiltersListenersDocManager;
    {* Метод получения экземпляра синглетона TnsFiltersListenersDocManager }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
 end;//TnsFiltersListenersDocManager
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , DataAdapter
 , SysUtils
 , l3Base
 //#UC START# *4F98447C0378impl_uses*
 //#UC END# *4F98447C0378impl_uses*
;

var g_TnsFiltersListenersDocManager: TnsFiltersListenersDocManager = nil;
 {* Экземпляр синглетона TnsFiltersListenersDocManager }

procedure TnsFiltersListenersDocManagerFree;
 {* Метод освобождения экземпляра синглетона TnsFiltersListenersDocManager }
begin
 l3Free(g_TnsFiltersListenersDocManager);
end;//TnsFiltersListenersDocManagerFree

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

class function TnsFiltersListenersDocManager.Instance: TnsFiltersListenersDocManager;
 {* Метод получения экземпляра синглетона TnsFiltersListenersDocManager }
begin
 if (g_TnsFiltersListenersDocManager = nil) then
 begin
  l3System.AddExitProc(TnsFiltersListenersDocManagerFree);
  g_TnsFiltersListenersDocManager := Create;
 end;
 Result := g_TnsFiltersListenersDocManager;
end;//TnsFiltersListenersDocManager.Instance

class function TnsFiltersListenersDocManager.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TnsFiltersListenersDocManager <> nil;
end;//TnsFiltersListenersDocManager.Exists

procedure TnsFiltersListenersDocManager.Cleanup;
 {* Функция очистки полей объекта. }
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
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
