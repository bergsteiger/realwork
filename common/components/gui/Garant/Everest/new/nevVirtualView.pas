unit nevVirtualView;
 {* Виртуальная область вывода. }

// Модуль: "w:\common\components\gui\Garant\Everest\new\nevVirtualView.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnevVirtualView" MUID: (4811FD87039D)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , nevBaseDrawView
 , nevBase
;

type
 TnevVirtualView = class(TnevBaseDrawView)
  {* Виртуальная область вывода. }
  protected
   function GetCanvas(const anExtent: TnevPoint): InevCanvas; override;
 end;//TnevVirtualView

implementation

uses
 l3ImplUses
 , l3VirtualCanvas
 //#UC START# *4811FD87039Dimpl_uses*
 //#UC END# *4811FD87039Dimpl_uses*
;

function TnevVirtualView.GetCanvas(const anExtent: TnevPoint): InevCanvas;
//#UC START# *4811F0AC0140_4811FD87039D_var*
//#UC END# *4811F0AC0140_4811FD87039D_var*
begin
//#UC START# *4811F0AC0140_4811FD87039D_impl*
 Result := Tl3VirtualCanvas.Make(anExtent);
//#UC END# *4811F0AC0140_4811FD87039D_impl*
end;//TnevVirtualView.GetCanvas

end.
