unit PostingsList_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/Monitorings/Forms/PostingsList_Form.pas"
// �����: 15.09.2009 18:15
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<VCMFinalForm::Class>> F1 Common For Shell And Monitoring::PostingOrder::View::Monitorings::CommonPost::PostingsList
//
// �����. ��� ��������� �����
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin)}
uses
  PostingOrder_FormDefinitions_Controls,
  PrimPostingsListOptions_Form,
  eeTreeView,
  Classes {a},
  l3InterfacedComponent {a},
  vcmComponent {a},
  vcmBaseEntities {a},
  vcmEntities {a},
  vcmExternalInterfaces {a},
  vcmInterfaces {a},
  vcmEntityForm {a}
  ;
{$IfEnd} //not Admin

{$If not defined(Admin)}
type
  TenPostingsList = {final form} class(TPrimPostingsListOptionsForm, PostingsListFormDef)
   {* �����. ��� ��������� ����� }
  Entities : TvcmEntities;
  end;//TenPostingsList

  TPostingsListForm = TenPostingsList;
{$IfEnd} //not Admin

implementation

{$R *.DFM}

{$If not defined(Admin)}
uses
  SysUtils
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  
  {$If not defined(Admin) AND not defined(NoScripts)}
  ,
  PostingsListKeywordsPack
  {$IfEnd} //not Admin AND not NoScripts
  
  ;
{$IfEnd} //not Admin

{$If not defined(Admin)}


{$IfEnd} //not Admin

initialization
{$If not defined(Admin) AND not defined(NoScripts)}
// ����������� PostingsList
 TtfwClassRef.Register(TenPostingsList);
{$IfEnd} //not Admin AND not NoScripts
{$If not defined(Admin)}
// ����������� ������� ����� PostingsList
 fm_enPostingsList.SetFactory(TenPostingsList.Make);
{$IfEnd} //not Admin

end.