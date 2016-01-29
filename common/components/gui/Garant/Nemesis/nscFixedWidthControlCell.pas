unit nscFixedWidthControlCell;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Nemesis"
// �����: ����� �.�.
// ������: "w:/common/components/gui/Garant/Nemesis/nscFixedWidthControlCell.pas"
// �����: 05.10.2009 22:24
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For F1::Nemesis::Grid::TnscFixedWidthControlCell
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
 TnscFixedWidthControlCell = class(TagControlCell)
  {* ������ ���������� ������� � ������ ������� ������ ����� ������ �������� }
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