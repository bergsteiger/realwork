unit ShutDown_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/PrimCommon/Forms/ShutDown_Form.pas"
// Начат: 21.08.2009 20:15
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMFinalForm::Class>> F1 Базовые определения предметной области::F1 Application Template::View::PrimCommon::PrimCommon::ShutDown
//
// Предупреждение
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
  Classes
  {$If not defined(NoVCM)}
  ,
  vcmInterfaces
  {$IfEnd} //not NoVCM
  ,
  PrimShutDown_Form
  {$If not defined(NoVCL)}
  ,
  ExtCtrls
  {$IfEnd} //not NoVCL
  ,
  vtPanel,
  vtLabel,
  vtButton,
  l3InterfacedComponent {a},
  vcmComponent {a},
  vcmBaseEntities {a},
  vcmEntities {a},
  vcmExternalInterfaces {a},
  vcmEntityForm {a}
  ;

const
    { ShutDownIDs }
   fm_ShutDownForm : TvcmFormDescriptor = (rFormID : (rName : 'ShutDownForm'; rID : 0); rFactory : nil);
    { Идентификатор формы TShutDownForm }

type
 ShutDownFormDef = interface(IUnknown)
  {* Идентификатор формы ShutDown }
   ['{30C1FF00-6CA8-4565-BDC9-191E8237EFAD}']
 end;//ShutDownFormDef

  TShutDownForm = {final form} class(TPrimShutDownForm, ShutDownFormDef)
   {* Предупреждение }
  Entities : TvcmEntities;
  end;//TShutDownForm

implementation

{$R *.DFM}

uses
  SysUtils
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  ShutDownKeywordsPack
  {$IfEnd} //not NoScripts
  
  ;


initialization
{$If not defined(NoScripts)}
// Регистрация ShutDown
 TtfwClassRef.Register(TShutDownForm);
{$IfEnd} //not NoScripts
// Регистрация фабрики формы ShutDown
 fm_ShutDownForm.SetFactory(TShutDownForm.Make);

end.