unit WorkWithDocumentInterfaces;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "BusinessInterfaces"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/BusinessInterfaces/WorkWithDocumentInterfaces.pas"
// Начат: 29.12.2010 18:32
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ControllerInterfaces::Category>> F1 Core::Common::BusinessInterfaces::WorkWithDocumentInterfaces
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
  DynamicDocListUnit,
  DocumentUnit,
  DynamicTreeUnit,
  bsTypes,
  DocumentAndListInterfaces
  {$If not defined(NoVCM)}
  ,
  vcmControllers
  {$IfEnd} //not NoVCM
  ,
  DocInfoInterfaces,
  bsTypesNew,
  nevTools,
  vcmInterfaces {a}
  ;

type
 IucpBaseSearchSupportQuery = interface
   ['{B8089C8A-893D-4E2E-9260-6BFD2F8E0C25}']
  // BaseSearchSupportQuery
   function Get_CanRunBaseSearch: Boolean;
   property CanRunBaseSearch: Boolean
     read Get_CanRunBaseSearch;
 end;//IucpBaseSearchSupportQuery

 IucpDocumentWithContents = interface
   ['{F12A4027-23C0-463E-BE27-720F8D76BEEE}']
   function pm_GetDsContents: IdsBaseContents;
   function pm_GetdsContentsRef: IvcmViewAreaControllerRef;
   property dsContents: IdsBaseContents
     read pm_GetDsContents;
     {* Оглавление }
   property dsContentsRef: IvcmViewAreaControllerRef
     read pm_GetdsContentsRef;
     {* Ссылка на "Оглавление" }
  // Contents
   procedure OpenContents(const aTree: IdeSimpleTree;
    anForceOpen: TnsContentsOpenMode;
    const aContainerOfDocument: InevDocumentContainer);
 end;//IucpDocumentWithContents

 IsdsDocument = interface(IsdsDocInfo{, IucpDocumentWithContents, InsWarningGenerator, InsWarningLocker, IucpBaseSearchSupportQuery})
   ['{158D206F-A24B-4C44-A989-F2563E04402E}']
   function pm_GetDsBaloonWarning: IdsWarning;
   function pm_GetDsTimeMachineWarning: IdsWarning;
   function pm_GetDsTranslationWarning: IdsWarning;
   function pm_GetDsCRBaloonWarning: IdsWarning;
   function pm_GetDsWarning: IdsWarning;
   function pm_GetdsWarningRef: IvcmViewAreaControllerRef;
   function pm_GetDsIncomingLinksToPart: IdsDocumentList;
   function pm_GetdsIncomingLinksToPartRef: IvcmViewAreaControllerRef;
   function pm_GetDsEditions: IdsEditions;
   function pm_GetdsEditionsRef: IvcmViewAreaControllerRef;
   function pm_GetDsOutgoingLinksFromPart: IdsDocumentList;
   function pm_GetdsOutgoingLinksFromPartRef: IvcmViewAreaControllerRef;
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
   property dsBaloonWarning: IdsWarning
     read pm_GetDsBaloonWarning;
     {* Предупреждение для баллона }
   property dsTimeMachineWarning: IdsWarning
     read pm_GetDsTimeMachineWarning;
   property dsTranslationWarning: IdsWarning
     read pm_GetDsTranslationWarning;
     {* Предупреждения к переводу }
   property dsCRBaloonWarning: IdsWarning
     read pm_GetDsCRBaloonWarning;
   property dsWarning: IdsWarning
     read pm_GetDsWarning;
     {* БОФ предупреждения }
   property dsWarningRef: IvcmViewAreaControllerRef
     read pm_GetdsWarningRef;
     {* Ссылка на "БОФ предупреждения" }
   property dsIncomingLinksToPart: IdsDocumentList
     read pm_GetDsIncomingLinksToPart;
     {* БОФ ссылок на фрагмент (корреспондентов) }
   property dsIncomingLinksToPartRef: IvcmViewAreaControllerRef
     read pm_GetdsIncomingLinksToPartRef;
     {* Ссылка на "БОФ ссылок на фрагмент (корреспондентов)" }
   property dsEditions: IdsEditions
     read pm_GetDsEditions;
     {* БОФ редакции документа }
   property dsEditionsRef: IvcmViewAreaControllerRef
     read pm_GetdsEditionsRef;
     {* Ссылка на "БОФ редакции документа" }
   property dsOutgoingLinksFromPart: IdsDocumentList
     read pm_GetDsOutgoingLinksFromPart;
     {* БОФ ссылок из фрагмента (респондентов) }
   property dsOutgoingLinksFromPartRef: IvcmViewAreaControllerRef
     read pm_GetdsOutgoingLinksFromPartRef;
     {* Ссылка на "БОФ ссылок из фрагмента (респондентов)" }
  // Методы преобразования к реализуемым интерфейсам
   function As_IucpDocumentWithContents: IucpDocumentWithContents;
   function As_InsWarningGenerator: InsWarningGenerator;
   function As_InsWarningLocker: InsWarningLocker;
   function As_IucpBaseSearchSupportQuery: IucpBaseSearchSupportQuery;
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
   function pm_GetDsWarningRef: IvcmFormDataSourceRef;
   function pm_GetDsIncomingLinksToPartRef: IvcmFormDataSourceRef;
   function pm_GetDsEditionsRef: IvcmFormDataSourceRef;
   function pm_GetDsOutgoingLinksFromPartRef: IvcmFormDataSourceRef;
   function pm_GetDsContentsRef: IvcmFormDataSourceRef;
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
     read pm_GetDsWarningRef;
     {* Ссылка на "БОФ предупреждения" }
   property dsIncomingLinksToPartRef: IvcmFormDataSourceRef
     read pm_GetDsIncomingLinksToPartRef;
     {* Ссылка на "БОФ ссылок на фрагмент (корреспондентов)" }
   property dsEditionsRef: IvcmFormDataSourceRef
     read pm_GetDsEditionsRef;
     {* Ссылка на "БОФ редакции документа" }
   property dsOutgoingLinksFromPartRef: IvcmFormDataSourceRef
     read pm_GetDsOutgoingLinksFromPartRef;
     {* Ссылка на "БОФ ссылок из фрагмента (респондентов)" }
   property dsContentsRef: IvcmFormDataSourceRef
     read pm_GetDsContentsRef;
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
{$IfEnd} //not Admin AND not Monitorings

implementation

end.