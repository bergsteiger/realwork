unit WorkWithList_StatusBar_Controls;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/WorkWithList_StatusBar_Controls.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<VCMControls::Category>> F1 ������ � ���������� � ������� ����������::WorkWithList::View::StatusBar
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

(* Selection = operations
  {* ���������� �������� }
   ['{D97C7564-6DFB-41DE-9383-048382A079B4}']
   operation Analize;
     {* ������ ������... }
   operation CopyToNewList;
 end;//Selection*)
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
const
 en_Selection = 'Selection';
 en_capSelection = '���������� ��������';
 op_Analize = 'Analize';
 op_capAnalize = '������ ������...';
 op_CopyToNewList = 'CopyToNewList';
 op_capCopyToNewList = '';
{$IfEnd} //not Admin AND not Monitorings

implementation

end.