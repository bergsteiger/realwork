unit NOT_FINISHED_F_AttrExplorer;

// Модуль: "w:\archi\source\projects\Archi\Frames\NOT_FINISHED_F_AttrExplorer.pas"
// Стереотип: "UtilityPack"

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If Defined(AppClientSide)}
uses
 l3IntfUses
;

type
 TAttrExplorer = class
 end;//TAttrExplorer
{$IfEnd} // Defined(AppClientSide)

implementation

{$If Defined(AppClientSide)}
uses
 l3ImplUses
 {$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)}
 , AttributeExplorerWordsPack
 {$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)
;
{$IfEnd} // Defined(AppClientSide)

end.
