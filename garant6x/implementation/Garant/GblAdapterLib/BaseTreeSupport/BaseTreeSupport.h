////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/BaseTreeSupport/BaseTreeSupport.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::BaseTreeSupport
//
// Поддержка старого дерева.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_BASETREESUPPORT_H__
#define __GARANT6X_GBLADAPTERLIB_BASETREESUPPORT_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTypes/BaseTypes.h"
#include "garant6x/implementation/Garant/GblAdapterLib/ContextSearchSupport/ContextSearchSupport.h"
#include "garant6x/implementation/Garant/GblAdapterLib/StartLocal/StartLocal.h"
#include "shared/GCI/IO/IO.h"

namespace GblAdapterLib {

// идентификатор типа сущности лежащей в Ноде. В каждом конкретном дереве определяется как
// AdapterEnum
typedef unsigned long EntityType;

// Возвращается если нода не может быть скопирована.
class CopyDisabled : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// Вызывается при попытке использовать нодй не являющуюся контенером как контейнер.
class InvalidContainer : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// Возвращается если нода не может быть перенесена.
class MoveDisabled : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// Возвращается при попытке присвоить одной сущности сущность другого типа.
class InvalidEntityType : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// Возвращается при попытке получить элемент списка по несуществующему индексу. Т.е. index<0 или
// index>=count.
class InvalidIndex : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// Возвращается при попытке вызвать операцию open у элемента каталога, не являющегося сущностью (в
// частности у папки).
class NotEntityElement : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

class Node;
typedef ::Core::Var<Node> Node_var;
typedef ::Core::Var<const Node> Node_cvar;
// Интерфейс для чтения данных об элементе древовидной структуры.
class Node
	: virtual public EntityStorage
{
public:
	// Уровень вложенности элемента в древовидной структуре.
	// У root_node=0.
	virtual long get_level () const = 0;

	// Количество вложенных элементов для текущего (один уровень).
	// У листьевых элементов =0.
	virtual long get_child_count () const = 0;

	// Количество вложенных элементов для текущего с учетом всех уровней вложенности.
	// У листьевых элементов =0.
	virtual long get_all_child_count () const = 0;

	// Поле для передачи дополнительной винарной информации о статусе элемента.
	virtual long get_flags () const = 0;

	// Позиция текущего элемента в предке (parent).
	virtual long get_index () const = 0;

	// Сквозная позиция элемента.
	virtual long get_through_index () const = 0;

	// родитель
	virtual const Node* get_parent () const = 0;
	virtual Node* get_parent () = 0;

	// предыдущая нода в дереве
	virtual const Node* get_previous_node () const = 0;
	virtual Node* get_previous_node () = 0;

	// следующая нода в дереве
	virtual const Node* get_next_node () const = 0;
	virtual Node* get_next_node () = 0;

	// название
	virtual const GCI::IO::String& get_caption () const = 0;
	virtual GCI::IO::String& get_caption () = 0;

	virtual void set_caption (GCI::IO::String* caption)
		/*throw (ConstantModify, AccessDenied)*/ = 0;

	// информация о ноде
	virtual const GCI::IO::String& get_hint () const = 0;
	virtual GCI::IO::String& get_hint () = 0;

	virtual void set_hint (GCI::IO::String* hint)
		/*throw (ConstantModify, AccessDenied)*/ = 0;

	// тип сущности, представляемой нодой
	virtual EntityType get_object_type () const
		/*throw (Unsupported)*/ = 0;

	// Получить интерфейс на один из вложенных элементов.
	// Параметр должен принимать значения из диапазона: 0<=index<=(child_coun-1)
	virtual Node* get_child (long index) /*throw (InvalidIndex)*/ = 0;

	// Сравнивает текущий элемент с элементом, поданным в параметре node.
	// Возвращает true в случае совпадения.
	virtual bool is_same_node (const Node* node) const = 0;

	// Возвращает интерфейс для работы с конкретным элементом (сущностью) системы.
	virtual Core::IObject* open () /*throw (CanNotFindData, NotEntityElement)*/ = 0;

	// Удаляет указанные узел из списка/дерева.
	// Если указан элемент, имеющий вложенные элементы, то они тоже удаляются. Если список/дерево
	// созданно как константное (неизменяемое) то генерится исключение ConstantModify
	virtual void delete_node () /*throw (ConstantModify, AccessDenied, EmptyResult)*/ = 0;

	// Добавляет сущность как ребенка к указанной ноде, возвращает новую созданную ноду. Если
	// список/дерево созданно как константное (неизменяемое) то генерится исключение ConstantModify.
	// Если нода не может содержать детей возвращается исключение InvalidContainer
	virtual Node* add_child_node (
		const Core::IObject* entity
	) const /*throw (
		ConstantModify
		, AccessDenied
		, Unsupported
		, DuplicateNode
		, InvalidEntityType
	)*/ = 0;

	// Добавляет сущность как "соседа" справа к указанной ноде, возвращает новую созданную ноду. Если
	// список/дерево созданно как константное (неизменяемое) то генерится исключение ConstantModify
	virtual Node* add_sibling_node (
		const Core::IObject* entity
	) const /*throw (
		ConstantModify
		, Unsupported
		, DuplicateNode
	)*/ = 0;

	// Переносит текущую ноду в указанный узел, делая ее его ребенком. Если узел не может пнринять
	// ноду (т.е. вставить ее в себя), то генерируется исключение InvalidContainer. Если операция
	// перемещения узлов не доступна, генерируется исключение MoveDisabled
	virtual void move_to_location (Node* destination) /*throw (InvalidContainer, MoveDisabled)*/ = 0;

	// Сопирует текущую ноду и оекурсивно все ее содержимое, в указанный узел, делая ее его ребенком.
	// Если узел не может пнринять ноду (т.е. вставить ее в себя), то генерируется исключение
	// InvalidContainer. Если операция копирования узлов не доступна, генерируется исключение
	// CopyDisabled
	virtual void copy_to_location (Node* destination) /*throw (CopyDisabled, InvalidContainer)*/ = 0;

	// можно ли переместить ноду
	virtual bool can_move () const = 0;

	// можно ли скопировать ноду
	virtual bool can_copy () const = 0;

	// можно ли вставить ноду
	virtual bool can_insert (Node* source) const = 0;

	// Последнией элемент.
	virtual bool is_last () const = 0;

	// Первый элемент.
	virtual bool is_first () const = 0;

	// Есть ли дочерние элементы.
	virtual bool has_child () const = 0;

	// перезаписать дочернюю ноду
	virtual Node* override_child_node (
		const Core::IObject* entity
	) const /*throw (
		ConstantModify
		, AccessDenied
		, Unsupported
		, DuplicateNode
		, InvalidEntityType
	)*/ = 0;

	// можно ли модифицировать ноду
	virtual bool can_modify () const = 0;
};

/// factory interface for Node
class NodeFactory {
public:
	// фабрика
	static Node* make ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

class BaseCatalog;
typedef ::Core::Var<BaseCatalog> BaseCatalog_var;
typedef ::Core::Var<const BaseCatalog> BaseCatalog_cvar;
// Базовый интерфейс для работы с древовидными и/или линейными списками различных сущностей
// системы. Навигация по структуре (дерево или линейный список) осуществляется через экземпляры
// интерфейса Node. При этом каждый екземпляр Node может быть приведен к интерфейсу необходимой
// сущности через метод open интерфейса BaseCatalog. Для того что бы сущность можно было привести
// таким образом, ее экземпляр должен реализовывать интерфейс BaseEntity.
// В случае если конкретное дерево не поддерживает тех или иных операция определенных на
// BaseCatalog, то при их вызове должно генерироваться исключение
class BaseCatalog
	: virtual public ::Core::IObject
{
public:
	// корень дерева
	virtual const Node* get_root () const = 0;
	virtual Node* get_root () = 0;

	// наложенный фильтр
	virtual const EntityType get_filter () const = 0;

	virtual void set_filter (EntityType filter) = 0;

	// Найти узел по его элементу.
	virtual Node* find (const Core::IObject* entity) const = 0;

	// Поиск контекста среди элементов списка.
	virtual Node* find_context (
		const char* mask
		, const SearchMode& mode
		, const Node* cur_item
		, ContextSearchResult*& result
	) const = 0;

	// сбрасывает все установленные фильтры по типам
	virtual void reset_type_filter () const = 0;
};

// флаги на старой ноде
typedef unsigned long BaseTreeNodeMask;

} // namespace GblAdapterLib

// TypeTraits specializations
namespace Core {	
template <>
struct TypeTraits <GblAdapterLib::Node> {
	typedef GblAdapterLib::NodeFactory Factory;
};
} // namespace Core


#endif //__GARANT6X_GBLADAPTERLIB_BASETREESUPPORT_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
