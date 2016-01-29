unit StyleEditorNavigator_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/Settings/Forms/StyleEditorNavigator_Form.pas"
// �����: 09.09.2009 16:29
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<VCMFinalForm::Class>> F1 �������� ����������::Settings::View::Settings::Settings::StyleEditorNavigator
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
  PrimStyleEditorNavigator_Form,
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
    { StyleEditorNavigatorIDs }
   fm_StyleEditorNavigatorForm : TvcmFormDescriptor = (rFormID : (rName : 'StyleEditorNavigatorForm'; rID : 0); rFactory : nil);
    { ������������� ����� TStyleEditorNavigatorForm }

type
 StyleEditorNavigatorFormDef = interface(IUnknown)
  {* ������������� ����� StyleEditorNavigator }
   ['{CA4048B0-89BD-4120-9949-4497958117C6}']
 end;//StyleEditorNavigatorFormDef

  TStyleEditorNavigatorForm = {final form} class(TPrimStyleEditorNavigatorForm, StyleEditorNavigatorFormDef)
   {* ������ ������ }
  Entities : TvcmEntities;
  end;//TStyleEditorNavigatorForm
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
  StyleEditorNavigatorKeywordsPack
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}


{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� StyleEditorNavigator
 TtfwClassRef.Register(TStyleEditorNavigatorForm);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings)}
// ����������� ������� ����� StyleEditorNavigator
 fm_StyleEditorNavigatorForm.SetFactory(TStyleEditorNavigatorForm.Make);
{$IfEnd} //not Admin AND not Monitorings

end.