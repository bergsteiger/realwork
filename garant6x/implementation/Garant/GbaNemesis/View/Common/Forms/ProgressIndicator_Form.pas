unit ProgressIndicator_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Common/Forms/ProgressIndicator_Form.pas"
// Начат: 24.08.2009 20:35
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMFinalForm::Class>> F1 Core::Common::View::Common::PrimF1Common::ProgressIndicator
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
  PrimProgressIndicator_Form
  {$If not defined(NoVCL)}
  ,
  ComCtrls
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
    { ProgressIndicatorIDs }
   fm_efProgressIndicator : TvcmFormDescriptor = (rFormID : (rName : 'efProgressIndicator'; rID : 0); rFactory : nil);
    { Идентификатор формы TefProgressIndicator }

type
 ProgressIndicatorFormDef = interface(IUnknown)
  {* Идентификатор формы ProgressIndicator }
   ['{83193317-8438-475F-9F0C-1C44F08B2DA4}']
 end;//ProgressIndicatorFormDef

  TefProgressIndicator = {final form} class(TPrimProgressIndicatorForm, ProgressIndicatorFormDef)
  Entities : TvcmEntities;
  ProgressBar: TProgressBar;
  end;//TefProgressIndicator

  TProgressIndicatorForm = TefProgressIndicator;
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
  ProgressIndicatorKeywordsPack
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}


{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация ProgressIndicator
 TtfwClassRef.Register(TefProgressIndicator);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.