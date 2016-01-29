unit WorkJournal_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/WorkJournal/Forms/WorkJournal_Form.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<VCMFinalForm::Class>> F1 �������� ����������::WorkJournal::View::WorkJournal::BaseWorkJournal::WorkJournal
//
// ������ ������
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
  PrimWorkJournalOptions_Form,
  nscTreeViewWithAdapterDragDrop,
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
    { WorkJournalIDs }
   fm_WorkJournalForm : TvcmFormDescriptor = (rFormID : (rName : 'WorkJournalForm'; rID : 0); rFactory : nil);
    { ������������� ����� TWorkJournalForm }

type
 WorkJournalFormDef = interface(IUnknown)
  {* ������������� ����� WorkJournal }
   ['{D0739331-5959-49D1-A117-74FAFA0E0939}']
 end;//WorkJournalFormDef

  TWorkJournalForm = {final form} class(TPrimWorkJournalOptionsForm, WorkJournalFormDef)
   {* ������ ������ }
  Entities : TvcmEntities;
  end;//TWorkJournalForm
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
  WorkJournalKeywordsPack
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}


{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� WorkJournal
 TtfwClassRef.Register(TWorkJournalForm);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings)}
// ����������� ������� ����� WorkJournal
 fm_WorkJournalForm.SetFactory(TWorkJournalForm.Make);
{$IfEnd} //not Admin AND not Monitorings

end.