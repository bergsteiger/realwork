unit F1TagDataProviderInterface;
 {* Интерфейс для получения данных тега }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\f1DocumentTagsImplementation\F1TagDataProviderInterface.pas"
// Стереотип: "Interfaces"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , IOUnit
 , l3Interfaces
 , k2Base
 , DocumentUnit
 , l3Variant
 , nevBase
 , nevTools
;

 (*
 Mf1SimpleTagDataProvider = interface
  {* Источник данных для "простого" тега }
  function Get_Caption: IString;
  function Get_Style: IStream;
  function Get_ExternalID: Integer;
  function Get_TypeID: Tk2Type;
  function Get_AsDocumentTextProvider: IDocumentTextProvider;
  function Get_IsProviderGot: Boolean;
  property Caption: IString
   read Get_Caption;
  property Style: IStream
   read Get_Style;
  property ExternalID: Integer
   read Get_ExternalID;
  property TypeID: Tk2Type
   read Get_TypeID;
  property AsDocumentTextProvider: IDocumentTextProvider
   read Get_AsDocumentTextProvider;
   {* Приведение к IDocumentTextProvider }
  property IsProviderGot: Boolean
   read Get_IsProviderGot;
   {* Провайдер данных уже был получен. Можно всё смело вычитывать }
 end;//Mf1SimpleTagDataProvider
 *)

 (*
 Mf1CommentTagDataProvider = interface
  procedure Set_wStyle(const aValue: IStream);
  property wStyle: IStream
   write Set_wStyle;
 end;//Mf1CommentTagDataProvider
 *)

type
 TnsNodeState = (
  ns_nsStyleParsed
  , ns_nsSubsBuilt
  , ns_nsInParse
  , ns_nsNotNeedSynchronizeWithTree
  , ns_nsChanged
 );//TnsNodeState

 TnsNodeStates = set of TnsNodeState;

 If1TagWrap = interface
  ['{0494E06B-231B-4338-BC12-F49E8BA1643A}']
  function Get_Tag: Tl3Tag;
  property Tag: Tl3Tag
   read Get_Tag;
 end;//If1TagWrap

 If1TagDataProvider = interface;

 If1ChildMaker = interface;

 (*
 Mf1ListTagDataProvider = interface
  function Get_AllParaChildrenCount: Integer;
  function Get_ChildrenCount: Integer;
  function Get_FirstChild: If1TagDataProvider;
  function Get_SiblingByIndex(anIndex: Integer): If1TagDataProvider;
  function Get_Next: If1TagDataProvider;
  procedure CreateNewNode(var theIndex: Integer;
   var theNode: Tl3Tag;
   const aMaker: If1ChildMaker;
   const anOp: InevOp);
  property AllParaChildrenCount: Integer
   read Get_AllParaChildrenCount;
  property ChildrenCount: Integer
   read Get_ChildrenCount;
  property FirstChild: If1TagDataProvider
   read Get_FirstChild;
  property SiblingByIndex[anIndex: Integer]: If1TagDataProvider
   read Get_SiblingByIndex;
  property Next: If1TagDataProvider
   read Get_Next;
 end;//Mf1ListTagDataProvider
 *)

 If1AtomChecker = interface;

 (*
 Mf1LeafTagDataProvider = interface
  function Get_Comment: IStream;
  function Get_TechComment: IString;
  procedure BuildSubs(aProp: Tk2CustomProperty;
   const aChecker: If1AtomChecker);
  property Comment: IStream
   read Get_Comment;
   {* Комментарий к параграфу }
  property TechComment: IString
   read Get_TechComment;
   {* Технический комментарий }
 end;//Mf1LeafTagDataProvider
 *)

 If1TagDataProvider = interface
  {* Источник данных тега }
  ['{7ABEBCFD-8A7D-4696-904D-39744685C71A}']
  function Get_Caption: IString;
  function Get_Style: IStream;
  function Get_ExternalID: Integer;
  function Get_TypeID: Tk2Type;
  function Get_AsDocumentTextProvider: IDocumentTextProvider;
  function Get_IsProviderGot: Boolean;
  procedure Set_wStyle(const aValue: IStream);
  function Get_AllParaChildrenCount: Integer;
  function Get_ChildrenCount: Integer;
  function Get_FirstChild: If1TagDataProvider;
  function Get_SiblingByIndex(anIndex: Integer): If1TagDataProvider;
  function Get_Next: If1TagDataProvider;
  function Get_Comment: IStream;
  function Get_TechComment: IString;
  procedure CreateNewNode(var theIndex: Integer;
   var theNode: Tl3Tag;
   const aMaker: If1ChildMaker;
   const anOp: InevOp);
  procedure BuildSubs(aProp: Tk2CustomProperty;
   const aChecker: If1AtomChecker);
  property Caption: IString
   read Get_Caption;
  property Style: IStream
   read Get_Style;
  property ExternalID: Integer
   read Get_ExternalID;
  property TypeID: Tk2Type
   read Get_TypeID;
  property AsDocumentTextProvider: IDocumentTextProvider
   read Get_AsDocumentTextProvider;
   {* Приведение к IDocumentTextProvider }
  property IsProviderGot: Boolean
   read Get_IsProviderGot;
   {* Провайдер данных уже был получен. Можно всё смело вычитывать }
  property wStyle: IStream
   write Set_wStyle;
  property AllParaChildrenCount: Integer
   read Get_AllParaChildrenCount;
  property ChildrenCount: Integer
   read Get_ChildrenCount;
  property FirstChild: If1TagDataProvider
   read Get_FirstChild;
  property SiblingByIndex[anIndex: Integer]: If1TagDataProvider
   read Get_SiblingByIndex;
  property Next: If1TagDataProvider
   read Get_Next;
  property Comment: IStream
   read Get_Comment;
   {* Комментарий к параграфу }
  property TechComment: IString
   read Get_TechComment;
   {* Технический комментарий }
 end;//If1TagDataProvider

 If1AtomChecker = interface(If1TagWrap)
  ['{FBFABCD3-5D71-4724-BB38-022917F1DC06}']
  function CheckAtom(aProp: Tk2CustomProperty): Tl3Tag;
  function MakeSubTag(const aProvider: If1TagDataProvider): Il3TagRef;
 end;//If1AtomChecker

 If1ChildMaker = interface(If1TagWrap)
  ['{FF5212F0-41B4-4735-978C-A1A83F959065}']
  function MakeChildTag(const aNode: If1TagDataProvider;
   aState: TnsNodeStates): Il3TagRef;
 end;//If1ChildMaker

 If1CommentSink = interface;

 IEVDStream = IStream;

 If1CommentSink = interface
  ['{60FAA2EE-026E-40DE-B4F8-1E1A779081C4}']
  function Get_State: TnsNodeStates;
  procedure Set_State(aValue: TnsNodeStates);
  procedure Store(const aStream: IEVDStream);
  property State: TnsNodeStates
   read Get_State
   write Set_State;
 end;//If1CommentSink

 InsDocumentAdornments = interface
  ['{880FD72B-19C6-4FFB-8F08-BC9E3B71A21E}']
  function Get_Bookmarks: IBookmarkList;
  function Get_Comments: ICommentsParaList;
  function Get_ExternalObjects: IExternalObjectDataList;
  function As_InevCommentTextProvider: InevCommentTextProvider;
   {* Метод приведения нашего интерфейса к InevCommentTextProvider }
  property Bookmarks: IBookmarkList
   read Get_Bookmarks;
  property Comments: ICommentsParaList
   read Get_Comments;
  property ExternalObjects: IExternalObjectDataList
   read Get_ExternalObjects;
 end;//InsDocumentAdornments

 If1EditionDocumentContainer = interface
  ['{1DBC85CB-1521-46AD-88F5-31AD7C115EE9}']
  function CollapsedTagDefaultValueForPara(aTag: Tl3Tag): Boolean;
 end;//If1EditionDocumentContainer

implementation

uses
 l3ImplUses
;

end.
