unit evCommentPara_InterfaceFactory;

// Модуль: "w:\common\components\gui\Garant\Everest\evCommentPara_InterfaceFactory.pas"
// Стереотип: "InterfaceFactory"
// Элемент модели: "TevCommentPara" MUID: (4857C9F90189)
// Имя типа: "TevCommentParaInterfaceFactory"

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

{$If Defined(k2ForEditor)}
uses
 l3IntfUses
 , evBlock_InterfaceFactory
 , l3Variant
 , l3IID
 , k2ToolPrim
;

type
 TevCommentParaInterfaceFactory = class(TevBlockInterfaceFactory)
  protected
   function COMQueryTool(aTag: Tl3Tag;
    const aIID: Tl3GUID;
    out theTool;
    const aProcessor: Ik2Processor): Boolean; override;
  public
   function QueryTool(aTag: Tl3Variant;
    const ID: Tl3IID;
    out I: Tk2ToolPrim): Boolean; override;
 end;//TevCommentParaInterfaceFactory
{$IfEnd} // Defined(k2ForEditor)

implementation

{$If Defined(k2ForEditor)}
uses
 l3ImplUses
 , nevRealTools
 , nevTools
 , nevGUIInterfaces
 , nevBase
 {$If Defined(evUseVisibleCursors)}
 , evCommentParaCursor
 {$IfEnd} // Defined(evUseVisibleCursors)
 {$If Defined(evNeedPainters)}
 , evCommentParaPainter
 {$IfEnd} // Defined(evNeedPainters)
 {$If Defined(evUseVisibleCursors)}
 , evCommentParaCursorPair
 {$IfEnd} // Defined(evUseVisibleCursors)
 , nevCommentPara
 {$If Defined(evNeedHotSpot)}
 , evCommentParaHotSpotTester
 {$IfEnd} // Defined(evNeedHotSpot)
 , CommentPara_Const
;

function TevCommentParaInterfaceFactory.QueryTool(aTag: Tl3Variant;
 const ID: Tl3IID;
 out I: Tk2ToolPrim): Boolean;
//#UC START# *4D63D26D033F_4857C9F90189_var*
//#UC END# *4D63D26D033F_4857C9F90189_var*
begin
//#UC START# *4D63D26D033F_4857C9F90189_impl*
 !!! Needs to be implemented !!!
//#UC END# *4D63D26D033F_4857C9F90189_impl*
end;//TevCommentParaInterfaceFactory.QueryTool

function TevCommentParaInterfaceFactory.COMQueryTool(aTag: Tl3Tag;
 const aIID: Tl3GUID;
 out theTool;
 const aProcessor: Ik2Processor): Boolean;
//#UC START# *53CCBDA5026D_4857C9F90189_var*
//#UC END# *53CCBDA5026D_4857C9F90189_var*
begin
//#UC START# *53CCBDA5026D_4857C9F90189_impl*
 !!! Needs to be implemented !!!
//#UC END# *53CCBDA5026D_4857C9F90189_impl*
end;//TevCommentParaInterfaceFactory.COMQueryTool
{$IfEnd} // Defined(k2ForEditor)

end.
