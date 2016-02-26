unit evLeafPara_InterfaceFactory;

// Модуль: "w:\common\components\gui\Garant\Everest\evLeafPara_InterfaceFactory.pas"
// Стереотип: "InterfaceFactory"

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

{$If Defined(k2ForEditor)}
uses
 l3IntfUses
 , evPara_InterfaceFactory
 , l3Variant
 , l3IID
 , k2ToolPrim
;

type
 TevLeafParaInterfaceFactory = class(TevParaInterfaceFactory)
  protected
   function COMQueryTool(aTag: Tl3Tag;
    const aIID: Tl3GUID;
    out theTool;
    const aProcessor: Ik2Processor): Boolean; override;
  public
   function QueryTool(aTag: Tl3Variant;
    const ID: Tl3IID;
    out I: Tk2ToolPrim): Boolean; override;
 end;//TevLeafParaInterfaceFactory
{$IfEnd} // Defined(k2ForEditor)

implementation

{$If Defined(k2ForEditor)}
uses
 l3ImplUses
 , nevTools
 , nevBase
 , nevLeafPara
 {$If Defined(evUseVisibleCursors)}
 , evLeafParaCursorPair
 {$IfEnd} // Defined(evUseVisibleCursors)
 {$If Defined(evUseVisibleCursors)}
 , evLeafParaCursor
 {$IfEnd} // Defined(evUseVisibleCursors)
 , nevLeafParaAnchor
 , nevLeafParaInevLeafParaMapper
;

function TevLeafParaInterfaceFactory.QueryTool(aTag: Tl3Variant;
 const ID: Tl3IID;
 out I: Tk2ToolPrim): Boolean;
//#UC START# *4D63D26D033F_48567B6E010E_var*
//#UC END# *4D63D26D033F_48567B6E010E_var*
begin
//#UC START# *4D63D26D033F_48567B6E010E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4D63D26D033F_48567B6E010E_impl*
end;//TevLeafParaInterfaceFactory.QueryTool

function TevLeafParaInterfaceFactory.COMQueryTool(aTag: Tl3Tag;
 const aIID: Tl3GUID;
 out theTool;
 const aProcessor: Ik2Processor): Boolean;
//#UC START# *53CCBDA5026D_48567B6E010E_var*
//#UC END# *53CCBDA5026D_48567B6E010E_var*
begin
//#UC START# *53CCBDA5026D_48567B6E010E_impl*
 !!! Needs to be implemented !!!
//#UC END# *53CCBDA5026D_48567B6E010E_impl*
end;//TevLeafParaInterfaceFactory.COMQueryTool
{$IfEnd} // Defined(k2ForEditor)

end.
