unit GblAdapter; {$Z4}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapter/GblAdapter.pas"
// Delphi интерфейсы для адаптера (.pas)
// Generated from UML model, root element: <<AdapterTargetUnion::Category>> garant6x::GblAdapter
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

interface

uses
	SysConst
	, SysUtils
	, Windows
	, l3Base
	, l3ProtoObject
	, Classes
	, ActiveX
	, IOUnit
	, BaseTypesUnit
	, ContextSearchSupportUnit
	, BaseTreeSupportUnit
	, SearchDefinesUnit
	, DynamicTreeDefinesUnit
	, FiltersUnit
	, ExternalObjectUnit
	, DynamicTreeUnit
	, UnderControlUnit
	, ProgressIndicatorSupportUnit
	, LoggingUnit
	, FoldersUnit
	, SettingsUnit
	, ExternalOperationUnit
	, DocumentUnit
	, SearchProgressIndicatorUnit
	, DynamicDocListUnit
	, NotifyUnit
	, SecurityUnit
	, SearchUnit
	, DocTreeUnit
	, BannerUnit
	, PrefixTreeUnit
	, ProfileUnit
	, StartUnit
	, ConsultingUnit
	, ComplectUnit
	, InternetSupportUnit
	, MonitoringUnit
	, ChatInterfacesUnit
	, IntegrationProjectUnit
	, TipsUnit
	, PrimeUnit
	, PharmFirmListUnit
	, UserJournalUnit
	, MainMenuUnit;

const
	CLibraryVersion: LongWord = 212;
	CLibraryName: PAnsiChar = 'GblAdapter.dll';

{$IF DEFINED(UseNoServerExceptionEvent)}
var
	g_NoServerExceptionEvent: procedure (var a_Exception: Exception) = nil;
{$IFEND} // UseNoServerExceptionEvent

type
	// Системные исключения.
	ELoadLibraryError = class (Exception); // используется при загрузке dll; 
	EGetProcAddressError = class (Exception); // используется при вызове операции dll; 
	EStdException = class (Exception); // используется при мапинге неизвестных Sdt исключений; 
	ECorbaException = class (Exception); // используется при мапинге неизвестных CORBA исключений;
	EWrongVersion = class (Exception); // выбрасывается в случае не соответствия версии клиента и dll
	EUnknownFactoryKey = class (Exception); // выбрасывается в случае, если нет ни одного зарегестрированного серванта c заданным ключом для запрашиваемого интерфейса
	
	ECantFindServer = class (Exception); // client-server DLL can't find corresponding server
	
	// exported root factory interface
	IGblAdapterRoot = interface (IInterface) ['{F11331C9-6903-4F59-9876-78B3CCEE3209}']
		procedure MakeStream (
			out aRet {: IStream}
		); stdcall; overload;

		procedure MakeStream (
			const aPath: PAnsiChar;
			out aRet {: IStream}
		); stdcall; overload;

		procedure AllocString (
			aMaximum: Longword;
			out aRet {: IString}
		); stdcall; overload;

		procedure MakeString (
			const aStr: PAnsiChar;
			out aRet {: IString}
		); stdcall; overload;

		procedure MakeActiveIntervalList (out aRet {: IActiveIntervalList}); stdcall;

		procedure MakeAssemblyInfo (
			out aRet {: IAssemblyInfo}
		); stdcall; overload;

		procedure MakeAttributeInfo (
			const aTag: TAttributeTag;
			out aRet {: IAttributeInfo}
		); stdcall; overload;

		procedure MakeAttributeList (out aRet {: IAttributeList}); stdcall;

		procedure MakeAttributesHelper (
			out aRet {: IAttributesHelper}
		); stdcall; overload;

		procedure MakeAuthorization (
			out aRet {: IAuthorization}
		); stdcall; overload;

		procedure MakeBlocksFilter (
			out aRet {: IBlocksFilter}
		); stdcall; overload;

		procedure MakeBookmarkList (out aRet {: IBookmarkList}); stdcall;

		procedure MakeChatManager (
			out aRet {: IChatManager}
		); stdcall; overload;

		procedure MakeCommentsParaList (out aRet {: ICommentsParaList}); stdcall;

		procedure MakeCommon (
			out aRet {: ICommon}
		); stdcall; overload;

		procedure MakeComplectInfo (
			out aRet {: IComplectInfo}
		); stdcall; overload;

		procedure MakeComponentManager (
			out aRet {: IComponentManager}
		); stdcall; overload;

		procedure MakeConfiguration (
			aId: Longint;
			const aName: IString;
			const aHint: IString;
			aReadonly: Bytebool;
			out aRet {: IConfiguration}
		); stdcall; overload;

		procedure MakeConfigurationManager (
			out aRet {: IConfigurationManager}
		); stdcall; overload;

		procedure MakeConfigurations (out aRet {: IConfigurations}); stdcall;

		procedure MakeConsultationManager (
			out aRet {: IConsultationManager}
		); stdcall; overload;

		procedure MakeConsultingTemplateInfo (
			out aRet {: IConsultingTemplateInfo}
		); stdcall; overload;

		procedure MakeContextFilter (
			out aRet {: IContextFilter}
		); stdcall; overload;

		procedure MakeContextList (out aRet {: IContextList}); stdcall;

		procedure MakeContextValueList (out aRet {: IContextValueList}); stdcall;

		procedure MakeContextWordList (out aRet {: IContextWordList}); stdcall;

		procedure MakeControlManager (
			out aRet {: IControlManager}
		); stdcall; overload;

		procedure MakeControlledObjects (out aRet {: IControlledObjects}); stdcall;

		procedure MakeCountryFilter (
			const aCountry: INodeBase;
			out aRet {: ICountryFilter}
		); stdcall; overload;

		procedure MakeCountryFilter (
			out aRet {: ICountryFilter}
		); stdcall; overload;

		procedure MakeCutToLeafCountFilter (
			aLeafCount: Longword;
			out aRet {: ICutToLeafCountFilter}
		); stdcall; overload;

		procedure MakeCutToLeafCountFilter (
			out aRet {: ICutToLeafCountFilter}
		); stdcall; overload;

		procedure MakeDateValueList (out aRet {: IDateValueList}); stdcall;

		procedure MakeDecisionsArchiveSupport (
			out aRet {: IDecisionsArchiveSupport}
		); stdcall; overload;

		procedure MakeDefaultValuesChangesIndicator (
			aState: TDefaultValuesChangesState;
			const aConfiguration: IConfiguration;
			out aRet {: IDefaultValuesChangesIndicator}
		); stdcall; overload;

		procedure MakeDiffDocDataProvider (
			const aLeft: IDocument;
			const aRight: IDocument;
			out aRet {: IDiffDocDataProvider}
		); stdcall; overload;

		procedure MakeDiffDocParaList (out aRet {: IDiffDocParaList}); stdcall;

		procedure MakeDocListFactory (
			out aRet {: IDocListFactory}
		); stdcall; overload;

		procedure MakeDocNodeFilter (
			out aRet {: IDocNodeFilter}
		); stdcall; overload;

		procedure MakeDocPointList (out aRet {: IDocPointList}); stdcall;

		procedure MakeDocumentState (
			const aSourceDoc: IDocument;
			out aRet {: IDocumentState}
		); stdcall; overload;

		procedure MakeDocumentTextProviderDescriptorList (out aRet {: IDocumentTextProviderDescriptorList}); stdcall;

		procedure MakeDocumentTextProviderList (out aRet {: IDocumentTextProviderList}); stdcall;

		procedure MakeDynList (
			aKey: TSpecialListKey;
			out aRet {: IDynList}
		); stdcall; overload;

		procedure MakeEstimation (
			out aRet {: IEstimation}
		); stdcall; overload;

		procedure MakeExternalObjectDataList (out aRet {: IExternalObjectDataList}); stdcall;

		procedure MakeExternalOperation (
			aId: TObjectId;
			out aRet {: IExternalOperation}
		); stdcall; overload;

		procedure MakeFilterList (out aRet {: IFilterList}); stdcall;

		procedure MakeFiltered (out aRet {: IFiltered}); stdcall;

		procedure MakeFiltersFromQuery (out aRet {: IFiltersFromQuery}); stdcall;

		procedure MakeFiltersManager (
			out aRet {: IFiltersManager}
		); stdcall; overload;

		procedure MakeFindPositionList (out aRet {: IFindPositionList}); stdcall;

		procedure MakeFolders (
			out aRet {: IFolders}
		); stdcall; overload;

		procedure MakeFragmentList (out aRet {: IFragmentList}); stdcall;

		procedure MakeHighlightPositionList (out aRet {: IHighlightPositionList}); stdcall;

		procedure MakeInpharmFilter (
			out aRet {: IInpharmFilter}
		); stdcall; overload;

		procedure MakeIntegration (
			out aRet {: IIntegration}
		); stdcall; overload;

		procedure MakeInternetSupport (
			out aRet {: IInternetSupport}
		); stdcall; overload;

		procedure MakeJournalBookmarkList (out aRet {: IJournalBookmarkList}); stdcall;

		procedure MakeKeysList (out aRet {: IKeysList}); stdcall;

		procedure MakeLanguagesList (out aRet {: ILanguagesList}); stdcall;

		procedure MakeLayerFilter (
			out aRet {: ILayerFilter}
		); stdcall; overload;

		procedure MakeLayerIdList (out aRet {: ILayerIdList}); stdcall;

		procedure MakeLogEventData (
			out aRet {: ILogEventData}
		); stdcall; overload;

		procedure MakeLogManager (
			out aRet {: ILogManager}
		); stdcall; overload;

		procedure MakeMainMenu (
			out aRet {: IMainMenu}
		); stdcall; overload;

		procedure MakeMessages (out aRet {: IMessages}); stdcall;

		procedure MakeMessagesManager (
			out aRet {: IMessagesManager}
		); stdcall; overload;

		procedure MakeMonitoring (
			out aRet {: IMonitoring}
		); stdcall; overload;

		procedure MakeNode (
			out aRet {: INode}
		); stdcall; overload;

		procedure MakeNodeBase (
			const aKey: PAnsiChar;
			out aRet {: INodeBase}
		); stdcall; overload;

		procedure MakeNodeIdList (out aRet {: INodeIdList}); stdcall;

		procedure MakeNodeIndexPath (out aRet {: INodeIndexPath}); stdcall;

		procedure MakeNodeIterator (
			out aRet {: INodeIterator}
		); stdcall; overload;

		procedure MakeNodeValueList (out aRet {: INodeValueList}); stdcall;

		procedure MakeNodesClipboard (
			out aRet {: INodesClipboard}
		); stdcall; overload;

		procedure MakeNotSureIntervalList (out aRet {: INotSureIntervalList}); stdcall;

		procedure MakeNotifyManager (
			out aRet {: INotifyManager}
		); stdcall; overload;

		procedure MakeOperationList (out aRet {: IOperationList}); stdcall;

		procedure MakeParasList (out aRet {: IParasList}); stdcall;

		procedure MakePermanentSettingsManager (
			out aRet {: IPermanentSettingsManager}
		); stdcall; overload;

		procedure MakePositionList (out aRet {: IPositionList}); stdcall;

		procedure MakePrefixNode (
			out aRet {: IPrefixNode}
		); stdcall; overload;

		procedure GetContractDataPrimeContractData (
			const aQuery: IQuery;
			out aRet {: IPrimeContractData}
		); stdcall; overload;

		procedure MakePrimeList (out aRet {: IPrimeList}); stdcall;

		procedure MakePrimeManager (
			out aRet {: IPrimeManager}
		); stdcall; overload;

		procedure MakePrimeSettingsManager (
			out aRet {: IPrimeSettingsManager}
		); stdcall; overload;

		procedure MakePropertyStringIDList (out aRet {: IPropertyStringIDList}); stdcall;

		procedure MakeQuery (
			aType: TQueryType;
			out aRet {: IQuery}
		); stdcall; overload;

		procedure MakeQueryAttributeList (out aRet {: IQueryAttributeList}); stdcall;

		procedure CreateQueryCardInfo (
			const aKey: PAnsiChar;
			out aRet {: IQueryCardInfo}
		); stdcall; overload;

		procedure MakeQueryContextAttribute (
			const aAttributeTag: TAttributeTag;
			out aRet {: IQueryContextAttribute}
		); stdcall; overload;

		procedure MakeQueryDateAttribute (
			const aAttributeTag: TAttributeTag;
			out aRet {: IQueryDateAttribute}
		); stdcall; overload;

		procedure MakeQueryList (out aRet {: IQueryList}); stdcall;

		procedure MakeQueryNodeAttribute (
			const aAttributeTag: TAttributeTag;
			out aRet {: IQueryNodeAttribute}
		); stdcall; overload;

		procedure MakeQueryPhoneNumberAttribute (
			const aAttributeTag: TAttributeTag;
			out aRet {: IQueryPhoneNumberAttribute}
		); stdcall; overload;

		procedure MakeRedactionInfoList (out aRet {: IRedactionInfoList}); stdcall;

		procedure MakeRedactionSourceDocumentInfoList (out aRet {: IRedactionSourceDocumentInfoList}); stdcall;

		procedure MakeSearch (
			out aRet {: ISearch}
		); stdcall; overload;

		procedure MakeSearchEntity (
			aResultType: TSearchResultType;
			aDocumentCount: Cardinal;
			aEntryCount: Cardinal;
			aEditionCount: Cardinal;
			out aRet {: ISearchEntity}
		); stdcall; overload;

		procedure MakeSectionItemList (out aRet {: ISectionItemList}); stdcall;

		procedure MakeSortFilter (
			out aRet {: ISortFilter}
		); stdcall; overload;

		procedure MakeSortTypes (out aRet {: ISortTypes}); stdcall;

		procedure MakeStopWatch (
			const aContext: PAnsiChar;
			out aRet {: IStopWatch}
		); stdcall; overload;

		procedure MakeStopWatchEx (
			const aId: PAnsiChar;
			const aContext: PAnsiChar;
			out aRet {: IStopWatchEx}
		); stdcall; overload;

		procedure MakeStringList (out aRet {: IStringList}); stdcall;

		procedure MakeSubList (out aRet {: ISubList}); stdcall;

		procedure MakeTipsManager (
			out aRet {: ITipsManager}
		); stdcall; overload;

		procedure MakeTrimFilter (
			out aRet {: ITrimFilter}
		); stdcall; overload;

		procedure MakeTrimLeafFilter (
			out aRet {: ITrimLeafFilter}
		); stdcall; overload;

		procedure MakeUidList (out aRet {: IUidList}); stdcall;

		procedure MakeUserFilter (
			out aRet {: IUserFilter}
		); stdcall; overload;

		procedure MakeUserJournal (
			out aRet {: IUserJournal}
		); stdcall; overload;

		procedure MakeUserManager (
			out aRet {: IUserManager}
		); stdcall; overload;

		procedure MakeUserProfile (
			out aRet {: IUserProfile}
		); stdcall; overload;

		procedure MakeVariant (
			out aRet {: IVariant}
		); stdcall; overload;

		procedure MakeBoolVariant (
			aValue: Bytebool;
			out aRet {: IVariant}
		); stdcall; overload;

		procedure MakeLongVariant (
			aValue: Longint;
			out aRet {: IVariant}
		); stdcall; overload;

		procedure MakeObjectVariant (
			const aValue: IUnknown;
			out aRet {: IVariant}
		); stdcall; overload;

		procedure MakeStringVariant (
			const aValue: IString;
			out aRet {: IVariant}
		); stdcall; overload;

		procedure MakeVariantsForDocFilter (
			aDocId: Longword;
			out aRet {: IVariantsForDocFilter}
		); stdcall; overload;

		procedure MakeVariantsForDocFilter (
			out aRet {: IVariantsForDocFilter}
		); stdcall; overload;

		procedure MakeVisualRepresentationList (out aRet {: IVisualRepresentationList}); stdcall;

	end;

	// DLL wrapper interface
	IGblAdapterDll = interface (IInterface)
		function GetVersion (): LongWord;

		function MakeStream (
		) : IStream; overload;

		function MakeStream (
			const aPath: PAnsiChar
		) : IStream; overload;

		function AllocString (
			aMaximum: Longword
		) : IString; overload;

		function MakeString (
			const aStr: PAnsiChar
		) : IString; overload;

		function MakeActiveIntervalList () : IActiveIntervalList;

		function MakeAssemblyInfo (
		) : IAssemblyInfo; overload;

		function MakeAttributeInfo (
			const aTag: TAttributeTag
		) : IAttributeInfo; overload;

		function MakeAttributeList () : IAttributeList;

		function MakeAttributesHelper (
		) : IAttributesHelper; overload;

		function MakeAuthorization (
		) : IAuthorization; overload;

		function MakeBlocksFilter (
		) : IBlocksFilter; overload;

		function MakeBookmarkList () : IBookmarkList;

		function MakeChatManager (
		) : IChatManager; overload;

		function MakeCommentsParaList () : ICommentsParaList;

		function MakeCommon (
		) : ICommon; overload;

		function MakeComplectInfo (
		) : IComplectInfo; overload;

		function MakeComponentManager (
		) : IComponentManager; overload;

		function MakeConfiguration (
			aId: Longint;
			const aName: IString;
			const aHint: IString;
			aReadonly: Bytebool
		) : IConfiguration; overload;

		function MakeConfigurationManager (
		) : IConfigurationManager; overload;

		function MakeConfigurations () : IConfigurations;

		function MakeConsultationManager (
		) : IConsultationManager; overload;

		function MakeConsultingTemplateInfo (
		) : IConsultingTemplateInfo; overload;

		function MakeContextFilter (
		) : IContextFilter; overload;

		function MakeContextList () : IContextList;

		function MakeContextValueList () : IContextValueList;

		function MakeContextWordList () : IContextWordList;

		function MakeControlManager (
		) : IControlManager; overload;

		function MakeControlledObjects () : IControlledObjects;

		function MakeCountryFilter (
			const aCountry: INodeBase
		) : ICountryFilter; overload;

		function MakeCountryFilter (
		) : ICountryFilter; overload;

		function MakeCutToLeafCountFilter (
			aLeafCount: Longword
		) : ICutToLeafCountFilter; overload;

		function MakeCutToLeafCountFilter (
		) : ICutToLeafCountFilter; overload;

		function MakeDateValueList () : IDateValueList;

		function MakeDecisionsArchiveSupport (
		) : IDecisionsArchiveSupport; overload;

		function MakeDefaultValuesChangesIndicator (
			aState: TDefaultValuesChangesState;
			const aConfiguration: IConfiguration
		) : IDefaultValuesChangesIndicator; overload;

		function MakeDiffDocDataProvider (
			const aLeft: IDocument;
			const aRight: IDocument
		) : IDiffDocDataProvider; overload;

		function MakeDiffDocParaList () : IDiffDocParaList;

		function MakeDocListFactory (
		) : IDocListFactory; overload;

		function MakeDocNodeFilter (
		) : IDocNodeFilter; overload;

		function MakeDocPointList () : IDocPointList;

		function MakeDocumentState (
			const aSourceDoc: IDocument
		) : IDocumentState; overload;

		function MakeDocumentTextProviderDescriptorList () : IDocumentTextProviderDescriptorList;

		function MakeDocumentTextProviderList () : IDocumentTextProviderList;

		function MakeDynList (
			aKey: TSpecialListKey
		) : IDynList; overload;

		function MakeEstimation (
		) : IEstimation; overload;

		function MakeExternalObjectDataList () : IExternalObjectDataList;

		function MakeExternalOperation (
			aId: TObjectId
		) : IExternalOperation; overload;

		function MakeFilterList () : IFilterList;

		function MakeFiltered () : IFiltered;

		function MakeFiltersFromQuery () : IFiltersFromQuery;

		function MakeFiltersManager (
		) : IFiltersManager; overload;

		function MakeFindPositionList () : IFindPositionList;

		function MakeFolders (
		) : IFolders; overload;

		function MakeFragmentList () : IFragmentList;

		function MakeHighlightPositionList () : IHighlightPositionList;

		function MakeInpharmFilter (
		) : IInpharmFilter; overload;

		function MakeIntegration (
		) : IIntegration; overload;

		function MakeInternetSupport (
		) : IInternetSupport; overload;

		function MakeJournalBookmarkList () : IJournalBookmarkList;

		function MakeKeysList () : IKeysList;

		function MakeLanguagesList () : ILanguagesList;

		function MakeLayerFilter (
		) : ILayerFilter; overload;

		function MakeLayerIdList () : ILayerIdList;

		function MakeLogEventData (
		) : ILogEventData; overload;

		function MakeLogManager (
		) : ILogManager; overload;

		function MakeMainMenu (
		) : IMainMenu; overload;

		function MakeMessages () : IMessages;

		function MakeMessagesManager (
		) : IMessagesManager; overload;

		function MakeMonitoring (
		) : IMonitoring; overload;

		function MakeNode (
		) : INode; overload;

		function MakeNodeBase (
			const aKey: PAnsiChar
		) : INodeBase; overload;

		function MakeNodeIdList () : INodeIdList;

		function MakeNodeIndexPath () : INodeIndexPath;

		function MakeNodeIterator (
		) : INodeIterator; overload;

		function MakeNodeValueList () : INodeValueList;

		function MakeNodesClipboard (
		) : INodesClipboard; overload;

		function MakeNotSureIntervalList () : INotSureIntervalList;

		function MakeNotifyManager (
		) : INotifyManager; overload;

		function MakeOperationList () : IOperationList;

		function MakeParasList () : IParasList;

		function MakePermanentSettingsManager (
		) : IPermanentSettingsManager; overload;

		function MakePositionList () : IPositionList;

		function MakePrefixNode (
		) : IPrefixNode; overload;

		function GetContractDataPrimeContractData (
			const aQuery: IQuery
		) : IPrimeContractData; overload;

		function MakePrimeList () : IPrimeList;

		function MakePrimeManager (
		) : IPrimeManager; overload;

		function MakePrimeSettingsManager (
		) : IPrimeSettingsManager; overload;

		function MakePropertyStringIDList () : IPropertyStringIDList;

		function MakeQuery (
			aType: TQueryType
		) : IQuery; overload;

		function MakeQueryAttributeList () : IQueryAttributeList;

		function CreateQueryCardInfo (
			const aKey: PAnsiChar
		) : IQueryCardInfo; overload;

		function MakeQueryContextAttribute (
			const aAttributeTag: TAttributeTag
		) : IQueryContextAttribute; overload;

		function MakeQueryDateAttribute (
			const aAttributeTag: TAttributeTag
		) : IQueryDateAttribute; overload;

		function MakeQueryList () : IQueryList;

		function MakeQueryNodeAttribute (
			const aAttributeTag: TAttributeTag
		) : IQueryNodeAttribute; overload;

		function MakeQueryPhoneNumberAttribute (
			const aAttributeTag: TAttributeTag
		) : IQueryPhoneNumberAttribute; overload;

		function MakeRedactionInfoList () : IRedactionInfoList;

		function MakeRedactionSourceDocumentInfoList () : IRedactionSourceDocumentInfoList;

		function MakeSearch (
		) : ISearch; overload;

		function MakeSearchEntity (
			aResultType: TSearchResultType;
			aDocumentCount: Cardinal;
			aEntryCount: Cardinal;
			aEditionCount: Cardinal
		) : ISearchEntity; overload;

		function MakeSectionItemList () : ISectionItemList;

		function MakeSortFilter (
		) : ISortFilter; overload;

		function MakeSortTypes () : ISortTypes;

		function MakeStopWatch (
			const aContext: PAnsiChar
		) : IStopWatch; overload;

		function MakeStopWatchEx (
			const aId: PAnsiChar;
			const aContext: PAnsiChar
		) : IStopWatchEx; overload;

		function MakeStringList () : IStringList;

		function MakeSubList () : ISubList;

		function MakeTipsManager (
		) : ITipsManager; overload;

		function MakeTrimFilter (
		) : ITrimFilter; overload;

		function MakeTrimLeafFilter (
		) : ITrimLeafFilter; overload;

		function MakeUidList () : IUidList;

		function MakeUserFilter (
		) : IUserFilter; overload;

		function MakeUserJournal (
		) : IUserJournal; overload;

		function MakeUserManager (
		) : IUserManager; overload;

		function MakeUserProfile (
		) : IUserProfile; overload;

		function MakeVariant (
		) : IVariant; overload;

		function MakeBoolVariant (
			aValue: Bytebool
		) : IVariant; overload;

		function MakeLongVariant (
			aValue: Longint
		) : IVariant; overload;

		function MakeObjectVariant (
			const aValue: IUnknown
		) : IVariant; overload;

		function MakeStringVariant (
			const aValue: IString
		) : IVariant; overload;

		function MakeVariantsForDocFilter (
			aDocId: Longword
		) : IVariantsForDocFilter; overload;

		function MakeVariantsForDocFilter (
		) : IVariantsForDocFilter; overload;

		function MakeVisualRepresentationList () : IVisualRepresentationList;


	end;

	// DLL wrapper impl
	TGblAdapterDll = class (Tl3ProtoObject, IGblAdapterDll)
	private
		f_HModule: HModule;
		f_DllRoot: IGblAdapterRoot;

	private
		procedure DllLoad;
		procedure DllFree;
		procedure RootInit(aClientVersion: LongWord); overload;
		procedure RootInit(aClientVersion: LongWord; const aLocale: PAnsiChar); overload;
		procedure RootDone;
		function GetRoot: IGblAdapterRoot;
	
	protected
		procedure Cleanup; override;

	public
		constructor Create (aClientVersion: LongWord); reintroduce; overload;
		constructor Create (aClientVersion: LongWord; const aLocale: PAnsiChar); reintroduce; overload;

		class function Make(): IGblAdapterDll; overload; // can raise ECantFindServer;
		class function Make(const aLocale: PAnsiChar): IGblAdapterDll; overload; // can raise ECantFindServer;

		function GetVersion: LongWord;
	public
		function MakeStream (
		) : IStream; overload;

		function MakeStream (
			const aPath: PAnsiChar
		) : IStream; overload;

		function AllocString (
			aMaximum: Longword
		) : IString; overload;

		function MakeString (
			const aStr: PAnsiChar
		) : IString; overload;

		function MakeActiveIntervalList () : IActiveIntervalList;

		function MakeAssemblyInfo (
		) : IAssemblyInfo; overload;

		function MakeAttributeInfo (
			const aTag: TAttributeTag
		) : IAttributeInfo; overload;

		function MakeAttributeList () : IAttributeList;

		function MakeAttributesHelper (
		) : IAttributesHelper; overload;

		function MakeAuthorization (
		) : IAuthorization; overload;

		function MakeBlocksFilter (
		) : IBlocksFilter; overload;

		function MakeBookmarkList () : IBookmarkList;

		function MakeChatManager (
		) : IChatManager; overload;

		function MakeCommentsParaList () : ICommentsParaList;

		function MakeCommon (
		) : ICommon; overload;

		function MakeComplectInfo (
		) : IComplectInfo; overload;

		function MakeComponentManager (
		) : IComponentManager; overload;

		function MakeConfiguration (
			aId: Longint;
			const aName: IString;
			const aHint: IString;
			aReadonly: Bytebool
		) : IConfiguration; overload;

		function MakeConfigurationManager (
		) : IConfigurationManager; overload;

		function MakeConfigurations () : IConfigurations;

		function MakeConsultationManager (
		) : IConsultationManager; overload;

		function MakeConsultingTemplateInfo (
		) : IConsultingTemplateInfo; overload;

		function MakeContextFilter (
		) : IContextFilter; overload;

		function MakeContextList () : IContextList;

		function MakeContextValueList () : IContextValueList;

		function MakeContextWordList () : IContextWordList;

		function MakeControlManager (
		) : IControlManager; overload;

		function MakeControlledObjects () : IControlledObjects;

		function MakeCountryFilter (
			const aCountry: INodeBase
		) : ICountryFilter; overload;

		function MakeCountryFilter (
		) : ICountryFilter; overload;

		function MakeCutToLeafCountFilter (
			aLeafCount: Longword
		) : ICutToLeafCountFilter; overload;

		function MakeCutToLeafCountFilter (
		) : ICutToLeafCountFilter; overload;

		function MakeDateValueList () : IDateValueList;

		function MakeDecisionsArchiveSupport (
		) : IDecisionsArchiveSupport; overload;

		function MakeDefaultValuesChangesIndicator (
			aState: TDefaultValuesChangesState;
			const aConfiguration: IConfiguration
		) : IDefaultValuesChangesIndicator; overload;

		function MakeDiffDocDataProvider (
			const aLeft: IDocument;
			const aRight: IDocument
		) : IDiffDocDataProvider; overload;

		function MakeDiffDocParaList () : IDiffDocParaList;

		function MakeDocListFactory (
		) : IDocListFactory; overload;

		function MakeDocNodeFilter (
		) : IDocNodeFilter; overload;

		function MakeDocPointList () : IDocPointList;

		function MakeDocumentState (
			const aSourceDoc: IDocument
		) : IDocumentState; overload;

		function MakeDocumentTextProviderDescriptorList () : IDocumentTextProviderDescriptorList;

		function MakeDocumentTextProviderList () : IDocumentTextProviderList;

		function MakeDynList (
			aKey: TSpecialListKey
		) : IDynList; overload;

		function MakeEstimation (
		) : IEstimation; overload;

		function MakeExternalObjectDataList () : IExternalObjectDataList;

		function MakeExternalOperation (
			aId: TObjectId
		) : IExternalOperation; overload;

		function MakeFilterList () : IFilterList;

		function MakeFiltered () : IFiltered;

		function MakeFiltersFromQuery () : IFiltersFromQuery;

		function MakeFiltersManager (
		) : IFiltersManager; overload;

		function MakeFindPositionList () : IFindPositionList;

		function MakeFolders (
		) : IFolders; overload;

		function MakeFragmentList () : IFragmentList;

		function MakeHighlightPositionList () : IHighlightPositionList;

		function MakeInpharmFilter (
		) : IInpharmFilter; overload;

		function MakeIntegration (
		) : IIntegration; overload;

		function MakeInternetSupport (
		) : IInternetSupport; overload;

		function MakeJournalBookmarkList () : IJournalBookmarkList;

		function MakeKeysList () : IKeysList;

		function MakeLanguagesList () : ILanguagesList;

		function MakeLayerFilter (
		) : ILayerFilter; overload;

		function MakeLayerIdList () : ILayerIdList;

		function MakeLogEventData (
		) : ILogEventData; overload;

		function MakeLogManager (
		) : ILogManager; overload;

		function MakeMainMenu (
		) : IMainMenu; overload;

		function MakeMessages () : IMessages;

		function MakeMessagesManager (
		) : IMessagesManager; overload;

		function MakeMonitoring (
		) : IMonitoring; overload;

		function MakeNode (
		) : INode; overload;

		function MakeNodeBase (
			const aKey: PAnsiChar
		) : INodeBase; overload;

		function MakeNodeIdList () : INodeIdList;

		function MakeNodeIndexPath () : INodeIndexPath;

		function MakeNodeIterator (
		) : INodeIterator; overload;

		function MakeNodeValueList () : INodeValueList;

		function MakeNodesClipboard (
		) : INodesClipboard; overload;

		function MakeNotSureIntervalList () : INotSureIntervalList;

		function MakeNotifyManager (
		) : INotifyManager; overload;

		function MakeOperationList () : IOperationList;

		function MakeParasList () : IParasList;

		function MakePermanentSettingsManager (
		) : IPermanentSettingsManager; overload;

		function MakePositionList () : IPositionList;

		function MakePrefixNode (
		) : IPrefixNode; overload;

		function GetContractDataPrimeContractData (
			const aQuery: IQuery
		) : IPrimeContractData; overload;

		function MakePrimeList () : IPrimeList;

		function MakePrimeManager (
		) : IPrimeManager; overload;

		function MakePrimeSettingsManager (
		) : IPrimeSettingsManager; overload;

		function MakePropertyStringIDList () : IPropertyStringIDList;

		function MakeQuery (
			aType: TQueryType
		) : IQuery; overload;

		function MakeQueryAttributeList () : IQueryAttributeList;

		function CreateQueryCardInfo (
			const aKey: PAnsiChar
		) : IQueryCardInfo; overload;

		function MakeQueryContextAttribute (
			const aAttributeTag: TAttributeTag
		) : IQueryContextAttribute; overload;

		function MakeQueryDateAttribute (
			const aAttributeTag: TAttributeTag
		) : IQueryDateAttribute; overload;

		function MakeQueryList () : IQueryList;

		function MakeQueryNodeAttribute (
			const aAttributeTag: TAttributeTag
		) : IQueryNodeAttribute; overload;

		function MakeQueryPhoneNumberAttribute (
			const aAttributeTag: TAttributeTag
		) : IQueryPhoneNumberAttribute; overload;

		function MakeRedactionInfoList () : IRedactionInfoList;

		function MakeRedactionSourceDocumentInfoList () : IRedactionSourceDocumentInfoList;

		function MakeSearch (
		) : ISearch; overload;

		function MakeSearchEntity (
			aResultType: TSearchResultType;
			aDocumentCount: Cardinal;
			aEntryCount: Cardinal;
			aEditionCount: Cardinal
		) : ISearchEntity; overload;

		function MakeSectionItemList () : ISectionItemList;

		function MakeSortFilter (
		) : ISortFilter; overload;

		function MakeSortTypes () : ISortTypes;

		function MakeStopWatch (
			const aContext: PAnsiChar
		) : IStopWatch; overload;

		function MakeStopWatchEx (
			const aId: PAnsiChar;
			const aContext: PAnsiChar
		) : IStopWatchEx; overload;

		function MakeStringList () : IStringList;

		function MakeSubList () : ISubList;

		function MakeTipsManager (
		) : ITipsManager; overload;

		function MakeTrimFilter (
		) : ITrimFilter; overload;

		function MakeTrimLeafFilter (
		) : ITrimLeafFilter; overload;

		function MakeUidList () : IUidList;

		function MakeUserFilter (
		) : IUserFilter; overload;

		function MakeUserJournal (
		) : IUserJournal; overload;

		function MakeUserManager (
		) : IUserManager; overload;

		function MakeUserProfile (
		) : IUserProfile; overload;

		function MakeVariant (
		) : IVariant; overload;

		function MakeBoolVariant (
			aValue: Bytebool
		) : IVariant; overload;

		function MakeLongVariant (
			aValue: Longint
		) : IVariant; overload;

		function MakeObjectVariant (
			const aValue: IUnknown
		) : IVariant; overload;

		function MakeStringVariant (
			const aValue: IString
		) : IVariant; overload;

		function MakeVariantsForDocFilter (
			aDocId: Longword
		) : IVariantsForDocFilter; overload;

		function MakeVariantsForDocFilter (
		) : IVariantsForDocFilter; overload;

		function MakeVisualRepresentationList () : IVisualRepresentationList;

	end;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
implementation
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

var
	g_GblAdapterDll: TGblAdapterDll = nil;

	function TGblAdapterDll.MakeStream (
	) : IStream;
	var
		aRes: IStream;
	begin
		GetRoot().MakeStream(aRes);
		Result := aRes;
	end;

	function TGblAdapterDll.MakeStream (
		const aPath: PAnsiChar
	) : IStream;
	var
		aRes: IStream;
	begin
		GetRoot().MakeStream(aPath, aRes);
		Result := aRes;
	end;

	function TGblAdapterDll.MakeString (
		const aStr: PAnsiChar
	) : IString;
	var
		aRes: IString;
	begin
		GetRoot().MakeString(aStr, aRes);
		Result := aRes;
	end;

	function TGblAdapterDll.AllocString (
		aMaximum: Longword
	) : IString;
	var
		aRes: IString;
	begin
		GetRoot().AllocString(aMaximum, aRes);
		Result := aRes;
	end;

	function TGblAdapterDll.MakeActiveIntervalList () : IActiveIntervalList;
	var
		aRes: IActiveIntervalList;
	begin
		GetRoot().MakeActiveIntervalList(aRes);
		Result := aRes;
	end;

	function TGblAdapterDll.MakeAssemblyInfo (
	) : IAssemblyInfo;
	var
		aRes: IAssemblyInfo;
	begin
		GetRoot().MakeAssemblyInfo(aRes);
		Result := aRes;
	end;

	function TGblAdapterDll.MakeAttributeInfo (
		const aTag: TAttributeTag
	) : IAttributeInfo;
	var
		aRes: IAttributeInfo;
	begin
		GetRoot().MakeAttributeInfo(aTag, aRes);
		Result := aRes;
	end;

	function TGblAdapterDll.MakeAttributeList () : IAttributeList;
	var
		aRes: IAttributeList;
	begin
		GetRoot().MakeAttributeList(aRes);
		Result := aRes;
	end;

	function TGblAdapterDll.MakeAttributesHelper (
	) : IAttributesHelper;
	var
		aRes: IAttributesHelper;
	begin
		GetRoot().MakeAttributesHelper(aRes);
		Result := aRes;
	end;

	function TGblAdapterDll.MakeAuthorization (
	) : IAuthorization;
	var
		aRes: IAuthorization;
	begin
		GetRoot().MakeAuthorization(aRes);
		Result := aRes;
	end;

	function TGblAdapterDll.MakeBlocksFilter (
	) : IBlocksFilter;
	var
		aRes: IBlocksFilter;
	begin
		GetRoot().MakeBlocksFilter(aRes);
		Result := aRes;
	end;

	function TGblAdapterDll.MakeBookmarkList () : IBookmarkList;
	var
		aRes: IBookmarkList;
	begin
		GetRoot().MakeBookmarkList(aRes);
		Result := aRes;
	end;

	function TGblAdapterDll.MakeChatManager (
	) : IChatManager;
	var
		aRes: IChatManager;
	begin
		GetRoot().MakeChatManager(aRes);
		Result := aRes;
	end;

	function TGblAdapterDll.MakeCommentsParaList () : ICommentsParaList;
	var
		aRes: ICommentsParaList;
	begin
		GetRoot().MakeCommentsParaList(aRes);
		Result := aRes;
	end;

	function TGblAdapterDll.MakeCommon (
	) : ICommon;
	var
		aRes: ICommon;
	begin
		GetRoot().MakeCommon(aRes);
		Result := aRes;
	end;

	function TGblAdapterDll.MakeComplectInfo (
	) : IComplectInfo;
	var
		aRes: IComplectInfo;
	begin
		GetRoot().MakeComplectInfo(aRes);
		Result := aRes;
	end;

	function TGblAdapterDll.MakeComponentManager (
	) : IComponentManager;
	var
		aRes: IComponentManager;
	begin
		GetRoot().MakeComponentManager(aRes);
		Result := aRes;
	end;

	function TGblAdapterDll.MakeConfiguration (
		aId: Longint;
			const aName: IString;
			const aHint: IString;
			aReadonly: Bytebool
	) : IConfiguration;
	var
		aRes: IConfiguration;
	begin
		GetRoot().MakeConfiguration(aId, aName, aHint, aReadonly, aRes);
		Result := aRes;
	end;

	function TGblAdapterDll.MakeConfigurationManager (
	) : IConfigurationManager;
	var
		aRes: IConfigurationManager;
	begin
		GetRoot().MakeConfigurationManager(aRes);
		Result := aRes;
	end;

	function TGblAdapterDll.MakeConfigurations () : IConfigurations;
	var
		aRes: IConfigurations;
	begin
		GetRoot().MakeConfigurations(aRes);
		Result := aRes;
	end;

	function TGblAdapterDll.MakeConsultationManager (
	) : IConsultationManager;
	var
		aRes: IConsultationManager;
	begin
		GetRoot().MakeConsultationManager(aRes);
		Result := aRes;
	end;

	function TGblAdapterDll.MakeConsultingTemplateInfo (
	) : IConsultingTemplateInfo;
	var
		aRes: IConsultingTemplateInfo;
	begin
		GetRoot().MakeConsultingTemplateInfo(aRes);
		Result := aRes;
	end;

	function TGblAdapterDll.MakeContextFilter (
	) : IContextFilter;
	var
		aRes: IContextFilter;
	begin
		GetRoot().MakeContextFilter(aRes);
		Result := aRes;
	end;

	function TGblAdapterDll.MakeContextList () : IContextList;
	var
		aRes: IContextList;
	begin
		GetRoot().MakeContextList(aRes);
		Result := aRes;
	end;

	function TGblAdapterDll.MakeContextValueList () : IContextValueList;
	var
		aRes: IContextValueList;
	begin
		GetRoot().MakeContextValueList(aRes);
		Result := aRes;
	end;

	function TGblAdapterDll.MakeContextWordList () : IContextWordList;
	var
		aRes: IContextWordList;
	begin
		GetRoot().MakeContextWordList(aRes);
		Result := aRes;
	end;

	function TGblAdapterDll.MakeControlManager (
	) : IControlManager;
	var
		aRes: IControlManager;
	begin
		GetRoot().MakeControlManager(aRes);
		Result := aRes;
	end;

	function TGblAdapterDll.MakeControlledObjects () : IControlledObjects;
	var
		aRes: IControlledObjects;
	begin
		GetRoot().MakeControlledObjects(aRes);
		Result := aRes;
	end;

	function TGblAdapterDll.MakeCountryFilter (
		const aCountry: INodeBase
	) : ICountryFilter;
	var
		aRes: ICountryFilter;
	begin
		GetRoot().MakeCountryFilter(aCountry, aRes);
		Result := aRes;
	end;

	function TGblAdapterDll.MakeCountryFilter (
	) : ICountryFilter;
	var
		aRes: ICountryFilter;
	begin
		GetRoot().MakeCountryFilter(aRes);
		Result := aRes;
	end;

	function TGblAdapterDll.MakeCutToLeafCountFilter (
		aLeafCount: Longword
	) : ICutToLeafCountFilter;
	var
		aRes: ICutToLeafCountFilter;
	begin
		GetRoot().MakeCutToLeafCountFilter(aLeafCount, aRes);
		Result := aRes;
	end;

	function TGblAdapterDll.MakeCutToLeafCountFilter (
	) : ICutToLeafCountFilter;
	var
		aRes: ICutToLeafCountFilter;
	begin
		GetRoot().MakeCutToLeafCountFilter(aRes);
		Result := aRes;
	end;

	function TGblAdapterDll.MakeDateValueList () : IDateValueList;
	var
		aRes: IDateValueList;
	begin
		GetRoot().MakeDateValueList(aRes);
		Result := aRes;
	end;

	function TGblAdapterDll.MakeDecisionsArchiveSupport (
	) : IDecisionsArchiveSupport;
	var
		aRes: IDecisionsArchiveSupport;
	begin
		GetRoot().MakeDecisionsArchiveSupport(aRes);
		Result := aRes;
	end;

	function TGblAdapterDll.MakeDefaultValuesChangesIndicator (
		aState: TDefaultValuesChangesState;
			const aConfiguration: IConfiguration
	) : IDefaultValuesChangesIndicator;
	var
		aRes: IDefaultValuesChangesIndicator;
	begin
		GetRoot().MakeDefaultValuesChangesIndicator(aState, aConfiguration, aRes);
		Result := aRes;
	end;

	function TGblAdapterDll.MakeDiffDocDataProvider (
		const aLeft: IDocument;
			const aRight: IDocument
	) : IDiffDocDataProvider;
	var
		aRes: IDiffDocDataProvider;
	begin
		GetRoot().MakeDiffDocDataProvider(aLeft, aRight, aRes);
		Result := aRes;
	end;

	function TGblAdapterDll.MakeDiffDocParaList () : IDiffDocParaList;
	var
		aRes: IDiffDocParaList;
	begin
		GetRoot().MakeDiffDocParaList(aRes);
		Result := aRes;
	end;

	function TGblAdapterDll.MakeDocListFactory (
	) : IDocListFactory;
	var
		aRes: IDocListFactory;
	begin
		GetRoot().MakeDocListFactory(aRes);
		Result := aRes;
	end;

	function TGblAdapterDll.MakeDocNodeFilter (
	) : IDocNodeFilter;
	var
		aRes: IDocNodeFilter;
	begin
		GetRoot().MakeDocNodeFilter(aRes);
		Result := aRes;
	end;

	function TGblAdapterDll.MakeDocPointList () : IDocPointList;
	var
		aRes: IDocPointList;
	begin
		GetRoot().MakeDocPointList(aRes);
		Result := aRes;
	end;

	function TGblAdapterDll.MakeDocumentState (
		const aSourceDoc: IDocument
	) : IDocumentState;
	var
		aRes: IDocumentState;
	begin
		GetRoot().MakeDocumentState(aSourceDoc, aRes);
		Result := aRes;
	end;

	function TGblAdapterDll.MakeDocumentTextProviderDescriptorList () : IDocumentTextProviderDescriptorList;
	var
		aRes: IDocumentTextProviderDescriptorList;
	begin
		GetRoot().MakeDocumentTextProviderDescriptorList(aRes);
		Result := aRes;
	end;

	function TGblAdapterDll.MakeDocumentTextProviderList () : IDocumentTextProviderList;
	var
		aRes: IDocumentTextProviderList;
	begin
		GetRoot().MakeDocumentTextProviderList(aRes);
		Result := aRes;
	end;

	function TGblAdapterDll.MakeDynList (
		aKey: TSpecialListKey
	) : IDynList;
	var
		aRes: IDynList;
	begin
		GetRoot().MakeDynList(aKey, aRes);
		Result := aRes;
	end;

	function TGblAdapterDll.MakeEstimation (
	) : IEstimation;
	var
		aRes: IEstimation;
	begin
		GetRoot().MakeEstimation(aRes);
		Result := aRes;
	end;

	function TGblAdapterDll.MakeExternalObjectDataList () : IExternalObjectDataList;
	var
		aRes: IExternalObjectDataList;
	begin
		GetRoot().MakeExternalObjectDataList(aRes);
		Result := aRes;
	end;

	function TGblAdapterDll.MakeExternalOperation (
		aId: TObjectId
	) : IExternalOperation;
	var
		aRes: IExternalOperation;
	begin
		GetRoot().MakeExternalOperation(aId, aRes);
		Result := aRes;
	end;

	function TGblAdapterDll.MakeFilterList () : IFilterList;
	var
		aRes: IFilterList;
	begin
		GetRoot().MakeFilterList(aRes);
		Result := aRes;
	end;

	function TGblAdapterDll.MakeFiltered () : IFiltered;
	var
		aRes: IFiltered;
	begin
		GetRoot().MakeFiltered(aRes);
		Result := aRes;
	end;

	function TGblAdapterDll.MakeFiltersFromQuery () : IFiltersFromQuery;
	var
		aRes: IFiltersFromQuery;
	begin
		GetRoot().MakeFiltersFromQuery(aRes);
		Result := aRes;
	end;

	function TGblAdapterDll.MakeFiltersManager (
	) : IFiltersManager;
	var
		aRes: IFiltersManager;
	begin
		GetRoot().MakeFiltersManager(aRes);
		Result := aRes;
	end;

	function TGblAdapterDll.MakeFindPositionList () : IFindPositionList;
	var
		aRes: IFindPositionList;
	begin
		GetRoot().MakeFindPositionList(aRes);
		Result := aRes;
	end;

	function TGblAdapterDll.MakeFolders (
	) : IFolders;
	var
		aRes: IFolders;
	begin
		GetRoot().MakeFolders(aRes);
		Result := aRes;
	end;

	function TGblAdapterDll.MakeFragmentList () : IFragmentList;
	var
		aRes: IFragmentList;
	begin
		GetRoot().MakeFragmentList(aRes);
		Result := aRes;
	end;

	function TGblAdapterDll.MakeHighlightPositionList () : IHighlightPositionList;
	var
		aRes: IHighlightPositionList;
	begin
		GetRoot().MakeHighlightPositionList(aRes);
		Result := aRes;
	end;

	function TGblAdapterDll.MakeInpharmFilter (
	) : IInpharmFilter;
	var
		aRes: IInpharmFilter;
	begin
		GetRoot().MakeInpharmFilter(aRes);
		Result := aRes;
	end;

	function TGblAdapterDll.MakeIntegration (
	) : IIntegration;
	var
		aRes: IIntegration;
	begin
		GetRoot().MakeIntegration(aRes);
		Result := aRes;
	end;

	function TGblAdapterDll.MakeInternetSupport (
	) : IInternetSupport;
	var
		aRes: IInternetSupport;
	begin
		GetRoot().MakeInternetSupport(aRes);
		Result := aRes;
	end;

	function TGblAdapterDll.MakeJournalBookmarkList () : IJournalBookmarkList;
	var
		aRes: IJournalBookmarkList;
	begin
		GetRoot().MakeJournalBookmarkList(aRes);
		Result := aRes;
	end;

	function TGblAdapterDll.MakeKeysList () : IKeysList;
	var
		aRes: IKeysList;
	begin
		GetRoot().MakeKeysList(aRes);
		Result := aRes;
	end;

	function TGblAdapterDll.MakeLanguagesList () : ILanguagesList;
	var
		aRes: ILanguagesList;
	begin
		GetRoot().MakeLanguagesList(aRes);
		Result := aRes;
	end;

	function TGblAdapterDll.MakeLayerFilter (
	) : ILayerFilter;
	var
		aRes: ILayerFilter;
	begin
		GetRoot().MakeLayerFilter(aRes);
		Result := aRes;
	end;

	function TGblAdapterDll.MakeLayerIdList () : ILayerIdList;
	var
		aRes: ILayerIdList;
	begin
		GetRoot().MakeLayerIdList(aRes);
		Result := aRes;
	end;

	function TGblAdapterDll.MakeLogEventData (
	) : ILogEventData;
	var
		aRes: ILogEventData;
	begin
		GetRoot().MakeLogEventData(aRes);
		Result := aRes;
	end;

	function TGblAdapterDll.MakeLogManager (
	) : ILogManager;
	var
		aRes: ILogManager;
	begin
		GetRoot().MakeLogManager(aRes);
		Result := aRes;
	end;

	function TGblAdapterDll.MakeMainMenu (
	) : IMainMenu;
	var
		aRes: IMainMenu;
	begin
		GetRoot().MakeMainMenu(aRes);
		Result := aRes;
	end;

	function TGblAdapterDll.MakeMessages () : IMessages;
	var
		aRes: IMessages;
	begin
		GetRoot().MakeMessages(aRes);
		Result := aRes;
	end;

	function TGblAdapterDll.MakeMessagesManager (
	) : IMessagesManager;
	var
		aRes: IMessagesManager;
	begin
		GetRoot().MakeMessagesManager(aRes);
		Result := aRes;
	end;

	function TGblAdapterDll.MakeMonitoring (
	) : IMonitoring;
	var
		aRes: IMonitoring;
	begin
		GetRoot().MakeMonitoring(aRes);
		Result := aRes;
	end;

	function TGblAdapterDll.MakeNode (
	) : INode;
	var
		aRes: INode;
	begin
		GetRoot().MakeNode(aRes);
		Result := aRes;
	end;

	function TGblAdapterDll.MakeNodeBase (
		const aKey: PAnsiChar
	) : INodeBase;
	var
		aRes: INodeBase;
	begin
		GetRoot().MakeNodeBase(aKey, aRes);
		Result := aRes;
	end;

	function TGblAdapterDll.MakeNodeIdList () : INodeIdList;
	var
		aRes: INodeIdList;
	begin
		GetRoot().MakeNodeIdList(aRes);
		Result := aRes;
	end;

	function TGblAdapterDll.MakeNodeIndexPath () : INodeIndexPath;
	var
		aRes: INodeIndexPath;
	begin
		GetRoot().MakeNodeIndexPath(aRes);
		Result := aRes;
	end;

	function TGblAdapterDll.MakeNodeIterator (
	) : INodeIterator;
	var
		aRes: INodeIterator;
	begin
		GetRoot().MakeNodeIterator(aRes);
		Result := aRes;
	end;

	function TGblAdapterDll.MakeNodeValueList () : INodeValueList;
	var
		aRes: INodeValueList;
	begin
		GetRoot().MakeNodeValueList(aRes);
		Result := aRes;
	end;

	function TGblAdapterDll.MakeNodesClipboard (
	) : INodesClipboard;
	var
		aRes: INodesClipboard;
	begin
		GetRoot().MakeNodesClipboard(aRes);
		Result := aRes;
	end;

	function TGblAdapterDll.MakeNotSureIntervalList () : INotSureIntervalList;
	var
		aRes: INotSureIntervalList;
	begin
		GetRoot().MakeNotSureIntervalList(aRes);
		Result := aRes;
	end;

	function TGblAdapterDll.MakeNotifyManager (
	) : INotifyManager;
	var
		aRes: INotifyManager;
	begin
		GetRoot().MakeNotifyManager(aRes);
		Result := aRes;
	end;

	function TGblAdapterDll.MakeOperationList () : IOperationList;
	var
		aRes: IOperationList;
	begin
		GetRoot().MakeOperationList(aRes);
		Result := aRes;
	end;

	function TGblAdapterDll.MakeParasList () : IParasList;
	var
		aRes: IParasList;
	begin
		GetRoot().MakeParasList(aRes);
		Result := aRes;
	end;

	function TGblAdapterDll.MakePermanentSettingsManager (
	) : IPermanentSettingsManager;
	var
		aRes: IPermanentSettingsManager;
	begin
		GetRoot().MakePermanentSettingsManager(aRes);
		Result := aRes;
	end;

	function TGblAdapterDll.MakePositionList () : IPositionList;
	var
		aRes: IPositionList;
	begin
		GetRoot().MakePositionList(aRes);
		Result := aRes;
	end;

	function TGblAdapterDll.MakePrefixNode (
	) : IPrefixNode;
	var
		aRes: IPrefixNode;
	begin
		GetRoot().MakePrefixNode(aRes);
		Result := aRes;
	end;

	function TGblAdapterDll.GetContractDataPrimeContractData (
		const aQuery: IQuery
	) : IPrimeContractData;
	var
		aRes: IPrimeContractData;
	begin
		GetRoot().GetContractDataPrimeContractData(aQuery, aRes);
		Result := aRes;
	end;

	function TGblAdapterDll.MakePrimeList () : IPrimeList;
	var
		aRes: IPrimeList;
	begin
		GetRoot().MakePrimeList(aRes);
		Result := aRes;
	end;

	function TGblAdapterDll.MakePrimeManager (
	) : IPrimeManager;
	var
		aRes: IPrimeManager;
	begin
		GetRoot().MakePrimeManager(aRes);
		Result := aRes;
	end;

	function TGblAdapterDll.MakePrimeSettingsManager (
	) : IPrimeSettingsManager;
	var
		aRes: IPrimeSettingsManager;
	begin
		GetRoot().MakePrimeSettingsManager(aRes);
		Result := aRes;
	end;

	function TGblAdapterDll.MakePropertyStringIDList () : IPropertyStringIDList;
	var
		aRes: IPropertyStringIDList;
	begin
		GetRoot().MakePropertyStringIDList(aRes);
		Result := aRes;
	end;

	function TGblAdapterDll.MakeQuery (
		aType: TQueryType
	) : IQuery;
	var
		aRes: IQuery;
	begin
		GetRoot().MakeQuery(aType, aRes);
		Result := aRes;
	end;

	function TGblAdapterDll.MakeQueryAttributeList () : IQueryAttributeList;
	var
		aRes: IQueryAttributeList;
	begin
		GetRoot().MakeQueryAttributeList(aRes);
		Result := aRes;
	end;

	function TGblAdapterDll.CreateQueryCardInfo (
		const aKey: PAnsiChar
	) : IQueryCardInfo;
	var
		aRes: IQueryCardInfo;
	begin
		GetRoot().CreateQueryCardInfo(aKey, aRes);
		Result := aRes;
	end;

	function TGblAdapterDll.MakeQueryContextAttribute (
		const aAttributeTag: TAttributeTag
	) : IQueryContextAttribute;
	var
		aRes: IQueryContextAttribute;
	begin
		GetRoot().MakeQueryContextAttribute(aAttributeTag, aRes);
		Result := aRes;
	end;

	function TGblAdapterDll.MakeQueryDateAttribute (
		const aAttributeTag: TAttributeTag
	) : IQueryDateAttribute;
	var
		aRes: IQueryDateAttribute;
	begin
		GetRoot().MakeQueryDateAttribute(aAttributeTag, aRes);
		Result := aRes;
	end;

	function TGblAdapterDll.MakeQueryList () : IQueryList;
	var
		aRes: IQueryList;
	begin
		GetRoot().MakeQueryList(aRes);
		Result := aRes;
	end;

	function TGblAdapterDll.MakeQueryNodeAttribute (
		const aAttributeTag: TAttributeTag
	) : IQueryNodeAttribute;
	var
		aRes: IQueryNodeAttribute;
	begin
		GetRoot().MakeQueryNodeAttribute(aAttributeTag, aRes);
		Result := aRes;
	end;

	function TGblAdapterDll.MakeQueryPhoneNumberAttribute (
		const aAttributeTag: TAttributeTag
	) : IQueryPhoneNumberAttribute;
	var
		aRes: IQueryPhoneNumberAttribute;
	begin
		GetRoot().MakeQueryPhoneNumberAttribute(aAttributeTag, aRes);
		Result := aRes;
	end;

	function TGblAdapterDll.MakeRedactionInfoList () : IRedactionInfoList;
	var
		aRes: IRedactionInfoList;
	begin
		GetRoot().MakeRedactionInfoList(aRes);
		Result := aRes;
	end;

	function TGblAdapterDll.MakeRedactionSourceDocumentInfoList () : IRedactionSourceDocumentInfoList;
	var
		aRes: IRedactionSourceDocumentInfoList;
	begin
		GetRoot().MakeRedactionSourceDocumentInfoList(aRes);
		Result := aRes;
	end;

	function TGblAdapterDll.MakeSearch (
	) : ISearch;
	var
		aRes: ISearch;
	begin
		GetRoot().MakeSearch(aRes);
		Result := aRes;
	end;

	function TGblAdapterDll.MakeSearchEntity (
		aResultType: TSearchResultType;
			aDocumentCount: Cardinal;
			aEntryCount: Cardinal;
			aEditionCount: Cardinal
	) : ISearchEntity;
	var
		aRes: ISearchEntity;
	begin
		GetRoot().MakeSearchEntity(aResultType, aDocumentCount, aEntryCount, aEditionCount, aRes);
		Result := aRes;
	end;

	function TGblAdapterDll.MakeSectionItemList () : ISectionItemList;
	var
		aRes: ISectionItemList;
	begin
		GetRoot().MakeSectionItemList(aRes);
		Result := aRes;
	end;

	function TGblAdapterDll.MakeSortFilter (
	) : ISortFilter;
	var
		aRes: ISortFilter;
	begin
		GetRoot().MakeSortFilter(aRes);
		Result := aRes;
	end;

	function TGblAdapterDll.MakeSortTypes () : ISortTypes;
	var
		aRes: ISortTypes;
	begin
		GetRoot().MakeSortTypes(aRes);
		Result := aRes;
	end;

	function TGblAdapterDll.MakeStopWatch (
		const aContext: PAnsiChar
	) : IStopWatch;
	var
		aRes: IStopWatch;
	begin
		GetRoot().MakeStopWatch(aContext, aRes);
		Result := aRes;
	end;

	function TGblAdapterDll.MakeStopWatchEx (
		const aId: PAnsiChar;
			const aContext: PAnsiChar
	) : IStopWatchEx;
	var
		aRes: IStopWatchEx;
	begin
		GetRoot().MakeStopWatchEx(aId, aContext, aRes);
		Result := aRes;
	end;

	function TGblAdapterDll.MakeStringList () : IStringList;
	var
		aRes: IStringList;
	begin
		GetRoot().MakeStringList(aRes);
		Result := aRes;
	end;

	function TGblAdapterDll.MakeSubList () : ISubList;
	var
		aRes: ISubList;
	begin
		GetRoot().MakeSubList(aRes);
		Result := aRes;
	end;

	function TGblAdapterDll.MakeTipsManager (
	) : ITipsManager;
	var
		aRes: ITipsManager;
	begin
		GetRoot().MakeTipsManager(aRes);
		Result := aRes;
	end;

	function TGblAdapterDll.MakeTrimFilter (
	) : ITrimFilter;
	var
		aRes: ITrimFilter;
	begin
		GetRoot().MakeTrimFilter(aRes);
		Result := aRes;
	end;

	function TGblAdapterDll.MakeTrimLeafFilter (
	) : ITrimLeafFilter;
	var
		aRes: ITrimLeafFilter;
	begin
		GetRoot().MakeTrimLeafFilter(aRes);
		Result := aRes;
	end;

	function TGblAdapterDll.MakeUidList () : IUidList;
	var
		aRes: IUidList;
	begin
		GetRoot().MakeUidList(aRes);
		Result := aRes;
	end;

	function TGblAdapterDll.MakeUserFilter (
	) : IUserFilter;
	var
		aRes: IUserFilter;
	begin
		GetRoot().MakeUserFilter(aRes);
		Result := aRes;
	end;

	function TGblAdapterDll.MakeUserJournal (
	) : IUserJournal;
	var
		aRes: IUserJournal;
	begin
		GetRoot().MakeUserJournal(aRes);
		Result := aRes;
	end;

	function TGblAdapterDll.MakeUserManager (
	) : IUserManager;
	var
		aRes: IUserManager;
	begin
		GetRoot().MakeUserManager(aRes);
		Result := aRes;
	end;

	function TGblAdapterDll.MakeUserProfile (
	) : IUserProfile;
	var
		aRes: IUserProfile;
	begin
		GetRoot().MakeUserProfile(aRes);
		Result := aRes;
	end;

	function TGblAdapterDll.MakeVariant (
	) : IVariant;
	var
		aRes: IVariant;
	begin
		GetRoot().MakeVariant(aRes);
		Result := aRes;
	end;

	function TGblAdapterDll.MakeLongVariant (
		aValue: Longint
	) : IVariant;
	var
		aRes: IVariant;
	begin
		GetRoot().MakeLongVariant(aValue, aRes);
		Result := aRes;
	end;

	function TGblAdapterDll.MakeBoolVariant (
		aValue: Bytebool
	) : IVariant;
	var
		aRes: IVariant;
	begin
		GetRoot().MakeBoolVariant(aValue, aRes);
		Result := aRes;
	end;

	function TGblAdapterDll.MakeStringVariant (
		const aValue: IString
	) : IVariant;
	var
		aRes: IVariant;
	begin
		GetRoot().MakeStringVariant(aValue, aRes);
		Result := aRes;
	end;

	function TGblAdapterDll.MakeObjectVariant (
		const aValue: IUnknown
	) : IVariant;
	var
		aRes: IVariant;
	begin
		GetRoot().MakeObjectVariant(aValue, aRes);
		Result := aRes;
	end;

	function TGblAdapterDll.MakeVariantsForDocFilter (
		aDocId: Longword
	) : IVariantsForDocFilter;
	var
		aRes: IVariantsForDocFilter;
	begin
		GetRoot().MakeVariantsForDocFilter(aDocId, aRes);
		Result := aRes;
	end;

	function TGblAdapterDll.MakeVariantsForDocFilter (
	) : IVariantsForDocFilter;
	var
		aRes: IVariantsForDocFilter;
	begin
		GetRoot().MakeVariantsForDocFilter(aRes);
		Result := aRes;
	end;

	function TGblAdapterDll.MakeVisualRepresentationList () : IVisualRepresentationList;
	var
		aRes: IVisualRepresentationList;
	begin
		GetRoot().MakeVisualRepresentationList(aRes);
		Result := aRes;
	end;



procedure TGblAdapterDll.DllLoad;

	function GetOsDependentCatalog: string;
	begin
		if (Longint (Windows.GetVersion) < 0) then
			Result := ExtractFilePath (ParamStr (0))+'win9X'
		else
			Result := ExtractFilePath (ParamStr (0))+'winNT';
	end;

var
	l_CurrentDir: string;
	l_ErrorMode: UINT;
	l_OsDependentCatalog: string;
begin
	l_ErrorMode := SetErrorMode (SEM_FAILCRITICALERRORS);
	try
		l_CurrentDir := GetCurrentDir;

		l_OsDependentCatalog := GetOsDependentCatalog;
		if SetCurrentDir (l_OsDependentCatalog) then
			try
				f_HModule := LoadLibraryA (CLibraryName);
				(* K: 384075072 *)
				if (f_HModule = HMODULE (0)) then
					f_HModule := LoadLibraryExA (PAnsiChar (l_OsDependentCatalog+'\'+CLibraryName), 0, LOAD_WITH_ALTERED_SEARCH_PATH);
			finally
				SetCurrentDir (l_CurrentDir);
			end
		else
			f_HModule := LoadLibraryA (PAnsiChar (l_OsDependentCatalog+'\'+CLibraryName));
		
		if (f_HModule = HMODULE (0)) then
		begin
			f_HModule := LoadLibraryA (CLibraryName);
		
			if (f_HModule = HMODULE (0)) then
				raise ELoadLibraryError.Create ('Dynamic library "'+CLibraryName+'" not found');
		end;
	finally
		SetErrorMode (l_ErrorMode);
	end;
end;

procedure TGblAdapterDll.DllFree;
begin
	if (f_HModule <> HMODULE (0)) then
	begin
		try
			FreeLibrary (f_HModule);
		except
		end;
	end;
end;

constructor TGblAdapterDll.Create(aClientVersion: LongWord);
begin
	inherited Create;
	DllLoad;
	RootInit(aClientVersion);
end;

constructor TGblAdapterDll.Create (aClientVersion: LongWord; const aLocale: PAnsiChar);
begin
	inherited Create;
	DllLoad;
	RootInit(aClientVersion, aLocale);
end;

procedure TGblAdapterDll.Cleanup;
begin
	f_DllRoot := nil;
	RootDone;
	DllFree;
	inherited Cleanup;
end;

class function TGblAdapterDll.Make(const aLocale: PAnsiChar): IGblAdapterDll;
begin
	if g_GblAdapterDLL = nil then
		g_GblAdapterDLL := TGblAdapterDll.Create(CLibraryVersion, aLocale);
	Result := g_GblAdapterDLL;
end;


class function TGblAdapterDll.Make: IGblAdapterDll;
begin
	if g_GblAdapterDLL = nil then
		g_GblAdapterDLL := TGblAdapterDll.Create(CLibraryVersion);
	Result := g_GblAdapterDLL;
end;


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
// plain DLL method's wrappers
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

function TGblAdapterDll.GetVersion: LongWord;
const
	CProcName = '_tie_dll_version@0';
type
	TProcType = function: Integer; stdcall;
var
	l_ProcAddress: Pointer;
begin
	l_ProcAddress := GetProcAddress (f_HModule, PAnsiChar (CProcName));
	if (not Assigned (l_ProcAddress)) then
		raise EGetProcAddressError.Create ('DLL method not found: '+CLibraryName+'.'+CProcName);

	Result := TProcType (l_ProcAddress);
end;

function TGblAdapterDll.GetRoot: IGblAdapterRoot;
const
	CProcName = '_tie_dll_get_root@4';
type
	TProcType = procedure (out aRoot{: IGblAdapterRoot}); stdcall;
var
	l_ProcAddress: Pointer;
begin
	if (not Assigned (f_DllRoot)) then
	begin
		l_ProcAddress := GetProcAddress (f_HModule, PAnsiChar (CProcName));
	
		if (not Assigned (l_ProcAddress)) then
			raise EGetProcAddressError.Create ('DLL method not found: '+CLibraryName+'.'+CProcName);
	
		TProcType (l_ProcAddress)(f_DllRoot);
	end;
	
	Result := f_DllRoot;
end;

procedure TGblAdapterDll.RootInit (aClientVersion: LongWord; const aLocale: PAnsiChar);
const
	CProcName = '_tie_dll_init_with_locale@8';
type
	TProcType = procedure (aClientVersion: LongWord; const aLocale: PAnsiChar); stdcall;
var
	l_ProcAddress: Pointer;
begin
	l_ProcAddress := GetProcAddress (f_HModule, PAnsiChar (CProcName));

	if (not Assigned (l_ProcAddress)) then
		raise EGetProcAddressError.Create ('DLL method not found: '+CLibraryName+'.'+CProcName);

	TProcType (l_ProcAddress) (aClientVersion, aLocale);
end;

procedure TGblAdapterDll.RootInit(aClientVersion: LongWord);
const
	CProcName = '_tie_dll_init@4';
type
	TProcType = procedure (aClientVersion: LongWord); stdcall;
var
	l_ProcAddress: Pointer;
begin
	l_ProcAddress := GetProcAddress (f_HModule, PAnsiChar (CProcName));

	if (not Assigned (l_ProcAddress)) then
		raise EGetProcAddressError.Create ('DLL method not found: '+CLibraryName+'.'+CProcName);

	TProcType (l_ProcAddress) (aClientVersion);
end;

procedure TGblAdapterDll.RootDone;
const
	CProcName = '_tie_dll_done@0';
type
	TProcType = procedure; stdcall;
var
	l_ProcAddress: Pointer;
begin
	if f_HModule <> HMODULE (0) then
	begin
		l_ProcAddress := GetProcAddress (f_HModule, PAnsiChar (CProcName));
	
		if (not Assigned (l_ProcAddress)) then
			raise EGetProcAddressError.Create ('DLL method not found: '+CLibraryName+'.'+CProcName);
			
		TProcType (l_ProcAddress);
	end;
end;
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
// exception maping support
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
type
	TExceptionIdMapItem = record
		rId: AnsiString;
		rEClass: ExceptClass;
		rMessage: string;
	end;

resourcestring
	// "Нормальные" текстовые сообщения для исключений, которые "видит" пользователь.
	// (!) Общий формат для имен: строка с именем `S<ИмяИсключения>` соответствует классу с именем `E<ИмяИсключения>`.
	//
	_SNotImplemented = 'функция не реализована';

	_SOperationError = 'Во время выполнения операции copy_to один из потоков, участвовавших в операции перешёл в некорректное состояние.';
	_SAccessDenied = 'Возбуждается в случае нарушения прав доступа.';

	_SAccountDisabled = 'AccountDisabled';

	_SAllChangesInTables = 'AllChangesInTables';

	_SAllContentIsFiltered = 'Всё сожержимое отфильтровано, что противоречит бизнес-логике';

	_SAlreadyControlled = 'Объект уже на контроле.';

	_SAlreadyLogged = 'AlreadyLogged';

	_SAutoregistrationDisabled = 'Авторегистрация запрещена администратором системы';

	_SBadNetworkConfig = 'Возбуждается, если в течении 10 секунд не пришел ответ от сервера ни на один из IP адрессов на машине-клиенте (вероятные причины: firewall блокирует `incoming connection` на порты, которые использует ACE/TAO при обратном вызове).';

	_SBadSMTPReply = 'BadSMTPReply';

	_SCanNotFindData = 'Запрошенные данные не найдены. Возвращается в случае, если данные запрошенные по операции get_<something> отсутствуют.';

	_SCanNotSave = 'объект не может быть сохранён';

	_SCantCreateObject = 'в базе недостаточно данных для построения объекта';

	_SConfigurationIsActiveNow = 'ConfigurationIsActiveNow';

	_SConfigurationsNotDefined = 'ConfigurationsNotDefined';

	_SConstantModify = 'Исключение возникает при попытке изменить константный параметер.';

	_SCopyDisabled = 'Возвращается если нода не может быть скопирована.';

	_SDeleted = 'Консультация удалена - все операции запрещены';

	_SDuplicateName = 'Элемент с таким именем уже существует, а два и более созадвать нельзя';

	_SDuplicateNode = 'Возникает в случае добавления узла в дерево, где уже есть такой же узел. При этом уникальность определяется самим узлом.';

	_SEmptyResult = 'Возвращается при операции по изменению дерева в случае, если результат получается пустой, и это запрещенно логикой конкретеного дерева.';

	_SExplanationDictionaryNotInstalled = 'Толковый словарь не установлен в системе. Возвращается в случае вызова операции "поиск толкования" и отсутствии в системе толкового словаря.';

	_SExternalApplicationError = 'Ошибка при работе внешнего приложения';

	_SFolderLinkNotFound = 'Не найдена ссылка на папочный элемент (возможно он был удален)';

	_SFoldersNotAvailable = 'Папки недоступны. Возвращается в случае, если у пользователя нет доступа к папкам.';

	_SIPAddressNotFound = 'Возбуждается, когда не надено ни одного IP адреса для машины клиента (вероятные причины: нет активных сетевых соединений).';

	_SInternalApplicationError = 'ошибка в механизме gcm';

	_SInternalDatabaseError = 'Произошла внутреняя ошибка при обращении к базе';

	_SInternalServerError = 'Внутренняя ошибка сервера';

	_SInvalidBase = 'Отсутствует или неверная база.';

	_SInvalidContainer = 'Вызывается при попытке использовать нодй не являющуюся контенером как контейнер.';

	_SInvalidDate = 'InvalidDate';

	_SInvalidEntityType = 'Возвращается при попытке присвоить одной сущности сущность другого типа.';

	_SInvalidEntryPoint = 'InvalidEntryPoint';

	_SInvalidIndex = 'Возвращается при попытке получить элемент списка по несуществующему индексу. Т.е. index<0 или index>=count.';

	_SInvalidLayerID = 'InvalidLayerID';

	_SInvalidObjectClass = 'InvalidObjectClass';

	_SInvalidParaId = 'Неверный идентификатор параграфа';

	_SInvalidTimeStamp = 'Исключение возбуждается в случае если запрошенная операция не может быть выполнена на сервер, по причине неверной метки синхронизации. Возможно необходимо повторить вызов.';

	_SInvalidTopicId = 'Возвращается при попытке выполнить операцию с внутренним идентификатором документа, несуществующим в базе.';

	_SInvalidType = 'Плохой тип данных';

	_SInvalidUserDatastore = 'может быть брошено только на desktop версии - сигнализирует о битой базе пользовалетя (что-то из содержимого каталога settings)';

	_SInvalidValueType = 'Возвращается при попытке прочитать или присвоить через интерфейс ParameterValues значение по типу, который не совпадает с реальным типом значения (реальный тип можно получить через свойство value_type).';

	_SInvalidXMLType = 'Ошибка при разборе XML';

	_SLicenceViolation = 'Нарушение лицензионных настроек';

	_SLoginDuplicate = 'Данный пользователь уже зарегестрирован в системе';

	_SMorphoNotExists = 'отсутствует морфоиндекс.';

	_SMoveDisabled = 'Возвращается если нода не может быть перенесена.';

	_SNoConnection = 'Нет связи с сервером консультаций';

	_SNoDefaultValue = 'Для атрибута нет значения по умолчанию';

	_SNoDocumentList = 'Нет списка документов в ответе';

	_SNoEntity = 'генерируется при попытке получить сущность на ноде которая ее не содержит';

	_SNoMoreConnections = 'NoMoreConnections';

	_SNoMorePrivilegedProfiles = 'нельзя завести новых пользователей с привилегированным входом';

	_SNoMoreProfiles = 'Превышение лимита профилей пользователей';

	_SNoPrevRedaction = 'NoPrevRedaction';

	_SNoServer = 'Возбуждается в случае, когда по каким-то причинам сервер оказался недоступным.';

	_SNoSession = 'выбрасывается из методов, которые могут дергаться только в контексте сессии, т.е. после логина';

	_SNoSubscription = 'Нет доступа с сервису - вы не подписаны на услугу';

	_SNotAllAttributesRestored = 'Не все атрибуты поискового запроса восстановлны из базы';

	_SNotDeleted = 'Нельзя удалить консультацию';

	_SNotEntityElement = 'Возвращается при попытке вызвать операцию open у элемента каталога, не являющегося сущностью (в частности у папки).';

	_SNotFound = 'возвращается если get_visible_delta не может найти ноду';

	_SNotSaved = 'Возвращается при попытке сохранить/восстановить изменения в несохраненном (т.е не привязанном к месту хранения, например к папкам) объекте';

	_SNotUnderControl = 'Объект не на контроле.';

	_SOldFormatConsultation = 'консультация старого формата';

	_SPaymentForbidden = 'У пользователя нет прав оплачивать консультации';

	_SQueryNotExecuted = 'QueryNotExecuted';

	_SRedactionNotFound = 'Возвращается в случае попытки получения несуществующей редакции объекта.';

	_SSMTPAuthorizationFailed = 'Неудачная авторизация на почтовом сервере';

	_SSMTPServerAddressNotDefined = 'Не задан адрес SMTP сервера';

	_SSMTPServerNotFound = 'Приложение не может соединиться c SMTP сервером. Возможно была допущена ошибка в при вводе адреса сервера.';

	_SServerIsStarting = 'сервер запущен, находится в процессе инициализации';

	_SServerVersionNotValid = 'ServerVersionNotValid';

	_SSettingsRestoreFails = 'SettingsRestoreFails';

	_SShutdownInited = 'Бросается в случае попытки залогинится в момент завершения работы сервера.';

	_SStorageLocked = 'База блокирована';

	_STrialPeriodExpired = 'Время ознакомительной версии истекло';

	_SUnknownExportError = 'UnknownExportError';

	_SUnknownUser = 'задан идентификатор неизвестного пользователя';

	_SUnsupported = 'Возвращается в случае если вызванная опреация не поддеоживается объектом.';

	_SUserActive = 'Попытка удалить работающего в данный момент пользователя';

	_SUserNotFound = 'Пользователь не найден';

	_SWorkingParamsNotFound = 'Не найдены параметры, необходимые для работы приложения.';

	_SWrongAuthentication = 'Неверные данные аутентификации';

	_SXMLImportRunning = 'Активен процесс заливки на стороне сервера';

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

const
	// Карта [map] перекодировки: текстовой строке ставиться в соответствие нужный мета-класс исключения и сообщение.
	//
	cIdToExceptionMapMaxItems = 92; // максимальное количество элементов в таблице

type
	TIdToExceptionMapArray = array [0..cIdToExceptionMapMaxItems - 1] of TExceptionIdMapItem;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

type
	TIdToExceptionMap = class(Tl3ProtoObject)
	private
		f_Map: TIdToExceptionMapArray;
	public
		constructor Create;
			reintroduce;
		function ConvertIdToIndex(const aId: PAnsiChar; out aIndex: Longword): Boolean;
		function GetExceptionClass(anIndex: Longword): ExceptClass;
		function CreateException(anIndex: Longword): Exception;
end;

{TIdToExceptionMap}

function TIdToExceptionMap.ConvertIdToIndex(const aId: PAnsiChar; out aIndex: Longword): Boolean;
var
	l_Index: Longword;
begin
	Result := False;
	aIndex := 0;
	for l_Index := Low (f_Map) to High (f_Map) do
		if (StrComp (aId, PAnsiChar (f_Map[l_Index].rId)) = 0) then
		begin
			aIndex := l_Index;
			Result := True;
			
			Break;
		end;
end;

constructor TIdToExceptionMap.Create;
	procedure lp_Init(anIndex: Longword; const aGUID, aMessage: string; const aClass: ExceptClass);
	begin
		with f_Map[anIndex] do
		begin
			rId := aGUID;
			rEClass := aClass;
			rMessage := aMessage;
		end;
	end;

begin
	inherited Create;
	// заполнение f_Map
	
	lp_Init (0, '0000-0000-0000-0000-000000000000', 'dummy exception', EStdException);
	lp_Init (1, '4DDEBC97-3F88-4811-9423-8BDEE07A9C21', 'Выход за границы массива', EListError);
	lp_Init (2, '69708A24-C2D3-4685-8016-7E2FD8A5888C', 'Неправильная версия ДЛЛ', EWrongVersion);
	lp_Init (3, '42540CD0-2B0C-45F2-82DB-0474D2D29867', 'No one servant was registers in factory with a given key', EUnknownFactoryKey);
	lp_Init (4, 'F11331C9-6903-4F59-9876-78B3CCEE3209', 'DLL can''t find corresponding server', ECantFindServer);
	lp_Init (5, 'F5A55B66-C39A-4758-BE4D-844DE9E142A4', '_SOperationError', EOperationError);
	lp_Init (6, 'BA9EDABD-A788-46FF-B5C3-45E967EFEE3C', '_SNotImplemented', ENotImplemented);
	lp_Init (7, '7EB3FB32-CFDF-4978-BD77-B2EBEEE93F0B', '_SConstantModify', EConstantModify);
	lp_Init (8, '1DCBD6AE-98D5-4ED8-BC92-A8C6666102A4', '_SAccessDenied', EAccessDenied);
	lp_Init (9, '53CFA0CF-AAC4-4F98-9A23-3F88BB96E993', '_SInvalidTimeStamp', EInvalidTimeStamp);
	lp_Init (10, '3AC52720-20FF-488A-9F39-D3C749B0BEB5', '_SStorageLocked', EStorageLocked);
	lp_Init (11, '6A74F86E-2B29-442C-B0F4-08E06801742A', '_SUnsupported', EUnsupported);
	lp_Init (12, '683A63D1-5A5A-46FC-80BB-5CFAAE4F3BE3', '_SNotSaved', ENotSaved);
	lp_Init (13, 'D5150C42-106F-4472-9A79-7A551CDE39AF', '_SFoldersNotAvailable', EFoldersNotAvailable);
	lp_Init (14, 'F5DA2B69-E229-477B-9DA8-40AD92596FBD', '_SCanNotFindData', ECanNotFindData);
	lp_Init (15, 'B8270401-B309-46E1-A462-7BBDE523B246', '_SDuplicateNode', EDuplicateNode);
	lp_Init (16, 'A53D3084-67B0-4755-A936-94EC07D0ABF1', '_SInvalidType', EInvalidType);
	lp_Init (17, '3BC3C183-4FC4-45E3-B00F-EB9BCEDDAAF7', '_SCanNotSave', ECanNotSave);
	lp_Init (18, '520D7669-08ED-481A-A9B1-AB62DF14D847', '_SInvalidXMLType', EInvalidXMLType);
	lp_Init (19, 'A93E2E23-A7C0-4031-97C4-95A9D7BF9006', '_SAllContentIsFiltered', EAllContentIsFiltered);
	lp_Init (20, '97952A97-16EC-4EA4-B6D9-C7125136BA04', '_SEmptyResult', EEmptyResult);
	lp_Init (21, '6BB3CE98-12F6-4458-B37B-4A6E98A23FE9', '_SInternalDatabaseError', EInternalDatabaseError);
	lp_Init (22, 'DC1511BC-35F7-4A94-BDAD-991A6C77A698', '_SNoSession', ENoSession);
	lp_Init (23, 'B44C2074-426C-4390-BB43-CE1778893D70', '_SDuplicateName', EDuplicateName);
	lp_Init (24, '63115710-F088-4EE0-B5B9-00B2E36FBF4C', '_SCopyDisabled', ECopyDisabled);
	lp_Init (25, '454FB780-DCE5-4AD5-AE99-9E41AFEE3248', '_SInvalidContainer', EInvalidContainer);
	lp_Init (26, '8A0D7774-AA8F-4EAA-A15F-C00D73F7FBD4', '_SMoveDisabled', EMoveDisabled);
	lp_Init (27, '0AEC4038-7533-4FB1-A975-58E76E255075', '_SInvalidEntityType', EInvalidEntityType);
	lp_Init (28, '56331F0C-AE40-4578-A38C-84316D7ABD7B', '_SInvalidIndex', EInvalidIndex);
	lp_Init (29, '7CA7E5D7-CA70-424A-BB8F-A7753B405C3F', '_SNotEntityElement', ENotEntityElement);
	lp_Init (30, 'EE06D8C5-03DF-425F-8462-8591D75847CE', '_SNotAllAttributesRestored', ENotAllAttributesRestored);
	lp_Init (31, 'AEAD1A12-C9B8-4BC7-83BE-3879BF08050F', '_SNoEntity', ENoEntity);
	lp_Init (32, 'C77F1E09-8D6D-4A2A-B273-9E81772DD261', '_SNotFound', ENotFound);
	lp_Init (33, '83248376-504D-462C-888E-F06FF4227EFD', '_SNotUnderControl', ENotUnderControl);
	lp_Init (34, '9A1F19D8-42B0-4179-883B-BF031C87BD86', '_SAlreadyControlled', EAlreadyControlled);
	lp_Init (35, '53443A7A-5ED8-4E63-990A-2F20E985BBF1', '_SInvalidValueType', EInvalidValueType);
	lp_Init (36, 'BD770959-DE38-4B42-9FDB-7C541DDDCC62', '_SConfigurationIsActiveNow', EConfigurationIsActiveNow);
	lp_Init (37, 'AAF23401-0674-4990-9861-0629AA3C4489', '_SConfigurationsNotDefined', EConfigurationsNotDefined);
	lp_Init (38, '81D2E64B-0285-4665-8EBB-77AB7B23A3AE', '_SInvalidParaId', EInvalidParaId);
	lp_Init (39, 'FE878400-C219-4FEC-BB94-F2810419776F', '_SInvalidTopicId', EInvalidTopicId);
	lp_Init (40, 'C8772FCD-1532-45DA-B06F-B8CFEEC690F5', '_SFolderLinkNotFound', EFolderLinkNotFound);
	lp_Init (41, 'C67DEF89-E674-4575-BCDD-F5B4232F6C43', '_SRedactionNotFound', ERedactionNotFound);
	lp_Init (42, '831C4B6F-1F96-4FD9-BC5B-72C094403C0C', '_SInvalidDate', EInvalidDate);
	lp_Init (43, '26E18290-AD8C-4074-8A60-93B5C3A1A1EE', '_SExplanationDictionaryNotInstalled', EExplanationDictionaryNotInstalled);
	lp_Init (44, 'BBCC4DD8-8638-4E20-A012-B93EA66BDFF5', '_SInvalidObjectClass', EInvalidObjectClass);
	lp_Init (45, 'A5E6BDD6-1CF7-42F1-A269-BC9C04E9708A', '_SNoPrevRedaction', ENoPrevRedaction);
	lp_Init (46, 'C9FCD56A-2C69-47CC-8B48-32E8C4296A40', '_SInvalidEntryPoint', EInvalidEntryPoint);
	lp_Init (47, 'E6D5FB9E-A514-44F7-B841-38A27EC6E33B', '_SInvalidLayerID', EInvalidLayerID);
	lp_Init (48, 'E9F52E90-CE36-4583-8178-1872A710E38A', '_SAllChangesInTables', EAllChangesInTables);
	lp_Init (49, '80BFA2E6-4042-47C3-AA1D-88FCEFBBA68A', '_SWrongAuthentication', EWrongAuthentication);
	lp_Init (50, 'B32A68D2-68F0-4DBE-AB9E-08E914C25499', '_SNoMoreProfiles', ENoMoreProfiles);
	lp_Init (51, '3638F5BA-04D9-471F-95F1-189DC103C6AA', '_SUserActive', EUserActive);
	lp_Init (52, 'DE3C78AF-C27D-4243-8916-D969C6B1C70C', '_SLicenceViolation', ELicenceViolation);
	lp_Init (53, '5A13C909-06FA-4682-8E2D-1C2AD5C2DAED', '_SXMLImportRunning', EXMLImportRunning);
	lp_Init (54, '449F06CD-5A0E-477F-8B6D-ADFB8844E8CC', '_SLoginDuplicate', ELoginDuplicate);
	lp_Init (55, 'DC16A621-69A1-4C58-AA89-B0231118E870', '_SShutdownInited', EShutdownInited);
	lp_Init (56, '7AB288B1-A8C3-40AF-855F-687762019272', '_STrialPeriodExpired', ETrialPeriodExpired);
	lp_Init (57, '02B61457-0724-454A-A52C-DB5B78CCA7B1', '_SAutoregistrationDisabled', EAutoregistrationDisabled);
	lp_Init (58, '7CA79B54-8C37-4D00-84C0-52F2F780D68F', '_SNoMorePrivilegedProfiles', ENoMorePrivilegedProfiles);
	lp_Init (59, '69B6D1D4-7DBB-40EE-8FDE-9675D33D230B', '_SNoDefaultValue', ENoDefaultValue);
	lp_Init (60, '7EA1017A-32F2-4EAC-AF81-62300653DE90', '_SQueryNotExecuted', EQueryNotExecuted);
	lp_Init (61, 'F2BB45BE-4533-476D-95CF-D7E121A195D5', '_SIPAddressNotFound', EIPAddressNotFound);
	lp_Init (62, '96670BC0-148F-4D2D-BDDC-15AE7D32FFAC', '_SInvalidBase', EInvalidBase);
	lp_Init (63, '303D9557-8EC2-400C-BF9C-BADEE422A49C', '_SNoServer', ENoServer);
	lp_Init (64, '1D13BCD4-1DFF-4300-B58D-F7890BAAA58F', '_SBadNetworkConfig', EBadNetworkConfig);
	lp_Init (65, 'C5A7C6C4-5834-4B8E-A5A2-4ECC471713C1', '_SSMTPServerAddressNotDefined', ESMTPServerAddressNotDefined);
	lp_Init (66, '1DA675AE-50AF-474F-8022-1BDEEE14E50B', '_SSMTPServerNotFound', ESMTPServerNotFound);
	lp_Init (67, '61872E6E-6284-40DF-B866-6BCAEC608893', '_SUserNotFound', EUserNotFound);
	lp_Init (68, '8FB9BB5A-04F2-4EC2-B183-9AC1347EE390', '_SServerVersionNotValid', EServerVersionNotValid);
	lp_Init (69, '6A6215CF-78F3-49EC-BF9F-50BB4CB9293D', '_SInternalServerError', EInternalServerError);
	lp_Init (70, '085E10E6-7A2A-4F1A-ABF6-AC9A6B700D74', '_SWorkingParamsNotFound', EWorkingParamsNotFound);
	lp_Init (71, 'BC028BE4-26A7-4936-B0E9-56AD866D0C05', '_SBadSMTPReply', EBadSMTPReply);
	lp_Init (72, '6ABA3BD8-676F-471F-85F7-604C3270212D', '_SSettingsRestoreFails', ESettingsRestoreFails);
	lp_Init (73, '9D512BC1-E36B-425C-94E9-EC550ED838F7', '_SExternalApplicationError', EExternalApplicationError);
	lp_Init (74, '8A31DA0B-1697-4FA3-949D-01DC71BE4E18', '_SAlreadyLogged', EAlreadyLogged);
	lp_Init (75, '9E554518-D746-4CDE-8C5D-847E73A44C74', '_SAccountDisabled', EAccountDisabled);
	lp_Init (76, '1EBCB8C2-D652-4497-88B7-B6F6DEFC8C86', '_SNoMoreConnections', ENoMoreConnections);
	lp_Init (77, '78893262-7052-47BD-A3ED-646A5A7B4B1E', '_SSMTPAuthorizationFailed', ESMTPAuthorizationFailed);
	lp_Init (78, '2FC04D3B-B292-420C-B225-71B7ACE65770', '_SMorphoNotExists', EMorphoNotExists);
	lp_Init (79, '82E6F745-353D-4022-BE27-AE22DCD2FB3E', '_SInternalApplicationError', EInternalApplicationError);
	lp_Init (80, '55650D62-B1A8-4834-B197-FC50EF727F69', '_SInvalidUserDatastore', EInvalidUserDatastore);
	lp_Init (81, 'FC547407-1744-4A16-B4B3-6CF86EB0E8C7', '_SServerIsStarting', EServerIsStarting);
	lp_Init (82, 'CDAAA10F-25B1-40AB-AF38-E442812FC0C4', '_SNoDocumentList', ENoDocumentList);
	lp_Init (83, '53B82DF7-4FB0-4277-8051-7B45D1BE2CFA', '_SNoConnection', ENoConnection);
	lp_Init (84, 'FE9BA082-AF49-4436-9F44-BB9F311123F4', '_SNoSubscription', ENoSubscription);
	lp_Init (85, 'EEF53043-B518-4C31-A0BB-D5FFA24C8148', '_SPaymentForbidden', EPaymentForbidden);
	lp_Init (86, '052FCB78-0AF7-43D4-90C2-7B0483DF9778', '_SNotDeleted', ENotDeleted);
	lp_Init (87, '0786C2ED-20EF-42D8-884B-777DD8CC206A', '_SDeleted', EDeleted);
	lp_Init (88, '5B2DADE4-4723-4C2B-857C-C4AF9455B1F2', '_SOldFormatConsultation', EOldFormatConsultation);
	lp_Init (89, '3E91B55D-A586-4966-8C1C-4AC142314949', '_SUnknownUser', EUnknownUser);
	lp_Init (90, 'B783DEE5-82F3-4AA5-8236-E64E479438A2', '_SCantCreateObject', ECantCreateObject);
	lp_Init (91, 'FF78F730-8F08-45DA-9CE1-3124651BDB7A', '_SUnknownExportError', EUnknownExportError);
end;

function TIdToExceptionMap.CreateException(anIndex: Longword): Exception;
begin
	with f_Map [anIndex] do
		Result := rEClass.Create (rMessage);
end;

function TIdToExceptionMap.GetExceptionClass(anIndex: Longword): ExceptClass;
begin
	Result := f_Map [anIndex].rEClass;
end;

var
	g_ExceptionMap: TIdToExceptionMap = nil;

var
	gExceptClsProc: Pointer;
	gExceptObjProc: Pointer;


function GetExceptionClass (aExceptionRecord: PExceptionRecord): ExceptClass;
type
	TExceptClsProc = function (aExceptionRecord: PExceptionRecord): ExceptClass;
var
	lIndex: Cardinal;
begin
	Result := nil;
	case aExceptionRecord^.ExceptionCode of
		DWORD ($E0040200):
		begin
			if (
				((aExceptionRecord^.ExceptionFlags and EXCEPTION_NONCONTINUABLE) <> 0)
				and (aExceptionRecord^.NumberParameters = 0)
			) then
			begin
				Result := EOutOfMemory;
			end;
		end;
		DWORD ($E0040201):
		begin
			if (
				((aExceptionRecord^.ExceptionFlags and EXCEPTION_NONCONTINUABLE) <> 0)
				and (aExceptionRecord^.NumberParameters = 1)
				and (aExceptionRecord^.ExceptionInformation [0] <> 0)
			) then
			begin
				Result := EStdException;
			end;
		end;
		DWORD ($E0040202):
		begin
			if (
				((aExceptionRecord^.ExceptionFlags and EXCEPTION_NONCONTINUABLE) <> 0)
				and (aExceptionRecord^.NumberParameters = 1)
				and (aExceptionRecord^.ExceptionInformation [0] <> 0)
			) then
			begin
				Result := ECorbaException;
			end;
		end;
		DWORD ($E0040203):
		begin
			if (
				((aExceptionRecord^.ExceptionFlags and EXCEPTION_NONCONTINUABLE) <> 0)
				and (aExceptionRecord^.NumberParameters = 1)
				and (aExceptionRecord^.ExceptionInformation [0] <> 0)
				and g_ExceptionMap.ConvertIdToIndex (PAnsiChar (aExceptionRecord^.ExceptionInformation [0]), lIndex)
			) then
				begin
					Result := g_ExceptionMap.GetExceptionClass(lIndex);
				end
			else
				if (
					((aExceptionRecord^.ExceptionFlags and EXCEPTION_NONCONTINUABLE) <> 0)
					and (aExceptionRecord^.NumberParameters = 2)
					and (aExceptionRecord^.ExceptionInformation [0] = 0)
					and (aExceptionRecord^.ExceptionInformation [1] <> 0)
				) then
					begin
						Result := g_ExceptionMap.GetExceptionClass(aExceptionRecord^.ExceptionInformation [1]);
					end;
		end;
	end;
	if (
		Result = nil
	) then
	begin
		Result := TExceptClsProc (gExceptClsProc) (aExceptionRecord);
	end;
end;

var
	g_CorbaExceptionMessage : String = '';
	g_StdExceptionMessage : String = '';

function GetExceptionObject (aExceptionRecord: PExceptionRecord): Exception;
type
	TExceptObjProc = function (aExceptionRecord: PExceptionRecord): Exception;
var
	lIndex: Cardinal;
begin
	Result := nil;
	case aExceptionRecord^.ExceptionCode of
		DWORD ($E0040200):
		begin
			if (
				((aExceptionRecord^.ExceptionFlags and EXCEPTION_NONCONTINUABLE) <> 0)
				and (aExceptionRecord^.NumberParameters = 0)
			) then
			begin
				// (!) Специальный трюк: это исключение о "нехватке" памяти и оно не может быть создано динамически.
				try
					OutOfMemoryError ();
				except
					on l_Exception: EOutOfMemory do Result := l_Exception;
				end;
			end;
		end;
		DWORD ($E0040201):
		begin
			if ((aExceptionRecord^.ExceptionFlags and EXCEPTION_NONCONTINUABLE) <> 0) then
			begin
				if (
					(aExceptionRecord^.NumberParameters = 1)
					and (aExceptionRecord^.ExceptionInformation [0] <> 0)
				) then
				begin
					try
						g_StdExceptionMessage := PAnsiChar (aExceptionRecord^.ExceptionInformation [0]);
						Result := EStdException.Create (g_StdExceptionMessage);
					finally
						try
							CoTaskMemFree (Pointer (aExceptionRecord^.ExceptionInformation [0]));
						finally
							aExceptionRecord^.NumberParameters := 2;
							aExceptionRecord^.ExceptionInformation [0] := 0;
							aExceptionRecord^.ExceptionInformation [1] := DWORD (-1);
						end;
					end;
				end
				else
				begin
					if (
						(aExceptionRecord^.NumberParameters = 2)
						and (aExceptionRecord^.ExceptionInformation [0]  = 0)
						and (aExceptionRecord^.ExceptionInformation [1] = DWORD (-1))
					) then
					begin
						Result := EStdException.Create (g_StdExceptionMessage);
					end;
				end;
			end;
		end;
		DWORD ($E0040202):
		begin
			if ((aExceptionRecord^.ExceptionFlags and EXCEPTION_NONCONTINUABLE) <> 0) then
			begin
				if (
					(aExceptionRecord^.NumberParameters = 1)
					and (aExceptionRecord^.ExceptionInformation [0] <> 0)
				) then
				begin
					try
						g_CorbaExceptionMessage := PAnsiChar (aExceptionRecord^.ExceptionInformation [0]);
						Result := ECorbaException.Create (g_CorbaExceptionMessage);
					finally
						try
							CoTaskMemFree (Pointer (aExceptionRecord^.ExceptionInformation [0]));
						finally
							aExceptionRecord^.NumberParameters := 2;
							aExceptionRecord^.ExceptionInformation [0] := 0;
							aExceptionRecord^.ExceptionInformation [1] := DWORD (-1);
						end;
					end;
				end
				else
				begin
					if (
						(aExceptionRecord^.NumberParameters = 2)
						and (aExceptionRecord^.ExceptionInformation [0]  = 0)
						and (aExceptionRecord^.ExceptionInformation [1] = DWORD (-1))
					) then
					begin
						Result := ECorbaException.Create (g_CorbaExceptionMessage);
					end;
				end;
			end;
		end;
		DWORD ($E0040203):
		begin
			if ((aExceptionRecord^.ExceptionFlags and EXCEPTION_NONCONTINUABLE) <> 0) then
			begin
				if (
					(aExceptionRecord^.NumberParameters = 1)
					and (aExceptionRecord^.ExceptionInformation [0] <> 0)
				) then
				begin
					try
						if (
							g_ExceptionMap.ConvertIdToIndex (PAnsiChar (aExceptionRecord^.ExceptionInformation [0]), lIndex)
						) then
						begin
							Result := g_ExceptionMap.CreateException(lIndex);
						end;
					finally
						try
							CoTaskMemFree (Pointer (aExceptionRecord^.ExceptionInformation [0]));
						finally
							aExceptionRecord^.NumberParameters := 2;
							aExceptionRecord^.ExceptionInformation [0] := 0;
							aExceptionRecord^.ExceptionInformation [1] := DWORD (lIndex);
						end;
					end;
				end
				else
				begin
					if (
						(aExceptionRecord^.NumberParameters = 2)
						and (aExceptionRecord^.ExceptionInformation [0]  = 0)
						and (aExceptionRecord^.ExceptionInformation [1] <> 0)
					) then
					begin
						lIndex := Longword (aExceptionRecord^.ExceptionInformation [1]);
						Result := g_ExceptionMap.CreateException(lIndex);
					end;
				end;
			end;
		end;
	end;

	if (Result = nil) then
	begin
		Result := TExceptObjProc (gExceptObjProc) (aExceptionRecord);
	end
	else
	begin
		{$IF DEFINED(UseNoServerExceptionEvent)}
		if ((Result is ENoServer) and Assigned(g_NoServerExceptionEvent)) then
		begin
			g_NoServerExceptionEvent(Result);
		end;
		{$IFEND} // UseNoServerExceptionEvent
	end;
end;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

procedure ExitProc;
begin
	FreeAndNil(g_GblAdapterDLL);
	ExceptObjProc := gExceptObjProc;
	ExceptClsProc := gExceptClsProc;
	FreeAndNil(g_ExceptionMap);
end;

procedure InitProc;
begin
	g_ExceptionMap := TIdToExceptionMap.Create;
	gExceptClsProc := ExceptClsProc;
	gExceptObjProc := ExceptObjProc;
	//
	ExceptClsProc := @GetExceptionClass;
	ExceptObjProc := @GetExceptionObject;
	//
	l3System.AddExitProc (ExitProc);
end;


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

initialization
	InitProc;

finalization
	Finalize(g_CorbaExceptionMessage);
	Finalize(g_StdExceptionMessage);

end.