unit l3ProtoObjectForTie;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\l3ProtoObjectForTie.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "Tl3ProtoObjectForTie" MUID: (4C9C9A0603D6)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , l3ProtoObject
;

type
 Tl3ProtoObjectForTie = class(Tl3ProtoObject)
  protected
   function DontUseMe: Pointer;
 end;//Tl3ProtoObjectForTie
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;

function Tl3ProtoObjectForTie.DontUseMe: Pointer;
//#UC START# *4C9C9A2E017F_4C9C9A0603D6_var*
//#UC END# *4C9C9A2E017F_4C9C9A0603D6_var*
begin
//#UC START# *4C9C9A2E017F_4C9C9A0603D6_impl*
 Result := nil;
 Assert(false);
//#UC END# *4C9C9A2E017F_4C9C9A0603D6_impl*
end;//Tl3ProtoObjectForTie.DontUseMe
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
