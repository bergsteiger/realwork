unit NOT_FINISHED_arHAFPainer;

// ������: "w:\archi\source\projects\Archi\Editor\NOT_FINISHED_arHAFPainer.pas"
// ���������: "SimpleClass"

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
;
{$IfEnd} // Defined(AppClientSide)

end.
