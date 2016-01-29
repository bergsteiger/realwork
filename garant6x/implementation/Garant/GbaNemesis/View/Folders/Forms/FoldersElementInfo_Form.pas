unit FoldersElementInfo_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/Folders/Forms/FoldersElementInfo_Form.pas"
// �����: 27.08.2009 20:37
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<VCMFinalForm::Class>> F1 �������� ����������::Folders::View::Folders::PrimFolders$UC::FoldersElementInfo
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
  PrimFoldersElementInfoOptions_Form,
  vtPanel,
  eeMemoWithEditOperations,
  vtLabel
  {$If defined(Nemesis)}
  ,
  nscComboBoxWithReadOnly
  {$IfEnd} //Nemesis
  ,
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
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
  TenFoldersElementInfo = {final form} class(TPrimFoldersElementInfoOptionsForm, FoldersElementInfoFormDef)
  Entities : TvcmEntities;
  end;//TenFoldersElementInfo

  TFoldersElementInfoForm = TenFoldersElementInfo;
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
  FoldersElementInfoKeywordsPack
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}


{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� FoldersElementInfo
 TtfwClassRef.Register(TenFoldersElementInfo);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings)}
// ����������� ������� ����� FoldersElementInfo
 fm_enFoldersElementInfo.SetFactory(TenFoldersElementInfo.Make);
{$IfEnd} //not Admin AND not Monitorings

end.