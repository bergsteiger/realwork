unit AdminMain_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/AdminMain_Form.pas"
// �����: 07.09.2009 18:25
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<VCMMainForm::Class>> F1 �������������::Admin$Shell::AdminApp::AdminMain
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If defined(Admin)}
uses
  Classes
  {$If not defined(NoVCM)}
  ,
  vcmInterfaces
  {$IfEnd} //not NoVCM
  ,
  PrimAdminMain_Form,
  MainPrim_Form
  {$If defined(Nemesis)}
  ,
  nscStatusBar
  {$IfEnd} //Nemesis
  ,
  vtPanel,
  vtProportionalPanel,
  vtSizeablePanel
  {$If defined(Nemesis)}
  ,
  nscNavigator
  {$IfEnd} //Nemesis
  ,
  l3InterfacedComponent {a},
  vcmComponent {a},
  vcmBaseEntities {a},
  vcmEntities {a},
  vcmExternalInterfaces {a},
  vcmEntityForm {a}
  ;
{$IfEnd} //Admin

{$If defined(Admin)}
const
   { AdminMainIDs }
  fm_AdminMainForm : TvcmFormDescriptor = (rFormID : (rName : 'AdminMainForm'; rID : 0); rFactory : nil);
   { ������������� ����� TAdminMainForm }

type
 AdminMainFormDef = interface(IUnknown)
  {* ������������� ����� AdminMain }
   ['{26239010-1045-42DC-ABBF-3909601CF2CB}']
 end;//AdminMainFormDef

 TAdminMainForm = {final form} class(TPrimAdminMainForm, AdminMainFormDef)
  Entities : TvcmEntities;
 end;//TAdminMainForm
{$IfEnd} //Admin

implementation

{$R *.DFM}

{$If defined(Admin)}
uses
  SysUtils
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  
  {$If defined(Admin) AND not defined(NoScripts)}
  ,
  AdminMainKeywordsPack
  {$IfEnd} //Admin AND not NoScripts
  
  ;
{$IfEnd} //Admin

{$If defined(Admin)}


{$IfEnd} //Admin

initialization
{$If defined(Admin) AND not defined(NoScripts)}
// ����������� AdminMain
 TtfwClassRef.Register(TAdminMainForm);
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin)}
// ����������� ������� ����� AdminMain
 fm_AdminMainForm.SetFactory(TAdminMainForm.Make);
{$IfEnd} //Admin

end.