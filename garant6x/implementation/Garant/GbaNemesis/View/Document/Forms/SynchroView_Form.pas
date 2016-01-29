unit SynchroView_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Тучнин Д.А.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Document/Forms/SynchroView_Form.pas"
// Начат: 2003/06/25 19:34:22
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMFinalForm::Class>> F1 Работа с документом и списком документов::Document::View::Document::Document::SynchroView
//
// Синхронный просмотр
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
  Common_FormDefinitions_Controls,
  PrimSynchroViewOptions_Form,
  vtPanel,
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
  TfcSynchroView = {final form} class(TPrimSynchroViewOptionsForm, SynchroViewFormDef)
   {* Синхронный просмотр }
  Entities : TvcmEntities;
  end;//TfcSynchroView

  TSynchroViewForm = TfcSynchroView;
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
  SynchroViewKeywordsPack
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}


{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация SynchroView
 TtfwClassRef.Register(TfcSynchroView);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings)}
// Регистрация фабрики формы SynchroView
 fm_fcSynchroView.SetFactory(TfcSynchroView.Make);
{$IfEnd} //not Admin AND not Monitorings

end.