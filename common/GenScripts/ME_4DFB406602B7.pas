unit arEditorUtils;

// Модуль: "w:\archi\source\projects\Archi\Archi_Insider_Test_Support\arEditorUtils.pas"
// Стереотип: "UtilityPack"

{$Include arDefine.inc}

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
;
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)

end.
