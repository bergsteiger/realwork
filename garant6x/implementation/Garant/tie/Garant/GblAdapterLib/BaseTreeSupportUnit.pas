unit BaseTreeSupportUnit;
 {* Поддержка старого дерева. }

// Модуль: "w:\garant6x\implementation\Garant\tie\Garant\GblAdapterLib\BaseTreeSupportUnit.pas"
// Стереотип: "Interfaces"
// Элемент модели: "BaseTreeSupport" MUID: (456F02A50196)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , IOUnit
 , BaseTypesUnit
 , ContextSearchSupportUnit
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
  procedure GetParent; stdcall;
  procedure GetPreviousNode; stdcall;
  procedure GetNextNode; stdcall;
  procedure GetCaption; stdcall;
  procedure SetCaption(const aValue); stdcall; { can raise ConstantModify, AccessDenied }
  procedure GetHint; stdcall;
  procedure SetHint(const aValue); stdcall; { can raise ConstantModify, AccessDenied }
  function GetObjectType: TEntityType; stdcall; { can raise Unsupported }
  procedure GetChild(index: Integer;
   out aRet
   {* INode }); stdcall; { can raise InvalidIndex }
   {* Получить интерфейс на один из вложенных элементов.
Параметр должен принимать значения из диапазона: 0<=index<=(child_coun-1) }
  function IsSameNode(const node: INode): ByteBool; stdcall;
   {* Сравнивает текущий элемент с элементом, поданным в параметре node.
Возвращает true в случае совпадения. }
  procedure Open(out aRet
   {* IUnknown }); stdcall; { can raise CanNotFindData, NotEntityElement }
   {* Возвращает интерфейс для работы с конкретным элементом (сущностью) системы. }
  procedure DeleteNode; stdcall; { can raise ConstantModify, AccessDenied, EmptyResult }
   {* Удаляет указанные узел из списка/дерева.
Если указан элемент, имеющий вложенные элементы, то они тоже удаляются. Если список/дерево созданно как константное (неизменяемое) то генерится исключение ConstantModify }
  procedure AddChildNode(const entity: IUnknown;
   out aRet
   {* INode }); stdcall; { can raise ConstantModify, AccessDenied, Unsupported, DuplicateNode, InvalidEntityType }
   {* Добавляет сущность как ребенка к указанной ноде, возвращает новую созданную ноду. Если список/дерево созданно как константное (неизменяемое) то генерится исключение ConstantModify. Если нода не может содержать детей возвращается исключение InvalidContainer }
  procedure AddSiblingNode(const entity: IUnknown;
   out aRet
   {* INode }); stdcall; { can raise ConstantModify, Unsupported, DuplicateNode }
   {* Добавляет сущность как "соседа" справа к указанной ноде, возвращает новую созданную ноду. Если список/дерево созданно как константное (неизменяемое) то генерится исключение ConstantModify }
  procedure MoveToLocation(var destination: INode); stdcall; { can raise InvalidContainer, MoveDisabled }
   {* Переносит текущую ноду в указанный узел, делая ее его ребенком. Если узел не может пнринять ноду (т.е. вставить ее в себя), то генерируется исключение InvalidContainer. Если операция перемещения узлов не доступна, генерируется исключение MoveDisabled }
  procedure CopyToLocation(var destination: INode); stdcall; { can raise CopyDisabled, InvalidContainer }
   {* Сопирует текущую ноду и оекурсивно все ее содержимое, в указанный узел, делая ее его ребенком. Если узел не может пнринять ноду (т.е. вставить ее в себя), то генерируется исключение InvalidContainer. Если операция копирования узлов не доступна, генерируется исключение CopyDisabled }
  function CanMove: ByteBool; stdcall;
   {* можно ли переместить ноду }
  function CanCopy: ByteBool; stdcall;
   {* можно ли скопировать ноду }
  function CanInsert(var source: INode): ByteBool; stdcall;
   {* можно ли вставить ноду }
  function IsLast: ByteBool; stdcall;
   {* Последнией элемент. }
  function IsFirst: ByteBool; stdcall;
   {* Первый элемент. }
  function HasChild: ByteBool; stdcall;
   {* Есть ли дочерние элементы. }
  procedure OverrideChildNode(const entity: IUnknown;
   out aRet
   {* INode }); stdcall; { can raise ConstantModify, AccessDenied, Unsupported, DuplicateNode, InvalidEntityType }
   {* перезаписать дочернюю ноду }
  function CanModify: ByteBool; stdcall;
   {* можно ли модифицировать ноду }
  property Level: Integer
   read GetLevel;
   {* Уровень вложенности элемента в древовидной структуре.
У root_node=0. }
  property ChildCount: Integer
   read GetChildCount;
   {* Количество вложенных элементов для текущего (один уровень).
У листьевых элементов =0. }
  property AllChildCount: Integer
   read GetAllChildCount;
   {* Количество вложенных элементов для текущего с учетом всех уровней вложенности.
У листьевых элементов =0. }
  property Flags: Integer
   read GetFlags;
   {* Поле для передачи дополнительной винарной информации о статусе элемента. }
  property Index: Integer
   read GetIndex;
   {* Позиция текущего элемента в предке (parent). }
  property ThroughIndex: Integer
   read GetThroughIndex;
   {* Сквозная позиция элемента. }
  property Parent: 
   read GetParent;
   {* родитель }
  property PreviousNode: 
   read GetPreviousNode;
   {* предыдущая нода в дереве }
  property NextNode: 
   read GetNextNode;
   {* следующая нода в дереве }
  property Caption: 
   read GetCaption
   write SetCaption;
   {* название }
  property Hint: 
   read GetHint
   write SetHint;
   {* информация о ноде }
  property ObjectType: TEntityType
   read GetObjectType;
   {* тип сущности, представляемой нодой }
 end;//INode

 IBaseCatalog = interface
  {* Базовый интерфейс для работы с древовидными и/или линейными списками различных сущностей системы. Навигация по структуре (дерево или линейный список) осуществляется через экземпляры интерфейса Node. При этом каждый екземпляр Node может быть приведен к интерфейсу необходимой сущности через метод open интерфейса BaseCatalog. Для того что бы сущность можно было привести таким образом, ее экземпляр должен реализовывать интерфейс BaseEntity.
В случае если конкретное дерево не поддерживает тех или иных операция определенных на BaseCatalog, то при их вызове должно генерироваться исключение }
  ['{B41C62C4-F733-4465-9B22-3D4C52162F8A}']
  procedure GetRoot; stdcall;
  function GetFilter: TEntityType; stdcall;
  procedure SetFilter(aValue: TEntityType); stdcall;
  procedure Find(const entity: IUnknown
   {* Искомый элемент. };
   out aRet
   {* INode }); stdcall;
   {* Найти узел по его элементу. }
  procedure FindContext(mask: PAnsiChar;
   const mode: TSearchMode;
   const cur_item: INode;
   out result: TContextSearchResult
   {* Результат поиска. При этом возвращается сквозной индекс. };
   out aRet
   {* INode }); stdcall;
   {* Поиск контекста среди элементов списка. }
  procedure ResetTypeFilter; stdcall;
   {* сбрасывает все установленные фильтры по типам }
  property Root: 
   read GetRoot;
   {* корень дерева }
  property Filter: TEntityType
   read GetFilter
   write SetFilter;
   {* наложенный фильтр }
 end;//IBaseCatalog

 TBaseTreeNodeMask = Cardinal;
  {* флаги на старой ноде }

implementation

uses
 l3ImplUses
;

end.
