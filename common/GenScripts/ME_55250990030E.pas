unit vtSpeedButtonForVGScene;

// Модуль: "w:\common\components\gui\Garant\VT\vtSpeedButtonForVGScene.pas"
// Стереотип: "GuiControl"

{$Include w:\common\components\gui\Garant\VT\vtDefine.inc}

interface

uses
 l3IntfUses
 , vtSpeedButton
 , Classes
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
;

type
 TvtSpeedButtonForVGScene = class(TvtSpeedButton)
  private
   f_ActivateWindowOnClick: Boolean;
    {* Поле для свойства ActivateWindowOnClick }
  protected
   {$If NOT Defined(NoVCL)}
   procedure MouseDown(Button: TMouseButton;
    Shift: TShiftState;
    X: Integer;
    Y: Integer); override;
   {$IfEnd} // NOT Defined(NoVCL)
  public
   constructor Create(AOwner: TComponent); override;
  public
   property ActivateWindowOnClick: Boolean
    read f_ActivateWindowOnClick
    write f_ActivateWindowOnClick;
 end;//TvtSpeedButtonForVGScene

implementation

uses
 l3ImplUses
 , Windows
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

constructor TvtSpeedButtonForVGScene.Create(AOwner: TComponent);
//#UC START# *47D1602000C6_55250990030E_var*
//#UC END# *47D1602000C6_55250990030E_var*
begin
//#UC START# *47D1602000C6_55250990030E_impl*
 inherited;
 f_ActivateWindowOnClick := False;
//#UC END# *47D1602000C6_55250990030E_impl*
end;//TvtSpeedButtonForVGScene.Create

{$If NOT Defined(NoVCL)}
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
{$IfEnd} // NOT Defined(NoVCL)

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TvtSpeedButtonForVGScene);
 {* Регистрация TvtSpeedButtonForVGScene }
{$IfEnd} // NOT Defined(NoScripts)

end.
