unit dsDocumentList;
 {* Список документов }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Business\List\dsDocumentList.pas"
// Стереотип: "ViewAreaControllerImp"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimListInterfaces
 , DocumentAndListInterfaces
 , bsInterfaces
 , bsTypes
 , DynamicTreeUnit
 , l3Tree_TLB
 , DocInfoInterfaces
 , WorkWithListInterfaces
 , l3TreeInterfaces
 , l3Interfaces
 , DocumentInterfaces
 , PrimPrimListInterfaces
 , l3InternalInterfaces
 , DocumentUnit
 , l3IID
 , DynamicDocListUnit
 , nsTypes
 , afwInterfaces
 , nsRootManager
 , BaseDocumentWithAttributesInterfaces
 , FiltersUnit
 , PreviewInterfaces
 , TreeInterfaces
 {$If NOT Defined(NoVCL)}
 , ExtCtrls
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , l3ProtoObjectWithCOMQI
 {$If NOT Defined(NoVCM)}
 , vcmLocalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , l3NotifyPtrList
 , WorkWithDocumentInterfaces
;

type
 _InitDataType_ = IdeDocumentList;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\Business\List\dsDocumentList.imp.pas}
 TdsDocumentList = class(_dsDocumentList_)
  {* Список документов }
 end;//TdsDocumentList
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , SysUtils
 , IOUnit
 , l3Nodes
 , UnderControlUnit
 , ListRes
 , vtUtils
 , deListSet
 , DataAdapter
 , BaseTypesUnit
 , nsManagers
 , bsUtils
 , bsConst
 , DebugStr
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
 , nsContextSearchParams
 , nsINodeWrap
 , nsAddToListEvent
 , nsListSortEvent
 , nsFindContextInListEvent
 , afwComplexDocumentPreview
 , nsINodesClipboardDataObject
 , nsHAFPainter
 , nsDocumentPreview
 , nsIListDataObject
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , l3String
 {$If NOT Defined(NoVCM)}
 , vcmForm
 {$IfEnd} // NOT Defined(NoVCM)
 , BaseTreeSupportUnit
 , nsNodes
 , nsDocumentTools
 , nsExternalObjectPrim
 , bsConvert
 , nsDocumentStreamWrapper
 , afwFacade
 , evMultiDocumentPreview
 , evHTMLDataObject
 , l3Memory
 , nsFolders
 , nsSuperComplexDocumentPreview
 , bsListTreeStruct
 , nevBase
 , nsListHAFMacroReplacer
 , evFormatHAFMacroReplacer
 , LoggingInterfaces
 , nsListPrintEvent
 , deList
 , nevInterfaces
 , bsTypesNew
 , nsFiltersContainer
 , nsTreeMultiDocumentPreviewContainer
 , bsDocumentMissingMessage
 , nsExternalObjectModelPart
 , nsDocumentStreamList
 , nsListExceptions
 , nsFiltersUtils
 , nsFiltersInterfaces
 , nsDocumentWithSnippetList
 , l3Base
 , vtStdRes
 , nsNewCachableNode
 , Windows
 , l3InterfacesMisc
;

{$If not Declared(_FormDataSourceType_)}type _FormDataSourceType_ = IdsDocumentList;{$IfEnd}

{$If not Declared(_UseCaseControllerType_)}type _UseCaseControllerType_ = IvcmFormSetDataSource;{$IfEnd}

type _Instance_R_ = TdsDocumentList;

{$Include w:\garant6x\implementation\Garant\GbaNemesis\Business\List\dsDocumentList.imp.pas}
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
