unit NOT_COMPLETED_WorkWithDocumentInterfaces;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\BusinessInterfaces\NOT_COMPLETED_WorkWithDocumentInterfaces.pas"
// Стереотип: "ControllerInterfaces"
// Элемент модели: "WorkWithDocumentInterfaces" MUID: (4D1B548F00EE)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , DynamicDocListUnit
 , DocumentUnit
 , DynamicTreeUnit
 , bsTypes
 , DocumentAndListInterfaces
 {$If NOT Defined(NoVCM)}
 , vcmControllers
 {$IfEnd} // NOT Defined(NoVCM)
 , DocInfoInterfaces
 , nevTools
 , bsTypesNew
 , DocumentInterfaces
 , ExternalObjectUnit
 , nsTypes
 , nevBase
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 , l3Types
 , bsInterfaces
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 IucpBaseSearchSupportQuery = interface
  ['{B8089C8A-893D-4E2E-9260-6BFD2F8E0C25}']
  function Get_CanRunBaseSearch: Boolean;
  property CanRunBaseSearch: Boolean
   read Get_CanRunBaseSearch;
 end;//IucpBaseSearchSupportQuery

 IucpDocumentWithContents = interface
  ['{F12A4027-23C0-463E-BE27-720F8D76BEEE}']
  function pm_GetdsContents: IdsBaseContents;
  procedure OpenContents(const aTree: IdeSimpleTree;
   anForceOpen: TnsContentsOpenMode;
   const aContainerOfDocument: InevDocumentContainer);
  property dsContents: IdsBaseContents
   read pm_GetdsContents;
   {* Оглавление }
 end;//IucpDocumentWithContents

 IsdsDocument = interface(IsdsDocInfo)
  ['{158D206F-A24B-4C44-A989-F2563E04402E}']
  function pm_GetdsBaloonWarning: IdsWarning;
  function pm_GetdsTimeMachineWarning: IdsWarning;
  function pm_GetdsTranslationWarning: IdsWarning;
  function pm_GetdsCRBaloonWarning: IdsWarning;
  function pm_GetdsWarning: IdsWarning;
  function pm_GetdsIncomingLinksToPart: IdsDocumentList;
  function pm_GetdsEditions: IdsEditions;
  function pm_GetdsOutgoingLinksFromPart: IdsDocumentList;
  procedure OpenWarning;
   {* предупреждение }
  procedure OpenEditions;
   {* редакции }
  procedure OpenSimilarDocuments;
   {* открыть список похожих документов }
  procedure OpenSimilarDocumentsToFragment(aBlockId: Integer);
  function OpenCRToPart(const aPositionList: IPositionList;
   const aNode: INodeBase;
   aType: TlstCRType): Boolean;
   {* вызывается для открытия вкладки корреспондентов/респондентов к фрагменту }
  function ChangeRedaction(const aChangeWorker: IbsChangeRedactionWorker;
   const aPos: TbsDocPos): Boolean;
   {* изменить редакцию документа }
  function IsWarningNeeded: Boolean;
   {* показывает необходимо ли показывать для данного документа предупреждение }
  function HasTimeMachineWarning: Boolean;
   {* показывает есть ли к документу предупреждение от Машины времени }
  function HasAnyRedaction: Boolean;
   {* показывает есть ли у документа не актуальные редакции }
  function As_IucpDocumentWithContents: IucpDocumentWithContents;
   {* Метод приведения нашего интерфейса к IucpDocumentWithContents }
  function As_InsWarningGenerator: InsWarningGenerator;
   {* Метод приведения нашего интерфейса к InsWarningGenerator }
  function As_InsWarningLocker: InsWarningLocker;
   {* Метод приведения нашего интерфейса к InsWarningLocker }
  function As_IucpBaseSearchSupportQuery: IucpBaseSearchSupportQuery;
   {* Метод приведения нашего интерфейса к IucpBaseSearchSupportQuery }
  property dsBaloonWarning: IdsWarning
   read pm_GetdsBaloonWarning;
   {* Предупреждение для баллона }
  property dsTimeMachineWarning: IdsWarning
   read pm_GetdsTimeMachineWarning;
  property dsTranslationWarning: IdsWarning
   read pm_GetdsTranslationWarning;
   {* Предупреждения к переводу }
  property dsCRBaloonWarning: IdsWarning
   read pm_GetdsCRBaloonWarning;
  property dsWarning: IdsWarning
   read pm_GetdsWarning;
   {* БОФ предупреждения }
  property dsIncomingLinksToPart: IdsDocumentList
   read pm_GetdsIncomingLinksToPart;
   {* БОФ ссылок на фрагмент (корреспондентов) }
  property dsEditions: IdsEditions
   read pm_GetdsEditions;
   {* БОФ редакции документа }
  property dsOutgoingLinksFromPart: IdsDocumentList
   read pm_GetdsOutgoingLinksFromPart;
   {* БОФ ссылок из фрагмента (респондентов) }
 end;//IsdsDocument

 IdDocument = interface(IdDocInfo)
  {* Данные прецедента документ }
  ['{9B1A4C3A-EB75-4FD3-A5D5-4517ABB88AC1}']
  function pm_GetIncomingLinksToPartFilter: INodeBase;
  procedure pm_SetIncomingLinksToPartFilter(const aValue: INodeBase);
  function pm_GetIncomingLinksToPartList: IDynList;
  procedure pm_SetIncomingLinksToPartList(const aValue: IDynList);
  function pm_GetIncomingLinksToPartPosList: IPositionList;
  procedure pm_SetIncomingLinksToPartPosList(const aValue: IPositionList);
  function Get_OutgoingLinksFromPartList: IDynList;
  procedure Set_OutgoingLinksFromPartList(const aValue: IDynList);
  function Get_OutgoingLinksFromPartFilter: INodeBase;
  procedure Set_OutgoingLinksFromPartFilter(const aValue: INodeBase);
  function Get_OutgoingLinksFromPartPosList: IPositionList;
  procedure Set_OutgoingLinksFromPartPosList(const aValue: IPositionList);
  function pm_GetSimilarDocumentsBlockId: Integer;
  procedure pm_SetSimilarDocumentsBlockId(aValue: Integer);
  function pm_GetContentsTree: IdeSimpleTree;
  procedure pm_SetContentsTree(const aValue: IdeSimpleTree);
  function pm_GetdsWarningRef: IvcmFormDataSourceRef;
  function pm_GetdsIncomingLinksToPartRef: IvcmFormDataSourceRef;
  function pm_GetdsEditionsRef: IvcmFormDataSourceRef;
  function pm_GetdsOutgoingLinksFromPartRef: IvcmFormDataSourceRef;
  function pm_GetdsContentsRef: IvcmFormDataSourceRef;
  property IncomingLinksToPartFilter: INodeBase
   read pm_GetIncomingLinksToPartFilter
   write pm_SetIncomingLinksToPartFilter;
  property IncomingLinksToPartList: IDynList
   read pm_GetIncomingLinksToPartList
   write pm_SetIncomingLinksToPartList;
  property IncomingLinksToPartPosList: IPositionList
   read pm_GetIncomingLinksToPartPosList
   write pm_SetIncomingLinksToPartPosList;
  property OutgoingLinksFromPartList: IDynList
   read Get_OutgoingLinksFromPartList
   write Set_OutgoingLinksFromPartList;
  property OutgoingLinksFromPartFilter: INodeBase
   read Get_OutgoingLinksFromPartFilter
   write Set_OutgoingLinksFromPartFilter;
  property OutgoingLinksFromPartPosList: IPositionList
   read Get_OutgoingLinksFromPartPosList
   write Set_OutgoingLinksFromPartPosList;
  property SimilarDocumentsBlockId: Integer
   read pm_GetSimilarDocumentsBlockId
   write pm_SetSimilarDocumentsBlockId;
  property ContentsTree: IdeSimpleTree
   read pm_GetContentsTree
   write pm_SetContentsTree;
  property dsWarningRef: IvcmFormDataSourceRef
   read pm_GetdsWarningRef;
   {* Ссылка на "БОФ предупреждения" }
  property dsIncomingLinksToPartRef: IvcmFormDataSourceRef
   read pm_GetdsIncomingLinksToPartRef;
   {* Ссылка на "БОФ ссылок на фрагмент (корреспондентов)" }
  property dsEditionsRef: IvcmFormDataSourceRef
   read pm_GetdsEditionsRef;
   {* Ссылка на "БОФ редакции документа" }
  property dsOutgoingLinksFromPartRef: IvcmFormDataSourceRef
   read pm_GetdsOutgoingLinksFromPartRef;
   {* Ссылка на "БОФ ссылок из фрагмента (респондентов)" }
  property dsContentsRef: IvcmFormDataSourceRef
   read pm_GetdsContentsRef;
   {* Ссылка на "Оглавление" }
 end;//IdDocument

 IsdsDocumentWithFlash = interface(IsdsDocument)
  {* Документ с flash-роликом. }
  ['{C138E766-DD9B-40A2-B310-442243D35F22}']
 end;//IsdsDocumentWithFlash

 IsdsAAC = interface(IsdsDocument)
  {* Контроллер прецедента "Актуальная аналитика" }
  ['{3E31BE40-9EBE-4B74-9FDF-D5C902C941FA}']
  function pm_GetContainer: IdsAACContainer;
  function pm_GetLeft: IdsBaseDocument;
  function pm_GetRight: IdsBaseDocument;
  property Container: IdsAACContainer
   read pm_GetContainer;
  property Left: IdsBaseDocument
   read pm_GetLeft;
  property Right: IdsBaseDocument
   read pm_GetRight;
 end;//IsdsAAC
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
