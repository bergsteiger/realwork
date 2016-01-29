unit l3Tree;

interface

uses
 l3IntfUses
 , l3ItemsStorage
 , l3InternalInterfaces
 , l3Interfaces
 , l3Tree_TLB
 , l3TreeInterfaces
 , SysUtils
;

type
 Tl3Tree = class(Tl3ItemsStorage, Il3ObjectWrap, Il3Window, Il3Tree, Il3TreeSource, Il3NodeNotifyRecipient)
  {* Структура данных "дерево". Используется как курсор для видимых элементов. }
  function Get__CRootNode: Il3RootNode;
  procedure DoNotify(aOperation: Integer;
   const aNode: Il3SimpleNode);
  function RootNode: Il3SimpleRootNode;
   {* корень дерева. }
  procedure Invalidate;
   {* Запрос на перерисовку. }
  function GetObject: TObject;
   {* получить объект из обертки. }
  function GetFlagsByAbsIndex(aAbsIndex: Integer): Integer;
  procedure SetFlagsByAbsIndex(aAbsIndex: Integer;
   aValue: Integer);
  function GetNodeByAbsIndex(aAbsIndex: Integer): Il3Node;
  function GetAbsIndex(const aCurNode: Il3Node): Integer;
  procedure Notify(aOperation: Integer;
   const aNode: Il3SimpleNode); overload;
   {* нотификация об операции над узлом. anOperation см. ntNone etc. }
  function ChangeExpand(const RNode: Il3Node;
   Mode: Tl3SetBitType;
   aForceMode: Boolean): Boolean; overload;
  function TestFlagMask(const aNode: Il3Node;
   aFlagMask: Integer): Boolean; overload;
  function TestFlagMask(aAbsIndex: Integer;
   aFlagMask: Integer): Boolean; overload;
  procedure SetFlagMask(aAbsIndex: Integer;
   aFlagMask: Integer;
   aMode: Tl3SetBitType); overload;
  procedure SetFlagMask(const aRNode: Il3Node;
   aFlagMask: Integer;
   aMode: Tl3SetBitType); overload;
  function GetPrev(const aCurNode: Il3Node): Il3Node; overload;
   {* возвращает узел, находящийся непосредственно перед указанным независимо от иерархии. }
  function IterateF(Action: Tl3NodeAction;
   IterMode: Integer;
   const aSubRootNode: Il3Node;
   const aFromNode: Il3Node): Il3Node;
   {* перебрать все узлы и освободить заглушку для Action. }
  procedure SetRootAndCountView(const aNode: Il3RootNode;
   aCountView: Integer);
   {* <?> Кандидат на удаление. }
  procedure SetAllFlag(aMode: Tl3SetBitType;
   aFlags: Integer);
  procedure PrintTreeList(const aFileName: TFileName;
   aWithNumber: Boolean;
   aIterMode: Integer;
   const aLevelIndent: AnsiString);
  function SearchByName(const aFirstNode: Il3Node;
   aNameStr: PAnsiChar;
   aIterMode: Integer): Il3Node;
  function FindNodeByParam(const Parent: Il3Node;
   Param: Integer;
   aIterMode: Integer): Il3Node;
  procedure ResetSelection;
  procedure LockSelModify;
  procedure UnLockSelModify;
  function GetNextSetFlag(const aCurNode: Il3Node;
   aFlag: Integer): Il3Node;
   {* //vvv }
  procedure ChangeName(const aNode: Il3Node;
   NewTitle: PAnsiChar);
   {* изменить название узла. }
  function InsertNode(const aParentNode: Il3Node;
   const aNode: Il3Node): Il3Node;
   {* вставить новый узел. }
  function InsertNodeBefore(const aNextNode: Il3Node;
   const aNode: Il3Node): Il3Node;
   {* вставить новый узел перед указанным. }
  procedure SetLevelSlash(const aSt: AnsiString);
  function IsSelect(const aNode: Il3Node): Boolean;
   {* является ли узел отмеченным. }
  function IsChildSelect(const aNode: Il3Node): Boolean;
  procedure Clear;
  function MoveSelectedNodes(aDirection: Tl3Direction): Boolean;
   {* перместить выделенные узлы }
  function DeleteSelectedNodes: Boolean;
   {* Удалить выделенные узлы, }
  function CNodes: Il3Node;
   {* узлы по индексу. }
  function SelectedNode: Boolean;
   {* выделенные узлы. }
  function NodeFlags: Integer;
   {* флаги узлов. (см. nfSelected etc) }
  function CRootNode: Il3RootNode;
   {* корневой узел дерева. }
  function CommonExpanded: Boolean;
  function SelModifiedCount: Integer;
  function Modified: Boolean;
   {* признак изменения структуры данных. }
  function Strings: PAnsiChar;
   {* строчки узлов по видимому индексу [0..CountView-1]. }
  function Tree: Il3Tree;
   {* Дерево, предоставляемое источником. }
  function GetNextSelect(const aCurNode: Il3Node): Il3Node;
  procedure Notify(aOperation: Integer;
   const aNode: Il3SimpleNode); overload;
   {* прошла операция. }
  procedure CursorTop;
   {* переставить курсор на первый видимый элемент. }
  function GetIndex(const aNode: Il3SimpleNode;
   const aSubRootNode: Il3SimpleNode): Integer;
   {* возвращает видимый индекс aNode относительно aSubRootNode или корня. }
  function GetLevel(const aNode: Il3SimpleNode): Integer;
   {* возвращает уровень узла относительно корня. }
  procedure SelectAllNodes(aMode: Tl3SetBitType);
   {* выделяет/развыделяет все узлы. }
  procedure SelectInterval(aFirstIndex: Integer;
   aLastIndex: Integer;
   aMode: Tl3SetBitType;
   aCleanOther: Boolean);
   {* выделяет/развыделяет узлы на указанном интервале. }
  function ChangeExpand(const aNode: Il3SimpleNode;
   aMode: Tl3SetBitType;
   aForceMode: Boolean): Boolean; overload;
   {* меняет развернутость узла. }
  procedure ExpandSubDir(const aNode: Il3SimpleNode;
   anExpand: Boolean;
   aDeepLevel: Byte);
   {* развернуть/свернуть узлы. }
  procedure SetBranchFlag(const aParentNode: Il3SimpleNode;
   aMode: Tl3SetBitType;
   aFlagsMask: Integer;
   anIterMode: Integer);
   {* зачем-то используется визуалкой в ExpandNode. }
  function CountViewItemsInSubDir(const aNode: Il3SimpleNode): Integer;
   {* зачем-то используется визуалкой в ShowMoreChildrenOnScreen. }
  function IsRoot(const aNode: Il3SimpleNode): Boolean;
   {* является ли узел корневым для дерева. }
  function IsExpanded(const aNode: Il3SimpleNode): Boolean;
   {* раскрыт ли узел. }
  function IsFirstVis(const aNode: Il3SimpleNode): Boolean;
   {* является ли узел первым видимым в ветке. }
  function IsLastVis(const aNode: Il3SimpleNode): Boolean;
   {* является ли узел последним видимым в ветке. }
  function HasVisibleChildren(const aNode: Il3SimpleNode): Boolean;
   {* есть ли видимые дети у aNode. }
  function GetLines(const aNode: Il3SimpleNode): Integer;
   {* маска для рисования линий (надо смотреть реализацию). }
  function Wake: Boolean;
   {* проснись!!! Типа начали рисовать. }
  function MoveNode(const aNode: Il3SimpleNode;
   aDirection: Tl3Direction): Boolean;
   {* переместить узел. }
  function SearchNameBegin(const aFirstNode: Il3SimpleNode;
   aSrchStr: PAnsiChar;
   aIterMode: Integer): Il3SimpleNode;
   {* зачем-то используется визуалкой в CharToItem. }
  function SearchNameOccur(const aFirstNode: Il3SimpleNode;
   aSrchStr: PAnsiChar;
   aIterMode: Integer): Il3SimpleNode;
   {* зачем-то используется визуалкой в SearchOccurStr,  который сейчас никем не используется. }
  function MakeNodeVisible(const aNode: Il3SimpleNode): Integer;
   {* зачем-то используется визуалкой в CharToItem, видимо для перемещения курсора на узел. }
  function GetPrev(const aNode: Il3SimpleNode): Il3SimpleNode; overload;
   {* предыдущий узел. Зачем-то используется в CharToItem. }
  function SimpleIterateF(Action: Tl3SimpleNodeAction;
   IterMode: Integer;
   const aSubRootNode: Il3SimpleNode): Il3SimpleNode;
   {* перебрать все узлы и освободить заглушку для Action. IterMode: imCheckResult, imParentNeed }
  function IsChanging: Boolean;
   {* дерево находится в фазе обновления. }
  procedure Changing;
  procedure Changed;
  function ShowRoot: Boolean;
   {* показывать ли корень? }
  function CountView: Integer;
   {* полное количество видимых элементов. }
  function SelectCount: Integer;
   {* количество выделенных узлов. }
  function Flags: Integer;
   {* флаги узлов по видимому индексу [0..CountView-1]. }
  function Select: Boolean;
   {* признак видимости узлов по видимому индексу [0..CountView-1]. }
  function Nodes: Il3SimpleNode;
   {* возвращает узел по видимому индексу [0..CountView-1]. }
  function MakeDataObject(const aNode: Il3SimpleNode;
   const aBitmap: IUnknown): IDataObject;
   {* сделать объект данных дерева, используется при перемещении элементов дерева в другие компоненты }
  function CanAcceptData(const aTargetNode: Il3SimpleNode;
   const aData: Tl3TreeData): Boolean;
  function DropData(const aTargetNode: Il3SimpleNode;
   const aData: Tl3TreeData): Boolean;
  procedure ClearSelected;
 end;//Tl3Tree
 
implementation

uses
 l3ImplUses
;

end.
