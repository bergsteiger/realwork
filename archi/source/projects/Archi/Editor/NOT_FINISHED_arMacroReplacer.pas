unit NOT_FINISHED_arMacroReplacer;

// ������: "w:\archi\source\projects\Archi\Editor\NOT_FINISHED_arMacroReplacer.pas"
// ���������: "SimpleClass"

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
;
{$IfEnd} // Defined(AppClientSide)

end.
