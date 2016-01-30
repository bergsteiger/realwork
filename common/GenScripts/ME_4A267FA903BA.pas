unit evHotSpot;

// Модуль: "w:\common\components\gui\Garant\Everest\evHotSpot.pas"
// Стереотип: "SimpleClass"

{$Include evDefine.inc}

interface

{$If Defined(evNeedHotSpot)}
uses
 l3IntfUses
 , k2ProcTagTool
 , nevGUIInterfaces
 , nevTools
 , afwInterfaces
;

type
 TevHotSpot = class(Tk2ProcTagTool)
  protected
   procedure DoHitTest(const aView: InevControlView;
    const aState: TafwCursorState;
    var theInfo: TafwCursorInfo); virtual;
  public
   procedure HitTest(const aView: InevControlView;
    const aState: TafwCursorState;
    var theInfo: TafwCursorInfo);
 end;//TevHotSpot
{$IfEnd} // Defined(evNeedHotSpot)

implementation

{$If Defined(evNeedHotSpot)}
uses
 l3ImplUses
;

procedure TevHotSpot.DoHitTest(const aView: InevControlView;
 const aState: TafwCursorState;
 var theInfo: TafwCursorInfo);
//#UC START# *4A267FC6016B_4A267FA903BA_var*
//#UC END# *4A267FC6016B_4A267FA903BA_var*
begin
//#UC START# *4A267FC6016B_4A267FA903BA_impl*
 // - ничего не делаем
//#UC END# *4A267FC6016B_4A267FA903BA_impl*
end;//TevHotSpot.DoHitTest

procedure TevHotSpot.HitTest(const aView: InevControlView;
 const aState: TafwCursorState;
 var theInfo: TafwCursorInfo);
//#UC START# *48E2622A03C4_4A267FA903BA_var*
//#UC END# *48E2622A03C4_4A267FA903BA_var*
begin
//#UC START# *48E2622A03C4_4A267FA903BA_impl*
 DoHitTest(aView, aState, theInfo);
//#UC END# *48E2622A03C4_4A267FA903BA_impl*
end;//TevHotSpot.HitTest
{$IfEnd} // Defined(evNeedHotSpot)

end.
