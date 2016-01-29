unit nscFixedWidthControlCell;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Nemesis"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Nemesis/nscFixedWidthControlCell.pas"
// Начат: 05.10.2009 22:24
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For F1::Nemesis::Grid::TnscFixedWidthControlCell
//
// Ячейка содержащая контрол и ширина которой ВСЕГДА равна ширине контрола
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
 TnscFixedWidthControlCell = class(TagControlCell)
  {* Ячейка содержащая контрол и ширина которой ВСЕГДА равна ширине контрола }
 public
 // overridden public methods
   constructor Create(aControl: TControl); override;
 end;//TnscFixedWidthControlCell
{$IfEnd} //Nemesis

implementation

{$If defined(Nemesis)}

// start class TnscFixedWidthControlCell

constructor TnscFixedWidthControlCell.Create(aControl: TControl);
//#UC START# *4ACA31830369_4ACA39B902E9_var*
//#UC END# *4ACA31830369_4ACA39B902E9_var*
begin
//#UC START# *4ACA31830369_4ACA39B902E9_impl*
 inherited;
 MinWidth := aControl.Width;
 FullWidth := aControl.Width;
//#UC END# *4ACA31830369_4ACA39B902E9_impl*
end;//TnscFixedWidthControlCell.Create

{$IfEnd} //Nemesis

end.