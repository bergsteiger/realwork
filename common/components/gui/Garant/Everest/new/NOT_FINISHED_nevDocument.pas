unit NOT_FINISHED_nevDocument;

// ������: "w:\common\components\gui\Garant\Everest\new\NOT_FINISHED_nevDocument.pas"
// ���������: "SimpleClass"

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

{$If Defined(k2ForEditor)}
uses
 l3IntfUses
 , nevParaList
;

type
 TnevDocument = class(TnevParaList)
 end;//TnevDocument
{$IfEnd} // Defined(k2ForEditor)

implementation

{$If Defined(k2ForEditor)}
uses
 l3ImplUses
;
{$IfEnd} // Defined(k2ForEditor)

end.
