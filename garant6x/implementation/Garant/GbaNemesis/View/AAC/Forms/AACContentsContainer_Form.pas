unit AACContentsContainer_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/AAC/Forms/AACContentsContainer_Form.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMFinalContainer::Class>> F1 Пользовательские сервисы::AAC::View::AAC::AACPrim::AACContentsContainer
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
  AACContainerPrim_Form,
  vtProportionalPanel,
  vtPanel,
  vtScrollBar,
  vtSizeablePanel,
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
    { AACContentsContainerIDs }
   fm_AACContentsContainerForm : TvcmFormDescriptor = (rFormID : (rName : 'AACContentsContainerForm'; rID : 0); rFactory : nil);
    { Идентификатор формы TAACContentsContainerForm }

type
 AACContentsContainerFormDef = interface(IUnknown)
  {* Идентификатор формы AACContentsContainer }
   ['{3EBD2AC1-BEED-4678-BF35-5B80CE4A6852}']
 end;//AACContentsContainerFormDef

  TAACContentsContainerForm = {final form} class(TAACContainerPrimForm, AACContentsContainerFormDef)
  Entities : TvcmEntities;
  end;//TAACContentsContainerForm
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
  AACContentsContainerKeywordsPack
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}


{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация AACContentsContainer
 TtfwClassRef.Register(TAACContentsContainerForm);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings)}
// Регистрация фабрики формы AACContentsContainer
 fm_AACContentsContainerForm.SetFactory(TAACContentsContainerForm.Make);
{$IfEnd} //not Admin AND not Monitorings

end.