unit l3TreeConst;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "L3"
// �����: ����� �.�.
// ������: "w:/common/components/rtl/Garant/L3/l3TreeConst.pas"
// �����: 26.12.2007 16:18
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi Low Level::L3::l3DataObject::l3TreeConst
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\L3\l3Define.inc}

interface

uses
  l3Interfaces
  ;

var CF_TreeNode : Tl3ClipboardFormat = 0;
 {* ������ ��� �� ������ ���� � ������}

var CF_TreeNodes : Tl3ClipboardFormat = 0;
 {* ������ ��� ���������� ����� � ������}

implementation

uses
  Windows
  ;


initialization
//#UC START# *48F4B57C010F*
  CF_TreeNode := Windows.RegisterClipboardFormat('Tree Node');
  CF_TreeNodes := Windows.RegisterClipboardFormat('Tree Nodes');
//#UC END# *48F4B57C010F*

end.