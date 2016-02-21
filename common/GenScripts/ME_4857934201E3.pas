unit evFormula_InterfaceFactory;

// Модуль: "w:\common\components\gui\Garant\Everest\evFormula_InterfaceFactory.pas"
// Стереотип: "InterfaceFactory"

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

{$If Defined(k2ForEditor)}
uses
 l3IntfUses
 , evTextPara_InterfaceFactory
 , Formula_Const
 , l3Variant
 , l3IID
 , k2ToolPrim
;

type
 TevFormulaInterfaceFactory = class(TevTextParaInterfaceFactory)
  protected
   function COMQueryTool(aTag: Tl3Tag;
    const aIID: Tl3GUID;
    out theTool;
    const aProcessor: Ik2Processor): Boolean; override;
  public
   function QueryTool(aTag: Tl3Variant;
    const ID: Tl3IID;
    out I: Tk2ToolPrim): Boolean; override;
 end;//TevFormulaInterfaceFactory
{$IfEnd} // Defined(k2ForEditor)

implementation

{$If Defined(k2ForEditor)}
uses
 l3ImplUses
 , nevRealTools
 , nevTools
 , nevBase
 {$If Defined(evNeedPainters)}
 , evFormulaPainter
 {$IfEnd} // Defined(evNeedPainters)
 , nevFormulaPara
 {$If Defined(evUseVisibleCursors)}
 , evFormulaCursor
 {$IfEnd} // Defined(evUseVisibleCursors)
;

function TevFormulaInterfaceFactory.QueryTool(aTag: Tl3Variant;
 const ID: Tl3IID;
 out I: Tk2ToolPrim): Boolean;
//#UC START# *4D63D26D033F_4857934201E3_var*
//#UC END# *4D63D26D033F_4857934201E3_var*
begin
//#UC START# *4D63D26D033F_4857934201E3_impl*
 !!! Needs to be implemented !!!
//#UC END# *4D63D26D033F_4857934201E3_impl*
end;//TevFormulaInterfaceFactory.QueryTool

function TevFormulaInterfaceFactory.COMQueryTool(aTag: Tl3Tag;
 const aIID: Tl3GUID;
 out theTool;
 const aProcessor: Ik2Processor): Boolean;
//#UC START# *53CCBDA5026D_4857934201E3_var*
//#UC END# *53CCBDA5026D_4857934201E3_var*
begin
//#UC START# *53CCBDA5026D_4857934201E3_impl*
 !!! Needs to be implemented !!!
//#UC END# *53CCBDA5026D_4857934201E3_impl*
end;//TevFormulaInterfaceFactory.COMQueryTool
{$IfEnd} // Defined(k2ForEditor)

end.
