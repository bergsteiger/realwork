unit l3ControlCanvas;

// ������: "w:\common\components\rtl\Garant\L3\l3ControlCanvas.pas"
// ���������: "SimpleClass"

{$Include l3Define.inc}

interface

uses
 l3IntfUses
 , l3Canvas
 , l3Interfaces
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , l3Units
;

type
 Tl3ControlCanvas = class(Tl3Canvas)
  private
   f_Caret: Il3Caret;
  protected
   procedure Cleanup; override;
    {* ������� ������� ����� �������. }
   function GetCaret: Il3Caret; override;
   procedure Invalidate; override;
  public
   constructor Create(aControl: TControl;
    const aCaret: Il3Caret = nil); reintroduce;
   function DoGetClientRect: Tl3Rect; override;
 end;//Tl3ControlCanvas

implementation

uses
 l3ImplUses
;

constructor Tl3ControlCanvas.Create(aControl: TControl;
 const aCaret: Il3Caret = nil);
//#UC START# *4FAE47E60126_48C68AC60396_var*
//#UC END# *4FAE47E60126_48C68AC60396_var*
begin
//#UC START# *4FAE47E60126_48C68AC60396_impl*
 CreateOwned(aControl);
 f_Caret := aCaret;
//#UC END# *4FAE47E60126_48C68AC60396_impl*
end;//Tl3ControlCanvas.Create

procedure Tl3ControlCanvas.Cleanup;
 {* ������� ������� ����� �������. }
//#UC START# *479731C50290_48C68AC60396_var*
//#UC END# *479731C50290_48C68AC60396_var*
begin
//#UC START# *479731C50290_48C68AC60396_impl*
 f_Caret := nil;
 inherited;
//#UC END# *479731C50290_48C68AC60396_impl*
end;//Tl3ControlCanvas.Cleanup

function Tl3ControlCanvas.GetCaret: Il3Caret;
//#UC START# *47DFB3CE02C5_48C68AC60396_var*
//#UC END# *47DFB3CE02C5_48C68AC60396_var*
begin
//#UC START# *47DFB3CE02C5_48C68AC60396_impl*
 Result := f_Caret;
//#UC END# *47DFB3CE02C5_48C68AC60396_impl*
end;//Tl3ControlCanvas.GetCaret

procedure Tl3ControlCanvas.Invalidate;
//#UC START# *4FAE47320103_48C68AC60396_var*
//#UC END# *4FAE47320103_48C68AC60396_var*
begin
//#UC START# *4FAE47320103_48C68AC60396_impl*
 inherited;
 TControl(Owner).Invalidate;
//#UC END# *4FAE47320103_48C68AC60396_impl*
end;//Tl3ControlCanvas.Invalidate

function Tl3ControlCanvas.DoGetClientRect: Tl3Rect;
//#UC START# *4FAE4C740135_48C68AC60396_var*
var
 R: Tl3SRect;
//#UC END# *4FAE4C740135_48C68AC60396_var*
begin
//#UC START# *4FAE4C740135_48C68AC60396_impl*
 R.R.WR := TControl(Owner).ClientRect;
 Result := DR2LR(R);
//#UC END# *4FAE4C740135_48C68AC60396_impl*
end;//Tl3ControlCanvas.DoGetClientRect

end.
