unit Base_Operations_View_Controls;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/Base_Operations_View_Controls.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<VCMControls::Category>> F1 Core::Base Operations::View::View
//
// �������� �������� �� ��������� ������������� �������� �������
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

(* Document = operations
  {* �������� }
   ['{2A657798-A7B2-4ED4-8520-D5E05BBADA44}']
   operation ShowJurorComments; has states;
     {* ��������/������ ����������� ������� }
      Hide = state
       { ������ ����������� ������� }
      end;//Hide
      Show = state
       { �������� ����������� ������� }
      end;//Show
   operation ShowUserComments; has states;
     {* ��������/������ ��� ����������� }
      Hide = state
       { ������ ��� ����������� }
      end;//Hide
      Show = state
       { �������� ��� ����������� }
      end;//Show
   operation ShowTechComments; has states;
     {* ���������� ����������� ����������� }
      Hide = state
      end;//Hide
      Show = state
      end;//Show
   operation ShowVersionComments; has states;
     {* ��������/��������� ���������� �� ���������� ��������� }
      Hide = state
       { ��������� ���������� �� ���������� ��������� }
      end;//Hide
      Show = state
       { �������� ���������� �� ���������� ��������� }
      end;//Show
   operation ShowJurorComments; has states;
     {* �������� ����������� ����������� }
   operation ShowUserComments; has states;
     {* �������� ����������� ������������ }
   operation ShowVersionComments; has states;
     {* �������� ���������� � ������ }
   operation ShowCommentsGroup;
     {* ����������� }
   operation ShowTechComments; has states;
     {* �������� ����������� ����������� }
 end;//Document*)
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
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

// ��������� ��������:
var st_user_Document_ShowJurorComments_Hide : TvcmOperationStateIndex = (rID : -1);
  // �������� -> ��������/������ ����������� ������� <-> ������ ����������� �������
var st_user_Document_ShowJurorComments_Show : TvcmOperationStateIndex = (rID : -1);
  // �������� -> ��������/������ ����������� ������� <-> �������� ����������� �������
var st_user_Document_ShowUserComments_Hide : TvcmOperationStateIndex = (rID : -1);
  // �������� -> ��������/������ ��� ����������� <-> ������ ��� �����������
var st_user_Document_ShowUserComments_Show : TvcmOperationStateIndex = (rID : -1);
  // �������� -> ��������/������ ��� ����������� <-> �������� ��� �����������
var st_user_Document_ShowTechComments_Hide : TvcmOperationStateIndex = (rID : -1);
  // �������� -> ���������� ����������� ����������� <-> Hide
var st_user_Document_ShowTechComments_Show : TvcmOperationStateIndex = (rID : -1);
  // �������� -> ���������� ����������� ����������� <-> Show
var st_user_Document_ShowVersionComments_Hide : TvcmOperationStateIndex = (rID : -1);
  // �������� -> ��������/��������� ���������� �� ���������� ��������� <-> ��������� ���������� �� ���������� ���������
var st_user_Document_ShowVersionComments_Show : TvcmOperationStateIndex = (rID : -1);
  // �������� -> ��������/��������� ���������� �� ���������� ��������� <-> �������� ���������� �� ���������� ���������
{$IfEnd} //not Admin AND not Monitorings

implementation

end.