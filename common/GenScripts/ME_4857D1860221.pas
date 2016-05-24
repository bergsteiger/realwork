unit evSBSCell_InterfaceFactory;

// Модуль: "w:\common\components\gui\Garant\Everest\evSBSCell_InterfaceFactory.pas"
// Стереотип: "InterfaceFactory"
// Элемент модели: "TevSBSCell" MUID: (4857D1860221)
// Имя типа: "TevSBSCellInterfaceFactory"

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

{$If Defined(k2ForEditor)}
uses
 l3IntfUses
 , evTableCell_InterfaceFactory
 , l3Variant
 , l3IID
;

type
 TevSBSCellInterfaceFactory = class(TevTableCellInterfaceFactory)
  protected
   function COMQueryTool(aTag: Tl3Tag;
    const aIID: Tl3GUID;
    out theTool;
    const aProcessor: Ik2Processor): Boolean; override;
 end;//TevSBSCellInterfaceFactory
{$IfEnd} // Defined(k2ForEditor)

implementation

{$If Defined(k2ForEditor)}
uses
 l3ImplUses
 , nevRealTools
 {$If Defined(evNeedPainters)}
 , evSBSCellPainter
 {$IfEnd} // Defined(evNeedPainters)
 , SBSCell_Const
;

function TevSBSCellInterfaceFactory.COMQueryTool(aTag: Tl3Tag;
 const aIID: Tl3GUID;
 out theTool;
 const aProcessor: Ik2Processor): Boolean;
//#UC START# *53CCBDA5026D_4857D1860221_var*
//#UC END# *53CCBDA5026D_4857D1860221_var*
begin
//#UC START# *53CCBDA5026D_4857D1860221_impl*
 !!! Needs to be implemented !!!
//#UC END# *53CCBDA5026D_4857D1860221_impl*
end;//TevSBSCellInterfaceFactory.COMQueryTool
{$IfEnd} // Defined(k2ForEditor)

end.
