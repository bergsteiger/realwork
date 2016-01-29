unit l3TreeInterfaces;

interface

uses
 l3IntfUses
 , l3Interfaces
;

type
 Il3Nodes = interface
  {* контейнер узлов }
 end;//Il3Nodes
 
 Il3NotifySource = interface(Il3ChangeNotifier)
  {* Объект, рассылающий нотификацию об изменении структуры. }
 end;//Il3NotifySource
 
 Il3SimpleNode = interface;
 
 Tl3TreeData = record
  {* Запись с данными о перемещаемом объекте }
 end;//Tl3TreeData
 
 Il3SimpleNode = interface
  {* Узел дерева. }
  function IsFirst: Boolean;
   {* это первый узел внутри родителя? }
  function IsLast: Boolean;
   {* это последний узел внутри родителя? }
  function HasChild: Boolean;
   {* есть ли дочерние узлы? }
  function MaybeChild: Boolean;
   {* может ли иметь дочерние узлы? }
  function GetLevel: Integer;
  function GetLevelFor(const aNode: Il3SimpleNode): Integer;
  function IsSame(const aNode: Il3SimpleNode): Boolean;
   {* сравнивает ноды. }
  function IsDisappeared: Boolean;
   {* True если интерфейс на удаленную ноду,
             применяется в виртуальных нодах - указателях на данные. }
  procedure BeginMove(var aUserParam: Pointer);
   {* начать перемещение узла. }
  procedure EndMove(aUserParam: Pointer);
   {* закончить перемещение узла. }
  procedure Delete;
   {* удалить узел из дерева, а его данные с постоянного носителя (например из БД) или связанные объекты. }
  function CanAcceptData(const aData: Tl3TreeData): Boolean;
   {* может ли узел принять данные }
  function DropData(const aData: Tl3TreeData): Boolean;
   {* принять данные }
  function CanMove: Boolean;
   {* определяет возможность перемещения узла }
 end;//Il3SimpleNode
 
 Il3SimpleRootNode = interface(Il3SimpleNode)
  function CanExpandCollapseAll: Boolean;
  procedure ExpandCollapseAll(anExpand: Boolean);
 end;//Il3SimpleRootNode
 
 Tl3SimpleNodeAction = function(const Intf: Il3SimpleNode): Boolean;
  {* Подитеративная функция для перебора элементов дерева. Если возвращает true, то процесс перебора узлов прекращается. }
 
 Il3RootSource = interface(Il3NotifySource)
  {* Источник корня дерева. }
 end;//Il3RootSource
 
 Il3HandleNode = interface
  {* Узел дерева с целочисленным идентификатором. }
 end;//Il3HandleNode
 
 Il3TreeFilters = interface
  {* фильтры реально установленные на дереве }
  function SetContext(const aValue: Il3CString): Il3TreeFilters;
  function Clone: Il3TreeFilters;
 end;//Il3TreeFilters
 
 Il3ContextFilterParamsNotifier = interface
  {* нотификатор о том что параметры изменились. }
  procedure ParamsChanged;
 end;//Il3ContextFilterParamsNotifier
 
 Il3ContextFilterTarget = interface
  {* проверяет что контекст тот же самый. }
  function IsSameContext(const aContext: Il3CString;
   out DiffStart: Cardinal): Boolean;
 end;//Il3ContextFilterTarget
 
 Il3ContextFilterParamsNotifySource = interface
  {* источник нотификации о том что параметры изменились. }
  procedure Subscribe(const aSubscriber: Il3ContextFilterParamsNotifier);
  procedure UnSubscribe(const aSubscriber: Il3ContextFilterParamsNotifier);
 end;//Il3ContextFilterParamsNotifySource
 
 Il3Base = l3Interfaces.Il3Base;
  {* Базовый предок. }
 
 Il3SimpleTree = interface(Il3RootSource)
  {* Дерево. }
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
  function MakeDataObject(const aNode: Il3SimpleNode;
   const aBitmap: IUnknown): IDataObject;
   {* сделать объект данных дерева, используется при перемещении элементов дерева в другие компоненты }
  function CanAcceptData(const aTargetNode: Il3SimpleNode;
   const aData: Tl3TreeData): Boolean;
  function DropData(const aTargetNode: Il3SimpleNode;
   const aData: Tl3TreeData): Boolean;
 end;//Il3SimpleTree
 
 Il3RootSpy = interface(Il3Notify)
  {* Объект, следящий за изменением корня. }
  procedure RootChanged(const anOldRoot: Il3SimpleRootNode;
   const aNewRoot: Il3SimpleRootNode);
 end;//Il3RootSpy
 
 Il3NodeNotifyRecipient = interface(Il3Notify)
  {* Подписчик для получения нотификации об операции. }
  procedure Notify(aOperation: Integer;
   const aNode: Il3SimpleNode);
   {* прошла операция. }
 end;//Il3NodeNotifyRecipient
 
 Il3FilterableTree = interface
  {* дерево умеющее накладывать фильтры. }
  function CloneFilters: Il3TreeFilters;
  function MakeFiltered(const aFilters: Il3TreeFilters;
   const aCurrentNode: Il3SimpleNode;
   out aSyncIndex: Integer {* Нода для синхронизации. Индекс этой ноды в
                                   фильтрованном вью, будет возвращен в
                                   параметре sync_index. };
   aAutoOpen: Boolean {* Раскрывать узлы с фильтром автоматически.
                                   Узлы, часть детей которых отфильтрованно,
                                   будут автоматически раскрываться. };
   CalcPartialContext: Boolean {* пытаться вычислить максимальный контекстный фильтр,
                                   который еще вернет данные }): Il3SimpleTree;
 end;//Il3FilterableTree
 
 Il3ContextFilterParams = interface
  {* параметры с которыми будет накладывается контекстный фильтр }
  function WordPosition: Tl3WordPosition;
  function WordOrder: Tl3WordOrder;
  function TreeLevelDist: Tl3TreeLevelDist;
 end;//Il3ContextFilterParams
 
 Il3ContextFilterNotifier = interface
  {* нотификатор об изменении контекстного фильтра }
  procedure RequestReapply;
   {* Желательно переприменить фильтр. }
  procedure RequestClearAndTurnOff;
   {* Дерево выключило на себе фильтр. }
  procedure RequestCheckValid;
   {* Дерево поменялось - нужно проверить валидность фильтра. }
 end;//Il3ContextFilterNotifier
 
 Il3ContextFilterNotifySource = interface
  {* источник нотификации о том что параметры изменились }
  procedure SubscribeToContextFilter(const aSubscriber: Il3ContextFilterNotifier);
  procedure UnSubscribeFromContextFilter(const aSubscriber: Il3ContextFilterNotifier);
 end;//Il3ContextFilterNotifySource
 
 Il3ContextFilterTargetContainer = interface
  {* Контайнер для проверяльшика }
  function Unfold: Il3ContextFilterTarget;
 end;//Il3ContextFilterTargetContainer
 
 Il3Wake = interface
  function Wake: Boolean;
 end;//Il3Wake
 
 Il3SimpleTreeSource = interface
 end;//Il3SimpleTreeSource
 
 Il3CountViewChangeRecipient = interface
  {* Подписчик для получения нотификации об изменении количества видимых элементов. }
  procedure CountViewChanged(aCountView: Integer);
   {* прошла операция. }
 end;//Il3CountViewChangeRecipient
 
 Il3SimpleInternalNode = interface
 end;//Il3SimpleInternalNode
 
 Pl3TreeData = ^Tl3TreeData;
  {* указатель на данные о перемещаемом объекте }
 
 Il3ExpandedSimpleTree = interface(Il3SimpleTree)
  {* Дерево с расширенной функциональностью. }
  function FlagIterateF(Action: Tl3SimpleNodeAction;
   FlagMask: Word;
   IterMode: Integer;
   const aSubRootNode: Il3SimpleNode;
   aCheckResult: Boolean): Il3SimpleNode;
   {* перебрать все узлы, удовлетворяющие FlagMask, и освободить заглушку для Action. IterMode: imCheckResult, imParentNeed }
 end;//Il3ExpandedSimpleTree
 
 Il3ExtItemNode = interface
  {* Нода из связанного словаря. А место ли ей в этом модуле? }
 end;//Il3ExtItemNode
 
implementation

uses
 l3ImplUses
;

end.
