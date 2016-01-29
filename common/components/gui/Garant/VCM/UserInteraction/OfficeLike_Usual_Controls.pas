unit OfficeLike_Usual_Controls;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "UserInteraction"
// �����: ����� �.�.
// ������: "w:/common/components/gui/Garant/VCM/UserInteraction/OfficeLike_Usual_Controls.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<VCMControls::Category>> Shared Delphi Operations::OfficeLike::UserInteraction::Usual
//
// "�������" ��������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\common\components\gui\sdoDefine.inc}

interface

{$If not defined(NoVCM)}
uses
  vcmExternalInterfaces {a}
  ;

(* Edit = operations
  {* ������ }
   ['{8C4E8A26-EE53-4DB5-860C-6DD344A4CD3C}']
   operation Delete; has states;
     {* ������� }
      Controlled = state
       { ����� � �������� }
      end;//Controlled
      User = state
       { ������� ������������ }
      end;//User
      MultiUsers = state
       { ������� ���������� ������������� }
      end;//MultiUsers
      Group = state
       { ������� ������ }
      end;//Group
      Contact = state
       { ������� ������������ }
      end;//Contact
   operation Delete; has states;
     {* ������� }
 end;//Edit*)

(* File = operations
  {* ���� }
   ['{573ECB0F-AA41-4D60-8771-E56B0E314D4D}']
   operation Print;
     {* ������ }
   operation PrintDialog;
     {* ������... }
   operation PrintPreview;
     {* ��������������� �������� }
   operation Save;
     {* ��������� }
 end;//File*)

(* Common = operations
  {* ���� }
   ['{7A22D5E9-1A0D-4D6A-9C78-D4DE151D47C6}']
   operation Exit;
 end;//Common*)

(* History = operations
  {* ������� }
   ['{3DD86EB3-4C41-4431-9F5B-B12D18423A9B}']
   operation Back;
     {* ����� }
   operation Forward;
     {* ����� }
 end;//History*)
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
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

// ��������� ��������:
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoVCM)}
var st_user_Edit_Delete_Controlled : TvcmOperationStateIndex = (rID : -1);
  // ������ -> ������� <-> ����� � ��������
{$IfEnd} //not Admin AND not Monitorings AND not NoVCM
{$If defined(Admin) AND not defined(NoVCM)}
var st_user_Edit_Delete_User : TvcmOperationStateIndex = (rID : -1);
  // ������ -> ������� <-> ������� ������������
{$IfEnd} //Admin AND not NoVCM
{$If defined(Admin) AND not defined(NoVCM)}
var st_user_Edit_Delete_MultiUsers : TvcmOperationStateIndex = (rID : -1);
  // ������ -> ������� <-> ������� ���������� �������������
{$IfEnd} //Admin AND not NoVCM
{$If defined(Admin) AND not defined(NoVCM)}
var st_user_Edit_Delete_Group : TvcmOperationStateIndex = (rID : -1);
  // ������ -> ������� <-> ������� ������
{$IfEnd} //Admin AND not NoVCM
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoVCM)}
var st_user_Edit_Delete_Contact : TvcmOperationStateIndex = (rID : -1);
  // ������ -> ������� <-> ������� ������������
{$IfEnd} //not Admin AND not Monitorings AND not NoVCM
{$IfEnd} //not NoVCM

implementation

end.