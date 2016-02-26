unit evBlock_InterfaceFactory;
 {* "фабрика интерфейсов" для блока документа (IevDocumentPart). }

// Модуль: "w:\common\components\gui\Garant\Everest\evBlock_InterfaceFactory.pas"
// Стереотип: "InterfaceFactory"

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

{$If Defined(k2ForEditor)}
uses
 l3IntfUses
 , evParaList_InterfaceFactory
 , l3Variant
 , l3IID
 , k2ToolPrim
;

type
 TevBlockInterfaceFactory = class(TevParaListInterfaceFactory)
  {* "фабрика интерфейсов" для блока документа (IevDocumentPart). }
  protected
   function COMQueryTool(aTag: Tl3Tag;
    const aIID: Tl3GUID;
    out theTool;
    const aProcessor: Ik2Processor): Boolean; override;
  public
   function QueryTool(aTag: Tl3Variant;
    const ID: Tl3IID;
    out I: Tk2ToolPrim): Boolean; override;
 end;//TevBlockInterfaceFactory
{$IfEnd} // Defined(k2ForEditor)

implementation

{$If Defined(k2ForEditor)}
uses
 l3ImplUses
 , nevRealTools
 , nevGUIInterfaces
 , nevTools
 , nevBase
 {$If Defined(evUseVisibleCursors)}
 , evDocumentPartCursor
 {$IfEnd} // Defined(evUseVisibleCursors)
 {$If Defined(evNeedPainters)}
 , evDocumentPartPainter
 {$IfEnd} // Defined(evNeedPainters)
 {$If Defined(evNeedHotSpot)}
 , evDocumentPartHotSpotTester
 {$IfEnd} // Defined(evNeedHotSpot)
 {$If Defined(evUseVisibleCursors)}
 , evDocumentPartCursorPair
 {$IfEnd} // Defined(evUseVisibleCursors)
 , nevDocumentPartAnchor
 , nevDocumentPart
;

function TevBlockInterfaceFactory.QueryTool(aTag: Tl3Variant;
 const ID: Tl3IID;
 out I: Tk2ToolPrim): Boolean;
//#UC START# *4D63D26D033F_4857AA550220_var*
//#UC END# *4D63D26D033F_4857AA550220_var*
begin
//#UC START# *4D63D26D033F_4857AA550220_impl*
 !!! Needs to be implemented !!!
//#UC END# *4D63D26D033F_4857AA550220_impl*
end;//TevBlockInterfaceFactory.QueryTool

function TevBlockInterfaceFactory.COMQueryTool(aTag: Tl3Tag;
 const aIID: Tl3GUID;
 out theTool;
 const aProcessor: Ik2Processor): Boolean;
//#UC START# *53CCBDA5026D_4857AA550220_var*
//#UC END# *53CCBDA5026D_4857AA550220_var*
begin
//#UC START# *53CCBDA5026D_4857AA550220_impl*
 !!! Needs to be implemented !!!
//#UC END# *53CCBDA5026D_4857AA550220_impl*
end;//TevBlockInterfaceFactory.COMQueryTool
{$IfEnd} // Defined(k2ForEditor)

end.
