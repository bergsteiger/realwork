unit dsMedicDictionDocument;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Medic"
// Автор: Лукьянец Р.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Medic/dsMedicDictionDocument.pas"
// Начат: 2008/03/06 10:02:57
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ViewAreaControllerImp::Class>> F1 Встроенные продукты::Inpharm::Medic::Medic::TdsMedicDictionDocument
//
// для словаря медицинских терминов
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
 TdsMedicDictionDocument = {vac} class(_dsBaseDocument_)
  {* для словаря медицинских терминов }
 protected
 // overridden protected methods
   function GetTimeMachineOff: Boolean; override;
     {* при получении источника данных машину времени нужно выключить }
   function MakeContainer: InevDocumentContainer; override;
     {* Конструирует контейнер документа }
 end;//TdsMedicDictionDocument
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  nsDictionDocumentContainer,
  nsF1DocumentContainer,
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

type _Instance_R_ = TdsMedicDictionDocument;

{$Include w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\dsBaseDocument.imp.pas}

// start class TdsMedicDictionDocument

function TdsMedicDictionDocument.GetTimeMachineOff: Boolean;
//#UC START# *491C264C02C2_491D8571015D_var*
//#UC END# *491C264C02C2_491D8571015D_var*
begin
//#UC START# *491C264C02C2_491D8571015D_impl*
 Result := true;
//#UC END# *491C264C02C2_491D8571015D_impl*
end;//TdsMedicDictionDocument.GetTimeMachineOff

function TdsMedicDictionDocument.MakeContainer: InevDocumentContainer;
//#UC START# *4C6AB38800F3_491D8571015D_var*
//#UC END# *4C6AB38800F3_491D8571015D_var*
begin
//#UC START# *4C6AB38800F3_491D8571015D_impl*
 //Result := TnsDictionDocumentContainer.Make(DocInfo);
 Result := TnsF1DocumentContainer.Make(DocInfo);
//#UC END# *4C6AB38800F3_491D8571015D_impl*
end;//TdsMedicDictionDocument.MakeContainer

{$IfEnd} //not Admin AND not Monitorings

end.