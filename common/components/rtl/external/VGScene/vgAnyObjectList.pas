unit vgAnyObjectList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "VGScene"
// �����: ����� �.�.
// ������: "w:/common/components/rtl/external/VGScene/vgAnyObjectList.pas"
// �����: 09.02.2011 21:09
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::VGScene::lulin::TvgAnyObjectList
//
// ������� ���������� �� ������. ������ �� �����������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\VGScene\vg_define.inc}

interface

{$If not defined(NoVGScene)}
uses
  l3ObjectList
  ;
{$IfEnd} //not NoVGScene

{$If not defined(NoVGScene)}
type
 TvgAnyObjectList = class(Tl3ObjectList)
  {* ������� ���������� �� ������. ������ �� ����������� }
 end;//TvgAnyObjectList
{$IfEnd} //not NoVGScene

implementation

end.