unit Document_F1Lite_Controls;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/Document_F1Lite_Controls.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<VCMControls::Category>> F1 ������ � ���������� � ������� ����������::Document::View::F1Lite
//
// ��������� "��������" ��� ����� ���� ��� ��������-�����
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  vcmExternalInterfaces {a}
  ;

(* Edit = operations
  {* ������ }
   ['{C0AE3E2E-B0F6-461B-B870-3EF896F8AE35}']
   operation ToggleFoundWords;
     {* ������������ ��������� �������� }
 end;//Edit*)

(* Text = operations
   ['{14C12509-3670-43CD-ACD1-F3EB8F46DC3C}']
   operation AddToControl; has states;
     {* ��������� �� �������� }
      RemoveFromControl = state
       { ����� � �������� }
      end;//RemoveFromControl
   operation AddToControl; has states;
 end;//Text*)

(* Selection = operations
   ['{7F3A0764-8FF9-4EF4-A641-1220243E8F57}']
   operation ShowCorrespondentListToPart;
   operation ShowRespondentListToPart;
 end;//Selection*)
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
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

// ��������� ��������:
var st_user_Text_AddToControl_RemoveFromControl : TvcmOperationStateIndex = (rID : -1);
  // Text$ForDocument -> ��������� �� �������� <-> ����� � ��������
{$IfEnd} //not Admin AND not Monitorings

implementation

end.