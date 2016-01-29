unit dsAutoreferat;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Autoreferat"
// Автор: Морозов М.А.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Autoreferat/dsAutoreferat.pas"
// Начат: 06.10.2005 14.52
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ViewAreaControllerImp::Class>> F1 Пользовательские сервисы::Autoreferat::Autoreferat::Autoreferat::TdsAutoreferat
//
// Автореферат
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
  DocumentAndListInterfaces,
  l3Interfaces,
  l3Types,
  afwInterfaces,
  nevTools,
  DocumentInterfaces,
  WorkWithListInterfaces,
  nsDocumentLikeStateHolder
  {$If not defined(NoVCM)}
  ,
  vcmInterfaces
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmExternalInterfaces
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmLocalInterfaces
  {$IfEnd} //not NoVCM
  ,
  l3ProtoObjectWithCOMQI,
  l3NotifyPtrList,
  UnderControlUnit,
  UnderControlInterfaces,
  bsTypes,
  DocumentUnit,
  bsTypesNew,
  FoldersDomainInterfaces,
  vcmControllers {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\dsBaseDocument.imp.pas}
 TdsAutoreferat = {vac} class(_dsBaseDocument_)
  {* Автореферат }
 protected
 // overridden protected methods
   function GetIsReadOnly: Boolean; override;
   function GetTimeMachineOff: Boolean; override;
     {* при получении источника данных машину времени нужно выключить }
   function MakeContainer: InevDocumentContainer; override;
     {* Конструирует контейнер документа }
 end;//TdsAutoreferat
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  nsAutoreferatDocumentContainer,
  IOUnit,
  l3Base,
  bsUtils,
  BaseTypesUnit,
  bsConvert,
  l3Utils,
  deDocInfo,
  nsTypes,
  nsDocInfoHAFMacroReplacer
  {$If not defined(NoVCM)}
  ,
  StdRes
  {$IfEnd} //not NoVCM
  ,
  nsFolderFilterInfo,
  l3InterfacesMisc,
  SysUtils,
  afwFacade
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

type _Instance_R_ = TdsAutoreferat;

{$Include w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\dsBaseDocument.imp.pas}

// start class TdsAutoreferat

function TdsAutoreferat.GetIsReadOnly: Boolean;
//#UC START# *491C263E03AF_491C3B8D00D8_var*
//#UC END# *491C263E03AF_491C3B8D00D8_var*
begin
//#UC START# *491C263E03AF_491C3B8D00D8_impl*
 Result := true;
//#UC END# *491C263E03AF_491C3B8D00D8_impl*
end;//TdsAutoreferat.GetIsReadOnly

function TdsAutoreferat.GetTimeMachineOff: Boolean;
//#UC START# *491C264C02C2_491C3B8D00D8_var*
//#UC END# *491C264C02C2_491C3B8D00D8_var*
begin
//#UC START# *491C264C02C2_491C3B8D00D8_impl*
 Result := true;
//#UC END# *491C264C02C2_491C3B8D00D8_impl*
end;//TdsAutoreferat.GetTimeMachineOff

function TdsAutoreferat.MakeContainer: InevDocumentContainer;
//#UC START# *4C6AB38800F3_491C3B8D00D8_var*
//#UC END# *4C6AB38800F3_491C3B8D00D8_var*
begin
//#UC START# *4C6AB38800F3_491C3B8D00D8_impl*
 Result := TnsAutoreferatDocumentContainer.Make(DocInfo);
//#UC END# *4C6AB38800F3_491C3B8D00D8_impl*
end;//TdsAutoreferat.MakeContainer

{$IfEnd} //not Admin AND not Monitorings

end.