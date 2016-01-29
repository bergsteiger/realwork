unit dsMedicFirmDocument;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Medic"
// Автор: Лукьянец Р.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Medic/dsMedicFirmDocument.pas"
// Начат: 2008/03/26 14:05:01
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ViewAreaControllerImp::Class>> F1 Встроенные продукты::Inpharm::Medic::Medic::TdsMedicFirmDocument
//
// Документ описания фирмы-производителя
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
  MedicInterfaces,
  InpharmInterfaces,
  l3Interfaces,
  l3Types,
  afwInterfaces,
  nevTools,
  DocumentAndListInterfaces,
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
 _FormDataSourceType_ = IdsMedicFirmDocument;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\dsBaseDocumentPrim.imp.pas}
 TdsMedicFirmDocument = {vac} class(_dsBaseDocumentPrim_, IdsMedicFirmDocument)
  {* Документ описания фирмы-производителя }
 private
 // private fields
   ucc_MedicFirmDocument : IsdsMedicFirmDocumentPrim;
 protected

  procedure InitRefs(const aDS: IvcmUseCaseController); override;
  procedure ClearRefs; override;
 protected
 // realized methods
   procedure OpenDrugList;
     {* открыть список выпускаемых препаратов }
 protected
 // overridden protected methods
   function GetTimeMachineOff: Boolean; override;
     {* при получении источника данных машину времени нужно выключить }
   function MakeContainer: InevDocumentContainer; override;
     {* Конструирует контейнер документа }
 end;//TdsMedicFirmDocument
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
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

type _Instance_R_ = TdsMedicFirmDocument;

{$Include w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\dsBaseDocumentPrim.imp.pas}

// start class TdsMedicFirmDocument

procedure TdsMedicFirmDocument.OpenDrugList;
//#UC START# *491D7D2A02E0_491D7D660107_var*
//#UC END# *491D7D2A02E0_491D7D660107_var*
begin
//#UC START# *491D7D2A02E0_491D7D660107_impl*
 if (ucc_MedicFirmDocument <> nil) then
  ucc_MedicFirmDocument.OpenDrugList;
//#UC END# *491D7D2A02E0_491D7D660107_impl*
end;//TdsMedicFirmDocument.OpenDrugList

function TdsMedicFirmDocument.GetTimeMachineOff: Boolean;
//#UC START# *491C264C02C2_491D7D660107_var*
//#UC END# *491C264C02C2_491D7D660107_var*
begin
//#UC START# *491C264C02C2_491D7D660107_impl*
 Result := True;
//#UC END# *491C264C02C2_491D7D660107_impl*
end;//TdsMedicFirmDocument.GetTimeMachineOff

function TdsMedicFirmDocument.MakeContainer: InevDocumentContainer;
//#UC START# *4C6AB38800F3_491D7D660107_var*
//#UC END# *4C6AB38800F3_491D7D660107_var*
begin
//#UC START# *4C6AB38800F3_491D7D660107_impl*
 Result := TnsF1DocumentContainer.Make(DocInfo);
//#UC END# *4C6AB38800F3_491D7D660107_impl*
end;//TdsMedicFirmDocument.MakeContainer

procedure TdsMedicFirmDocument.InitRefs(const aDS: IvcmUseCaseController);
begin
 inherited;
 Supports(aDS, IsdsMedicFirmDocumentPrim, ucc_MedicFirmDocument);
end;

procedure TdsMedicFirmDocument.ClearRefs;
begin
 inherited;
 ucc_MedicFirmDocument := nil;
end;

{$IfEnd} //not Admin AND not Monitorings

end.