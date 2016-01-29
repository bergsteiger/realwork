unit SaveLoad_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View$For F1 and Monitorings"
// Автор: Тучнин Д.А.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Search/Forms/SaveLoad_Form.pas"
// Начат: 2003/10/13 14:47:21
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMFinalForm::Class>> F1 Common For Shell And Monitoring::Search::View$For F1 and Monitorings::Search$Presentation for F1 and Monitorings::CommonSearch::SaveLoad
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin)}
uses
  Search_FormDefinitions_Controls,
  PrimSaveLoadOptionsWithUserTypes_Form,
  vtPanel,
  vtLabel
  {$If not defined(NoVCL)}
  ,
  ExtCtrls
  {$IfEnd} //not NoVCL
  ,
  Classes {a},
  l3InterfacedComponent {a},
  vcmComponent {a},
  vcmBaseEntities {a},
  vcmEntities {a},
  vcmExternalInterfaces {a},
  vcmInterfaces {a},
  vcmEntityForm {a}
  ;
{$IfEnd} //not Admin

{$If not defined(Admin)}
type
  TcfSaveLoad = {final form} class(TPrimSaveLoadOptionsWithUserTypesForm, SaveLoadFormDef)
  Entities : TvcmEntities;
  end;//TcfSaveLoad

  TSaveLoadForm = TcfSaveLoad;
{$IfEnd} //not Admin

implementation

{$R *.DFM}

{$If not defined(Admin)}
uses
  SysUtils
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  
  {$If not defined(Admin) AND not defined(NoScripts)}
  ,
  SaveLoadKeywordsPack
  {$IfEnd} //not Admin AND not NoScripts
  
  ;
{$IfEnd} //not Admin

{$If not defined(Admin)}


{$IfEnd} //not Admin

initialization
{$If not defined(Admin) AND not defined(NoScripts)}
// Регистрация SaveLoad
 TtfwClassRef.Register(TcfSaveLoad);
{$IfEnd} //not Admin AND not NoScripts
{$If not defined(Admin)}
// Регистрация фабрики формы SaveLoad
 fm_cfSaveLoad.SetFactory(TcfSaveLoad.Make);
{$IfEnd} //not Admin

end.