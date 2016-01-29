unit nsFiltersListenersManagerPrim;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Filters"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Filters/nsFiltersListenersManagerPrim.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Core::Common::Filters::FiltersNotification::TnsFiltersListenersManagerPrim
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
  FiltersUnit,
  l3ProtoObject,
  nsFiltersInterfaces,
  nsFiltersListenersList
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TnsFiltersListenersManagerPrim = class(Tl3ProtoObject, IFilterNotifier)
 private
 // private fields
   f_Listeners : TnsFiltersListenersList;
 protected
 // realized methods
   procedure FiltersChanged; stdcall;
   procedure FilterNameChanged; stdcall;
   procedure FilterPermanenceChanged; stdcall;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   procedure InitFields; override;
 protected
 // protected methods
   class function GetInstance: TnsFiltersListenersManagerPrim; virtual; abstract;
   class function HasInstance: Boolean; virtual; abstract;
 public
 // public methods
   class procedure AddListener(const aListener: InsFiltersListener);
   class procedure RemoveListener(const aListener: InsFiltersListener);
 end;//TnsFiltersListenersManagerPrim
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  l3Base
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TnsFiltersListenersManagerPrim

class procedure TnsFiltersListenersManagerPrim.AddListener(const aListener: InsFiltersListener);
//#UC START# *4F982629031E_4F98242D007E_var*
//#UC END# *4F982629031E_4F98242D007E_var*
begin
//#UC START# *4F982629031E_4F98242D007E_impl*
 with GetInstance do
  if f_Listeners.IndexOf(aListener) < 0 then
   f_Listeners.Add(aListener);
//#UC END# *4F982629031E_4F98242D007E_impl*
end;//TnsFiltersListenersManagerPrim.AddListener

class procedure TnsFiltersListenersManagerPrim.RemoveListener(const aListener: InsFiltersListener);
//#UC START# *4F98265301F4_4F98242D007E_var*
//#UC END# *4F98265301F4_4F98242D007E_var*
begin
//#UC START# *4F98265301F4_4F98242D007E_impl*
 if HasInstance then
  GetInstance.f_Listeners.Remove(aListener);
//#UC END# *4F98265301F4_4F98242D007E_impl*
end;//TnsFiltersListenersManagerPrim.RemoveListener

procedure TnsFiltersListenersManagerPrim.FiltersChanged;
//#UC START# *4CB2B26B0365_4F98242D007E_var*
var
 l_Loop: Integer;
//#UC END# *4CB2B26B0365_4F98242D007E_var*
begin
//#UC START# *4CB2B26B0365_4F98242D007E_impl*
 for l_Loop := 0 to f_Listeners.Count - 1 do
  f_Listeners[l_Loop].FiltersChanged;
//#UC END# *4CB2B26B0365_4F98242D007E_impl*
end;//TnsFiltersListenersManagerPrim.FiltersChanged

procedure TnsFiltersListenersManagerPrim.FilterNameChanged;
//#UC START# *4CB2B27F03C3_4F98242D007E_var*
var
 l_Loop: Integer;
//#UC END# *4CB2B27F03C3_4F98242D007E_var*
begin
//#UC START# *4CB2B27F03C3_4F98242D007E_impl*
 for l_Loop := 0 to f_Listeners.Count - 1 do
  f_Listeners[l_Loop].FilterNameChanged;
//#UC END# *4CB2B27F03C3_4F98242D007E_impl*
end;//TnsFiltersListenersManagerPrim.FilterNameChanged

procedure TnsFiltersListenersManagerPrim.FilterPermanenceChanged;
//#UC START# *4CB2B2910052_4F98242D007E_var*
var
 l_Loop: Integer;
//#UC END# *4CB2B2910052_4F98242D007E_var*
begin
//#UC START# *4CB2B2910052_4F98242D007E_impl*
 for l_Loop := 0 to f_Listeners.Count - 1 do
  f_Listeners[l_Loop].FilterPermanenceChanged;
//#UC END# *4CB2B2910052_4F98242D007E_impl*
end;//TnsFiltersListenersManagerPrim.FilterPermanenceChanged

procedure TnsFiltersListenersManagerPrim.Cleanup;
//#UC START# *479731C50290_4F98242D007E_var*
//#UC END# *479731C50290_4F98242D007E_var*
begin
//#UC START# *479731C50290_4F98242D007E_impl*
 l3Free(f_Listeners);
 inherited;
//#UC END# *479731C50290_4F98242D007E_impl*
end;//TnsFiltersListenersManagerPrim.Cleanup

procedure TnsFiltersListenersManagerPrim.InitFields;
//#UC START# *47A042E100E2_4F98242D007E_var*
//#UC END# *47A042E100E2_4F98242D007E_var*
begin
//#UC START# *47A042E100E2_4F98242D007E_impl*
 inherited;
 f_Listeners := TnsFiltersListenersList.Create; 
//#UC END# *47A042E100E2_4F98242D007E_impl*
end;//TnsFiltersListenersManagerPrim.InitFields

{$IfEnd} //not Admin AND not Monitorings

end.