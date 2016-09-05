unit l3ProtoObjectForTie;

// Модуль: "w:\common\components\rtl\Garant\L3\l3ProtoObjectForTie.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "Tl3ProtoObjectForTie" MUID: (4C9C9A0603D6)

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

interface

uses
 l3IntfUses
 , l3ProtoObject
;

type
 Tl3ProtoObjectForTie = class(Tl3ProtoObject)
  protected
   function DontUseMe: Pointer;
 end;//Tl3ProtoObjectForTie

implementation

uses
 l3ImplUses
 //#UC START# *4C9C9A0603D6impl_uses*
 //#UC END# *4C9C9A0603D6impl_uses*
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

end.
