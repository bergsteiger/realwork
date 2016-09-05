unit NOT_FINISHED_arHAFPainer;

// Модуль: "w:\archi\source\projects\Archi\Editor\NOT_FINISHED_arHAFPainer.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TarHAFPainer" MUID: (4E004E2F0251)

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If Defined(AppClientSide)}
uses
 l3IntfUses
 , evHAFPainterEx
;

type
 TarHAFPainer = class(TevHAFPainterEx)
 end;//TarHAFPainer
{$IfEnd} // Defined(AppClientSide)

implementation

{$If Defined(AppClientSide)}
uses
 l3ImplUses
 //#UC START# *4E004E2F0251impl_uses*
 //#UC END# *4E004E2F0251impl_uses*
;
{$IfEnd} // Defined(AppClientSide)

end.
