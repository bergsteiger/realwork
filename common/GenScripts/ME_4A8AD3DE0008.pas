unit OfficeLike_ResultEx_Controls;
 {* ��������� ������� }

// ������: "w:\common\components\gui\Garant\VCM\UserInteraction\OfficeLike_ResultEx_Controls.pas"
// ���������: "VCMControls"
// ������� ������: "ResultEx" MUID: (4A8AD3DE0008)

{$Include w:\common\components\gui\sdoDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , OfficeLike_Result_Controls
 , vcmExternalInterfaces
;

const
 en_Result = OfficeLike_Result_Controls.en_Result;
 en_capResult = OfficeLike_Result_Controls.en_capResult;
 op_OkExt = 'OkExt';
 op_capOkExt = 'OK';

var opcode_Result_OkExt: TvcmOPID = (rEnID : -1; rOpID : -1);
var st_user_Result_OkExt_Search: TvcmOperationStateIndex = (rID : -1);
 {* ��������� ������� -> OK <-> ������ }
var st_user_Result_OkExt_Save: TvcmOperationStateIndex = (rID : -1);
 {* ��������� ������� -> OK <-> ��������� }
var st_user_Result_OkExt_AttributesSelect: TvcmOperationStateIndex = (rID : -1);
 {* ��������� ������� -> OK <->  }
var st_user_Result_OkExt_Consult: TvcmOperationStateIndex = (rID : -1);
 {* ��������� ������� -> OK <-> ��������� ������ }
var st_user_Result_OkExt_Chat: TvcmOperationStateIndex = (rID : -1);
 {* ��������� ������� -> OK <-> ��������� (Ctrl+Enter) }
{$If NOT Defined(Monitorings)}
var st_user_Result_OkExt_SaveAndSend: TvcmOperationStateIndex = (rID : -1);
 {* ��������� ������� -> OK <-> ��������� � ��������� }
{$IfEnd} // NOT Defined(Monitorings)
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
 , vcmOperationsForRegister
 , vcmOperationStatesForRegister
;

initialization
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Result, op_OkExt, en_capResult, op_capOkExt, False, False, opcode_Result_OkExt)) do
 begin
  with AddState(TvcmOperationStateForRegister_C('Search', st_user_Result_OkExt_Search))^ do
  begin
   rCaption := '������';
   rHint := '�������� ����� �� ��������� ����������';
  end;
  with AddState(TvcmOperationStateForRegister_C('Save', st_user_Result_OkExt_Save))^ do
  begin
   rCaption := '���������';
   rHint := '���������';
  end;
  with AddState(TvcmOperationStateForRegister_C('AttributesSelect', st_user_Result_OkExt_AttributesSelect))^ do
  begin
  end;
  with AddState(TvcmOperationStateForRegister_C('Consult', st_user_Result_OkExt_Consult))^ do
  begin
   rCaption := '��������� ������';
   rImageIndex := 154;
  end;
  with AddState(TvcmOperationStateForRegister_C('Chat', st_user_Result_OkExt_Chat))^ do
  begin
   rCaption := '��������� (Ctrl+Enter)';
  end;
  {$If NOT Defined(Monitorings)}
  with AddState(TvcmOperationStateForRegister_C('SaveAndSend', st_user_Result_OkExt_SaveAndSend))^ do
  begin
   rCaption := '��������� � ���������';
   rHint := '��������� � ���������';
  end;
  {$IfEnd} // NOT Defined(Monitorings)
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Result, op_OkExt, en_capResult, op_capOkExt, False, False, opcode_Result_OkExt)) do
 begin
 end;

{$IfEnd} // NOT Defined(NoVCM)

end.
