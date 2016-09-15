unit ImsmControllerList;

// Модуль: "w:\common\components\gui\Garant\msm\ImsmControllerList.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TImsmControllerList" MUID: (57DA9E250137)

{$Include w:\common\components\msm.inc}

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , msmControllers
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = ImsmController;
 _l3InterfaceRefList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3InterfaceRefList.imp.pas}
 TImsmControllerList = class(_l3InterfaceRefList_)
  protected
   procedure DoActivate; virtual;
   procedure DoActivated; virtual;
  public
   procedure Activate;
   procedure Activated;
 end;//TImsmControllerList

implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
 //#UC START# *57DA9E250137impl_uses*
 //#UC END# *57DA9E250137impl_uses*
;

type _Instance_R_ = TImsmControllerList;

{$Include w:\common\components\rtl\Garant\L3\l3InterfaceRefList.imp.pas}

procedure TImsmControllerList.DoActivate;
//#UC START# *57D2B82102BD_57DA9E250137_var*
//#UC END# *57D2B82102BD_57DA9E250137_var*
begin
//#UC START# *57D2B82102BD_57DA9E250137_impl*
 // - ничего не желаем, это для потомков
//#UC END# *57D2B82102BD_57DA9E250137_impl*
end;//TImsmControllerList.DoActivate

procedure TImsmControllerList.DoActivated;
//#UC START# *57DAB38900EF_57DA9E250137_var*
//#UC END# *57DAB38900EF_57DA9E250137_var*
begin
//#UC START# *57DAB38900EF_57DA9E250137_impl*
 // - ничего не желаем, это для потомков
//#UC END# *57DAB38900EF_57DA9E250137_impl*
end;//TImsmControllerList.DoActivated

procedure TImsmControllerList.Activate;
//#UC START# *57B1AB98014B_57DA9E250137_var*
var
 l_Index : Integer;
//#UC END# *57B1AB98014B_57DA9E250137_var*
begin
//#UC START# *57B1AB98014B_57DA9E250137_impl*
 for l_Index := 0 to Pred(Count) do
  Items[l_Index].Activate;
 DoActivate;
 Activated;
//#UC END# *57B1AB98014B_57DA9E250137_impl*
end;//TImsmControllerList.Activate

procedure TImsmControllerList.Activated;
//#UC START# *57B6A3EF0191_57DA9E250137_var*
var
 l_Index : Integer;
//#UC END# *57B6A3EF0191_57DA9E250137_var*
begin
//#UC START# *57B6A3EF0191_57DA9E250137_impl*
 for l_Index := 0 to Pred(Count) do
  Items[l_Index].Activated;
 DoActivated;
//#UC END# *57B6A3EF0191_57DA9E250137_impl*
end;//TImsmControllerList.Activated

end.
