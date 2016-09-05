unit l3ControlCanvas;

// Модуль: "w:\common\components\rtl\Garant\L3\l3ControlCanvas.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "Tl3ControlCanvas" MUID: (48C68AC60396)

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

interface

uses
 l3IntfUses
 , l3Canvas
 , l3Interfaces
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
;

type
 Tl3ControlCanvas = class(Tl3Canvas)
  private
   f_Caret: Il3Caret;
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure Invalidate; override;
   function GetCaret: Il3Caret; override;
   function DoGetClientRect: Tl3Rect; override;
  public
   constructor Create(aControl: TControl;
    const aCaret: Il3Caret = nil); reintroduce;
 end;//Tl3ControlCanvas

implementation

uses
 l3ImplUses
 , l3Units
 //#UC START# *48C68AC60396impl_uses*
 //#UC END# *48C68AC60396impl_uses*
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
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_48C68AC60396_var*
//#UC END# *479731C50290_48C68AC60396_var*
begin
//#UC START# *479731C50290_48C68AC60396_impl*
 f_Caret := nil;
 inherited;
//#UC END# *479731C50290_48C68AC60396_impl*
end;//Tl3ControlCanvas.Cleanup

procedure Tl3ControlCanvas.Invalidate;
//#UC START# *56B0BB0501B9_48C68AC60396_var*
//#UC END# *56B0BB0501B9_48C68AC60396_var*
begin
//#UC START# *56B0BB0501B9_48C68AC60396_impl*
 inherited;
 TControl(Owner).Invalidate;
//#UC END# *56B0BB0501B9_48C68AC60396_impl*
end;//Tl3ControlCanvas.Invalidate

function Tl3ControlCanvas.GetCaret: Il3Caret;
//#UC START# *56B49F030225_48C68AC60396_var*
//#UC END# *56B49F030225_48C68AC60396_var*
begin
//#UC START# *56B49F030225_48C68AC60396_impl*
 Result := f_Caret;
//#UC END# *56B49F030225_48C68AC60396_impl*
end;//Tl3ControlCanvas.GetCaret

function Tl3ControlCanvas.DoGetClientRect: Tl3Rect;
//#UC START# *56B4D83B00EC_48C68AC60396_var*
var
 R: Tl3SRect;
//#UC END# *56B4D83B00EC_48C68AC60396_var*
begin
//#UC START# *56B4D83B00EC_48C68AC60396_impl*
 R.R.WR := TControl(Owner).ClientRect;
 Result := DR2LR(R);
//#UC END# *56B4D83B00EC_48C68AC60396_impl*
end;//Tl3ControlCanvas.DoGetClientRect

end.
