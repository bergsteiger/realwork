unit F1_Without_Usecases_DocumentsCacheOperations_Controls;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/F1_Without_Usecases_DocumentsCacheOperations_Controls.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<VCMControls::Category>> F1 �������� ��� �����������::F1 Without Usecases::View::DocumentsCacheOperations
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

(* DocumentsCache = operations
   ['{EB218A51-86E0-4545-852F-B89B0EEF7952}']
   query Clear;
     {* �������� ��� ���������� }
   operation Disable; has states;
     {* ��������� ��� ���������� }
      Disable = state
      end;//Disable
      Enable = state
      end;//Enable
 end;//DocumentsCache*)
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
const
 en_DocumentsCache = 'DocumentsCache';
 en_capDocumentsCache = '';
 op_Clear = 'Clear';
 op_capClear = '�������� ��� ����������';
 op_Disable = 'Disable';
 op_capDisable = '��������� ��� ����������';

// ��������� ��������:
var st_user_DocumentsCache_Disable_Disable : TvcmOperationStateIndex = (rID : -1);
  // DocumentsCache -> ��������� ��� ���������� <-> Disable
var st_user_DocumentsCache_Disable_Enable : TvcmOperationStateIndex = (rID : -1);
  // DocumentsCache -> ��������� ��� ���������� <-> Enable
{$IfEnd} //not Admin AND not Monitorings

implementation

end.