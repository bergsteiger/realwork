unit dsTipsDocument;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DayTips"
// Автор: Лукьянец Р.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/DayTips/dsTipsDocument.pas"
// Начат: 2008/02/21 08:50:34
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ViewAreaControllerImp::Class>> F1 Интерфейсные элементы::DayTips::DayTips::DayTips::TdsTipsDocument
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
 TdsTipsDocument = {vac} class(_dsBaseDocument_)
 protected
 // overridden protected methods
   function GetIsReadOnly: Boolean; override;
   function GetTimeMachineOff: Boolean; override;
     {* при получении источника данных машину времени нужно выключить }
   function MakeContainer: InevDocumentContainer; override;
     {* Конструирует контейнер документа }
 end;//TdsTipsDocument
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  nsTipsDocumentContainer,
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

type _Instance_R_ = TdsTipsDocument;

{$Include w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\dsBaseDocument.imp.pas}

// start class TdsTipsDocument

function TdsTipsDocument.GetIsReadOnly: Boolean;
//#UC START# *491C263E03AF_491D56370182_var*
//#UC END# *491C263E03AF_491D56370182_var*
begin
//#UC START# *491C263E03AF_491D56370182_impl*
 Result := true;
//#UC END# *491C263E03AF_491D56370182_impl*
end;//TdsTipsDocument.GetIsReadOnly

function TdsTipsDocument.GetTimeMachineOff: Boolean;
//#UC START# *491C264C02C2_491D56370182_var*
//#UC END# *491C264C02C2_491D56370182_var*
begin
//#UC START# *491C264C02C2_491D56370182_impl*
 Result := true;
//#UC END# *491C264C02C2_491D56370182_impl*
end;//TdsTipsDocument.GetTimeMachineOff

function TdsTipsDocument.MakeContainer: InevDocumentContainer;
//#UC START# *4C6AB38800F3_491D56370182_var*
//#UC END# *4C6AB38800F3_491D56370182_var*
begin
//#UC START# *4C6AB38800F3_491D56370182_impl*
 Result := TnsTipsDocumentContainer.Make(DocInfo);
//#UC END# *4C6AB38800F3_491D56370182_impl*
end;//TdsTipsDocument.MakeContainer

{$IfEnd} //not Admin AND not Monitorings

end.