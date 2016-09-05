unit l3ExceptionsLogEx;

// Модуль: "w:\common\components\rtl\Garant\L3\l3ExceptionsLogEx.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "Tl3ExceptionsLogEx" MUID: (540EE27400BE)

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

interface

uses
 l3IntfUses
 , l3ExceptionsLog
;

type
 Tl3ExceptionsLogEx = class(Tl3ExceptionsLog)
  protected
   {$If Defined(_m0USEFORMS1)}
   procedure SetOnException; override;
   {$IfEnd} // Defined(_m0USEFORMS1)
   {$If Defined(_m0USEFORMS1)}
   procedure ResOnException; override;
   {$IfEnd} // Defined(_m0USEFORMS1)
   function NeedTime: Boolean; override;
 end;//Tl3ExceptionsLogEx

implementation

uses
 l3ImplUses
 //#UC START# *540EE27400BEimpl_uses*
 //#UC END# *540EE27400BEimpl_uses*
;

{$If Defined(_m0USEFORMS1)}
procedure Tl3ExceptionsLogEx.SetOnException;
//#UC START# *540EE287029C_540EE27400BE_var*
//#UC END# *540EE287029C_540EE27400BE_var*
begin
//#UC START# *540EE287029C_540EE27400BE_impl*
 // - ничего не делаем
//#UC END# *540EE287029C_540EE27400BE_impl*
end;//Tl3ExceptionsLogEx.SetOnException
{$IfEnd} // Defined(_m0USEFORMS1)

{$If Defined(_m0USEFORMS1)}
procedure Tl3ExceptionsLogEx.ResOnException;
//#UC START# *540EE29A0095_540EE27400BE_var*
//#UC END# *540EE29A0095_540EE27400BE_var*
begin
//#UC START# *540EE29A0095_540EE27400BE_impl*
 // - ничего не делаем
//#UC END# *540EE29A0095_540EE27400BE_impl*
end;//Tl3ExceptionsLogEx.ResOnException
{$IfEnd} // Defined(_m0USEFORMS1)

function Tl3ExceptionsLogEx.NeedTime: Boolean;
//#UC START# *5422E8FC025D_540EE27400BE_var*
//#UC END# *5422E8FC025D_540EE27400BE_var*
begin
//#UC START# *5422E8FC025D_540EE27400BE_impl*
 Result := true;
//#UC END# *5422E8FC025D_540EE27400BE_impl*
end;//Tl3ExceptionsLogEx.NeedTime

end.
