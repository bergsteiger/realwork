unit vtSpeedButtonForVGScene;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VT"
// Модуль: "w:/common/components/gui/Garant/VT/vtSpeedButtonForVGScene.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<GuiControl::Class>> Shared Delphi::VT::Buttons::TvtSpeedButtonForVGScene
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\VT\vtDefine.inc}

interface

uses
  vtSpeedButton,
  Classes
  {$If not defined(NoVCL)}
  ,
  Controls
  {$IfEnd} //not NoVCL
  
  ;

type
 TvtSpeedButtonForVGScene = class(TvtSpeedButton)
 private
 // private fields
   f_ActivateWindowOnClick : Boolean;
    {* Поле для свойства ActivateWindowOnClick}
 protected
 // overridden protected methods
    {$If not defined(NoVCL)}
   procedure MouseDown(Button: TMouseButton;
     Shift: TShiftState;
     X: Integer;
     Y: Integer); override;
    {$IfEnd} //not NoVCL
 public
 // overridden public methods
   constructor Create(AOwner: TComponent); override;
 public
 // public properties
   property ActivateWindowOnClick: Boolean
     read f_ActivateWindowOnClick
     write f_ActivateWindowOnClick;
 end;//TvtSpeedButtonForVGScene

implementation

uses
  Windows
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  
  ;

// start class TvtSpeedButtonForVGScene

constructor TvtSpeedButtonForVGScene.Create(AOwner: TComponent);
//#UC START# *47D1602000C6_55250990030E_var*
//#UC END# *47D1602000C6_55250990030E_var*
begin
//#UC START# *47D1602000C6_55250990030E_impl*
 inherited;
 f_ActivateWindowOnClick := False;
//#UC END# *47D1602000C6_55250990030E_impl*
end;//TvtSpeedButtonForVGScene.Create

{$If not defined(NoVCL)}
procedure TvtSpeedButtonForVGScene.MouseDown(Button: TMouseButton;
  Shift: TShiftState;
  X: Integer;
  Y: Integer);
//#UC START# *4F88473B03CD_55250990030E_var*
 function lp_TopParentWindow: THandle;
 var
  W: TControl;
 begin
  W := Self;
  while Assigned(W.Parent) do
   W := W.Parent;
  Assert(W is TWinControl);
  Result := TWinControl(W).Handle;
 end;
var
 l_TopWindow: THandle;
//#UC END# *4F88473B03CD_55250990030E_var*
begin
//#UC START# *4F88473B03CD_55250990030E_impl*
 if f_ActivateWindowOnClick then
 begin
  l_TopWindow := lp_TopParentWindow;
  if (GetForegroundWindow <> l_TopWindow) then
   SetForegroundWindow(l_TopWindow);
 end;
 inherited;
//#UC END# *4F88473B03CD_55250990030E_impl*
end;//TvtSpeedButtonForVGScene.MouseDown
{$IfEnd} //not NoVCL

initialization
{$If not defined(NoScripts)}
// Регистрация TvtSpeedButtonForVGScene
 TtfwClassRef.Register(TvtSpeedButtonForVGScene);
{$IfEnd} //not NoScripts

end.