unit l3WinControlCanvas;

// Модуль: "w:\common\components\rtl\Garant\L3\l3WinControlCanvas.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "Tl3WinControlCanvas" MUID: (48C68AA40296)

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

interface

uses
 l3IntfUses
 , l3ControlCanvas
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , l3Interfaces
 , Windows
;

type
 Tl3WinControlCanvas = class(Tl3ControlCanvas)
  protected
   function GetAlienDC: hDC; override;
   procedure FreeAlienDC(aDC: hDC); override;
   procedure FireDCSetToNull; override;
  public
   constructor Create(aControl: TWinControl;
    const aCaret: Il3Caret = nil); reintroduce;
 end;//Tl3WinControlCanvas

implementation

uses
 l3ImplUses
 , l3CanvasPrim
 , l3Base
 //#UC START# *48C68AA40296impl_uses*
 //#UC END# *48C68AA40296impl_uses*
;

type
 THackWinControl = class({$If NOT Defined(NoVCL)}
 TWinControl
 {$IfEnd} // NOT Defined(NoVCL)
 )
 end;//THackWinControl

constructor Tl3WinControlCanvas.Create(aControl: TWinControl;
 const aCaret: Il3Caret = nil);
//#UC START# *4FAE537C02FA_48C68AA40296_var*
//#UC END# *4FAE537C02FA_48C68AA40296_var*
begin
//#UC START# *4FAE537C02FA_48C68AA40296_impl*
 inherited Create(aControl, aCaret);
 BackColor := THackWinControl(aControl).Color;
//#UC END# *4FAE537C02FA_48C68AA40296_impl*
end;//Tl3WinControlCanvas.Create

function Tl3WinControlCanvas.GetAlienDC: hDC;
//#UC START# *4FAE533E035C_48C68AA40296_var*
//#UC END# *4FAE533E035C_48C68AA40296_var*
begin
//#UC START# *4FAE533E035C_48C68AA40296_impl*
 Result := l3System.GetDC(TWinControl(Owner).Handle);
//#UC END# *4FAE533E035C_48C68AA40296_impl*
end;//Tl3WinControlCanvas.GetAlienDC

procedure Tl3WinControlCanvas.FreeAlienDC(aDC: hDC);
//#UC START# *56B0B2610026_48C68AA40296_var*
//#UC END# *56B0B2610026_48C68AA40296_var*
begin
//#UC START# *56B0B2610026_48C68AA40296_impl*
 if TWinControl(Owner).HandleAllocated then
  l3System.ReleaseDC(TWinControl(Owner).Handle, aDC);
//#UC END# *56B0B2610026_48C68AA40296_impl*
end;//Tl3WinControlCanvas.FreeAlienDC

procedure Tl3WinControlCanvas.FireDCSetToNull;
//#UC START# *56B0B54F03CC_48C68AA40296_var*
//#UC END# *56B0B54F03CC_48C68AA40296_var*
begin
//#UC START# *56B0B54F03CC_48C68AA40296_impl*
 inherited;
 DCFlag := ev_dcfGot;
//#UC END# *56B0B54F03CC_48C68AA40296_impl*
end;//Tl3WinControlCanvas.FireDCSetToNull

end.
