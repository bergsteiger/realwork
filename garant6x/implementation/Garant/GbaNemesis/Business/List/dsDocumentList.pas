unit dsDocumentList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Business"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Business/List/dsDocumentList.pas"
// Начат: 26.11.2008 19:06
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ViewAreaControllerImp::Class>> F1 Core::Common::Business::ListDataSources::TdsDocumentList
//
// Список документов
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
  PrimListInterfaces,
  DynamicTreeUnit,
  l3TreeInterfaces,
  l3Tree_TLB,
  bsTypes,
  bsInterfaces,
  DocumentAndListInterfaces,
  WorkWithListInterfaces,
  DocInfoInterfaces,
  DynamicDocListUnit,
  DocumentUnit,
  FiltersUnit,
  l3Interfaces,
  afwInterfaces,
  nsRootManager,
  nsTypes,
  PrimPrimListInterfaces,
  DocumentInterfaces,
  BaseDocumentWithAttributesInterfaces,
  l3InternalInterfaces
  {$If not defined(NoVCL)}
  ,
  ExtCtrls
  {$IfEnd} //not NoVCL
  ,
  TreeInterfaces
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
  WorkWithDocumentInterfaces,
  vcmControllers {a},
  nsTypesNew,
  PreviewInterfaces,
  l3IID
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 _InitDataType_ = IdeDocumentList;
 {$Include ..\List\dsDocumentList.imp.pas}
 TdsDocumentList = {vac} class(_dsDocumentList_)
  {* Список документов }
 end;//TdsDocumentList
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  SysUtils,
  IOUnit,
  l3Nodes,
  UnderControlUnit,
  ListRes,
  vtUtils,
  deListSet,
  DataAdapter,
  BaseTypesUnit,
  nsManagers,
  bsUtils,
  bsConst,
  DebugStr
  {$If not defined(NoVCM)}
  ,
  StdRes
  {$IfEnd} //not NoVCM
  ,
  nsContextSearchParams,
  nsINodeWrap,
  nsAddToListEvent,
  nsListSortEvent,
  nsFindContextInListEvent,
  afwComplexDocumentPreview,
  nsINodesClipboardDataObject,
  nsHAFPainter,
  nsDocumentPreview,
  nsIListDataObject
  {$If not defined(NoVCM)}
  ,
  vcmBase
  {$IfEnd} //not NoVCM
  ,
  l3String
  {$If not defined(NoVCM)}
  ,
  vcmForm
  {$IfEnd} //not NoVCM
  ,
  BaseTreeSupportUnit,
  nsNodes,
  nsDocumentTools,
  nsExternalObjectPrim,
  bsConvert,
  nsDocumentStreamWrapper,
  afwFacade,
  evMultiDocumentPreview,
  evHTMLDataObject,
  l3Memory,
  nsFolders,
  nsSuperComplexDocumentPreview,
  bsListTreeStruct,
  nevBase,
  nsListHAFMacroReplacer,
  evFormatHAFMacroReplacer,
  LoggingInterfaces,
  nsListPrintEvent,
  deList,
  nevInterfaces,
  bsTypesNew,
  nsFiltersContainer,
  nsTreeMultiDocumentPreviewContainer,
  bsDocumentMissingMessage,
  nsExternalObjectModelPart,
  nsDocumentStreamList,
  nsListExceptions,
  nsFiltersUtils,
  nsFiltersInterfaces,
  nsDocumentWithSnippetList,
  l3Base,
  vtStdRes,
  nsNewCachableNode,
  Windows,
  l3InterfacesMisc
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

type _Instance_R_ = TdsDocumentList;

{$Include ..\List\dsDocumentList.imp.pas}


{$IfEnd} //not Admin AND not Monitorings
end.