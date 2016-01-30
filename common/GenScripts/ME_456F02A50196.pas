unit BaseTreeSupportUnit;
 {* Поддержка старого дерева. }

// Модуль: "w:\garant6x\implementation\Garant\tie\Garant\GblAdapterLib\BaseTreeSupportUnit.pas"
// Стереотип: "Interfaces"

{$Include nsDefine.inc}

interface

uses
 l3IntfUses
 , BaseTypesUnit
 , IOUnit
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
  function Get_level: Integer;
  function Get_child_count: Integer;
  function Get_all_child_count: Integer;
  function Get_flags: Integer;
  function Get_index: Integer;
  function Get_through_index: Integer;
  function Get_parent: INode;
  function Get_previous_node: INode;
  function Get_next_node: INode;
  function Get_caption: IString;
  procedure Set_caption(const aValue: IString); { can raise ConstantModify, AccessDenied }
  function Get_hint: IString;
  procedure Set_hint(const aValue: IString); { can raise ConstantModify, AccessDenied }
  function Get_object_type: TEntityType; { can raise Unsupported }
  function get_child(index: Integer): INode; { can raise InvalidIndex }
   {* Получить интерфейс на один из вложенных элементов.
Параметр должен принимать значения из диапазона: 0<=index<=(child_coun-1) }
  function is_same_node(const node: INode): Boolean;
   {* Сравнивает текущий элемент с элементом, поданным в параметре node.
Возвращает true в случае совпадения. }
  function open: IUnknown; { can raise CanNotFindData, NotEntityElement }
   {* Возвращает интерфейс для работы с конкретным элементом (сущностью) системы. }
  procedure delete_node; { can raise ConstantModify, AccessDenied, EmptyResult }
   {* Удаляет указанные узел из списка/дерева.
Если указан элемент, имеющий вложенные элементы, то они тоже удаляются. Если список/дерево созданно как константное (неизменяемое) то генерится исключение ConstantModify }
  function add_child_node(const entity: IUnknown): INode; { can raise ConstantModify, AccessDenied, Unsupported, DuplicateNode, InvalidEntityType }
   {* Добавляет сущность как ребенка к указанной ноде, возвращает новую созданную ноду. Если список/дерево созданно как константное (неизменяемое) то генерится исключение ConstantModify. Если нода не может содержать детей возвращается исключение InvalidContainer }
  function add_sibling_node(const entity: IUnknown): INode; { can raise ConstantModify, Unsupported, DuplicateNode }
   {* Добавляет сущность как "соседа" справа к указанной ноде, возвращает новую созданную ноду. Если список/дерево созданно как константное (неизменяемое) то генерится исключение ConstantModify }
  procedure move_to_location(var destination: INode); { can raise InvalidContainer, MoveDisabled }
   {* Переносит текущую ноду в указанный узел, делая ее его ребенком. Если узел не может пнринять ноду (т.е. вставить ее в себя), то генерируется исключение InvalidContainer. Если операция перемещения узлов не доступна, генерируется исключение MoveDisabled }
  procedure copy_to_location(var destination: INode); { can raise CopyDisabled, InvalidContainer }
   {* Сопирует текущую ноду и оекурсивно все ее содержимое, в указанный узел, делая ее его ребенком. Если узел не может пнринять ноду (т.е. вставить ее в себя), то генерируется исключение InvalidContainer. Если операция копирования узлов не доступна, генерируется исключение CopyDisabled }
  function can_move: Boolean;
   {* можно ли переместить ноду }
  function can_copy: Boolean;
   {* можно ли скопировать ноду }
  function can_insert(var source: INode): Boolean;
   {* можно ли вставить ноду }
  function is_last: Boolean;
   {* Последнией элемент. }
  function is_first: Boolean;
   {* Первый элемент. }
  function has_child: Boolean;
   {* Есть ли дочерние элементы. }
  function override_child_node(const entity: IUnknown): INode; { can raise ConstantModify, AccessDenied, Unsupported, DuplicateNode, InvalidEntityType }
   {* перезаписать дочернюю ноду }
  function can_modify: Boolean;
   {* можно ли модифицировать ноду }
  property level: Integer
   read Get_level;
   {* Уровень вложенности элемента в древовидной структуре.
У root_node=0. }
  property child_count: Integer
   read Get_child_count;
   {* Количество вложенных элементов для текущего (один уровень).
У листьевых элементов =0. }
  property all_child_count: Integer
   read Get_all_child_count;
   {* Количество вложенных элементов для текущего с учетом всех уровней вложенности.
У листьевых элементов =0. }
  property flags: Integer
   read Get_flags;
   {* Поле для передачи дополнительной винарной информации о статусе элемента. }
  property index: Integer
   read Get_index;
   {* Позиция текущего элемента в предке (parent). }
  property through_index: Integer
   read Get_through_index;
   {* Сквозная позиция элемента. }
  property parent: INode
   read Get_parent;
   {* родитель }
  property previous_node: INode
   read Get_previous_node;
   {* предыдущая нода в дереве }
  property next_node: INode
   read Get_next_node;
   {* следующая нода в дереве }
  property caption: IString
   read Get_caption
   write Set_caption;
   {* название }
  property hint: IString
   read Get_hint
   write Set_hint;
   {* информация о ноде }
  property object_type: TEntityType
   read Get_object_type;
   {* тип сущности, представляемой нодой }
 end;//INode

 IBaseCatalog = interface
  {* Базовый интерфейс для работы с древовидными и/или линейными списками различных сущностей системы. Навигация по структуре (дерево или линейный список) осуществляется через экземпляры интерфейса Node. При этом каждый екземпляр Node может быть приведен к интерфейсу необходимой сущности через метод open интерфейса BaseCatalog. Для того что бы сущность можно было привести таким образом, ее экземпляр должен реализовывать интерфейс BaseEntity.
В случае если конкретное дерево не поддерживает тех или иных операция определенных на BaseCatalog, то при их вызове должно генерироваться исключение }
  ['{B41C62C4-F733-4465-9B22-3D4C52162F8A}']
  function Get_root: INode;
  function Get_filter: TEntityType;
  procedure Set_filter(aValue: TEntityType);
  function find(const entity: IUnknown {* Искомый элемент. }): INode;
   {* Найти узел по его элементу. }
  function find_context(mask: PAnsiChar;
   const mode: TSearchMode;
   const cur_item: INode;
   out result: TContextSearchResult {* Результат поиска. При этом возвращается сквозной индекс. }): INode;
   {* Поиск контекста среди элементов списка. }
  procedure reset_type_filter;
   {* сбрасывает все установленные фильтры по типам }
  property root: INode
   read Get_root;
   {* корень дерева }
  property filter: TEntityType
   read Get_filter
   write Set_filter;
   {* наложенный фильтр }
 end;//IBaseCatalog

 TBaseTreeNodeMask = Cardinal;
  {* флаги на старой ноде }

class function make: BadFactoryType;
 {* фабрика }

implementation

uses
 l3ImplUses
;

class function make: BadFactoryType;
 {* фабрика }
var
 l_Inst : INode;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//make

end.
