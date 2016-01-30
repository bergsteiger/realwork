unit NOT_FINISHED_vcmDockTree;

// Модуль: "w:\common\components\gui\Garant\VCM\implementation\Visual\NOT_FINISHED_vcmDockTree.pas"
// Стереотип: "SimpleClass"

{$Include vcmDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , l3DockTree
;

type
 TvcmDockTree = class(Tl3DockTree)
 end;//TvcmDockTree
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(NoVCM)

end.
