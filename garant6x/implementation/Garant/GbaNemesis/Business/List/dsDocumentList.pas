unit dsDocumentList;
 {* Список документов }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Business\List\dsDocumentList.pas"
// Стереотип: "ViewAreaControllerImp"
// Элемент модели: "TdsDocumentList" MUID: (492D73D80122)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

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
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , afwInterfaces
 , nsRootManager
 , BaseDocumentWithAttributesInterfaces
 , FiltersUnit
 , PreviewInterfaces
 , nsTypesNew
 , TreeInterfaces
 {$If NOT Defined(NoVCL)}
 , ExtCtrls
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
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
 , Common_F1CommonServices_Contracts
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
 //#UC START# *492D73D80122impl_uses*
 , vcmDispatcher
 //#UC END# *492D73D80122impl_uses*
;

type _Instance_R_ = TdsDocumentList;

{$Include w:\garant6x\implementation\Garant\GbaNemesis\Business\List\dsDocumentList.imp.pas}
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
