unit FoldersInfo_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Тучнин Д.А.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Folders/Forms/FoldersInfo_Form.pas"
// Начат: 2004/07/05 08:05:59
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMFinalForm::Class>> F1 Основные прецеденты::Folders::View::Folders::PrimFolders$UC::FoldersInfo
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
  PrimFoldersInfoOptions_Form,
  vtPanel,
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
    { FoldersInfoIDs }
   fm_cfFoldersInfo : TvcmFormDescriptor = (rFormID : (rName : 'cfFoldersInfo'; rID : 0); rFactory : nil);
    { Идентификатор формы TcfFoldersInfo }

type
 FoldersInfoFormDef = interface(IUnknown)
  {* Идентификатор формы FoldersInfo }
   ['{A7FC5777-8418-45E1-9EE1-511BCC3B18B5}']
 end;//FoldersInfoFormDef

  TcfFoldersInfo = {final form} class(TPrimFoldersInfoOptionsForm, FoldersInfoFormDef)
  Entities : TvcmEntities;
  end;//TcfFoldersInfo

  TFoldersInfoForm = TcfFoldersInfo;
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
  FoldersInfoKeywordsPack
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}


{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация FoldersInfo
 TtfwClassRef.Register(TcfFoldersInfo);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings)}
// Регистрация фабрики формы FoldersInfo
 fm_cfFoldersInfo.SetFactory(TcfFoldersInfo.Make);
{$IfEnd} //not Admin AND not Monitorings

end.