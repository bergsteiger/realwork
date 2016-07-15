unit OfficeLike_Usual_Controls;
 {* "�������" �������� }

// ������: "w:\common\components\gui\Garant\VCM\UserInteraction\OfficeLike_Usual_Controls.pas"
// ���������: "VCMControls"
// ������� ������: "Usual" MUID: (494F898C013E)

{$Include w:\common\components\gui\sdoDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , vcmExternalInterfaces
;

const
 en_Edit = 'Edit';
 en_capEdit = '������';
 op_Delete = 'Delete';
 op_capDelete = '�������';
 en_File = 'File';
 en_capFile = '����';
 op_Print = 'Print';
 op_capPrint = '������';
 op_PrintDialog = 'PrintDialog';
 op_capPrintDialog = '������...';
 op_PrintPreview = 'PrintPreview';
 op_capPrintPreview = '��������������� ��������';
 op_Save = 'Save';
 op_capSave = '���������';
 en_Common = 'Common';
 en_capCommon = '����';
 op_Exit = 'Exit';
 op_capExit = '';
 en_History = 'History';
 en_capHistory = '�������';
 op_Back = 'Back';
 op_capBack = '�����';
 op_Forward = 'Forward';
 op_capForward = '�����';

var opcode_Edit_Delete: TvcmOPID = (rEnID : -1; rOpID : -1);
{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
var st_user_Edit_Delete_Controlled: TvcmOperationStateIndex = (rID : -1);
 {* ������ -> ������� <-> ����� � �������� }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
{$If Defined(Admin)}
var st_user_Edit_Delete_User: TvcmOperationStateIndex = (rID : -1);
 {* ������ -> ������� <-> ������� ������������ }
{$IfEnd} // Defined(Admin)
{$If Defined(Admin)}
var st_user_Edit_Delete_MultiUsers: TvcmOperationStateIndex = (rID : -1);
 {* ������ -> ������� <-> ������� ���������� ������������� }
{$IfEnd} // Defined(Admin)
{$If Defined(Admin)}
var st_user_Edit_Delete_Group: TvcmOperationStateIndex = (rID : -1);
 {* ������ -> ������� <-> ������� ������ }
{$IfEnd} // Defined(Admin)
{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
var st_user_Edit_Delete_Contact: TvcmOperationStateIndex = (rID : -1);
 {* ������ -> ������� <-> ������� ������������ }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
var opcode_File_Print: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_File_PrintDialog: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_File_PrintPreview: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_File_Save: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Common_Exit: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_History_Back: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_History_Forward: TvcmOPID = (rEnID : -1; rOpID : -1);
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
 , vcmOperationsForRegister
 , vcmOperationStatesForRegister
;

initialization
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Edit, op_Delete, en_capEdit, op_capDelete, False, False, opcode_Edit_Delete)) do
 begin
  {$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
  with AddState(TvcmOperationStateForRegister_C('Controlled', st_user_Edit_Delete_Controlled))^ do
  begin
   rCaption := '����� � ��������';
  end;
  {$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
  {$If Defined(Admin)}
  with AddState(TvcmOperationStateForRegister_C('User', st_user_Edit_Delete_User))^ do
  begin
   rCaption := '������� ������������';
   rImageIndex := 149;
  end;
  {$IfEnd} // Defined(Admin)
  {$If Defined(Admin)}
  with AddState(TvcmOperationStateForRegister_C('MultiUsers', st_user_Edit_Delete_MultiUsers))^ do
  begin
   rCaption := '������� ���������� �������������';
   rImageIndex := 149;
  end;
  {$IfEnd} // Defined(Admin)
  {$If Defined(Admin)}
  with AddState(TvcmOperationStateForRegister_C('Group', st_user_Edit_Delete_Group))^ do
  begin
   rCaption := '������� ������';
   rImageIndex := 193;
  end;
  {$IfEnd} // Defined(Admin)
  {$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
  with AddState(TvcmOperationStateForRegister_C('Contact', st_user_Edit_Delete_Contact))^ do
  begin
   rCaption := '������� ������������';
  end;
  {$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Edit, op_Delete, en_capEdit, op_capDelete, False, False, opcode_Edit_Delete)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_File, op_Print, en_capFile, op_capPrint, False, False, opcode_File_Print)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_File, op_PrintDialog, en_capFile, op_capPrintDialog, False, False, opcode_File_PrintDialog)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_File, op_PrintPreview, en_capFile, op_capPrintPreview, False, False, opcode_File_PrintPreview)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_File, op_Save, en_capFile, op_capSave, False, False, opcode_File_Save)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Common, op_Exit, en_capCommon, op_capExit, False, False, opcode_Common_Exit)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_History, op_Back, en_capHistory, op_capBack, False, False, opcode_History_Back)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_History, op_Forward, en_capHistory, op_capForward, False, False, opcode_History_Forward)) do
 begin
 end;

{$IfEnd} // NOT Defined(NoVCM)

end.
