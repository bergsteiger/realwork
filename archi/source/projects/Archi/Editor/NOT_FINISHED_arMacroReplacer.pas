unit NOT_FINISHED_arMacroReplacer;

// Модуль: "w:\archi\source\projects\Archi\Editor\NOT_FINISHED_arMacroReplacer.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TarMacroReplacer" MUID: (4E004EA70057)

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If Defined(AppClientSide)}
uses
 l3IntfUses
 , evCustomHAFMacroReplacer
;

type
 TarMacroReplacer = class(TevCustomHAFMacroReplacer)
 end;//TarMacroReplacer
{$IfEnd} // Defined(AppClientSide)

implementation

{$If Defined(AppClientSide)}
uses
 l3ImplUses
 //#UC START# *4E004EA70057impl_uses*
 //#UC END# *4E004EA70057impl_uses*
;
{$IfEnd} // Defined(AppClientSide)

end.
