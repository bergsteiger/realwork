unit MedicFirmList_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/Inpharm/Forms/MedicFirmList_Form.pas"
// �����: 04.09.2009 12:57
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<VCMFinalForm::Class>> F1 ���������� ��������::Inpharm::View::Inpharm::Inpharm::MedicFirmList$Form
//
// ���������������� ����� (������ ������)
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
  PrimMedicFirmListOptions_Form,
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
  Ten_MedicFirmList = {final form} class(TPrimMedicFirmListOptionsForm, MedicFirmListFormDef)
   {* ���������������� ����� (������ ������) }
  Entities : TvcmEntities;
  end;//Ten_MedicFirmList

  TMedicFirmListForm = Ten_MedicFirmList;
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
  MedicFirmListKeywordsPack
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}


{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� MedicFirmList$Form
 TtfwClassRef.Register(Ten_MedicFirmList);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings)}
// ����������� ������� ����� MedicFirmList$Form
 fm_en_MedicFirmList.SetFactory(Ten_MedicFirmList.Make);
{$IfEnd} //not Admin AND not Monitorings

end.