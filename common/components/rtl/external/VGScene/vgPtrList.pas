unit vgPtrList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "VGScene"
// �����: ����� �.�.
// ������: "w:/common/components/rtl/external/VGScene/vgPtrList.pas"
// �����: 09.02.2011 21:10
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::VGScene::lulin::TvgPtrList
//
// ������ ���������� �� ����� ������. ������ �� �����������
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
  l3DataPtrList
  ;
{$IfEnd} //not NoVGScene

{$If not defined(NoVGScene)}
type
 TvgPtrList = class(Tl3DataPtrList)
  {* ������ ���������� �� ����� ������. ������ �� ����������� }
 end;//TvgPtrList
{$IfEnd} //not NoVGScene

implementation

end.