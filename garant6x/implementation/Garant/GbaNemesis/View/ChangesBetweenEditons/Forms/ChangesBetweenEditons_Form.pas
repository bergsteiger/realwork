unit ChangesBetweenEditons_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/ChangesBetweenEditons/Forms/ChangesBetweenEditons_Form.pas"
// �����: 25.05.2011 14:14
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<VCMFinalForm::Class>> F1 ���������������� �������::ChangesBetweenEditions::View::ChangesBetweenEditons::ChangesBetweenEditions::ChangesBetweenEditons
//
// ��������� � ���������
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
  PrimChangesBetweenEditons_Form
  {$If defined(Nemesis)}
  ,
  nscEditor
  {$IfEnd} //Nemesis
  
  {$If defined(Nemesis)}
  ,
  nscTextSource
  {$IfEnd} //Nemesis
  ,
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
    { ChangesBetweenEditonsIDs }
   fm_ChangesBetweenEditonsForm : TvcmFormDescriptor = (rFormID : (rName : 'ChangesBetweenEditonsForm'; rID : 0); rFactory : nil);
    { ������������� ����� TChangesBetweenEditonsForm }

type
 ChangesBetweenEditonsFormDef = interface(IUnknown)
  {* ������������� ����� ChangesBetweenEditons }
   ['{E8402096-B641-4FAE-B341-69369D1BB399}']
 end;//ChangesBetweenEditonsFormDef

  TChangesBetweenEditonsForm = {final form} class(TPrimChangesBetweenEditonsForm, ChangesBetweenEditonsFormDef)
   {* ��������� � ��������� }
  Entities : TvcmEntities;
  end;//TChangesBetweenEditonsForm
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
  ChangesBetweenEditonsKeywordsPack
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}


{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� ChangesBetweenEditons
 TtfwClassRef.Register(TChangesBetweenEditonsForm);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings)}
// ����������� ������� ����� ChangesBetweenEditons
 fm_ChangesBetweenEditonsForm.SetFactory(TChangesBetweenEditonsForm.Make);
{$IfEnd} //not Admin AND not Monitorings

end.