unit sdsDocumentWithFlash;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Document"
// Автор: Морозов М.А.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Document/sdsDocumentWithFlash.pas"
// Начат: 2008/06/19 11:30:02
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UseCaseControllerImp::Class>> F1 Контроллер работы с документом и абстрактная фабрика документа::F1 Document Processing::Document::Document::TsdsDocumentWithFlash
//
// БОС документа-схемы
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
  WorkWithDocumentInterfaces,
  DynamicTreeUnit
  {$If not defined(NoVCM)}
  ,
  vcmInterfaces
  {$IfEnd} //not NoVCM
  ,
  bsTypes
  {$If not defined(NoVCM)}
  ,
  vcmControllers
  {$IfEnd} //not NoVCM
  ,
  DocumentInterfaces,
  bsTypesNew,
  DynamicDocListUnit,
  PrimListInterfaces,
  DocInfoInterfaces,
  BaseDocumentWithAttributesInterfaces,
  DocumentUnit,
  DocumentAndListInterfaces
  {$If not defined(NoVCM)}
  ,
  vcmExternalInterfaces
  {$IfEnd} //not NoVCM
  ,
  l3ProtoObjectWithCOMQI,
  l3Interfaces,
  l3NotifyPtrList,
  l3IID,
  nevTools,
  afwInterfaces,
  FoldersDomainInterfaces,
  l3InternalInterfaces,
  l3TreeInterfaces,
  bsInterfaces,
  ExternalObjectUnit,
  evdInterfaces,
  l3Tree_TLB,
  PrimPrimListInterfaces,
  FiltersUnit,
  nsTypes,
  PreviewInterfaces,
  nevBase
  {$If not defined(NoVCM)}
  ,
  vcmUserControls
  {$IfEnd} //not NoVCM
  
  {$If defined(Nemesis)}
  ,
  nscNewInterfaces
  {$IfEnd} //Nemesis
  ,
  F1TagDataProviderInterface,
  nsTypesNew
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 _SetType_ = IsdsDocumentWithFlash;
 {$Include ..\Document\sdsDocument.imp.pas}
 TsdsDocumentWithFlash = {ucc} class(_sdsDocument_, IsdsDocumentWithFlash)
  {* БОС документа-схемы }
 protected
 // overridden protected methods
   function DoCanRunBaseSearch: Boolean; override;
 end;//TsdsDocumentWithFlash
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  dDocument,
  SysUtils,
  dsDocument,
  dsDocumentListCRToPart,
  deDocumentListCR,
  dsWarning,
  dsContents,
  dsEditions
  {$If not defined(NoVCM)}
  ,
  vcmForm
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmGUI
  {$IfEnd} //not NoVCM
  ,
  IOUnit
  {$If not defined(NoVCM)}
  ,
  StdRes
  {$IfEnd} //not NoVCM
  ,
  BaseTypesUnit,
  DataAdapter,
  k2Tags
  {$If not defined(NoVCM)}
  ,
  vcmFormSetRefreshParams
  {$IfEnd} //not NoVCM
  ,
  bsUtils,
  l3String,
  l3Core,
  nsDocumentTools,
  afwFacade,
  Graphics
  {$If not defined(NoVCM)}
  ,
  vcmBase
  {$IfEnd} //not NoVCM
  ,
  l3Base,
  nsConst,
  Document_Const,
  TextPara_Const,
  WarningUserTypes_Warning_UserType,
  UnderControlInterfaces
  {$If not defined(NoVCM)}
  ,
  vcmMessagesSupport
  {$IfEnd} //not NoVCM
  ,
  ControlStatusUtils,
  nsDocumentWarningGenerator,
  dsTranslationWarning,
  dsCRWarning,
  nsTabbedInterfaceTypes,
  dsDocumentListCR,
  dsDocumentList,
  dsAnnotation,
  dsDocumentWithFlash,
  bsFrozenNode,
  deDocInfo,
  bsDataContainer,
  deDocumentList,
  bsUserCRListInfo,
  l3Types,
  DebugStr,
  l3Utils,
  nsUtils,
  dsTranslation,
  dsRelatedDoc,
  dsChronology,
  dsAttributes,
  Windows
  {$If not defined(NoVCM)}
  ,
  vcmLocalInterfaces
  {$IfEnd} //not NoVCM
  ,
  afwSettingsChangePublisher,
  vcmFormDataSourceRef {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

type _Instance_R_ = TsdsDocumentWithFlash;

{$Include ..\Document\sdsDocument.imp.pas}

// start class TsdsDocumentWithFlash

function TsdsDocumentWithFlash.DoCanRunBaseSearch: Boolean;
//#UC START# *496F437400A6_493E754301C8_var*
//#UC END# *496F437400A6_493E754301C8_var*
begin
//#UC START# *496F437400A6_493E754301C8_impl*
 Result := False;
//#UC END# *496F437400A6_493E754301C8_impl*
end;//TsdsDocumentWithFlash.DoCanRunBaseSearch

{$IfEnd} //not Admin AND not Monitorings

end.