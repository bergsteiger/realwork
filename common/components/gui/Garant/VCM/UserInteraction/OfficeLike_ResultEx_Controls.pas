unit OfficeLike_ResultEx_Controls;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "UserInteraction"
// ������: "w:/common/components/gui/Garant/VCM/UserInteraction/OfficeLike_ResultEx_Controls.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<VCMControls::Category>> Shared Delphi Operations::OfficeLike::UserInteraction::ResultEx
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
  OfficeLike_Result_Controls,
  vcmExternalInterfaces {a}
  ;

(* Result = operations(Result)
  {* ��������� ������� }
   ['{A38EF0B5-FAEA-45DB-8B71-2442C825A429}']
   operation OkExt; has states;
     {* OK }
      Search = state
       { ������ }
       { �������� ����� �� ��������� ���������� }
      end;//Search
      Save = state
       { ��������� }
       { ��������� }
      end;//Save
      AttributesSelect = state
      end;//AttributesSelect
      Consult = state
       { ��������� ������ }
      end;//Consult
      Chat = state
       { ��������� (Ctrl+Enter) }
      end;//Chat
      SaveAndSend = state
       { ��������� � ��������� }
       { ��������� � ��������� }
      end;//SaveAndSend
   operation OkExt; has states;
     {* OK }
 end;//Result*)
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
const
 en_Result = OfficeLike_Result_Controls.en_Result;
 en_capResult = OfficeLike_Result_Controls.en_capResult;
 op_OkExt = 'OkExt';
 op_capOkExt = 'OK';

// ��������� ��������:
var st_user_Result_OkExt_Search : TvcmOperationStateIndex = (rID : -1);
  // ��������� ������� -> OK <-> ������
var st_user_Result_OkExt_Save : TvcmOperationStateIndex = (rID : -1);
  // ��������� ������� -> OK <-> ���������
var st_user_Result_OkExt_AttributesSelect : TvcmOperationStateIndex = (rID : -1);
  // ��������� ������� -> OK <-> AttributesSelect
var st_user_Result_OkExt_Consult : TvcmOperationStateIndex = (rID : -1);
  // ��������� ������� -> OK <-> ��������� ������
var st_user_Result_OkExt_Chat : TvcmOperationStateIndex = (rID : -1);
  // ��������� ������� -> OK <-> ��������� (Ctrl+Enter)
{$If not defined(Monitorings) AND not defined(NoVCM)}
var st_user_Result_OkExt_SaveAndSend : TvcmOperationStateIndex = (rID : -1);
  // ��������� ������� -> OK <-> ��������� � ���������
{$IfEnd} //not Monitorings AND not NoVCM
{$IfEnd} //not NoVCM

implementation

end.