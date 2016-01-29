unit AACContainer_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/AAC/Forms/AACContainer_Form.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMFinalContainer::Class>> F1 Пользовательские сервисы::AAC::View::AAC::AACPrim::AACContainer
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
  AACTextContainerPrim_Form,
  vtProportionalPanel,
  vtPanel,
  vtScrollBar,
  vtSizeablePanel,
  AACContainerPrim_Form,
  nscSimpleEditorForDialogs,
  vtLabel
  {$If not defined(NoVCL)}
  ,
  ExtCtrls
  {$IfEnd} //not NoVCL
  ,
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
    { AACContainerIDs }
   fm_AACContainerForm : TvcmFormDescriptor = (rFormID : (rName : 'AACContainerForm'; rID : 0); rFactory : nil);
    { Идентификатор формы TAACContainerForm }

type
 AACContainerFormDef = interface(IUnknown)
  {* Идентификатор формы AACContainer }
   ['{548CB0E3-A19F-4AD8-A785-C6FB8E70BF73}']
 end;//AACContainerFormDef

  TAACContainerForm = {final form} class(TAACTextContainerPrimForm, AACContainerFormDef)
  Entities : TvcmEntities;
  end;//TAACContainerForm
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
  AACContainerKeywordsPack
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}


{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация AACContainer
 TtfwClassRef.Register(TAACContainerForm);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings)}
// Регистрация фабрики формы AACContainer
 fm_AACContainerForm.SetFactory(TAACContainerForm.Make);
{$IfEnd} //not Admin AND not Monitorings

end.