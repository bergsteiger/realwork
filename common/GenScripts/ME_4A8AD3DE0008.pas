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
;
{$IfEnd} // NOT Defined(NoVCM)

end.
