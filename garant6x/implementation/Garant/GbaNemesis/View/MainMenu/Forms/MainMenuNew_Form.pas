unit MainMenuNew_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/MainMenu/Forms/MainMenuNew_Form.pas"
// Начат: 07.10.2009 18:44
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMFinalForm::Class>> F1 Интерфейсные элементы::MainMenu::View::MainMenu::MainMenu$FP::MainMenuNew
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
  PrimMainMenuNew_Form,
  Common_FormDefinitions_Controls,
  vtPanel
  {$If defined(Nemesis)}
  ,
  nscHideField
  {$IfEnd} //Nemesis
  
  {$If defined(Nemesis)}
  ,
  nscTreeViewHotTruck
  {$IfEnd} //Nemesis
  ,
  PrimLegalMainMenu_Form
  {$If not defined(NoVCL)}
  ,
  ExtCtrls
  {$IfEnd} //not NoVCL
  
  {$If defined(Nemesis)}
  ,
  nscFocusLabel
  {$IfEnd} //Nemesis
  
  {$If not defined(NoImageEn)}
  ,
  imageenview
  {$IfEnd} //not NoImageEn
  
  {$If not defined(NoImageEn)}
  ,
  imageenio
  {$IfEnd} //not NoImageEn
  ,
  PrimMainMenu_Form,
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
  Ten_MainMenuNew = {final form} class(TPrimMainMenuNewForm, MainMenuNewFormDef)
  Entities : TvcmEntities;
  end;//Ten_MainMenuNew

  TMainMenuNewForm = Ten_MainMenuNew;
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
  
  {$If not defined(DesignTimeLibrary)}
  ,
  evStyleTableSpy
  {$IfEnd} //not DesignTimeLibrary
  ,
  afwFacade
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  MainMenuNewKeywordsPack
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}


{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация MainMenuNew
 TtfwClassRef.Register(Ten_MainMenuNew);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings)}
// Регистрация фабрики формы MainMenuNew
 fm_en_MainMenuNew.SetFactory(Ten_MainMenuNew.Make);
{$IfEnd} //not Admin AND not Monitorings

end.