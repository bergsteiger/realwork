////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/RoseModel/RoseModel.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Interfaces::Category>> MDProcess::MDAModel::RoseModel
//
// Собственные обёртки над розовскими типами. Обёртки нужны, чтобы не складывать алгоритмы в одну
// кучу (сейчас это RoseHelper)
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_ROSEMODEL_H__
#define __MDPROCESS_MDAMODEL_ROSEMODEL_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include <set>
#include <vector>
#include "MDProcess/MDAModel/Base/Base.h"
#include "MDProcess/MDAModel/RoseTypes/RationalRoseTlb.h"


class Element;
typedef ::Core::Var<Element> Element_var;
typedef ::Core::Var<const Element> Element_cvar;

class Element;

// список элементов
typedef std::vector < Element_var > ElementList;

// Базовый интерфейс для всех элементов модели
class Element
	: virtual public ::Core::IObject
{
public:
	// возвращает список непосредственных детей элемента
	virtual ElementList* get_childs () const = 0;

	// возвращает список всех детей элемента (с учетом вложенности)
	virtual ElementList* get_all_childs () const = 0;

	// возвращает true, если элемент доступен для редактирования
	virtual bool can_modify () const = 0;
};

class Category;
typedef ::Core::Var<Category> Category_var;
typedef ::Core::Var<const Category> Category_cvar;

class Category;

// список папок
typedef std::vector < Category_var > CategoryList;

// Элемент-папка. Обёртка над розовским элементом, предоставляет дополнительную функциональность.
class Category
	: virtual public Element
{
public:
	// возвращает true, если элемент "вылит" в собственный cat
	virtual bool is_controlled () const = 0;

	// определяет можно ли папку вылить в отдельный кат
	virtual bool can_control () const = 0;

	// возвращает true, если хотя бы один ребенок (рекурсивно) "вылит" в собственный cat
	virtual bool has_controlled_child () const = 0;

	// возвращает полное имя элемента
	virtual const std::string get_full_name () const = 0;

	// возвращает true, если есть дочерние элементы не доступные для редактирования, т.е их нужно
	// захватить для того, чтобы начать редактировать
	virtual bool has_ro_child () const = 0;

	// возвращает список всех детей - папок (рекурсивно)
	virtual CategoryList* get_all_categories () const = 0;

	// возвращает список папок - непосредственных детей элемента
	virtual CategoryList* get_categories () const = 0;
};

/// factory interface for Category
class CategoryFactory {
public:
	// создаёт экземпляр
	static Category* make (IRoseCategoryPtr cat)
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

class IsVirtual;
typedef ::Core::Var<IsVirtual> IsVirtual_var;
typedef ::Core::Var<const IsVirtual> IsVirtual_cvar;
// алгоритм определения виртуальности элемента
class IsVirtual
	: virtual public ::Core::IObject
{
public:
	// возвращает true, если элемент виртуальный
	virtual bool execute (IRoseElementPtr elem) const = 0;
};

/// factory interface for IsVirtual
class IsVirtualFactory {
public:
	static IsVirtual& get ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

class PropertyHelper;
typedef ::Core::Var<PropertyHelper> PropertyHelper_var;
typedef ::Core::Var<const PropertyHelper> PropertyHelper_cvar;
// вспомогательный интерфейс для работы со свойствами
class PropertyHelper
	: virtual public ::Core::IObject
{
public:
	// возвращает true, если свойство нужно обязательно сохранить в модель
	virtual bool need_persist (const std::string& prop_id) const = 0;

	// возвращает true, если свойство определяет сгенерированный артефакт
	virtual bool is_self_generated_source (const std::string& prop_id) const = 0;

	// возвращает true, если свойство может быть удалено из модели
	virtual bool can_be_deleted (IRosePropertyPtr property) const = 0;
};

/// factory interface for PropertyHelper
class PropertyHelperFactory {
public:
	static PropertyHelper& get ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

class ModelPropertiesHelper;
typedef ::Core::Var<ModelPropertiesHelper> ModelPropertiesHelper_var;
typedef ::Core::Var<const ModelPropertiesHelper> ModelPropertiesHelper_cvar;
// вспомогательный интерфейс для работы с дополнительными свойствами элемента (видимость,
// нативность и т.д)
class ModelPropertiesHelper
	: virtual public ::Core::IObject
{
public:
	// возвращает уровень видимости для элемента
	virtual int get_visibility_level (IRoseElementPtr elem) const = 0;

	// устанавливает уровень видимости детей для элемента (при необходимсоти захватывает элемент)
	virtual void set_visibility_level (IRoseElementPtr elem, int level) const = 0;

	virtual bool is_global_locally (IRoseElementPtr elem) const = 0;

	virtual void set_global_locally (IRoseElementPtr elem, bool value) const = 0;
};

/// factory interface for ModelPropertiesHelper
class ModelPropertiesHelperFactory {
public:
	static ModelPropertiesHelper& get ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

class TypeLinkHelper;
typedef ::Core::Var<TypeLinkHelper> TypeLinkHelper_var;
typedef ::Core::Var<const TypeLinkHelper> TypeLinkHelper_cvar;
// вспомогательный инфтерфейс для связи типов элементов с реальными элементами модели
class TypeLinkHelper
	: virtual public ::Core::IObject
{
public:
	// Прописывает в свойства элемента, что он связан с элементом, имеющим гуид target_uid
	virtual void link (IRoseElementPtr source, const std::string& target_uid) const = 0;

	// разрывает связь для элемента
	virtual void unlink (IRoseElementPtr source) const = 0;

	// возвращает идентифкатор элемента, с которым связан элемент
	virtual const std::string get_linked (IRoseElementPtr source) const = 0;
};

/// factory interface for TypeLinkHelper
class TypeLinkHelperFactory {
public:
	// фабрика
	static TypeLinkHelper& get ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

class InheritedItem;
typedef ::Core::Var<InheritedItem> InheritedItem_var;
typedef ::Core::Var<const InheritedItem> InheritedItem_cvar;
// баозвый абстрактный интерфейс для сущностей, представляющих реализуемый/переопределяемый элемент
class InheritedItem
	: virtual public ::Core::IObject
{
public:
	// уникальный идентификатор элемента
	virtual const std::string& get_uid () const = 0;

	// признак, что нужно собирать детей элемента
	virtual bool get_need_collect_children () const = 0;

	virtual void set_need_collect_children (bool need_collect_children) = 0;

	// переопределнный тип видимости
	virtual const std::string& get_visibility_type () const = 0;

	virtual void set_visibility_type (const std::string& visibility_type) = 0;

	// переопределенные свойства
	virtual const Base::ToolPropertyMap& get_properties () const = 0;

	virtual void set_properties (const Base::ToolPropertyMap& properties) = 0;

	// устанавливает юзер-свойство
	virtual void set_property (const std::string& tool_name, const std::string& name, const std::string& value) = 0;

	// возвращает значение свойства, если свойство отсутсвует - возвращает 0 (возвращаемый указатель
	// захватывать не надо!!!)
	virtual std::string* get_property_value (const std::string& tool_name, const std::string& prop_name) const = 0;

	// удаляет свойство
	virtual void remove_property (const std::string& tool_name, const std::string& prop_name) = 0;
};

class OverloadedItem;
typedef ::Core::Var<OverloadedItem> OverloadedItem_var;
typedef ::Core::Var<const OverloadedItem> OverloadedItem_cvar;
// сущность переопределяемого элемента
class OverloadedItem
	: virtual public InheritedItem
{
};

/// factory interface for OverloadedItem
class OverloadedItemFactory {
public:
	// фабрика
	static OverloadedItem* make (const std::string& uid, bool need_collect_child)
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

class ImplementedItem;
typedef ::Core::Var<ImplementedItem> ImplementedItem_var;
typedef ::Core::Var<const ImplementedItem> ImplementedItem_cvar;
// сущность реализуемого элемента
class ImplementedItem
	: virtual public InheritedItem
{
};

/// factory interface for ImplementedItem
class ImplementedItemFactory {
public:
	// фабрика
	static ImplementedItem* make (const std::string& uid, bool need_collect_child)
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

// функтор сравнения
struct InheritedItemComparator : public std::binary_function<InheritedItem_var, InheritedItem_var, bool> {
	bool operator () (InheritedItem_var first_param_, InheritedItem_var second_param_) const;
};

// функтор
struct ImplementedItemComparator : public std::binary_function<ImplementedItem_var, ImplementedItem_var, bool> {
	bool operator () (ImplementedItem_var first_param_, ImplementedItem_var second_param_) const;
};

// функтор
struct OverloadedItemComparator : public std::binary_function<OverloadedItem_var, OverloadedItem_var, bool> {
	bool operator () (OverloadedItem_var first_param_, OverloadedItem_var second_param_) const;
};

// множество реализуемых/переопределяемых элементов
typedef std::set < InheritedItem_var, InheritedItemComparator > InheritedItemSet;

typedef std::set < ImplementedItem_var, ImplementedItemComparator > ImplementedItemSet;

typedef std::set < OverloadedItem_var, OverloadedItemComparator > OverloadedItemSet;

class InheritedItemHelper;
typedef ::Core::Var<InheritedItemHelper> InheritedItemHelper_var;
typedef ::Core::Var<const InheritedItemHelper> InheritedItemHelper_cvar;
// вспомагетльный интерфейс для работы с реулизуемыми/переопределенными элементами
class InheritedItemHelper
	: virtual public ::Core::IObject
{
public:
	// возвращает список переопределяемых элементов, для элемента elem на основе сохраненной ранее
	// информации
	virtual OverloadedItemSet* get_stored_overloaded (IRoseElementPtr elem) const = 0;

	// возвращает список переопределяемых элементов, для элемента elem на основе сохраненной ранее
	// информации
	// elem должен быть экземпляром RoseAbstractDumper (тут используется тип Dumper, чтобы не зависеть
	// от пакета RoseDumpers)
	virtual OverloadedItemSet* get_stored_overloaded (const Base::Dumper* elem) const = 0;

	// возвращает список реализуемых элементов, для элемента elem на основе сохраненной ранее
	// информации
	virtual ImplementedItemSet* get_stored_implemented (IRoseElementPtr elem) const = 0;

	// возвращает список реализуемых элементов, для элемента elem на основе сохраненной ранее
	// информации
	// elem должен быть экземпляром RoseAbstractDumper (тут используется тип Dumper, чтобы не зависеть
	// от пакета RoseDumpers)
	virtual ImplementedItemSet* get_stored_implemented (const Base::Dumper* elem) const = 0;

	// сохранить список реализуемых элементов
	virtual bool save (IRoseElementPtr elem, const ImplementedItemSet& items) const = 0;

	// сохранить список переопределямых элементов
	virtual bool save (IRoseElementPtr elem, const OverloadedItemSet& items) const = 0;

	// возвращает список переопределяемых элементов сохраненных в свойствах по ключу prop_name
	virtual InheritedItemSet* get_stored_inherited_items (IRoseElementPtr elem, const std::string& prop_name) const = 0;

	// возвращает список переопределяемых элементов сохраненных в свойствах по ключу prop_name
	// 
	// elem должен быть экземпляром RoseAbstractDumper (тут используется тип Dumper, чтобы не зависеть
	// от пакета RoseDumpers)
	virtual InheritedItemSet* get_stored_inherited_items (
		const Base::Dumper* elem
		, const std::string& prop_name
	) const = 0;

	// возвращает сериализованное значение для множества переопределяемых элементов
	virtual const std::string stored_value (const InheritedItemSet& inherited_items) const = 0;

	// возвращает сериализованное значение для множества переопределяемых элементов
	virtual const std::string stored_value (const OverloadedItemSet& inherited_items) const = 0;

	// возвращает сериализованное значение для множества переопределяемых элементов
	virtual const std::string stored_value (const ImplementedItemSet& inherited_items) const = 0;

	// создает элемент обертку для переопределяемого элемента
	virtual IRoseElementPtr make_wrapper (IRoseElementPtr elem, const InheritedItem* state) const = 0;

	// сохранить список реализуемых элементов
	virtual bool save (Base::Dumper* elem, const ImplementedItemSet& items) const = 0;

	// сохранить список переопределяемых элементов
	virtual bool save (Base::Dumper* elem, const OverloadedItemSet& items) const = 0;
};

/// factory interface for InheritedItemHelper
class InheritedItemHelperFactory {
public:
	static InheritedItemHelper& get ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

class ModelSearcher;
typedef ::Core::Var<ModelSearcher> ModelSearcher_var;
typedef ::Core::Var<const ModelSearcher> ModelSearcher_cvar;
// вспомогательный интерфейс для поиска элементов модели. Экземпляр интерфейса нельзя передавать из
// потока в поток! Также не стоит кэшировать экземпляр на длительное время - т.к модель может
// поменяться - в этом случае поведение не предсказуемо
class ModelSearcher
	: virtual public ::Core::IObject
{
public:
	// ищет элемент модели по идентификатору, если не находит - возвращает 0
	virtual IRoseElementPtr search (const std::string& uid) const = 0;

	// обработка создания нового элемента (или загрузка из модели старого)
	virtual void on_new_element (IRoseElementPtr element) const = 0;

	// обработка удаления элемента с модели
	virtual void on_delete_element (IRoseElementPtr elem) const = 0;
};

/// factory interface for ModelSearcher
class ModelSearcherFactory {
public:
	static ModelSearcher& get ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};


// TypeTraits specializations
namespace Core {	
template <>
struct TypeTraits <Category> {
	typedef CategoryFactory Factory;
};
template <>
struct TypeTraits <IsVirtual> {
	typedef IsVirtualFactory Factory;
};
template <>
struct TypeTraits <PropertyHelper> {
	typedef PropertyHelperFactory Factory;
};
template <>
struct TypeTraits <ModelPropertiesHelper> {
	typedef ModelPropertiesHelperFactory Factory;
};
template <>
struct TypeTraits <TypeLinkHelper> {
	typedef TypeLinkHelperFactory Factory;
};
template <>
struct TypeTraits <OverloadedItem> {
	typedef OverloadedItemFactory Factory;
};
template <>
struct TypeTraits <ImplementedItem> {
	typedef ImplementedItemFactory Factory;
};
template <>
struct TypeTraits <InheritedItemHelper> {
	typedef InheritedItemHelperFactory Factory;
};
template <>
struct TypeTraits <ModelSearcher> {
	typedef ModelSearcherFactory Factory;
};
} // namespace Core


#endif //__MDPROCESS_MDAMODEL_ROSEMODEL_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
