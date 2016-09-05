unit l3GraphicControlCanvas;

// Модуль: "w:\common\components\rtl\Garant\L3\l3GraphicControlCanvas.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "Tl3GraphicControlCanvas" MUID: (4F29376B00C7)

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

interface

uses
 l3IntfUses
 , l3ControlCanvas
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
;

type
 Tl3GraphicControlCanvas = class(Tl3ControlCanvas)
  public
   constructor Create(aControl: TGraphicControl); reintroduce;
 end;//Tl3GraphicControlCanvas

implementation

uses
 l3ImplUses
 //#UC START# *4F29376B00C7impl_uses*
 //#UC END# *4F29376B00C7impl_uses*
;

{$If NOT Defined(NoVCL)}
type
 TGraphicControlFriend = {abstract} class(TGraphicControl)
  {* Друг к классу TGraphicControl }
 end;//TGraphicControlFriend
{$IfEnd} // NOT Defined(NoVCL)

{$If NOT Defined(NoVCL)}
{$IfEnd} // NOT Defined(NoVCL)
constructor Tl3GraphicControlCanvas.Create(aControl: TGraphicControl);
//#UC START# *56B9CBE7022E_4F29376B00C7_var*
//#UC END# *56B9CBE7022E_4F29376B00C7_var*
begin
//#UC START# *56B9CBE7022E_4F29376B00C7_impl*
 inherited Create(aControl);
 BackColor := TGraphicControlFriend(aControl).Color;
 Canvas := TGraphicControlFriend(aControl).Canvas;
//#UC END# *56B9CBE7022E_4F29376B00C7_impl*
end;//Tl3GraphicControlCanvas.Create

end.
