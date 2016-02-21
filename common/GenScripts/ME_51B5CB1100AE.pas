unit DefineSearchDateUtils;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\DefineSearchDateUtils.pas"
// Стереотип: "UtilityPack"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
;

function CompareButtons(Item1: Pointer;
 Item2: Pointer): Integer;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
;

function CompareButtons(Item1: Pointer;
 Item2: Pointer): Integer;
//#UC START# *51B5CA81031F_51B5CB1100AE_var*
//#UC END# *51B5CA81031F_51B5CB1100AE_var*
begin
//#UC START# *51B5CA81031F_51B5CB1100AE_impl*
 Result := TWinControl(Item1).TabOrder - TWinControl(Item2).TabOrder;
//#UC END# *51B5CA81031F_51B5CB1100AE_impl*
end;//CompareButtons
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
