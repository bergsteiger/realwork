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

var opcode_Tree_ExpandAll: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Tree_CollapseAll: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Tree_Wrap: TvcmOPID = (rEnID : -1; rOpID : -1);
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
 , vcmOperationsForRegister
 , vcmOperationStatesForRegister
;

initialization
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Tree, op_ExpandAll, en_capTree, op_capExpandAll, False, False, opcode_Tree_ExpandAll)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Tree, op_CollapseAll, en_capTree, op_capCollapseAll, False, False, opcode_Tree_CollapseAll)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Tree, op_Wrap, en_capTree, op_capWrap, False, False, opcode_Tree_Wrap)) do
 begin
 end;

{$IfEnd} // NOT Defined(NoVCM)

end.
