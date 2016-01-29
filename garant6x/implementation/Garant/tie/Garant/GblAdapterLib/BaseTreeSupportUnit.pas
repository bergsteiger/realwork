unit BaseTreeSupportUnit;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "GblAdapterLib"
// Модуль: "w:/garant6x/implementation/Garant/tie/Garant/GblAdapterLib/BaseTreeSupportUnit.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::BaseTreeSupport
//
// Поддержка старого дерева.
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
  BaseTypesUnit,
  ContextSearchSupportUnit
  ;

type
 TEntityType = Cardinal;
  {* идентификатор типа сущности лежащей в Ноде. В каждом конкретном дереве определяется как AdapterEnum }

 CopyDisabled = class
  {* Возвращается если нода не может быть скопирована. }
 end;//CopyDisabled

 InvalidContainer = class
  {* Вызывается при попытке использовать нодй не являющуюся контенером как контейнер. }
 end;//InvalidContainer

 MoveDisabled = class
  {* Возвращается если нода не может быть перенесена. }
 end;//MoveDisabled

 InvalidEntityType = class
  {* Возвращается при попытке присвоить одной сущности сущность другого типа. }
 end;//InvalidEntityType

 InvalidIndex = class
  {* Возвращается при попытке получить элемент списка по несуществующему индексу. Т.е. index<0 или index>=count. }
 end;//InvalidIndex

 NotEntityElement = class
  {* Возвращается при попытке вызвать операцию open у элемента каталога, не являющегося сущностью (в частности у папки). }
 end;//NotEntityElement

 INode = interface(IEntityStorage)
  {* Интерфейс для чтения данных об элементе древовидной структуры. }
   ['{A050343E-CA33-4D63-8385-2FFBD9B012DA}']
   function GetLevel: Integer; stdcall;
   function GetChildCount: Integer; stdcall;
   function GetAllChildCount: Integer; stdcall;
   function GetFlags: Integer; stdcall;
   function GetIndex: Integer; stdcall;
   function GetThroughIndex: Integer; stdcall;
   function GetParent: INode; stdcall;
   function GetPreviousNode: INode; stdcall;
   function GetNextNode: INode; stdcall;
   function GetCaption: IString; stdcall;
   procedure SetCaption(const aValue: IString); stdcall;
   function GetHint: IString; stdcall;
   procedure SetHint(const aValue: IString); stdcall;
   function GetObjectType: TEntityType; stdcall;
   procedure GetChild(aIndex: Integer; out aRet {: INode}); stdcall; // can raise InvalidIndex
     {* Получить интерфейс на один из вложенных элементов.
Параметр должен принимать значения из диапазона: 0<=index<=(child_coun-1) }
   function IsSameNode(const aNode: INode): ByteBool; stdcall;
     {* Сравнивает текущий элемент с элементом, поданным в параметре node.
Возвращает true в случае совпадения. }
   procedure Open(out aRet {: IUnknown}); stdcall; // can raise CanNotFindData, NotEntityElement
     {* Возвращает интерфейс для работы с конкретным элементом (сущностью) системы. }
   procedure DeleteNode; stdcall; // can raise ConstantModify, AccessDenied, EmptyResult
     {* Удаляет указанные узел из списка/дерева.
Если указан элемент, имеющий вложенные элементы, то они тоже удаляются. Если список/дерево созданно как константное (неизменяемое) то генерится исключение ConstantModify }
   procedure AddChildNode(const aEntity: IUnknown; out aRet {: INode}); stdcall; // can raise ConstantModify, AccessDenied, Unsupported, DuplicateNode, InvalidEntityType
     {* Добавляет сущность как ребенка к указанной ноде, возвращает новую созданную ноду. Если список/дерево созданно как константное (неизменяемое) то генерится исключение ConstantModify. Если нода не может содержать детей возвращается исключение InvalidContainer }
   procedure AddSiblingNode(const aEntity: IUnknown; out aRet {: INode}); stdcall; // can raise ConstantModify, Unsupported, DuplicateNode
     {* Добавляет сущность как "соседа" справа к указанной ноде, возвращает новую созданную ноду. Если список/дерево созданно как константное (неизменяемое) то генерится исключение ConstantModify }
   procedure MoveToLocation(var aDestination: INode); stdcall; // can raise InvalidContainer, MoveDisabled
     {* Переносит текущую ноду в указанный узел, делая ее его ребенком. Если узел не может пнринять ноду (т.е. вставить ее в себя), то генерируется исключение InvalidContainer. Если операция перемещения узлов не доступна, генерируется исключение MoveDisabled }
   procedure CopyToLocation(var aDestination: INode); stdcall; // can raise CopyDisabled, InvalidContainer
     {* Сопирует текущую ноду и оекурсивно все ее содержимое, в указанный узел, делая ее его ребенком. Если узел не может пнринять ноду (т.е. вставить ее в себя), то генерируется исключение InvalidContainer. Если операция копирования узлов не доступна, генерируется исключение CopyDisabled }
   function CanMove: ByteBool; stdcall;
     {* можно ли переместить ноду }
   function CanCopy: ByteBool; stdcall;
     {* можно ли скопировать ноду }
   function CanInsert(var aSource: INode): ByteBool; stdcall;
     {* можно ли вставить ноду }
   function IsLast: ByteBool; stdcall;
     {* Последнией элемент. }
   function IsFirst: ByteBool; stdcall;
     {* Первый элемент. }
   function HasChild: ByteBool; stdcall;
     {* Есть ли дочерние элементы. }
   procedure OverrideChildNode(const aEntity: IUnknown; out aRet {: INode}); stdcall; // can raise ConstantModify, AccessDenied, Unsupported, DuplicateNode, InvalidEntityType
     {* перезаписать дочернюю ноду }
   function CanModify: ByteBool; stdcall;
     {* можно ли модифицировать ноду }
   property level: Integer
     read GetLevel;
     {* Уровень вложенности элемента в древовидной структуре.
У root_node=0. }
   property child_count: Integer
     read GetChildCount;
     {* Количество вложенных элементов для текущего (один уровень).
У листьевых элементов =0. }
   property all_child_count: Integer
     read GetAllChildCount;
     {* Количество вложенных элементов для текущего с учетом всех уровней вложенности.
У листьевых элементов =0. }
   property flags: Integer
     read GetFlags;
     {* Поле для передачи дополнительной винарной информации о статусе элемента. }
   property index: Integer
     read GetIndex;
     {* Позиция текущего элемента в предке (parent). }
   property through_index: Integer
     read GetThroughIndex;
     {* Сквозная позиция элемента. }
   property parent: INode
     read GetParent;
     {* родитель }
   property previous_node: INode
     read GetPreviousNode;
     {* предыдущая нода в дереве }
   property next_node: INode
     read GetNextNode;
     {* следующая нода в дереве }
   property caption: IString
     read GetCaption
     write SetCaption;
     {* название }
   property hint: IString
     read GetHint
     write SetHint;
     {* информация о ноде }
   property object_type: TEntityType
     read GetObjectType;
     {* тип сущности, представляемой нодой }
 end;//INode

 IBaseCatalog = interface(IUnknown)
  {* Базовый интерфейс для работы с древовидными и/или линейными списками различных сущностей системы. Навигация по структуре (дерево или линейный список) осуществляется через экземпляры интерфейса Node. При этом каждый екземпляр Node может быть приведен к интерфейсу необходимой сущности через метод open интерфейса BaseCatalog. Для того что бы сущность можно было привести таким образом, ее экземпляр должен реализовывать интерфейс BaseEntity.
В случае если конкретное дерево не поддерживает тех или иных операция определенных на BaseCatalog, то при их вызове должно генерироваться исключение }
   ['{B41C62C4-F733-4465-9B22-3D4C52162F8A}']
   function GetRoot: INode; stdcall;
   function GetFilter: TEntityType; stdcall;
   procedure SetFilter(aValue: TEntityType); stdcall;
   procedure Find(const aEntity: IUnknown
    {* Искомый элемент.}; out aRet {: INode}); stdcall;
     {* Найти узел по его элементу. }
   procedure FindContext(aMask: PAnsiChar;
    const aMode: TSearchMode;
    const aCurItem: INode;
    out aResult: TContextSearchResult
    {* Результат поиска. При этом возвращается сквозной индекс.}; out aRet {: INode}); stdcall;
     {* Поиск контекста среди элементов списка. }
   procedure ResetTypeFilter; stdcall;
     {* сбрасывает все установленные фильтры по типам }
   property root: INode
     read GetRoot;
     {* корень дерева }
   property filter: TEntityType
     read GetFilter
     write SetFilter;
     {* наложенный фильтр }
 end;//IBaseCatalog

 TBaseTreeNodeMask = Cardinal;
  {* флаги на старой ноде }

implementation

end.