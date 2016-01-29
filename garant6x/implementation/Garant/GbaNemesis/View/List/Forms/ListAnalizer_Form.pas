unit ListAnalizer_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/List/Forms/ListAnalizer_Form.pas"
// �����: 31.08.2009 20:51
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<VCMFinalForm::Class>> F1 ������ � ���������� � ������� ����������::WorkWithList::View::List::List$FP::ListAnalizer
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
  PrimListAnalizer_Form,
  vtPanel,
  eeTreeView,
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
    { ListAnalizerIDs }
   fm_ListAnalizerForm : TvcmFormDescriptor = (rFormID : (rName : 'ListAnalizerForm'; rID : 0); rFactory : nil);
    { ������������� ����� TListAnalizerForm }

type
 ListAnalizerFormDef = interface(IUnknown)
  {* ������������� ����� ListAnalizer }
   ['{534B1ADF-ACC6-4DD9-AF54-C92914E3CBA4}']
 end;//ListAnalizerFormDef

  TListAnalizerForm = {final form} class(TPrimListAnalizerForm, ListAnalizerFormDef)
   {* ������ ������ }
  Entities : TvcmEntities;
  end;//TListAnalizerForm
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
  ListAnalizerKeywordsPack
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}


{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� ListAnalizer
 TtfwClassRef.Register(TListAnalizerForm);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.