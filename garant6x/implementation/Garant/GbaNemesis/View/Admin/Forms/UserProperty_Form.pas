unit UserProperty_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/Admin/Forms/UserProperty_Form.pas"
// �����: 07.09.2009 18:00
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<VCMFinalForm::Class>> F1 �������������::Admin::View::Admin::Admin::UserProperty
//
// �������� ������������
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
  PrimUserPropertyOptions_Form,
  Admin_FormDefinitions_Controls,
  vtPanel,
  vtLabel
  {$If defined(Nemesis)}
  ,
  nscComboBox
  {$IfEnd} //Nemesis
  ,
  vtComboBoxQS,
  vtCheckBox,
  Classes {a},
  l3InterfacedComponent {a},
  vcmComponent {a},
  vcmBaseEntities {a},
  vcmEntities {a},
  vcmExternalInterfaces {a},
  vcmInterfaces {a},
  vcmEntityForm {a}
  ;
{$IfEnd} //Admin

{$If defined(Admin)}
type
  TefUserProperty = {final form} class(TPrimUserPropertyOptionsForm, UserPropertyFormDef)
   {* �������� ������������ }
  Entities : TvcmEntities;
  end;//TefUserProperty

  TUserPropertyForm = TefUserProperty;
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
  UserPropertyKeywordsPack
  {$IfEnd} //Admin AND not NoScripts
  
  ;
{$IfEnd} //Admin

{$If defined(Admin)}


{$IfEnd} //Admin

initialization
{$If defined(Admin) AND not defined(NoScripts)}
// ����������� UserProperty
 TtfwClassRef.Register(TefUserProperty);
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin)}
// ����������� ������� ����� UserProperty
 fm_efUserProperty.SetFactory(TefUserProperty.Make);
{$IfEnd} //Admin

end.