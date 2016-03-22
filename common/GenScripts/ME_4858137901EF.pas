unit evBitmapPara_InterfaceFactory;
 {* "фабрика интерфейсов" для параграфа с картинкой. }

// Модуль: "w:\common\components\gui\Garant\Everest\evBitmapPara_InterfaceFactory.pas"
// Стереотип: "InterfaceFactory"
// Элемент модели: "TevBitmapPara" MUID: (4858137901EF)
// Имя типа: "TevBitmapParaInterfaceFactory"

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

{$If Defined(k2ForEditor)}
uses
 l3IntfUses
 , evSolidPara_InterfaceFactory
 , l3Variant
 , l3IID
 , k2ToolPrim
;

type
 TevBitmapParaInterfaceFactory = class(TevSolidParaInterfaceFactory)
  {* "фабрика интерфейсов" для параграфа с картинкой. }
  protected
   function COMQueryTool(aTag: Tl3Tag;
    const aIID: Tl3GUID;
    out theTool;
    const aProcessor: Ik2Processor): Boolean; override;
  public
   function QueryTool(aTag: Tl3Variant;
    const ID: Tl3IID;
    out I: Tk2ToolPrim): Boolean; override;
 end;//TevBitmapParaInterfaceFactory
{$IfEnd} // Defined(k2ForEditor)

implementation

{$If Defined(k2ForEditor)}
uses
 l3ImplUses
 , nevRealTools
 , nevTools
 {$If Defined(evUseVisibleCursors)}
 , evBitmapParaCursor
 {$IfEnd} // Defined(evUseVisibleCursors)
 {$If Defined(evNeedPainters)}
 , evBitmapParaPainter
 {$IfEnd} // Defined(evNeedPainters)
 , nevBitmapParaAnchor
;

function TevBitmapParaInterfaceFactory.QueryTool(aTag: Tl3Variant;
 const ID: Tl3IID;
 out I: Tk2ToolPrim): Boolean;
//#UC START# *4D63D26D033F_4858137901EF_var*
//#UC END# *4D63D26D033F_4858137901EF_var*
begin
//#UC START# *4D63D26D033F_4858137901EF_impl*
 !!! Needs to be implemented !!!
//#UC END# *4D63D26D033F_4858137901EF_impl*
end;//TevBitmapParaInterfaceFactory.QueryTool

function TevBitmapParaInterfaceFactory.COMQueryTool(aTag: Tl3Tag;
 const aIID: Tl3GUID;
 out theTool;
 const aProcessor: Ik2Processor): Boolean;
//#UC START# *53CCBDA5026D_4858137901EF_var*
//#UC END# *53CCBDA5026D_4858137901EF_var*
begin
//#UC START# *53CCBDA5026D_4858137901EF_impl*
 !!! Needs to be implemented !!!
//#UC END# *53CCBDA5026D_4858137901EF_impl*
end;//TevBitmapParaInterfaceFactory.COMQueryTool
{$IfEnd} // Defined(k2ForEditor)

end.
