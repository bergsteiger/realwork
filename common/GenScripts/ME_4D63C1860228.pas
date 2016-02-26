unit evReqGroup_InterfaceFactory;
 {* Фабрика интерфейсов для группы реквизитов }

// Модуль: "w:\common\components\gui\Garant\Everest\evReqGroup_InterfaceFactory.pas"
// Стереотип: "InterfaceFactory"

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

{$If Defined(k2ForEditor)}
uses
 l3IntfUses
 , evTable_InterfaceFactory
 , l3Variant
 , l3IID
;

type
 TevReqGroupInterfaceFactory = class(TevTableInterfaceFactory)
  {* Фабрика интерфейсов для группы реквизитов }
  protected
   function COMQueryTool(aTag: Tl3Tag;
    const aIID: Tl3GUID;
    out theTool;
    const aProcessor: Ik2Processor): Boolean; override;
 end;//TevReqGroupInterfaceFactory
{$IfEnd} // Defined(k2ForEditor)

implementation

{$If Defined(k2ForEditor)}
uses
 l3ImplUses
 , nevGUIInterfaces
 , nevRealTools
 {$If Defined(evNeedHotSpot) AND Defined(evReqGroupNeedsRadio)}
 , evReqGroupHotSpotTester
 {$IfEnd} // Defined(evNeedHotSpot) AND Defined(evReqGroupNeedsRadio)
 {$If Defined(evNeedPainters) AND Defined(evReqGroupNeedsRadio)}
 , evReqGroupPainter
 {$IfEnd} // Defined(evNeedPainters) AND Defined(evReqGroupNeedsRadio)
;

function TevReqGroupInterfaceFactory.COMQueryTool(aTag: Tl3Tag;
 const aIID: Tl3GUID;
 out theTool;
 const aProcessor: Ik2Processor): Boolean;
//#UC START# *53CCBDA5026D_4D63C1860228_var*
//#UC END# *53CCBDA5026D_4D63C1860228_var*
begin
//#UC START# *53CCBDA5026D_4D63C1860228_impl*
 !!! Needs to be implemented !!!
//#UC END# *53CCBDA5026D_4D63C1860228_impl*
end;//TevReqGroupInterfaceFactory.COMQueryTool
{$IfEnd} // Defined(k2ForEditor)

end.
