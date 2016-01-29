unit MainWindow_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/MainWindow_Form.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<VCMFinalMainForm::Class>> F1 �������� ��� �����������::F1 Without Usecases::View::PrimNemesis::MainWindow
//
// ������
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
  MainWithReminders_Form,
  MainPrim_Form
  {$If defined(Nemesis)}
  ,
  nscRemindersLine
  {$IfEnd} //Nemesis
  
  {$If defined(Nemesis)}
  ,
  nscReminder
  {$IfEnd} //Nemesis
  
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
  MainOptions_Form,
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
   { MainWindowIDs }
  fm_nsMainWindow : TvcmFormDescriptor = (rFormID : (rName : 'nsMainWindow'; rID : 0); rFactory : nil);
   { ������������� ����� TnsMainWindow }

type
 MainWindowFormDef = interface(IUnknown)
  {* ������������� ����� MainWindow }
   ['{A88F9772-00AF-401E-BACE-E6A02B415485}']
 end;//MainWindowFormDef

 TnsMainWindow = {final form} class(TMainWithRemindersForm, MainWindowFormDef)
  {* ������ }
  Entities : TvcmEntities;
 end;//TnsMainWindow

  TMainWindowForm = TnsMainWindow;
{$IfEnd} //not Admin AND not Monitorings

implementation

{$R *.DFM}

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  nsBaseSearcher,
  L10nInterfaces
  {$If not defined(NoVCM)}
  ,
  nsWindowsList
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  MainWindowKeywordsPack
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}


{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� MainWindow
 TtfwClassRef.Register(TnsMainWindow);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings)}
// ����������� ������� ����� MainWindow
 fm_nsMainWindow.SetFactory(TnsMainWindow.Make);
{$IfEnd} //not Admin AND not Monitorings

end.