unit NOT_FINISHED_nevCommentPara;

// ������: "w:\common\components\gui\Garant\Everest\new\NOT_FINISHED_nevCommentPara.pas"
// ���������: "SimpleClass"

{$Include evDefine.inc}

interface

{$If Defined(k2ForEditor)}
uses
 l3IntfUses
 , nevDocumentPart
;

type
 TnevCommentPara = class(TnevDocumentPart)
 end;//TnevCommentPara
{$IfEnd} // Defined(k2ForEditor)

implementation

{$If Defined(k2ForEditor)}
uses
 l3ImplUses
;
{$IfEnd} // Defined(k2ForEditor)

end.
