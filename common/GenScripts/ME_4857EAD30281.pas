unit evReqRow_InterfaceFactory;

// Модуль: "w:\common\components\gui\Garant\Everest\evReqRow_InterfaceFactory.pas"
// Стереотип: "InterfaceFactory"

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

{$If Defined(k2ForEditor)}
uses
 l3IntfUses
 , evTableRow_InterfaceFactory
 , ReqRow_Const
 , l3Variant
 , l3IID
;

type
 TevReqRowInterfaceFactory = class(TevTableRowInterfaceFactory)
  protected
   function COMQueryTool(aTag: Tl3Tag;
    const aIID: Tl3GUID;
    out theTool;
    const aProcessor: Ik2Processor): Boolean; override;
 end;//TevReqRowInterfaceFactory
{$IfEnd} // Defined(k2ForEditor)

implementation

{$If Defined(k2ForEditor)}
uses
 l3ImplUses
 , nevRealTools
 , nevGUIInterfaces
 , evQueryCardInt
 {$If Defined(evNeedPainters)}
 , evReqRowPainter
 {$IfEnd} // Defined(evNeedPainters)
 {$If Defined(evNeedHotSpot) AND NOT Defined(evCanEditControlsAsText)}
 , evReqRowHotSpotTester
 {$IfEnd} // Defined(evNeedHotSpot) AND NOT Defined(evCanEditControlsAsText)
 , evReqRowModelControlMapper
;

function TevReqRowInterfaceFactory.COMQueryTool(aTag: Tl3Tag;
 const aIID: Tl3GUID;
 out theTool;
 const aProcessor: Ik2Processor): Boolean;
//#UC START# *53CCBDA5026D_4857EAD30281_var*
//#UC END# *53CCBDA5026D_4857EAD30281_var*
begin
//#UC START# *53CCBDA5026D_4857EAD30281_impl*
 !!! Needs to be implemented !!!
//#UC END# *53CCBDA5026D_4857EAD30281_impl*
end;//TevReqRowInterfaceFactory.COMQueryTool
{$IfEnd} // Defined(k2ForEditor)

end.
