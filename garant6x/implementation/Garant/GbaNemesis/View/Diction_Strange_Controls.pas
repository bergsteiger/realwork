unit Diction_Strange_Controls;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/Diction_Strange_Controls.pas"
// �����: 06.09.2010 19:58
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<VCMControls::Category>> F1 ���������� ��������::Diction::View::Strange
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

(* Lang = operations
   ['{347964B6-F4D1-49B1-8887-B1AC2DF105AD}']
   operation Russian;
   operation English;
   operation French;
   operation Deutch;
   operation Italian;
   operation Spanish;
 end;//Lang*)
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
const
 en_Lang = 'Lang';
 en_capLang = '';
 op_Russian = 'Russian';
 op_capRussian = '';
 op_English = 'English';
 op_capEnglish = '';
 op_French = 'French';
 op_capFrench = '';
 op_Deutch = 'Deutch';
 op_capDeutch = '';
 op_Italian = 'Italian';
 op_capItalian = '';
 op_Spanish = 'Spanish';
 op_capSpanish = '';
{$IfEnd} //not Admin AND not Monitorings

implementation

end.