unit BaseTreeSupportUnit; {$Z4}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "GblAdapterLib"
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/BaseTreeSupportUnit.pas"
// Delphi интерфейсы для адаптера (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::BaseTreeSupport
//
// Поддержка старого дерева.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

interface

uses
	SysUtils
	, IOUnit
	, BaseTypesUnit
	, ContextSearchSupportUnit
	//#UC START# *4423F94903C8_456F02A50196_UNIT_FOR_Stream*
	//#UC END# *4423F94903C8_456F02A50196_UNIT_FOR_Stream*
	;

type

INode = interface;
{ - предварительное описание INode. }

IBaseCatalog = interface;
{ - предварительное описание IBaseCatalog. }


// идентификатор типа сущности лежащей в Ноде. В каждом конкретном дереве определяется как
// AdapterEnum
PEntityType = ^TEntityType;
TEntityType = Longword;

// Возвращается если нода не может быть скопирована.
ECopyDisabled = class (Exception);

// Вызывается при попытке использовать нодй не являющуюся контенером как контейнер.
EInvalidContainer = class (Exception);

// Возвращается если нода не может быть перенесена.
EMoveDisabled = class (Exception);

// Возвращается при попытке присвоить одной сущности сущность другого типа.
EInvalidEntityType = class (Exception);

// Возвращается при попытке получить элемент списка по несуществующему индексу. Т.е. index<0 или
// index>=count.
EInvalidIndex = class (Exception);

// Возвращается при попытке вызвать операцию open у элемента каталога, не являющегося сущностью (в
// частности у папки).
ENotEntityElement = class (Exception);

// флаги на старой ноде
PBaseTreeNodeMask = ^TBaseTreeNodeMask;
TBaseTreeNodeMask = Longword;

// Интерфейс для чтения данных об элементе древовидной структуры.
INode = interface (IEntityStorage) ['{A050343E-CA33-4D63-8385-2FFBD9B012DA}']
	// Добавляет сущность как ребенка к указанной ноде, возвращает новую созданную ноду. Если
	// список/дерево созданно как константное (неизменяемое) то генерится исключение ConstantModify.
	// Если нода не может содержать детей возвращается исключение InvalidContainer
	procedure AddChildNode (
		const aEntity: IUnknown;
		out aRet {: INode}
	); stdcall; // can raise EConstantModify, EAccessDenied, EUnsupported, EDuplicateNode, EInvalidEntityType

	// Добавляет сущность как "соседа" справа к указанной ноде, возвращает новую созданную ноду. Если
	// список/дерево созданно как константное (неизменяемое) то генерится исключение ConstantModify
	procedure AddSiblingNode (
		const aEntity: IUnknown;
		out aRet {: INode}
	); stdcall; // can raise EConstantModify, EUnsupported, EDuplicateNode

	// Количество вложенных элементов для текущего с учетом всех уровней вложенности.
	// У листьевых элементов =0.
	function GetAllChildCount (): Longint; stdcall;

	// можно ли скопировать ноду
	function CanCopy (): Bytebool; stdcall;

	// можно ли вставить ноду
	function CanInsert (
		const aSource: INode
	): Bytebool; stdcall;

	// можно ли модифицировать ноду
	function CanModify (): Bytebool; stdcall;

	// можно ли переместить ноду
	function CanMove (): Bytebool; stdcall;

	// название
	procedure GetCaption (out aRet {: IString}); stdcall;
	procedure SetCaption (const aCaption: IString); stdcall;

	// Количество вложенных элементов для текущего (один уровень).
	// У листьевых элементов =0.
	function GetChildCount (): Longint; stdcall;

	// Сопирует текущую ноду и оекурсивно все ее содержимое, в указанный узел, делая ее его ребенком.
	// Если узел не может пнринять ноду (т.е. вставить ее в себя), то генерируется исключение
	// InvalidContainer. Если операция копирования узлов не доступна, генерируется исключение
	// CopyDisabled
	procedure CopyToLocation (
		const aDestination: INode
	); stdcall; // can raise ECopyDisabled, EInvalidContainer

	// Удаляет указанные узел из списка/дерева.
	// Если указан элемент, имеющий вложенные элементы, то они тоже удаляются. Если список/дерево
	// созданно как константное (неизменяемое) то генерится исключение ConstantModify
	procedure DeleteNode (); stdcall; // can raise EConstantModify, EAccessDenied, EEmptyResult

	// Поле для передачи дополнительной винарной информации о статусе элемента.
	function GetFlags (): Longint; stdcall;

	// Получить интерфейс на один из вложенных элементов.
	// Параметр должен принимать значения из диапазона: 0<=index<=(child_coun-1)
	procedure GetChild (
		aIndex: Longint;
		out aRet {: INode}
	); stdcall; // can raise EInvalidIndex

	// Есть ли дочерние элементы.
	function HasChild (): Bytebool; stdcall;

	// информация о ноде
	procedure GetHint (out aRet {: IString}); stdcall;
	procedure SetHint (const aHint: IString); stdcall;

	// Позиция текущего элемента в предке (parent).
	function GetIndex (): Longint; stdcall;

	// Первый элемент.
	function IsFirst (): Bytebool; stdcall;

	// Последнией элемент.
	function IsLast (): Bytebool; stdcall;

	// Сравнивает текущий элемент с элементом, поданным в параметре node.
	// Возвращает true в случае совпадения.
	function IsSameNode (
		const aNode: INode
	): Bytebool; stdcall;

	// Уровень вложенности элемента в древовидной структуре.
	// У root_node=0.
	function GetLevel (): Longint; stdcall;

	// Переносит текущую ноду в указанный узел, делая ее его ребенком. Если узел не может пнринять
	// ноду (т.е. вставить ее в себя), то генерируется исключение InvalidContainer. Если операция
	// перемещения узлов не доступна, генерируется исключение MoveDisabled
	procedure MoveToLocation (
		const aDestination: INode
	); stdcall; // can raise EInvalidContainer, EMoveDisabled

	// следующая нода в дереве
	procedure GetNextNode (out aRet {: INode}); stdcall;

	// тип сущности, представляемой нодой
	function GetObjectType (): TEntityType; stdcall;

	// Возвращает интерфейс для работы с конкретным элементом (сущностью) системы.
	procedure Open (
		out aRet {: IUnknown}
	); stdcall; // can raise ECanNotFindData, ENotEntityElement

	// перезаписать дочернюю ноду
	procedure OverrideChildNode (
		const aEntity: IUnknown;
		out aRet {: INode}
	); stdcall; // can raise EConstantModify, EAccessDenied, EUnsupported, EDuplicateNode, EInvalidEntityType

	// родитель
	procedure GetParent (out aRet {: INode}); stdcall;

	// предыдущая нода в дереве
	procedure GetPreviousNode (out aRet {: INode}); stdcall;

	// Сквозная позиция элемента.
	function GetThroughIndex (): Longint; stdcall;
end;

// Базовый интерфейс для работы с древовидными и/или линейными списками различных сущностей
// системы. Навигация по структуре (дерево или линейный список) осуществляется через экземпляры
// интерфейса Node. При этом каждый екземпляр Node может быть приведен к интерфейсу необходимой
// сущности через метод open интерфейса BaseCatalog. Для того что бы сущность можно было привести
// таким образом, ее экземпляр должен реализовывать интерфейс BaseEntity.
// В случае если конкретное дерево не поддерживает тех или иных операция определенных на
// BaseCatalog, то при их вызове должно генерироваться исключение
IBaseCatalog = interface (IInterface) ['{B41C62C4-F733-4465-9B22-3D4C52162F8A}']
	function DontUseMe: Pointer;
	// наложенный фильтр
	function GetFilter (): TEntityType; stdcall;
	procedure SetFilter (aFilter: TEntityType); stdcall;

	// Найти узел по его элементу.
	procedure Find (
		const aEntity: IUnknown;
		out aRet {: INode}
	); stdcall;

	// Поиск контекста среди элементов списка.
	procedure FindContext (
		const aMask: PAnsiChar;
		const aMode: TSearchMode;
		const aCurItem: INode;
		out aResult: TContextSearchResult;
		out aRet {: INode}
	); stdcall;

	// сбрасывает все установленные фильтры по типам
	procedure ResetTypeFilter (); stdcall;

	// корень дерева
	procedure GetRoot (out aRet {: INode}); stdcall;
end;

implementation
end.