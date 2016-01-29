unit OfficeLike_Result_Controls;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "UserInteraction"
// ������: "w:/common/components/gui/Garant/VCM/UserInteraction/OfficeLike_Result_Controls.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<VCMControls::Category>> Shared Delphi Operations::OfficeLike::UserInteraction::Result
//
// ��������� �������
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

(* Result = operations
  {* ��������� ������� }
   ['{54EBD98C-A36C-4EFB-8242-023AB9626D17}']
   operation Cancel; has states;
     {* ������ }
   operation Cancel;
     {* ������ }
 end;//Result*)

(* Result = operations
  {* ��������� ������� }
   ['{887D93F4-2EBD-4EED-B006-EB9EC85FBD5D}']
   operation Ok; has states;
     {* OK }
      Search = state
       { ������ }
       { �������� ����� �� ��������� ���������� }
      end;//Search
      Print = state
       { ������ }
      end;//Print
      AttributesSelect = state
       { ����������� ����� ��������� }
      end;//AttributesSelect
      ConsultationMark = state
       { ������� }
      end;//ConsultationMark
      Analize = state
       { ��������� }
      end;//Analize
   operation Ok; has states;
     {* OK }
 end;//Result*)

(* Result = operations
  {* ��������� ������� }
   ['{8AEF6AF4-847D-492A-9358-0461CA633384}']
   operation Cancel; has states;
     {* ������ }
      Close = state
       { ������� }
      end;//Close
   operation Cancel; has states;
     {* ������ }
 end;//Result*)
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
const
 en_Result = 'Result';
 en_capResult = '��������� �������';
 op_Cancel = 'Cancel';
 op_capCancel = '������';
 op_Ok = 'Ok';
 op_capOk = 'OK';

// ��������� ��������:
var st_user_Result_Ok_Search : TvcmOperationStateIndex = (rID : -1);
  // ��������� ������� -> OK <-> ������
var st_user_Result_Ok_Print : TvcmOperationStateIndex = (rID : -1);
  // ��������� ������� -> OK <-> ������
var st_user_Result_Ok_AttributesSelect : TvcmOperationStateIndex = (rID : -1);
  // ��������� ������� -> OK <-> ����������� ����� ���������
var st_user_Result_Ok_ConsultationMark : TvcmOperationStateIndex = (rID : -1);
  // ��������� ������� -> OK <-> �������
var st_user_Result_Ok_Analize : TvcmOperationStateIndex = (rID : -1);
  // ��������� ������� -> OK <-> ���������
var st_user_Result_Cancel_Close : TvcmOperationStateIndex = (rID : -1);
  // ��������� ������� -> ������ <-> �������
{$IfEnd} //not NoVCM

implementation

end.