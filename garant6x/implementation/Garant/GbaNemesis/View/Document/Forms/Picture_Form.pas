unit Picture_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/Document/Forms/Picture_Form.pas"
// �����: 05.02.2009 19:28
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<VCMFinalForm::Class>> F1 ������ � ���������� � ������� ����������::Document::View::Document::Document::Picture
//
// �������
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
  PrimPictureOptions_Form
  {$If not defined(NoImageEn)}
  ,
  imageenio
  {$IfEnd} //not NoImageEn
  
  {$If not defined(NoImageEn)}
  ,
  imageenview
  {$IfEnd} //not NoImageEn
  
  {$If not defined(NoImageEn)}
  ,
  imageenproc
  {$IfEnd} //not NoImageEn
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
    { PictureIDs }
   fm_PictureForm : TvcmFormDescriptor = (rFormID : (rName : 'PictureForm'; rID : 0); rFactory : nil);
    { ������������� ����� TPictureForm }

type
 PictureFormDef = interface(IUnknown)
  {* ������������� ����� Picture }
   ['{9794D84D-10DE-4BC6-A05D-F4C88FBEEBC7}']
 end;//PictureFormDef

//#UC START# *4AAFCF930362ci*
//#UC END# *4AAFCF930362ci*
//#UC START# *4AAFCF930362cit*
//#UC END# *4AAFCF930362cit*
  TPictureForm = {final form} class(TPrimPictureOptionsForm, PictureFormDef)
   {* ������� }
  Entities : TvcmEntities;
//#UC START# *4AAFCF930362publ*
  published
   property Scale;
//#UC END# *4AAFCF930362publ*
  end;//TPictureForm
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
  PictureKeywordsPack
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}


//#UC START# *4AAFCF930362impl*
//#UC END# *4AAFCF930362impl*

{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Picture
 TtfwClassRef.Register(TPictureForm);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings)}
// ����������� ������� ����� Picture
 fm_PictureForm.SetFactory(TPictureForm.Make);
{$IfEnd} //not Admin AND not Monitorings

end.