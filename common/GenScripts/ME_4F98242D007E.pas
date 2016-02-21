unit nsFiltersListenersManagerPrim;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Filters\nsFiltersListenersManagerPrim.pas"
// Стереотип: "SimpleClass"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , l3ProtoObject
 , FiltersUnit
 , nsFiltersListenersList
 , nsFiltersInterfaces
;

type
 TnsFiltersListenersManagerPrim = class(Tl3ProtoObject, IFilterNotifier)
  private
   f_Listeners: TnsFiltersListenersList;
  protected
   class function GetInstance: TnsFiltersListenersManagerPrim; virtual; abstract;
   class function HasInstance: Boolean; virtual; abstract;
   procedure filters_changed;
   procedure filter_name_changed;
   procedure filter_permanence_changed;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure InitFields; override;
  public
   class procedure AddListener(const aListener: InsFiltersListener);
   class procedure RemoveListener(const aListener: InsFiltersListener);
 end;//TnsFiltersListenersManagerPrim
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , l3Base
;

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

procedure TnsFiltersListenersManagerPrim.filters_changed;
//#UC START# *4CB2B26B0365_4F98242D007E_var*
var
 l_Loop: Integer;
//#UC END# *4CB2B26B0365_4F98242D007E_var*
begin
//#UC START# *4CB2B26B0365_4F98242D007E_impl*
 for l_Loop := 0 to f_Listeners.Count - 1 do
  f_Listeners[l_Loop].FiltersChanged;
//#UC END# *4CB2B26B0365_4F98242D007E_impl*
end;//TnsFiltersListenersManagerPrim.filters_changed

procedure TnsFiltersListenersManagerPrim.filter_name_changed;
//#UC START# *4CB2B27F03C3_4F98242D007E_var*
var
 l_Loop: Integer;
//#UC END# *4CB2B27F03C3_4F98242D007E_var*
begin
//#UC START# *4CB2B27F03C3_4F98242D007E_impl*
 for l_Loop := 0 to f_Listeners.Count - 1 do
  f_Listeners[l_Loop].FilterNameChanged;
//#UC END# *4CB2B27F03C3_4F98242D007E_impl*
end;//TnsFiltersListenersManagerPrim.filter_name_changed

procedure TnsFiltersListenersManagerPrim.filter_permanence_changed;
//#UC START# *4CB2B2910052_4F98242D007E_var*
var
 l_Loop: Integer;
//#UC END# *4CB2B2910052_4F98242D007E_var*
begin
//#UC START# *4CB2B2910052_4F98242D007E_impl*
 for l_Loop := 0 to f_Listeners.Count - 1 do
  f_Listeners[l_Loop].FilterPermanenceChanged;
//#UC END# *4CB2B2910052_4F98242D007E_impl*
end;//TnsFiltersListenersManagerPrim.filter_permanence_changed

procedure TnsFiltersListenersManagerPrim.Cleanup;
 {* Функция очистки полей объекта. }
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
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
