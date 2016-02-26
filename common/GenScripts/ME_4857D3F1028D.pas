unit evSBSRow_InterfaceFactory;

// Модуль: "w:\common\components\gui\Garant\Everest\evSBSRow_InterfaceFactory.pas"
// Стереотип: "InterfaceFactory"

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

{$If Defined(k2ForEditor)}
uses
 l3IntfUses
 , evTableRow_InterfaceFactory
 , l3Variant
 , l3IID
 , k2ToolPrim
;

type
 TevSBSRowInterfaceFactory = class(TevTableRowInterfaceFactory)
  protected
   function COMQueryTool(aTag: Tl3Tag;
    const aIID: Tl3GUID;
    out theTool;
    const aProcessor: Ik2Processor): Boolean; override;
  public
   function QueryTool(aTag: Tl3Variant;
    const ID: Tl3IID;
    out I: Tk2ToolPrim): Boolean; override;
 end;//TevSBSRowInterfaceFactory
{$IfEnd} // Defined(k2ForEditor)

implementation

{$If Defined(k2ForEditor)}
uses
 l3ImplUses
 , nevGUIInterfaces
 {$If Defined(evUseVisibleCursors)}
 , evSBSRowCursor
 {$IfEnd} // Defined(evUseVisibleCursors)
 {$If Defined(evNeedHotSpot)}
 , evSBSRowHotSpotTester
 {$IfEnd} // Defined(evNeedHotSpot)
;

function TevSBSRowInterfaceFactory.QueryTool(aTag: Tl3Variant;
 const ID: Tl3IID;
 out I: Tk2ToolPrim): Boolean;
//#UC START# *4D63D26D033F_4857D3F1028D_var*
//#UC END# *4D63D26D033F_4857D3F1028D_var*
begin
//#UC START# *4D63D26D033F_4857D3F1028D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4D63D26D033F_4857D3F1028D_impl*
end;//TevSBSRowInterfaceFactory.QueryTool

function TevSBSRowInterfaceFactory.COMQueryTool(aTag: Tl3Tag;
 const aIID: Tl3GUID;
 out theTool;
 const aProcessor: Ik2Processor): Boolean;
//#UC START# *53CCBDA5026D_4857D3F1028D_var*
//#UC END# *53CCBDA5026D_4857D3F1028D_var*
begin
//#UC START# *53CCBDA5026D_4857D3F1028D_impl*
 !!! Needs to be implemented !!!
//#UC END# *53CCBDA5026D_4857D3F1028D_impl*
end;//TevSBSRowInterfaceFactory.COMQueryTool
{$IfEnd} // Defined(k2ForEditor)

end.
