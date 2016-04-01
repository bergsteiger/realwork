unit evControlParaHotSpotTester;
 {* ѕарень, который определ€ет зону контрола (некий аналог WM_NCHITTEST) }

// ћодуль: "w:\common\components\gui\Garant\Everest\evControlParaHotSpotTester.pas"
// —тереотип: "SimpleClass"
// Ёлемент модели: "TevControlParaHotSpotTester" MUID: (4A27A8C70359)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

{$If Defined(evNeedHotSpot) AND NOT Defined(evCanEditControlsAsText)}
uses
 l3IntfUses
 , evTextParaHotSpotTester
 , nevTools
 , nevGUIInterfaces
;

type
 TevControlParaHotSpotTester = class(TevTextParaHotSpotTester)
  {* ѕарень, который определ€ет зону контрола (некий аналог WM_NCHITTEST) }
  protected
   function GetSegmentClass: RevSegmentClass; override;
   function DoGetAdvancedHotSpot(const aView: InevControlView;
    const aState: TevCursorState;
    const aPt: InevBasePoint;
    const aMap: InevMap;
    out theSpot: IevHotSpot): Boolean; override;
 end;//TevControlParaHotSpotTester
{$IfEnd} // Defined(evNeedHotSpot) AND NOT Defined(evCanEditControlsAsText)

implementation

{$If Defined(evNeedHotSpot) AND NOT Defined(evCanEditControlsAsText)}
uses
 l3ImplUses
 , evControlParaHotSpot
 , evControlSegmentHotSpot
;

function TevControlParaHotSpotTester.GetSegmentClass: RevSegmentClass;
//#UC START# *4A26B035006A_4A27A8C70359_var*
//#UC END# *4A26B035006A_4A27A8C70359_var*
begin
//#UC START# *4A26B035006A_4A27A8C70359_impl*
 Result := TevControlSegmentHotSpot;
//#UC END# *4A26B035006A_4A27A8C70359_impl*
end;//TevControlParaHotSpotTester.GetSegmentClass

function TevControlParaHotSpotTester.DoGetAdvancedHotSpot(const aView: InevControlView;
 const aState: TevCursorState;
 const aPt: InevBasePoint;
 const aMap: InevMap;
 out theSpot: IevHotSpot): Boolean;
//#UC START# *4A26B4EB02EB_4A27A8C70359_var*
//#UC END# *4A26B4EB02EB_4A27A8C70359_var*
begin
//#UC START# *4A26B4EB02EB_4A27A8C70359_impl*
 Result := inherited DoGetAdvancedHotSpot(aView, aState, aPt, aMap, theSpot);
 if not Result then
 begin
  // - ѕредок ничего не вернул, и параграф существует - можно попробовать
  //   вернуть свое виденье данного вопроса.
  Result := true;
  theSpot := TevControlParaHotSpot.Make(aMap, GetRedirect);
 end;//not Result
//#UC END# *4A26B4EB02EB_4A27A8C70359_impl*
end;//TevControlParaHotSpotTester.DoGetAdvancedHotSpot
{$IfEnd} // Defined(evNeedHotSpot) AND NOT Defined(evCanEditControlsAsText)

end.
