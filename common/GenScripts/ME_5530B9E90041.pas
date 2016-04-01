unit evArchiCollapser;

// Модуль: "w:\common\components\gui\Garant\Everest\evArchiCollapser.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TevArchiCollapser" MUID: (5530B9E90041)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

{$If Defined(evNeedHotSpot)}
uses
 l3IntfUses
 , evSegmentHotSpot
 , afwNavigation
 , nevTools
 , afwInterfaces
;

type
 TevArchiCollapser = class(TevSegmentHotSpot)
  protected
   function TryDoHyperlink(const aView: InevControlView;
    anEffects: TafwJumpToEffects): Boolean; override;
 end;//TevArchiCollapser
{$IfEnd} // Defined(evNeedHotSpot)

implementation

{$If Defined(evNeedHotSpot)}
uses
 l3ImplUses
 {$If Defined(k2ForEditor)}
 , evParaTools
 {$IfEnd} // Defined(k2ForEditor)
;

function TevArchiCollapser.TryDoHyperlink(const aView: InevControlView;
 anEffects: TafwJumpToEffects): Boolean;
var l_MonikerSink: IevMonikerSink;
//#UC START# *4A269489009C_5530B9E90041_var*
//#UC END# *4A269489009C_5530B9E90041_var*
begin
//#UC START# *4A269489009C_5530B9E90041_impl*
 Result := EvExpandOrCollapse(aView, GetDownPointPara);
//#UC END# *4A269489009C_5530B9E90041_impl*
end;//TevArchiCollapser.TryDoHyperlink
{$IfEnd} // Defined(evNeedHotSpot)

end.
