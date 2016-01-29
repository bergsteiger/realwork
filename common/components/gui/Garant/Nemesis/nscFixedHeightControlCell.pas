unit nscFixedHeightControlCell;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Nemesis"
// �����: ����� �.�.
// ������: "w:/common/components/gui/Garant/Nemesis/nscFixedHeightControlCell.pas"
// �����: 05.10.2009 21:45
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For F1::Nemesis::Grid::TnscFixedHeightControlCell
//
// ������ ���������� ������� � ������ ������� ������ ����� ������ ��������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

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
  {* ������ ���������� ������� � ������ ������� ������ ����� ������ �������� }
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