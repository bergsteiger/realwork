unit evTableRow_InterfaceFactory;

// Модуль: "w:\common\components\gui\Garant\Everest\evTableRow_InterfaceFactory.pas"
// Стереотип: "InterfaceFactory"
// Элемент модели: "TevTableRow" MUID: (4857D32B011E)
// Имя типа: "TevTableRowInterfaceFactory"

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
 TevTableRowInterfaceFactory = class(TevParaListInterfaceFactory)
  protected
   function COMQueryTool(aTag: Tl3Tag;
    const aIID: Tl3GUID;
    out theTool;
    const aProcessor: Ik2Processor): Boolean; override;
  public
   function QueryTool(aTag: Tl3Variant;
    const ID: Tl3IID;
    out I: Tk2ToolPrim): Boolean; override;
 end;//TevTableRowInterfaceFactory
{$IfEnd} // Defined(k2ForEditor)

implementation

{$If Defined(k2ForEditor)}
uses
 l3ImplUses
 , nevRealTools
 , nevTools
 , nevGUIInterfaces
 , nevBase
 {$If Defined(evNeedPainters)}
 , evTableRowPainter
 {$IfEnd} // Defined(evNeedPainters)
 , nevTableRow
 {$If Defined(evNeedHotSpot)}
 , evTableRowHotSpot
 {$IfEnd} // Defined(evNeedHotSpot)
 {$If Defined(evUseVisibleCursors)}
 , evTableRowCursor
 {$IfEnd} // Defined(evUseVisibleCursors)
 {$If Defined(evUseVisibleCursors)}
 , evTableRowCursorPair
 {$IfEnd} // Defined(evUseVisibleCursors)
 , nevTableRowAnchor
 {$If Defined(evUseVisibleCursors)}
 , nevTableRowBaseLine4Print
 {$IfEnd} // Defined(evUseVisibleCursors)
 {$If Defined(evUseVisibleCursors)}
 , nevTableRowBaseLine4Anchor
 {$IfEnd} // Defined(evUseVisibleCursors)
 , TableRow_Const
;

function TevTableRowInterfaceFactory.QueryTool(aTag: Tl3Variant;
 const ID: Tl3IID;
 out I: Tk2ToolPrim): Boolean;
//#UC START# *4D63D26D033F_4857D32B011E_var*
//#UC END# *4D63D26D033F_4857D32B011E_var*
begin
//#UC START# *4D63D26D033F_4857D32B011E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4D63D26D033F_4857D32B011E_impl*
end;//TevTableRowInterfaceFactory.QueryTool

function TevTableRowInterfaceFactory.COMQueryTool(aTag: Tl3Tag;
 const aIID: Tl3GUID;
 out theTool;
 const aProcessor: Ik2Processor): Boolean;
//#UC START# *53CCBDA5026D_4857D32B011E_var*
//#UC END# *53CCBDA5026D_4857D32B011E_var*
begin
//#UC START# *53CCBDA5026D_4857D32B011E_impl*
 !!! Needs to be implemented !!!
//#UC END# *53CCBDA5026D_4857D32B011E_impl*
end;//TevTableRowInterfaceFactory.COMQueryTool
{$IfEnd} // Defined(k2ForEditor)

end.
