unit nscFixedHeightControlCell;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Nemesis"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Nemesis/nscFixedHeightControlCell.pas"
// Начат: 05.10.2009 21:45
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For F1::Nemesis::Grid::TnscFixedHeightControlCell
//
// Ячейка содержащая контрол и высота которой ВСЕГДА равна высоте контрола
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Nemesis\nscDefine.inc}

interface

{$If defined(Nemesis)}
uses
  nscArrangeGridCell
  {$If not defined(NoVCL)}
  ,
  Controls
  {$IfEnd} //not NoVCL
  
  ;
{$IfEnd} //Nemesis

{$If defined(Nemesis)}
type
 TnscFixedHeightControlCell = class(TagControlCell)
  {* Ячейка содержащая контрол и высота которой ВСЕГДА равна высоте контрола }
 public
 // overridden public methods
   constructor Create(aControl: TControl); override;
 end;//TnscFixedHeightControlCell
{$IfEnd} //Nemesis

implementation

{$If defined(Nemesis)}

// start class TnscFixedHeightControlCell

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

{$IfEnd} //Nemesis

end.