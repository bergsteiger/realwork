unit vcmToolbarUtils;

// Модуль: "w:\common\components\gui\Garant\VCM\vcmToolbarUtils.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "vcmToolbarUtils" MUID: (502BC6DC00F4)

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , l3ProtoObject
 , vcmBase
;

type
 TvcmToolbarDockListManager = class(Tl3ProtoObject)
  private
   f_DockList: TvcmObjectList;
  protected
   function pm_GetDockList: TvcmObjectList; virtual;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   class function Exists: Boolean;
   class function Instance: TvcmToolbarDockListManager;
    {* Метод получения экземпляра синглетона TvcmToolbarDockListManager }
  public
   property DockList: TvcmObjectList
    read pm_GetDockList;
 end;//TvcmToolbarDockListManager
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
 , SysUtils
 , l3Base
 //#UC START# *502BC6DC00F4impl_uses*
 //#UC END# *502BC6DC00F4impl_uses*
;

var g_TvcmToolbarDockListManager: TvcmToolbarDockListManager = nil;
 {* Экземпляр синглетона TvcmToolbarDockListManager }

procedure TvcmToolbarDockListManagerFree;
 {* Метод освобождения экземпляра синглетона TvcmToolbarDockListManager }
begin
 l3Free(g_TvcmToolbarDockListManager);
end;//TvcmToolbarDockListManagerFree

function TvcmToolbarDockListManager.pm_GetDockList: TvcmObjectList;
//#UC START# *502BC739002B_502CEFC803B2get_var*
//#UC END# *502BC739002B_502CEFC803B2get_var*
begin
//#UC START# *502BC739002B_502CEFC803B2get_impl*
 if f_DockList = nil then
  f_DockList := TvcmObjectList.Make;
 Result := f_DockList;
//#UC END# *502BC739002B_502CEFC803B2get_impl*
end;//TvcmToolbarDockListManager.pm_GetDockList

class function TvcmToolbarDockListManager.Exists: Boolean;
begin
 Result := g_TvcmToolbarDockListManager <> nil;
end;//TvcmToolbarDockListManager.Exists

class function TvcmToolbarDockListManager.Instance: TvcmToolbarDockListManager;
 {* Метод получения экземпляра синглетона TvcmToolbarDockListManager }
begin
 if (g_TvcmToolbarDockListManager = nil) then
 begin
  l3System.AddExitProc(TvcmToolbarDockListManagerFree);
  g_TvcmToolbarDockListManager := Create;
 end;
 Result := g_TvcmToolbarDockListManager;
end;//TvcmToolbarDockListManager.Instance

procedure TvcmToolbarDockListManager.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_502CEFC803B2_var*
//#UC END# *479731C50290_502CEFC803B2_var*
begin
//#UC START# *479731C50290_502CEFC803B2_impl*
 l3Free(f_DockList);
//#UC END# *479731C50290_502CEFC803B2_impl*
end;//TvcmToolbarDockListManager.Cleanup
{$IfEnd} // NOT Defined(NoVCM)

end.
