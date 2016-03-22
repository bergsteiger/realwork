unit evPageBreak_InterfaceFactory;
 {* "фабрика интерфейсов" для разрыва страницы. }

// Модуль: "w:\common\components\gui\Garant\Everest\evPageBreak_InterfaceFactory.pas"
// Стереотип: "InterfaceFactory"
// Элемент модели: "TevPageBreak" MUID: (48567BA50307)
// Имя типа: "TevPageBreakInterfaceFactory"

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
 TevPageBreakInterfaceFactory = class(TevSolidParaInterfaceFactory)
  {* "фабрика интерфейсов" для разрыва страницы. }
  protected
   function COMQueryTool(aTag: Tl3Tag;
    const aIID: Tl3GUID;
    out theTool;
    const aProcessor: Ik2Processor): Boolean; override;
  public
   function QueryTool(aTag: Tl3Variant;
    const ID: Tl3IID;
    out I: Tk2ToolPrim): Boolean; override;
 end;//TevPageBreakInterfaceFactory
{$IfEnd} // Defined(k2ForEditor)

implementation

{$If Defined(k2ForEditor)}
uses
 l3ImplUses
 , nevRealTools
 , nevTools
 {$If Defined(evNeedPainters)}
 , evPageBreakPainter
 {$IfEnd} // Defined(evNeedPainters)
 {$If Defined(evUseVisibleCursors)}
 , evBreakParaCursor
 {$IfEnd} // Defined(evUseVisibleCursors)
 , nevBreakParaAnchor
;

function TevPageBreakInterfaceFactory.QueryTool(aTag: Tl3Variant;
 const ID: Tl3IID;
 out I: Tk2ToolPrim): Boolean;
//#UC START# *4D63D26D033F_48567BA50307_var*
//#UC END# *4D63D26D033F_48567BA50307_var*
begin
//#UC START# *4D63D26D033F_48567BA50307_impl*
 !!! Needs to be implemented !!!
//#UC END# *4D63D26D033F_48567BA50307_impl*
end;//TevPageBreakInterfaceFactory.QueryTool

function TevPageBreakInterfaceFactory.COMQueryTool(aTag: Tl3Tag;
 const aIID: Tl3GUID;
 out theTool;
 const aProcessor: Ik2Processor): Boolean;
//#UC START# *53CCBDA5026D_48567BA50307_var*
//#UC END# *53CCBDA5026D_48567BA50307_var*
begin
//#UC START# *53CCBDA5026D_48567BA50307_impl*
 !!! Needs to be implemented !!!
//#UC END# *53CCBDA5026D_48567BA50307_impl*
end;//TevPageBreakInterfaceFactory.COMQueryTool
{$IfEnd} // Defined(k2ForEditor)

end.
