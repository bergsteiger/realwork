unit arEditorUtils;

// Модуль: "w:\archi\source\projects\Archi\Archi_Insider_Test_Support\arEditorUtils.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "arEditorUtils" MUID: (4DFB406602B7)

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
;
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , kwClickOnCommentHeader
 , kwEditorDblClickOnSub
 , kwDeleteSub
 , kwDocEditorSetModified
 , kwAddBlock
 , kwEditorSetTOC
 , kwGotoSub
 , kwEndAddSubByMouse
 , kwSetExpiredStyle
 //#UC START# *4DFB406602B7impl_uses*
 //#UC END# *4DFB406602B7impl_uses*
;
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)

end.
