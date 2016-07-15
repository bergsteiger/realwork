unit Folders_Result_Controls;
 {* ��������� ������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Folders_Result_Controls.pas"
// ���������: "VCMControls"
// ������� ������: "Result" MUID: (4A97FFC40154)

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
 en_Result = 'Result';
 en_capResult = '��������� �������';
 op_Append = 'Append';
 op_capAppend = '��������';
 en_ResultExt = 'ResultExt';
 en_capResultExt = '';
 op_Ok = 'Ok';
 op_capOk = 'OK';
 op_Cancel = 'Cancel';
 op_capCancel = '������';

var opcode_Result_Append: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_ResultExt_Ok: TvcmOPID = (rEnID : -1; rOpID : -1);
var st_user_ResultExt_Ok_None: TvcmOperationStateIndex = (rID : -1);
 {*  -> OK <->  }
var st_user_ResultExt_Ok_NewFolder: TvcmOperationStateIndex = (rID : -1);
 {*  -> OK <->  }
var st_user_ResultExt_Ok_Edit: TvcmOperationStateIndex = (rID : -1);
 {*  -> OK <->  }
var st_user_ResultExt_Ok_Load: TvcmOperationStateIndex = (rID : -1);
 {*  -> OK <-> ��������� }
var st_user_ResultExt_Ok_Select: TvcmOperationStateIndex = (rID : -1);
 {*  -> OK <->  }
var st_user_ResultExt_Ok_FolderSave: TvcmOperationStateIndex = (rID : -1);
 {*  -> OK <-> ��������� }
var opcode_ResultExt_Append: TvcmOPID = (rEnID : -1; rOpID : -1);
var st_user_ResultExt_Append_Bookmark: TvcmOperationStateIndex = (rID : -1);
 {*  -> �������� <->  }
var st_user_ResultExt_Append_List: TvcmOperationStateIndex = (rID : -1);
 {*  -> �������� <->  }
var st_user_ResultExt_Append_Query: TvcmOperationStateIndex = (rID : -1);
 {*  -> �������� <->  }
var opcode_ResultExt_Cancel: TvcmOPID = (rEnID : -1; rOpID : -1);
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
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Result, op_Append, en_capResult, op_capAppend, False, False, opcode_Result_Append)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_ResultExt, op_Ok, en_capResultExt, op_capOk, False, False, opcode_ResultExt_Ok)) do
 begin
  with AddState(TvcmOperationStateForRegister_C('None', st_user_ResultExt_Ok_None))^ do
  begin
   rHint := '����������� �����';
   rEnabled := vcm_osfFalse;
  end;
  with AddState(TvcmOperationStateForRegister_C('NewFolder', st_user_ResultExt_Ok_NewFolder))^ do
  begin
   rHint := '������� �����';
  end;
  with AddState(TvcmOperationStateForRegister_C('Edit', st_user_ResultExt_Ok_Edit))^ do
  begin
   rHint := '��������� ����������������� ���������';
  end;
  with AddState(TvcmOperationStateForRegister_C('Load', st_user_ResultExt_Ok_Load))^ do
  begin
   rCaption := '���������';
   rHint := '��������� ��������� �������';
  end;
  with AddState(TvcmOperationStateForRegister_C('Select', st_user_ResultExt_Ok_Select))^ do
  begin
   rHint := '����������� ����� ��������';
  end;
  with AddState(TvcmOperationStateForRegister_C('FolderSave', st_user_ResultExt_Ok_FolderSave))^ do
  begin
   rCaption := '���������';
   rHint := '��������� ������� � ������� �����';
   rImageIndex := 22;
  end;
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_ResultExt, op_Append, en_capResultExt, op_capAppend, False, False, opcode_ResultExt_Append)) do
 begin
  with AddState(TvcmOperationStateForRegister_C('Bookmark', st_user_ResultExt_Append_Bookmark))^ do
  begin
   rHint := '�������� ����� �������� � ���������� ������������ ����� �������';
  end;
  with AddState(TvcmOperationStateForRegister_C('List', st_user_ResultExt_Append_List))^ do
  begin
   rHint := '�������� ����� ������ � ���������� ������������ ����� �������';
  end;
  with AddState(TvcmOperationStateForRegister_C('Query', st_user_ResultExt_Append_Query))^ do
  begin
   rHint := '�������� ����� ������ � ���������� ������������ ����� �������';
  end;
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_ResultExt, op_Cancel, en_capResultExt, op_capCancel, False, False, opcode_ResultExt_Cancel)) do
 begin
 end;

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
