unit MainWindow_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/MainWindow_Form.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMFinalMainForm::Class>> F1 Оболочка Без Прецедентов::F1 Without Usecases::View::PrimNemesis::MainWindow
//
// Гарант
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

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
   { Идентификатор формы TnsMainWindow }

type
 MainWindowFormDef = interface(IUnknown)
  {* Идентификатор формы MainWindow }
   ['{A88F9772-00AF-401E-BACE-E6A02B415485}']
 end;//MainWindowFormDef

 TnsMainWindow = {final form} class(TMainWithRemindersForm, MainWindowFormDef)
  {* Гарант }
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
// Регистрация MainWindow
 TtfwClassRef.Register(TnsMainWindow);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings)}
// Регистрация фабрики формы MainWindow
 fm_nsMainWindow.SetFactory(TnsMainWindow.Make);
{$IfEnd} //not Admin AND not Monitorings

end.