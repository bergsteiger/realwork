unit Base_Operations_F1Specific_Controls;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/Base_Operations_F1Specific_Controls.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<VCMControls::Category>> F1 Core::Base Operations::View::F1Specific
//
// ��������, ����������� ��� F1
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
  Classes
  {$If not defined(NoVCM)}
  ,
  OfficeLike_Usual_Controls
  {$IfEnd} //not NoVCM
  ,
  vcmExternalInterfaces {a}
  ;

(* File = operations(File)
  {* ���� }
   ['{3041ED2E-9529-4DC4-A83B-0367A48DC97B}']
   operation ToMSWord;
     {* ������� � Word }
   operation SendMailAsAttachment;
     {* ������� �� e-mail }
 end;//File*)
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
const
 en_File = OfficeLike_Usual_Controls.en_File;
 en_capFile = OfficeLike_Usual_Controls.en_capFile;
 op_ToMSWord = 'ToMSWord';
 op_capToMSWord = '������� � Word';
 op_SendMailAsAttachment = 'SendMailAsAttachment';
 op_capSendMailAsAttachment = '������� �� e-mail';
{$IfEnd} //not Admin AND not Monitorings

implementation

end.