unit l3FormCanvas;

// Модуль: "w:\common\components\rtl\Garant\L3\l3FormCanvas.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "Tl3FormCanvas" MUID: (4F916FD10199)

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

interface

uses
 l3IntfUses
 , l3WinControlCanvas
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
;

type
 Tl3FormCanvas = class(Tl3WinControlCanvas)
  public
   constructor Create(aForm: TForm); reintroduce;
 end;//Tl3FormCanvas

implementation

uses
 l3ImplUses
 //#UC START# *4F916FD10199impl_uses*
 //#UC END# *4F916FD10199impl_uses*
;

constructor Tl3FormCanvas.Create(aForm: TForm);
//#UC START# *4FAE57980326_4F916FD10199_var*
//#UC END# *4FAE57980326_4F916FD10199_var*
begin
//#UC START# *4FAE57980326_4F916FD10199_impl*
 inherited Create(aForm);
 Canvas := aForm.Canvas;
//#UC END# *4FAE57980326_4F916FD10199_impl*
end;//Tl3FormCanvas.Create

end.
