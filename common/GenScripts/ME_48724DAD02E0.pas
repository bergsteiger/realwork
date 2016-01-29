unit l3SimpleTree;

interface

uses
 l3IntfUses
 , l3CacheableBase
 , l3TreeInterfaces
 , l3Interfaces
;

type
 Tl3SimpleTree = class(Tl3CacheableBase, Il3SimpleTree)
  {* "Простое" дерево. }
  procedure Create(const aRoot: Il3SimpleRootNode);
  procedure Make(const aRoot: Il3SimpleRootNode);
  procedure RootChanged(const aOld: Il3SimpleRootNode;
   const aNew: Il3SimpleRootNode);
  function RootNode: Il3SimpleRootNode;
   {* корень дерева. }
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
   aForceMode: Boolean): Boolean;
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
  function GetPrev(const aNode: Il3SimpleNode): Il3SimpleNode;
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
 end;//Tl3SimpleTree
 
implementation

uses
 l3ImplUses
 , l3InterfacesMisc
 , l3Bits
 , l3Types
 , l3Base
 , SysUtils
;

end.
