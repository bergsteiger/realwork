unit vcmToolbarUtils;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VCM"
// Модуль: "w:/common/components/gui/Garant/VCM/vcmToolbarUtils.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi::VCM::vcmToolbarUnit::vcmToolbarUtils
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\VCM\vcmDefine.inc}

interface

{$If not defined(NoVCM)}
uses
  vcmBase,
  l3ProtoObject
  ;

type
 TvcmToolbarDockListManager = class(Tl3ProtoObject)
 private
 // private fields
   f_DockList : TvcmObjectList;
    {* Поле для свойства DockList}
 protected
 // property methods
   function pm_GetDockList: TvcmObjectList; virtual;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
 public
 // public methods
   class function Exists: Boolean;
 public
 // public properties
   property DockList: TvcmObjectList
     read pm_GetDockList;
 public
 // singleton factory method
   class function Instance: TvcmToolbarDockListManager;
    {- возвращает экземпляр синглетона. }
 end;//TvcmToolbarDockListManager
{$IfEnd} //not NoVCM

implementation

{$If not defined(NoVCM)}
uses
  l3Base {a}
  ;


// start class TvcmToolbarDockListManager

var g_TvcmToolbarDockListManager : TvcmToolbarDockListManager = nil;

procedure TvcmToolbarDockListManagerFree;
begin
 l3Free(g_TvcmToolbarDockListManager);
end;

class function TvcmToolbarDockListManager.Instance: TvcmToolbarDockListManager;
begin
 if (g_TvcmToolbarDockListManager = nil) then
 begin
  l3System.AddExitProc(TvcmToolbarDockListManagerFree);
  g_TvcmToolbarDockListManager := Create;
 end;
 Result := g_TvcmToolbarDockListManager;
end;


class function TvcmToolbarDockListManager.Exists: Boolean;
//#UC START# *502CF050026B_502CEFC803B2_var*
//#UC END# *502CF050026B_502CEFC803B2_var*
begin
//#UC START# *502CF050026B_502CEFC803B2_impl*
 Result := g_TvcmToolbarDockListManager <> nil;
//#UC END# *502CF050026B_502CEFC803B2_impl*
end;//TvcmToolbarDockListManager.Exists

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

procedure TvcmToolbarDockListManager.Cleanup;
//#UC START# *479731C50290_502CEFC803B2_var*
//#UC END# *479731C50290_502CEFC803B2_var*
begin
//#UC START# *479731C50290_502CEFC803B2_impl*
 l3Free(f_DockList);
//#UC END# *479731C50290_502CEFC803B2_impl*
end;//TvcmToolbarDockListManager.Cleanup
{$IfEnd} //not NoVCM

end.