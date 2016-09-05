unit NOT_FINISHED_l3ExceptionsLog;

// Модуль: "w:\common\components\rtl\Garant\L3\NOT_FINISHED_l3ExceptionsLog.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "Tl3ExceptionsLog" MUID: (540EE24702BC)

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

interface

uses
 l3IntfUses
;

type
 Tl3ExceptionsLog = class(TObject)
  protected
   {$If Defined(_m0USEFORMS1)}
   procedure SetOnException; virtual;
   {$IfEnd} // Defined(_m0USEFORMS1)
   {$If Defined(_m0USEFORMS1)}
   procedure ResOnException; virtual;
   {$IfEnd} // Defined(_m0USEFORMS1)
   function NeedTime: Boolean; virtual;
 end;//Tl3ExceptionsLog

implementation

uses
 l3ImplUses
 //#UC START# *540EE24702BCimpl_uses*
 //#UC END# *540EE24702BCimpl_uses*
;

{$If Defined(_m0USEFORMS1)}
procedure Tl3ExceptionsLog.SetOnException;
//#UC START# *540EE287029C_540EE24702BC_var*
//#UC END# *540EE287029C_540EE24702BC_var*
begin
//#UC START# *540EE287029C_540EE24702BC_impl*
 !!! Needs to be implemented !!!
//#UC END# *540EE287029C_540EE24702BC_impl*
end;//Tl3ExceptionsLog.SetOnException
{$IfEnd} // Defined(_m0USEFORMS1)

{$If Defined(_m0USEFORMS1)}
procedure Tl3ExceptionsLog.ResOnException;
//#UC START# *540EE29A0095_540EE24702BC_var*
//#UC END# *540EE29A0095_540EE24702BC_var*
begin
//#UC START# *540EE29A0095_540EE24702BC_impl*
 !!! Needs to be implemented !!!
//#UC END# *540EE29A0095_540EE24702BC_impl*
end;//Tl3ExceptionsLog.ResOnException
{$IfEnd} // Defined(_m0USEFORMS1)

function Tl3ExceptionsLog.NeedTime: Boolean;
//#UC START# *5422E8FC025D_540EE24702BC_var*
//#UC END# *5422E8FC025D_540EE24702BC_var*
begin
//#UC START# *5422E8FC025D_540EE24702BC_impl*
 !!! Needs to be implemented !!!
//#UC END# *5422E8FC025D_540EE24702BC_impl*
end;//Tl3ExceptionsLog.NeedTime

end.
