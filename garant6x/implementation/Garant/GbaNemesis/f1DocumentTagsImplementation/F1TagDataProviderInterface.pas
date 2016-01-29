unit F1TagDataProviderInterface;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "f1DocumentTagsImplementation"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/f1DocumentTagsImplementation/F1TagDataProviderInterface.pas"
// Начат: 20.08.2010 18:36
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> F1 Базовые определения предметной области::LegalDomain::f1DocumentTagsImplementation::F1TagDataProviderInterface
//
// Интерфейс для получения данных тега
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
  IOUnit,
  DocumentUnit,
  DynamicTreeUnit,
  DocTreeUnit,
  l3Interfaces,
  k2Interfaces,
  nevBase,
  nevTools,
  k2Base,
  l3Variant
  ;

(*
 Mf1SimpleTagDataProvider = PureMixIn
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
 Mf1CommentTagDataProvider = PureMixIn
   procedure Set_WStyle(const aValue: IStream);
   property wStyle: IStream
     write Set_WStyle;
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

 If1TagWrap = interface(IUnknown)
   ['{0494E06B-231B-4338-BC12-F49E8BA1643A}']
   function Get_Tag: Tl3Tag;
   property Tag: Tl3Tag
     read Get_Tag;
 end;//If1TagWrap
 If1TagDataProvider = interface;
 { - предварительное описание If1TagDataProvider. }

 If1ChildMaker = interface;
 { - предварительное описание If1ChildMaker. }


(*
 Mf1ListTagDataProvider = PureMixIn
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
 { - предварительное описание If1AtomChecker. }


(*
 Mf1LeafTagDataProvider = PureMixIn
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

 If1TagDataProvider = interface(IUnknown)
  {* Источник данных тега }
   ['{7ABEBCFD-8A7D-4696-904D-39744685C71A}']
  // Mf1SimpleTagDataProvider
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
  // Mf1CommentTagDataProvider
   procedure Set_WStyle(const aValue: IStream);
   property wStyle: IStream
     write Set_WStyle;
  // Mf1ListTagDataProvider
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
  // Mf1LeafTagDataProvider
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

  IEVDStream = l3Interfaces.IStream;

 If1CommentSink = interface(IUnknown)
   ['{60FAA2EE-026E-40DE-B4F8-1E1A779081C4}']
   function Get_State: TnsNodeStates;
   procedure Set_State(aValue: TnsNodeStates);
   procedure Store(const aStream: IEVDStream);
   property State: TnsNodeStates
     read Get_State
     write Set_State;
 end;//If1CommentSink

 InsDocumentAdornments = interface(IUnknown{, InevCommentTextProvider})
   ['{880FD72B-19C6-4FFB-8F08-BC9E3B71A21E}']
   function Get_Bookmarks: IBookmarkList;
   function Get_Comments: ICommentsParaList;
   function Get_ExternalObjects: IExternalObjectDataList;
   property Bookmarks: IBookmarkList
     read Get_Bookmarks;
   property Comments: ICommentsParaList
     read Get_Comments;
   property ExternalObjects: IExternalObjectDataList
     read Get_ExternalObjects;
  // Методы преобразования к реализуемым интерфейсам
   function As_InevCommentTextProvider: InevCommentTextProvider;
 end;//InsDocumentAdornments

 If1EditionDocumentContainer = interface(IUnknown{, Области с перечнем дат в сравнении редакций должны быть раскрыты})
   ['{1DBC85CB-1521-46AD-88F5-31AD7C115EE9}']
   function CollapsedTagDefaultValueForPara(aTag: Tl3Tag): Boolean;
 end;//If1EditionDocumentContainer

implementation

end.