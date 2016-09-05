unit evControlSegmentHotSpot;

// Модуль: "w:\common\components\gui\Garant\Everest\evControlSegmentHotSpot.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TevControlSegmentHotSpot" MUID: (4A27A44403BE)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

{$If Defined(evNeedHotSpot)}
uses
 l3IntfUses
 , evSegmentHotSpot
 , nevTools
 , afwInterfaces
;

type
 TevControlSegmentHotSpot = class(TevSegmentHotSpot)
  protected
   procedure DoHitTest(const aView: InevControlView;
    const aState: TafwCursorState;
    var theInfo: TafwCursorInfo); override;
 end;//TevControlSegmentHotSpot
{$IfEnd} // Defined(evNeedHotSpot)

implementation

{$If Defined(evNeedHotSpot)}
uses
 l3ImplUses
 //#UC START# *4A27A44403BEimpl_uses*
 //#UC END# *4A27A44403BEimpl_uses*
;

procedure TevControlSegmentHotSpot.DoHitTest(const aView: InevControlView;
 const aState: TafwCursorState;
 var theInfo: TafwCursorInfo);
//#UC START# *4A267FC6016B_4A27A44403BE_var*
//#UC END# *4A267FC6016B_4A27A44403BE_var*
begin
//#UC START# *4A267FC6016B_4A27A44403BE_impl*
 inherited;
 theInfo.rHint := nil;
//#UC END# *4A267FC6016B_4A27A44403BE_impl*
end;//TevControlSegmentHotSpot.DoHitTest
{$IfEnd} // Defined(evNeedHotSpot)

end.
