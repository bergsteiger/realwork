unit vgCustomCanvas;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "VGScene"
// �����: ����� �.�.
// ������: "w:/common/components/rtl/external/VGScene/vgCustomCanvas.pas"
// �����: 10.02.2011 21:59
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::VGScene::Core::TvgCustomCanvas
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
  vgPersistent
  ;
{$IfEnd} //not NoVGScene

{$If not defined(NoVGScene)}
type
 TvgCustomCanvas = {abstract} class(TvgPersistent)
 end;//TvgCustomCanvas
{$IfEnd} //not NoVGScene

implementation

end.