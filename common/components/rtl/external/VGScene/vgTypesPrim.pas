unit vgTypesPrim;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "VGScene"
// �����: ����� �.�.
// ������: "w:/common/components/rtl/external/VGScene/vgTypesPrim.pas"
// �����: 11.02.2011 15:23
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi::VGScene::Core::vgTypesPrim
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
  vgCustomObject
  ;

type
 TvgObjectSortCompare = function (item1: TvgCustomObject;
  item2: TvgCustomObject): integer;
{$IfEnd} //not NoVGScene

implementation

{$If not defined(NoVGScene)}
{$IfEnd} //not NoVGScene
end.