unit Rubricator_Strange_Controls;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/Rubricator_Strange_Controls.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<VCMControls::Category>> F1 �������� ����������::Rubricator::View::Strange
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

(* Rubric = operations
   ['{DA3937F1-62F1-4CB3-8271-F068FC2AD694}']
   query Execute;
 end;//Rubric*)
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
const
 en_Rubric = 'Rubric';
 en_capRubric = '';
 op_Execute = 'Execute';
 op_capExecute = '';
{$IfEnd} //not Admin AND not Monitorings

implementation

end.