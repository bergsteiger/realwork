unit l3TreeConst;

// ������: "w:\common\components\rtl\Garant\L3\l3TreeConst.pas"
// ���������: "UtilityPack"
// ������� ������: "l3TreeConst" MUID: (48F4B5300085)

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

interface

uses
 l3IntfUses
 , l3Interfaces
;

var CF_TreeNode: Tl3ClipboardFormat = 0;
 {* ������ ��� �� ������ ���� � ������ }
var CF_TreeNodes: Tl3ClipboardFormat = 0;
 {* ������ ��� ���������� ����� � ������ }

implementation

uses
 l3ImplUses
 , Windows
 //#UC START# *48F4B5300085impl_uses*
 //#UC END# *48F4B5300085impl_uses*
;

initialization
//#UC START# *48F4B57C010F*
  CF_TreeNode := Windows.RegisterClipboardFormat('Tree Node');
  CF_TreeNodes := Windows.RegisterClipboardFormat('Tree Nodes');
//#UC END# *48F4B57C010F*

end.
