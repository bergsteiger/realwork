unit NOT_FINISHED_arTextOfDocumentWithContentsTree;

// ������: "w:\archi\source\projects\Archi\Editor\NOT_FINISHED_arTextOfDocumentWithContentsTree.pas"
// ���������: "SimpleClass"
// ������� ������: "TarTextOfDocumentWithContentsTree" MUID: (4E007CE303AC)

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
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TarTextOfDocumentWithContentsTree);
 {* ����������� TarTextOfDocumentWithContentsTree }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // Defined(AppClientSide)

end.
