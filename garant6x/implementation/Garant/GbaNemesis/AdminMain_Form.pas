unit AdminMain_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/AdminMain_Form.pas"
// Начат: 07.09.2009 18:25
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMMainForm::Class>> F1 Администратор::Admin$Shell::AdminApp::AdminMain
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If defined(Admin)}
uses
  Classes
  {$If not defined(NoVCM)}
  ,
  vcmInterfaces
  {$IfEnd} //not NoVCM
  ,
  PrimAdminMain_Form,
  MainPrim_Form
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
  l3InterfacedComponent {a},
  vcmComponent {a},
  vcmBaseEntities {a},
  vcmEntities {a},
  vcmExternalInterfaces {a},
  vcmEntityForm {a}
  ;
{$IfEnd} //Admin

{$If defined(Admin)}
const
   { AdminMainIDs }
  fm_AdminMainForm : TvcmFormDescriptor = (rFormID : (rName : 'AdminMainForm'; rID : 0); rFactory : nil);
   { Идентификатор формы TAdminMainForm }

type
 AdminMainFormDef = interface(IUnknown)
  {* Идентификатор формы AdminMain }
   ['{26239010-1045-42DC-ABBF-3909601CF2CB}']
 end;//AdminMainFormDef

 TAdminMainForm = {final form} class(TPrimAdminMainForm, AdminMainFormDef)
  Entities : TvcmEntities;
 end;//TAdminMainForm
{$IfEnd} //Admin

implementation

{$R *.DFM}

{$If defined(Admin)}
uses
  SysUtils
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  
  {$If defined(Admin) AND not defined(NoScripts)}
  ,
  AdminMainKeywordsPack
  {$IfEnd} //Admin AND not NoScripts
  
  ;
{$IfEnd} //Admin

{$If defined(Admin)}


{$IfEnd} //Admin

initialization
{$If defined(Admin) AND not defined(NoScripts)}
// Регистрация AdminMain
 TtfwClassRef.Register(TAdminMainForm);
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin)}
// Регистрация фабрики формы AdminMain
 fm_AdminMainForm.SetFactory(TAdminMainForm.Make);
{$IfEnd} //Admin

end.