unit NOT_FINISHED_F_AttrExplorer;

// Модуль: "w:\archi\source\projects\Archi\Frames\NOT_FINISHED_F_AttrExplorer.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "F_AttrExplorer" MUID: (528A0B83039C)

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
 //#UC START# *528A0B83039Cimpl_uses*
 //#UC END# *528A0B83039Cimpl_uses*
;
{$IfEnd} // Defined(AppClientSide)

end.
