unit InternetAgent_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/InternetAgent/Forms/InternetAgent_Form.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<VCMFinalForm::Class>> F1 ���������� ��������::InternetAgent::View::InternetAgent::PrimInternetAgent$FP::InternetAgent$F
//
// ������� ������
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
  vcmInterfaces
  {$IfEnd} //not NoVCM
  ,
  PrimInternetAgent_Form,
  l3InterfacedComponent {a},
  vcmComponent {a},
  vcmBaseEntities {a},
  vcmEntities {a},
  vcmExternalInterfaces {a},
  vcmEntityForm {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
const
    { InternetAgent$FIDs }
   fm_InternetAgentForm : TvcmFormDescriptor = (rFormID : (rName : 'InternetAgentForm'; rID : 0); rFactory : nil);
    { ������������� ����� TInternetAgentForm }

type
 InternetAgentFormDef = interface(IUnknown)
  {* ������������� ����� InternetAgent$F }
   ['{4953CF3C-7760-41BE-BBC7-7CA06BAE484D}']
 end;//InternetAgentFormDef

  TInternetAgentForm = {final form} class(TPrimInternetAgentForm, InternetAgentFormDef)
   {* ������� ������ }
  Entities : TvcmEntities;
  end;//TInternetAgentForm
{$IfEnd} //not Admin AND not Monitorings

implementation

{$R *.DFM}

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  SysUtils
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  InternetAgentKeywordsPack
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}


{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� InternetAgent$F
 TtfwClassRef.Register(TInternetAgentForm);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings)}
// ����������� ������� ����� InternetAgent$F
 fm_InternetAgentForm.SetFactory(TInternetAgentForm.Make);
{$IfEnd} //not Admin AND not Monitorings

end.