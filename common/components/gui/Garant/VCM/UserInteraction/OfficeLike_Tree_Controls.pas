unit OfficeLike_Tree_Controls;
 {* ������������� � ���� ������ }

// ������: "w:\common\components\gui\Garant\VCM\UserInteraction\OfficeLike_Tree_Controls.pas"
// ���������: "VCMControls"
// ������� ������: "Tree" MUID: (4BDAF7510113)

{$Include w:\common\components\gui\sdoDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , vcmExternalInterfaces
;

const
 en_Tree = 'Tree';
 en_capTree = '������';
 op_ExpandAll = 'ExpandAll';
 op_capExpandAll = '���������� ���';
 op_CollapseAll = 'CollapseAll';
 op_capCollapseAll = '�������� ���';
 op_Wrap = 'Wrap';
 op_capWrap = '������� �� ������';
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(NoVCM)

end.
