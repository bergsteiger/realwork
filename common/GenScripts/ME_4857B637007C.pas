unit evDocument_InterfaceFactory;
 {* "фабрика интерфейсов" для документа. }

// Модуль: "w:\common\components\gui\Garant\Everest\evDocument_InterfaceFactory.pas"
// Стереотип: "InterfaceFactory"
// Элемент модели: "TevDocument" MUID: (4857B637007C)
// Имя типа: "TevDocumentInterfaceFactory"

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
 TevDocumentInterfaceFactory = class(TevParaListInterfaceFactory)
  {* "фабрика интерфейсов" для документа. }
  protected
   function COMQueryTool(aTag: Tl3Tag;
    const aIID: Tl3GUID;
    out theTool;
    const aProcessor: Ik2Processor): Boolean; override;
  public
   function QueryTool(aTag: Tl3Variant;
    const ID: Tl3IID;
    out I: Tk2ToolPrim): Boolean; override;
 end;//TevDocumentInterfaceFactory
{$IfEnd} // Defined(k2ForEditor)

implementation

{$If Defined(k2ForEditor)}
uses
 l3ImplUses
 , nevRealTools
 , nevGUIInterfaces
 , nevTools
 , nevBase
 {$If Defined(evNeedPainters)}
 , evDocumentPainter
 {$IfEnd} // Defined(evNeedPainters)
 {$If Defined(evNeedHotSpot)}
 , evDocumentHotSpotTester
 {$IfEnd} // Defined(evNeedHotSpot)
 {$If Defined(evUseVisibleCursors)}
 , evDocumentCursor
 {$IfEnd} // Defined(evUseVisibleCursors)
 {$If Defined(evUseVisibleCursors)}
 , evDocumentCursorPair
 {$IfEnd} // Defined(evUseVisibleCursors)
 , nevDocument
 , evDocumentAnchorIndex
;

function TevDocumentInterfaceFactory.QueryTool(aTag: Tl3Variant;
 const ID: Tl3IID;
 out I: Tk2ToolPrim): Boolean;
//#UC START# *4D63D26D033F_4857B637007C_var*
//#UC END# *4D63D26D033F_4857B637007C_var*
begin
//#UC START# *4D63D26D033F_4857B637007C_impl*
 !!! Needs to be implemented !!!
//#UC END# *4D63D26D033F_4857B637007C_impl*
end;//TevDocumentInterfaceFactory.QueryTool

function TevDocumentInterfaceFactory.COMQueryTool(aTag: Tl3Tag;
 const aIID: Tl3GUID;
 out theTool;
 const aProcessor: Ik2Processor): Boolean;
//#UC START# *53CCBDA5026D_4857B637007C_var*
//#UC END# *53CCBDA5026D_4857B637007C_var*
begin
//#UC START# *53CCBDA5026D_4857B637007C_impl*
 !!! Needs to be implemented !!!
//#UC END# *53CCBDA5026D_4857B637007C_impl*
end;//TevDocumentInterfaceFactory.COMQueryTool
{$IfEnd} // Defined(k2ForEditor)

end.
