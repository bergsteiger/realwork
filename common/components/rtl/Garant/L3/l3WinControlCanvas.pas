unit l3WinControlCanvas;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "L3"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/L3/l3WinControlCanvas.pas"
// Начат: 26.05.2005 17:40
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi Low Level::L3::l3Canvas::Tl3WinControlCanvas
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\L3\l3Define.inc}

interface

uses
  l3Interfaces
  {$If not defined(NoVCL)}
  ,
  Controls
  {$IfEnd} //not NoVCL
  ,
  l3ControlCanvas,
  Windows
  ;

type
 Tl3WinControlCanvas = class(Tl3ControlCanvas)
 protected
 // overridden protected methods
   function GetAlienDC: hDC; override;
   procedure FreeAlienDC(aDC: hDC); override;
   procedure FireDCSetToNull; override;
     {* Сигнатура метода FireDCSetToNull }
 public
 // public methods
   constructor Create(aControl: TWinControl;
    const aCaret: Il3Caret = nil); reintroduce;
 end;//Tl3WinControlCanvas

implementation

uses
  l3CanvasPrim,
  l3Base
  ;

type
  THackWinControl = class(TWinControl)
  end;//THackWinControl

// start class Tl3WinControlCanvas

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