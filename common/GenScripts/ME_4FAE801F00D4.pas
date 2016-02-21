unit l3CustomControlCanvas;

// Модуль: "w:\common\components\rtl\Garant\L3\l3CustomControlCanvas.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

interface

uses
 l3IntfUses
 , l3WinControlCanvas
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , l3Interfaces
;

type
 Tl3CustomControlCanvas = class(Tl3WinControlCanvas)
  public
   constructor Create(aControl: TCustomControl;
    const aCaret: Il3Caret = nil); reintroduce;
 end;//Tl3CustomControlCanvas

implementation

uses
 l3ImplUses
;

type
 THackControl = class(TCustomControl)
 end;//THackControl

constructor Tl3CustomControlCanvas.Create(aControl: TCustomControl;
 const aCaret: Il3Caret = nil);
//#UC START# *4FAE803503C7_4FAE801F00D4_var*
//#UC END# *4FAE803503C7_4FAE801F00D4_var*
begin
//#UC START# *4FAE803503C7_4FAE801F00D4_impl*
 inherited Create(aControl, aCaret);
 Canvas := THackControl(aControl).Canvas;
//#UC END# *4FAE803503C7_4FAE801F00D4_impl*
end;//Tl3CustomControlCanvas.Create

end.
