unit NOT_FINISHED_arTextOfDocumentWithContentsTree;

// Модуль: "w:\archi\source\projects\Archi\Editor\NOT_FINISHED_arTextOfDocumentWithContentsTree.pas"
// Стереотип: "SimpleClass"

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If Defined(AppClientSide)}
uses
 l3IntfUses
 , arTextOfDocument
;

type
 TarTextOfDocumentWithContentsTree = class(TarTextOfDocument)
 end;//TarTextOfDocumentWithContentsTree
{$IfEnd} // Defined(AppClientSide)

implementation

{$If Defined(AppClientSide)}
uses
 l3ImplUses
 , arDocumentContainerWithContentsTree
;
{$IfEnd} // Defined(AppClientSide)

end.
