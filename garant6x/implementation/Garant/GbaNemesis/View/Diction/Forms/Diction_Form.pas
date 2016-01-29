unit Diction_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/Diction/Forms/Diction_Form.pas"
// �����: 01.09.2009 13:14
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<VCMFinalForm::Class>> F1 ���������� ��������::Diction::View::Diction::Diction$FP::Diction
//
// �������� �������
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
  Common_FormDefinitions_Controls,
  PrimDictionOptions_Form,
  vtPanel
  {$If defined(Nemesis)}
  ,
  nscContextFilter
  {$IfEnd} //Nemesis
  ,
  nscTreeViewWithAdapterDragDrop,
  Classes {a},
  l3InterfacedComponent {a},
  vcmComponent {a},
  vcmBaseEntities {a},
  vcmEntities {a},
  vcmExternalInterfaces {a},
  vcmInterfaces {a},
  vcmEntityForm {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
  TenDiction = {final form} class(TPrimDictionOptionsForm, DictionFormDef)
   {* �������� ������� }
  Entities : TvcmEntities;
  end;//TenDiction

  TDictionForm = TenDiction;
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
  DictionKeywordsPack
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}


{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Diction
 TtfwClassRef.Register(TenDiction);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings)}
// ����������� ������� ����� Diction
 fm_enDiction.SetFactory(TenDiction.Make);
{$IfEnd} //not Admin AND not Monitorings

end.