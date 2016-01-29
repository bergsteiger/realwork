unit GroupProperty_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/Admin/Forms/GroupProperty_Form.pas"
// �����: 07.09.2009 18:00
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<VCMFinalForm::Class>> F1 �������������::Admin::View::Admin::Admin::GroupProperty
//
// �������� ������
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
  PrimGroupPropertyOptions_Form
  {$If defined(Nemesis)}
  ,
  nscComboBox
  {$IfEnd} //Nemesis
  ,
  vtLabel,
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
    { GroupPropertyIDs }
   fm_efGroupProperty : TvcmFormDescriptor = (rFormID : (rName : 'efGroupProperty'; rID : 0); rFactory : nil);
    { ������������� ����� TefGroupProperty }

type
 GroupPropertyFormDef = interface(IUnknown)
  {* ������������� ����� GroupProperty }
   ['{F213AE84-ECF9-427D-8B89-53C6221D1F27}']
 end;//GroupPropertyFormDef

  TefGroupProperty = {final form} class(TPrimGroupPropertyOptionsForm, GroupPropertyFormDef)
   {* �������� ������ }
  Entities : TvcmEntities;
  end;//TefGroupProperty

  TGroupPropertyForm = TefGroupProperty;
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
  GroupPropertyKeywordsPack
  {$IfEnd} //Admin AND not NoScripts
  
  ;
{$IfEnd} //Admin

{$If defined(Admin)}


{$IfEnd} //Admin

initialization
{$If defined(Admin) AND not defined(NoScripts)}
// ����������� GroupProperty
 TtfwClassRef.Register(TefGroupProperty);
{$IfEnd} //Admin AND not NoScripts

end.