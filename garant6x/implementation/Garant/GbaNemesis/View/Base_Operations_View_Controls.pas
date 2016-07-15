unit Base_Operations_View_Controls;
 {* �������� �������� �� ��������� ������������� �������� ������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Base_Operations_View_Controls.pas"
// ���������: "VCMControls"
// ������� ������: "View" MUID: (4A7C0A8202A9)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 en_Document = 'Document';
 en_capDocument = '��������';
 op_ShowJurorComments = 'ShowJurorComments';
 op_capShowJurorComments = '��������/������ ����������� �������';
 op_ShowUserComments = 'ShowUserComments';
 op_capShowUserComments = '��������/������ ��� �����������';
 op_ShowTechComments = 'ShowTechComments';
 op_capShowTechComments = '���������� ����������� �����������';
 op_ShowVersionComments = 'ShowVersionComments';
 op_capShowVersionComments = '��������/��������� ���������� �� ���������� ���������';
 op_ShowCommentsGroup = 'ShowCommentsGroup';
 op_capShowCommentsGroup = '�����������';

var opcode_Document_ShowJurorComments: TvcmOPID = (rEnID : -1; rOpID : -1);
var st_user_Document_ShowJurorComments_Hide: TvcmOperationStateIndex = (rID : -1);
 {* �������� -> ��������/������ ����������� ������� <-> ������ ����������� ������� }
var st_user_Document_ShowJurorComments_Show: TvcmOperationStateIndex = (rID : -1);
 {* �������� -> ��������/������ ����������� ������� <-> �������� ����������� ������� }
var opcode_Document_ShowUserComments: TvcmOPID = (rEnID : -1; rOpID : -1);
var st_user_Document_ShowUserComments_Hide: TvcmOperationStateIndex = (rID : -1);
 {* �������� -> ��������/������ ��� ����������� <-> ������ ��� ����������� }
var st_user_Document_ShowUserComments_Show: TvcmOperationStateIndex = (rID : -1);
 {* �������� -> ��������/������ ��� ����������� <-> �������� ��� ����������� }
var opcode_Document_ShowTechComments: TvcmOPID = (rEnID : -1; rOpID : -1);
var st_user_Document_ShowTechComments_Hide: TvcmOperationStateIndex = (rID : -1);
 {* �������� -> ���������� ����������� ����������� <->  }
var st_user_Document_ShowTechComments_Show: TvcmOperationStateIndex = (rID : -1);
 {* �������� -> ���������� ����������� ����������� <->  }
var opcode_Document_ShowVersionComments: TvcmOPID = (rEnID : -1; rOpID : -1);
var st_user_Document_ShowVersionComments_Hide: TvcmOperationStateIndex = (rID : -1);
 {* �������� -> ��������/��������� ���������� �� ���������� ��������� <-> ��������� ���������� �� ���������� ��������� }
var st_user_Document_ShowVersionComments_Show: TvcmOperationStateIndex = (rID : -1);
 {* �������� -> ��������/��������� ���������� �� ���������� ��������� <-> �������� ���������� �� ���������� ��������� }
var opcode_Document_ShowCommentsGroup: TvcmOPID = (rEnID : -1; rOpID : -1);
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoVCM)}
 , vcmOperationsForRegister
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmOperationStatesForRegister
 {$IfEnd} // NOT Defined(NoVCM)
;

initialization
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Document, op_ShowJurorComments, en_capDocument, op_capShowJurorComments, False, False, opcode_Document_ShowJurorComments)) do
 begin
  with AddState(TvcmOperationStateForRegister_C('Hide', st_user_Document_ShowJurorComments_Hide))^ do
  begin
   rCaption := '������ ����������� �������';
   rChecked := vcm_osfTrue;
  end;
  with AddState(TvcmOperationStateForRegister_C('Show', st_user_Document_ShowJurorComments_Show))^ do
  begin
   rCaption := '�������� ����������� �������';
  end;
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Document, op_ShowUserComments, en_capDocument, op_capShowUserComments, False, False, opcode_Document_ShowUserComments)) do
 begin
  with AddState(TvcmOperationStateForRegister_C('Hide', st_user_Document_ShowUserComments_Hide))^ do
  begin
   rCaption := '������ ��� �����������';
   rChecked := vcm_osfTrue;
  end;
  with AddState(TvcmOperationStateForRegister_C('Show', st_user_Document_ShowUserComments_Show))^ do
  begin
   rCaption := '�������� ��� �����������';
  end;
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Document, op_ShowTechComments, en_capDocument, op_capShowTechComments, False, False, opcode_Document_ShowTechComments)) do
 begin
  with AddState(TvcmOperationStateForRegister_C('Hide', st_user_Document_ShowTechComments_Hide))^ do
  begin
   rChecked := vcm_osfTrue;
  end;
  with AddState(TvcmOperationStateForRegister_C('Show', st_user_Document_ShowTechComments_Show))^ do
  begin
  end;
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Document, op_ShowVersionComments, en_capDocument, op_capShowVersionComments, False, False, opcode_Document_ShowVersionComments)) do
 begin
  with AddState(TvcmOperationStateForRegister_C('Hide', st_user_Document_ShowVersionComments_Hide))^ do
  begin
   rCaption := '��������� ���������� �� ���������� ���������';
   rChecked := vcm_osfTrue;
  end;
  with AddState(TvcmOperationStateForRegister_C('Show', st_user_Document_ShowVersionComments_Show))^ do
  begin
   rCaption := '�������� ���������� �� ���������� ���������';
  end;
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Document, op_ShowJurorComments, en_capDocument, op_capShowJurorComments, False, False, opcode_Document_ShowJurorComments)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Document, op_ShowUserComments, en_capDocument, op_capShowUserComments, False, False, opcode_Document_ShowUserComments)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Document, op_ShowVersionComments, en_capDocument, op_capShowVersionComments, False, False, opcode_Document_ShowVersionComments)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Document, op_ShowCommentsGroup, en_capDocument, op_capShowCommentsGroup, False, False, opcode_Document_ShowCommentsGroup)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Document, op_ShowTechComments, en_capDocument, op_capShowTechComments, False, False, opcode_Document_ShowTechComments)) do
 begin
 end;

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
