unit Inpharm_Strange_Controls;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/Inpharm_Strange_Controls.pas"
// �����: 30.07.2010 18:46
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<VCMControls::Category>> F1 ���������� ��������::Inpharm::View::Strange
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

(* MedicListSynchroView = operations
  {* ���������� �������� ������ }
   ['{337FF9E1-287B-4F58-B7C5-9E640E11F803}']
   operation OpenDocument; has states;
     {* ����� ��������� }
      Drug = state
       { �������� ��������� }
      end;//Drug
      MedicFirm = state
       { �������� ����� }
      end;//MedicFirm
   operation OpenList; has states;
     {* ������ ���������� }
      Drug = state
       { ���������-�������� }
       { ������ ����������-��������� �� �������������� �������� }
      end;//Drug
      MedicFirm = state
       { ������������ ��������� }
       { ������ ������������ ���������� }
      end;//MedicFirm
   operation OpenDocument; has states;
   operation OpenAttributesForm;
   operation OpenList; has states;
 end;//MedicListSynchroView*)

(* MedicFirmList = operations
   ['{7AA0F678-0660-4DEA-B2B9-204C526629AD}']
   operation CountryFilter;
 end;//MedicFirmList*)
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
const
 en_MedicListSynchroView = 'MedicListSynchroView';
 en_capMedicListSynchroView = '���������� �������� ������';
 op_OpenDocument = 'OpenDocument';
 op_capOpenDocument = '����� ���������';
 op_OpenList = 'OpenList';
 op_capOpenList = '������ ����������';
 op_OpenAttributesForm = 'OpenAttributesForm';
 op_capOpenAttributesForm = '';
 en_MedicFirmList = 'MedicFirmList';
 en_capMedicFirmList = '';
 op_CountryFilter = 'CountryFilter';
 op_capCountryFilter = '';

// ��������� ��������:
var st_user_MedicListSynchroView_OpenDocument_Drug : TvcmOperationStateIndex = (rID : -1);
  // ���������� �������� ������ -> ����� ��������� <-> �������� ���������
var st_user_MedicListSynchroView_OpenDocument_MedicFirm : TvcmOperationStateIndex = (rID : -1);
  // ���������� �������� ������ -> ����� ��������� <-> �������� �����
var st_user_MedicListSynchroView_OpenList_Drug : TvcmOperationStateIndex = (rID : -1);
  // ���������� �������� ������ -> ������ ���������� <-> ���������-��������
var st_user_MedicListSynchroView_OpenList_MedicFirm : TvcmOperationStateIndex = (rID : -1);
  // ���������� �������� ������ -> ������ ���������� <-> ������������ ���������
{$IfEnd} //not Admin AND not Monitorings

implementation

end.