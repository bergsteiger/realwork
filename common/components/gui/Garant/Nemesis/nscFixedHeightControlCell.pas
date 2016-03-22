unit nscFixedHeightControlCell;
 {* Ячейка содержащая контрол и высота которой ВСЕГДА равна высоте контрола }

// Модуль: "w:\common\components\gui\Garant\Nemesis\nscFixedHeightControlCell.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnscFixedHeightControlCell" MUID: (4ACA30C3014C)

{$Include w:\common\components\gui\Garant\Nemesis\nscDefine.inc}

interface

{$If Defined(Nemesis)}
uses
 l3IntfUses
 , nscArrangeGridCell
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
;

type
 TnscFixedHeightControlCell = class(TagControlCell)
  {* Ячейка содержащая контрол и высота которой ВСЕГДА равна высоте контрола }
  public
   constructor Create(aControl: TControl); override;
 end;//TnscFixedHeightControlCell
{$IfEnd} // Defined(Nemesis)

implementation

{$If Defined(Nemesis)}
uses
 l3ImplUses
;

constructor TnscFixedHeightControlCell.Create(aControl: TControl);
//#UC START# *4ACA31830369_4ACA30C3014C_var*
//#UC END# *4ACA31830369_4ACA30C3014C_var*
begin
//#UC START# *4ACA31830369_4ACA30C3014C_impl*
 inherited;
 MinHeight := aControl.Height;
 FullHeight := aControl.Height;
//#UC END# *4ACA31830369_4ACA30C3014C_impl*
end;//TnscFixedHeightControlCell.Create
{$IfEnd} // Defined(Nemesis)

end.
