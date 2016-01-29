unit nevDocumentContainer;

interface

uses
 l3IntfUses
 , nevObjectHolderPrim
 , l3Interfaces
 , k2Interfaces
 , nevTools
 , nevInternalInterfaces
 , evInternalInterfaces
 , l3Variant
 , nevWaiterList
 , evDocumentPreviewInfoList
 , afwInterfaces
 , l3LongintList
 , nevBase
 , k2TagGen
 , k2Base
 , k2DocumentGenerator
 , k2InternalInterfaces
 , l3Filer
 , evGeneratorsInterfaces
 , evdInterfaces
 , l3IID
 , k2Op
 , k2Prim
 , evDocumentPartGenerator
;

type
 RevDocumentPartGenerator = class of TevDocumentPartGenerator;
 
 TnevDocumentContainer = class(TnevObjectHolderPrim, Il3Lock, Il3ItemNotifyRecipient, Ik2GeneratorTarget, InevDocumentContainer, InevSubList, InevTagReader, InevTagWriter, InevDocumentContainerInternal, IevSubFlagsSpy, InevCommentTextProvider)
  {* Контейнер документа. }
  procedure WriteDataExEx;
   {* считать документ из памяти в TextSource }
  procedure NotifySubReallyAdded(aParaID: Integer;
   aSubID: Integer;
   aLayerID: Integer;
   const aSubName: Tl3WString;
   aFlags: Integer);
  procedure NotifySubReallyDeleted(aParaID: Integer;
   aSubID: Integer;
   aLayerID: Integer);
  procedure SubDeleted(aSubID: Integer);
  procedure ClearSubs;
  procedure SendTOCCreatedNotify;
  procedure GetWriter(aFormat: TnevFormat;
   anInternal: Boolean;
   out theWriter: Tk2TagGenerator;
   out theCharCountMul: Integer;
   out theFormatName: Il3CString;
   const aFilters: InevTagGenerator;
   aCodePage: Integer); overload;
  function ReplaceContainerInOwner(const aDocumentContainer: InevDocumentContainer): Boolean;
  procedure Clear;
  procedure ResetPreviewCaches(ResetInfo: Boolean);
  function StartOp(Op: Integer;
   DoLock: Boolean): InevOp;
   {* открывает пачку операций с кодом Op. }
  procedure DocumentChanged(anOldDocument: Tl3Variant;
   aNewDocument: Tl3Variant);
  procedure AddToDocumentsCache;
  function CanBePlacedInDocumentsCache: Boolean;
  function DocumentPreview(const aKey: TevPreviewCacheKey;
   const aMacroReplacer: IafwHAFMacroReplacer;
   const aRange: InevRange): IafwDocumentPreview;
  function FindPreview(aCache: TevDocumentPreviewInfoList;
   const aKey: TevPreviewCacheKey): IafwDocumentPreview;
  function InfoPreview(const aKey: TevPreviewCacheKey;
   const aMacroReplacer: IafwHAFMacroReplacer): IafwDocumentPreview;
  function MakeDocumentPreview(const aKey: TevPreviewCacheKey;
   const aMacroReplacer: IafwHAFMacroReplacer;
   const aRange: InevRange): IafwDocumentPreview;
  function MakeInfoPreview(const aKey: TevPreviewCacheKey;
   const aMacroReplacer: IafwHAFMacroReplacer): IafwDocumentPreview;
  procedure SignalDocumentLoaded;
  procedure CheckWaiters; overload;
  procedure CheckWaiters(aParent: Tl3Variant;
   aChild: Tl3Variant); overload;
  function CheckDocumentPreviewCache: TevDocumentPreviewInfoList;
  function CheckInfoPreviewCache: TevDocumentPreviewInfoList;
  function StartLoading: Boolean;
  procedure SetLoaded;
  function DoFindParaByID(const aDocument: InevObject;
   aParaID: Integer;
   out aPara: InevObject): Boolean;
  procedure CheckCloseWindow;
  function RealizeSub(aLayerHandle: Integer;
   Atom: Tl3Variant;
   anObject: Tl3Variant;
   const anOpPack: InevOp): Tl3Variant; overload;
  procedure NotifySubDeleted(aSubTag: Tl3Variant;
   const aSub: IevSub);
  function GetGeneratorPrim(const aView: InevView;
   const aGeneratorTarget: IUnknown): Tk2TagGenerator;
  function DoStartAtom(G: Tk2DocumentGenerator;
   var Atom: Tk2StackAtom): Boolean;
  function DoFinishAtom(G: Tk2DocumentGenerator;
   var Atom: Tk2StackAtom): Boolean;
  function DoFinishAtom1(G: Tk2DocumentGenerator;
   var Atom: Tk2StackAtom): Boolean;
  procedure DoAddAtom(G: Tk2TagGenerator;
   const Atom: Tk2StackAtom;
   Prop: Integer;
   aSource: Tl3Variant);
  function DoBeforeFinishAtom1(aGenerator: Tk2DocumentGenerator;
   var anAtom: Tk2StackAtom): Boolean;
  function DoBeforeFinishAtom(G: Tk2DocumentGenerator;
   var Atom: Tk2StackAtom): Boolean;
  function StartIOOp(DoLock: Boolean): InevOp;
   {* открывает пачку операций ввода/вывода. }
  procedure MakeNext;
  procedure RealizeSubs(Parent: Tl3Variant;
   Atom: Tl3Variant;
   G: Tk2TagGenerator);
  procedure DoGetReader(aFormat: TnevFormat;
   const aPool: IStream;
   out theReader: Tk2CustomReader;
   anInternal: Boolean;
   aCodePage: Integer;
   const aBlock: IUnknown);
  function Make: InevDocumentContainer;
  function DoGetProcessor: InevProcessor;
  function DoGetDocumentLimits: InevDocumentLimits;
  function DoGetDocumentInfo: InevDocumentInfo;
  function GetHasProcessor: Boolean;
  function DoGetSubEx(anID: Integer;
   aLayerID: Integer): IevSub;
  function GetIsSame(const aContainer: InevDocumentContainer): Boolean;
  function GetIsSameText(const aContainer: InevDocumentContainer): Boolean; overload;
  function GetIsSameText(const aTextSource: IUnknown): Boolean; overload;
  function GetDocument: Tl3Tag;
  function GetContentsTree: InevSimpleTree;
  function PartGeneratorClass: RevDocumentPartGenerator;
  function NeedsProgressOnSave: Boolean;
  function GetDocumentType: Tk2Type;
  procedure Lock(const aLocker: IUnknown);
   {* закрыть. }
  procedure Unlock(const aLocker: IUnknown);
   {* открыть. }
  procedure Notify(const aNotifier: Il3ChangeNotifier;
   aOperation: Integer;
   aIndex: Integer);
   {* прошла операция. }
  function ReadTag(aFormat: TnevFormat;
   const aPool: IStream;
   const aFilters: InevTagGenerator;
   const Block: InevDataObjectPrim2;
   aFlags: TevdStoreFlags;
   aCodePage: Integer): Integer;
   {* считать тег из Storage в aPool. }
  function ReadTagEx(const Writer: InevTagGenerator;
   const aPool: IStream;
   const aBlock: InevDataObjectPrim2;
   aFlags: TevdStoreFlags;
   CharCountMul: Integer;
   const FormatName: Il3CString;
   aCodePage: Integer): Integer;
   {* записать документ в память (Pool) из TextSource. }
  function WriteTag(const aView: InevView;
   aFormat: TnevFormat;
   const aPool: IStream;
   const aBlock: IUnknown;
   aFlags: TevLoadFlags;
   aCodePage: Integer): Boolean;
   {* записать тэг из Pool в Storage. }
  procedure WriteTagEx(const aView: InevView;
   const aReader: InevReader;
   const aBlock: IUnknown;
   aFlags: TevLoadFlags);
   {* записать тэг из Pool в Storage. }
  function HasDocument: Boolean;
  function IsSame(const aContainer: InevDocumentContainer): Boolean;
  function IsSameText(const aTextSource: IUnknown): Boolean; overload;
  function IsSameText(const aContainer: InevDocumentContainer): Boolean; overload;
  function ReadFrom(const aStream: IStream): Boolean;
  procedure WriteTo(const aGenerator: InevTagGenerator);
  procedure LinkTextSource(const aTextSource: InevTextSource);
  procedure UnlinkTextSource(const aTextSource: InevTextSource);
  function HasProcessor: Boolean;
  procedure RemoveFromDocumentsCache;
  function Internal: IUnknown;
   {* //InevDocumentContainerInternal }
  procedure GetSubFlagsIterator(aLayer: Integer);
  function Preview(const aKey: TevPreviewCacheKey;
   const aMacroReplacer: IafwHAFMacroReplacer;
   const aRange: InevRange;
   TreatRangeAsSelection: Boolean): InevComplexDocumentPreview;
  function RealizeSub(aLayerHandle: Integer;
   Atom: Tl3Variant;
   anObject: Tl3Variant): Tl3Variant; overload;
  function LinkWaiter(const aWaiter: InevWaiter): Boolean;
  function GetGenerator(const aView: InevView;
   const aGeneratorTarget: IUnknown): InevTagGenerator;
  function TextSource: InevTextSource;
  function Processor: InevProcessor;
  function Document: IevDocument;
  function SubList: InevSubList;
  function DocumentInfo: InevDocumentInfo;
  function DocumentLimits: InevDocumentLimits;
   {* ограничения документа. }
  function AbortedLoad: Boolean;
   {* загрузка документа прервана. }
  function NeedProcessMessages: Boolean;
  function ContentsTree: InevSimpleTree;
  function ExistingDocument: Tl3Variant;
  function Sub: IevSub;
   {* метка с идентификатором anID на слое ev_sbtSub. }
  function SubEx: IevSub;
   {* метка с идентификатором anID на слое aLayerID. }
  function NewSub: IevSub;
   {* метка с новым ID на слое ev_sbtSub. }
  function NewSubEx: IevSub;
   {* метка с новым ID на слое aLayerID. }
  function Block: IevDocumentPart;
   {* блок с идетификатором anID. }
  function BlockEx: IevDocumentPart;
   {* блок с идетификатором anID. }
  function InternalDocument: Tl3Tag;
   {* документ. }
  procedure GetReader(aFormat: TnevFormat;
   const aPool: IStream;
   out theReader: Tk2CustomReader;
   anInternal: Boolean;
   aCodePage: Integer;
   const aBlock: IUnknown);
  procedure GetWriter(aFormat: TnevFormat;
   anInternal: Boolean;
   out theWriter: Tk2TagGenerator;
   const aFilters: InevTagGenerator;
   aCodePage: Integer); overload;
  function Loading: Boolean;
  procedure LinkSubChangeListener(const aSubChangeListener: InevSubChangeListener);
  procedure DoInvalidateShape(const aShape: InevObject;
   aParts: TnevShapeParts);
  function GetTagReader: InevTagReader;
  function GetTagWriter: InevTagWriter;
  procedure NotifyFlagsChange(const aSub: IevSub);
   {* флаги метки изменились }
  function DefaultDocumentType: Tk2Type;
   {* Тип документа по-умолчанию }
  procedure NotifySubAdded(aParaID: Integer;
   aSubID: Integer;
   aLayerID: Integer;
   const aSubName: Tl3WString;
   aFlags: Integer);
   {* Нотификация о добавлении Sub'а в другом "похожем" документе }
  function GetCommentTextByParaID(aParaID: Integer): Il3CString;
  procedure DeleteCommentByParaID(aParaID: Integer);
 end;//TnevDocumentContainer
 
implementation

uses
 l3ImplUses
 , l3Types
 , Classes
 , l3Stream
 , l3Chars
 , nevInterfaces
 , l3String
 , evDocumentsCache
 , l3InterfacesMisc
 , Messages
 , l3Base
 , l3Math
 , l3Except
 , nevFacade
 , evParaTools
 , evSearch
 , nevTextSourcePool
 , k2Tags
 , afwComplexDocumentPreviewFactory
 , evHighLevelDocumentGenerator
 , afwFacade
 , evDef
 , evSegLst
 , evdTypes
 , l3MinMax
 , evMsgCode
 , evSubImplementation
 , l3Nodes
 , evSubNode
 , evNode
 , l3Bits
 , SysUtils
 , k2BaseTypes
 , Mark_Const
 , CommentPara_Const
 , Document_Const
 , LeafPara_Const
 , SubLayer_Const
 , DocSubLayer_Const
 , Block_Const
 , Para_Const
 , StyledLeafPara_Const
 , TableCell_Const
 , Bookmark_Const
 , TextSegment_Const
 , ParaList_Const
 , Sub_Const
 , DocumentSub_Const
 , HyperLink_Const
 , TextPara_Const
 , evdTextStyle_Const
 , k2Facade
 , evTypes
 , evdStyles
 , LeafParaDecorationsHolder_Const
 , l3BaseStream
 , k2NullTagImpl
 , k2NilOp
;

type
 OevModified = class(Tk2Op)
 end;//OevModified
 
end.
