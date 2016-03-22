unit evSectionBreak_InterfaceFactory;
 {* "фабрика интерфейсов" для разрыва раздела. }

// Модуль: "w:\common\components\gui\Garant\Everest\evSectionBreak_InterfaceFactory.pas"
// Стереотип: "InterfaceFactory"
// Элемент модели: "TevSectionBreak" MUID: (48567BD10027)
// Имя типа: "TevSectionBreakInterfaceFactory"

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

{$If Defined(k2ForEditor)}
uses
 l3IntfUses
 , evPageBreak_InterfaceFactory
 , l3Variant
 , l3IID
;

type
 TevSectionBreakInterfaceFactory = class(TevPageBreakInterfaceFactory)
  {* "фабрика интерфейсов" для разрыва раздела. }
  protected
   function COMQueryTool(aTag: Tl3Tag;
    const aIID: Tl3GUID;
    out theTool;
    const aProcessor: Ik2Processor): Boolean; override;
 end;//TevSectionBreakInterfaceFactory
{$IfEnd} // Defined(k2ForEditor)

implementation

{$If Defined(k2ForEditor)}
uses
 l3ImplUses
 , nevRealTools
 , nevGUIInterfaces
 {$If Defined(evNeedPainters)}
 , evSectionBreakPainter
 {$IfEnd} // Defined(evNeedPainters)
 {$If Defined(evNeedHotSpot)}
 , evSectionBreakHotSpot
 {$IfEnd} // Defined(evNeedHotSpot)
;

function TevSectionBreakInterfaceFactory.COMQueryTool(aTag: Tl3Tag;
 const aIID: Tl3GUID;
 out theTool;
 const aProcessor: Ik2Processor): Boolean;
//#UC START# *53CCBDA5026D_48567BD10027_var*
//#UC END# *53CCBDA5026D_48567BD10027_var*
begin
//#UC START# *53CCBDA5026D_48567BD10027_impl*
 !!! Needs to be implemented !!!
//#UC END# *53CCBDA5026D_48567BD10027_impl*
end;//TevSectionBreakInterfaceFactory.COMQueryTool
{$IfEnd} // Defined(k2ForEditor)

end.
