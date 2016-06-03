unit Document_F1Lite_Controls;
 {* ��������� "��������" ��� ����� ���� ��� ��������-����� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Document_F1Lite_Controls.pas"
// ���������: "VCMControls"
// ������� ������: "F1Lite" MUID: (49885BF10395)

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
 en_Edit = 'Edit';
 en_capEdit = '������';
 op_ToggleFoundWords = 'ToggleFoundWords';
 op_capToggleFoundWords = '������������ ��������� ��������';
 en_Text = 'Text';
 en_capText = '';
 op_AddToControl = 'AddToControl';
 op_capAddToControl = '��������� �� ��������';
 en_Selection = 'Selection';
 en_capSelection = '';
 op_ShowCorrespondentListToPart = 'ShowCorrespondentListToPart';
 op_capShowCorrespondentListToPart = '';
 op_ShowRespondentListToPart = 'ShowRespondentListToPart';
 op_capShowRespondentListToPart = '';

var st_user_Text_AddToControl_RemoveFromControl: TvcmOperationStateIndex = (rID : -1);
 {*  -> ��������� �� �������� <-> ����� � �������� }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
