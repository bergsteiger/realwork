unit WorkJournal_Strange_Controls;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/WorkJournal_Strange_Controls.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<VCMControls::Category>> F1 �������� ����������::WorkJournal::View::Strange
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

(* Journal = operations
   ['{A9853EC2-9025-4B5F-8F17-E96990FB2AFE}']
   operation Clear;
 end;//Journal*)
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
const
 en_Journal = 'Journal';
 en_capJournal = '';
 op_Clear = 'Clear';
 op_capClear = '';
{$IfEnd} //not Admin AND not Monitorings

implementation

end.