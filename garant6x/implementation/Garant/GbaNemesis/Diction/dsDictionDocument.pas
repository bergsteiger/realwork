unit dsDictionDocument;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Diction"
// Автор: Морозов М.А.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Diction/dsDictionDocument.pas"
// Начат: 07.10.2005 17.02
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ViewAreaControllerImp::Class>> F1 Встроенные продукты::Diction::Diction::Diction::TdsDictionDocument
//
// Документ толкового словаря
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
  DictionInterfaces,
  DictionInterfacesPrim,
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
 _FormDataSourceType_ = IdsDictionDocument;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\dsBaseDocumentPrim.imp.pas}
 TdsDictionDocument = {final vac} class(_dsBaseDocumentPrim_, IdsDictionDocument)
  {* Документ толкового словаря }
 private
 // private fields
   ucc_Diction : IsdsDiction;
 protected

  procedure InitRefs(const aDS: IvcmUseCaseController); override;
  procedure ClearRefs; override;
 protected
 // realized methods
   procedure OpenLiteratureList;
     {* открыть список литературы для толкового словаря }
   function pm_GetIsMainDiction: Boolean;
 protected
 // overridden protected methods
   function GetTimeMachineOff: Boolean; override;
     {* при получении источника данных машину времени нужно выключить }
   function MakeContainer: InevDocumentContainer; override;
     {* Конструирует контейнер документа }
 end;//TdsDictionDocument
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  DataAdapter,
  nsDictionDocumentContainer,
  bsConst,
  nsConst,
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

type _Instance_R_ = TdsDictionDocument;

{$Include w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\dsBaseDocumentPrim.imp.pas}

// start class TdsDictionDocument

procedure TdsDictionDocument.OpenLiteratureList;
//#UC START# *491D58670154_491D5BE30111_var*
//#UC END# *491D58670154_491D5BE30111_var*
begin
//#UC START# *491D58670154_491D5BE30111_impl*
 if (ucc_Diction <> nil) then
  ucc_Diction.OpenLiteratureList;
//#UC END# *491D58670154_491D5BE30111_impl*
end;//TdsDictionDocument.OpenLiteratureList

function TdsDictionDocument.pm_GetIsMainDiction: Boolean;
//#UC START# *491D58890177_491D5BE30111get_var*
//#UC END# *491D58890177_491D5BE30111get_var*
begin
//#UC START# *491D58890177_491D5BE30111get_impl*
 Result := Assigned(DocInfo) and
  (DocInfo.Language = DefDataAdapter.DocDefaultLang);
//#UC END# *491D58890177_491D5BE30111get_impl*
end;//TdsDictionDocument.pm_GetIsMainDiction

function TdsDictionDocument.GetTimeMachineOff: Boolean;
//#UC START# *491C264C02C2_491D5BE30111_var*
//#UC END# *491C264C02C2_491D5BE30111_var*
begin
//#UC START# *491C264C02C2_491D5BE30111_impl*
 Result := true;
//#UC END# *491C264C02C2_491D5BE30111_impl*
end;//TdsDictionDocument.GetTimeMachineOff

function TdsDictionDocument.MakeContainer: InevDocumentContainer;
//#UC START# *4C6AB38800F3_491D5BE30111_var*
//#UC END# *4C6AB38800F3_491D5BE30111_var*
begin
//#UC START# *4C6AB38800F3_491D5BE30111_impl*
 if (DocInfo.Doc.GetInternalId + c_InternalDocShift =
      c_LiteratureListForDictionary) then
  Result := TnsF1DocumentContainer.Make(DocInfo)
 else
  Result := TnsDictionDocumentContainer.Make(DocInfo);
//#UC END# *4C6AB38800F3_491D5BE30111_impl*
end;//TdsDictionDocument.MakeContainer

procedure TdsDictionDocument.InitRefs(const aDS: IvcmUseCaseController);
begin
 inherited;
 Supports(aDS, IsdsDiction, ucc_Diction);
end;

procedure TdsDictionDocument.ClearRefs;
begin
 inherited;
 ucc_Diction := nil;
end;

{$IfEnd} //not Admin AND not Monitorings

end.