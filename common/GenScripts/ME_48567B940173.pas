unit evSolidPara_InterfaceFactory;

// Модуль: "w:\common\components\gui\Garant\Everest\evSolidPara_InterfaceFactory.pas"
// Стереотип: "InterfaceFactory"
// Элемент модели: "TevSolidPara" MUID: (48567B940173)
// Имя типа: "TevSolidParaInterfaceFactory"

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

{$If Defined(k2ForEditor)}
uses
 l3IntfUses
 , evLeafPara_InterfaceFactory
 , l3Variant
 , l3IID
 , k2ToolPrim
;

type
 TevSolidParaInterfaceFactory = class(TevLeafParaInterfaceFactory)
  protected
   function COMQueryTool(aTag: Tl3Tag;
    const aIID: Tl3GUID;
    out theTool;
    const aProcessor: Ik2Processor): Boolean; override;
  public
   function QueryTool(aTag: Tl3Variant;
    const ID: Tl3IID;
    out I: Tk2ToolPrim): Boolean; override;
 end;//TevSolidParaInterfaceFactory
{$IfEnd} // Defined(k2ForEditor)

implementation

{$If Defined(k2ForEditor)}
uses
 l3ImplUses
 , nevTools
 {$If Defined(evUseVisibleCursors)}
 , evSolidParaCursor
 {$IfEnd} // Defined(evUseVisibleCursors)
 , nevSolidParaAnchor
 {$If Defined(evUseVisibleCursors)}
 , evSolidParaCursorPair
 {$IfEnd} // Defined(evUseVisibleCursors)
;

function TevSolidParaInterfaceFactory.QueryTool(aTag: Tl3Variant;
 const ID: Tl3IID;
 out I: Tk2ToolPrim): Boolean;
//#UC START# *4D63D26D033F_48567B940173_var*
//#UC END# *4D63D26D033F_48567B940173_var*
begin
//#UC START# *4D63D26D033F_48567B940173_impl*
 !!! Needs to be implemented !!!
//#UC END# *4D63D26D033F_48567B940173_impl*
end;//TevSolidParaInterfaceFactory.QueryTool

function TevSolidParaInterfaceFactory.COMQueryTool(aTag: Tl3Tag;
 const aIID: Tl3GUID;
 out theTool;
 const aProcessor: Ik2Processor): Boolean;
//#UC START# *53CCBDA5026D_48567B940173_var*
//#UC END# *53CCBDA5026D_48567B940173_var*
begin
//#UC START# *53CCBDA5026D_48567B940173_impl*
 !!! Needs to be implemented !!!
//#UC END# *53CCBDA5026D_48567B940173_impl*
end;//TevSolidParaInterfaceFactory.COMQueryTool
{$IfEnd} // Defined(k2ForEditor)

end.
