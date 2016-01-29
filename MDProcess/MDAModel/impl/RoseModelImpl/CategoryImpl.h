////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/RoseModelImpl/CategoryImpl.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::RoseModelImpl::CategoryImpl
// Заголовок реализации класса серванта для интерфеса Category
//
// реализация элемента-папка
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_ROSEMODELIMPL_CATEGORYIMPL_H__
#define __MDPROCESS_MDAMODEL_ROSEMODELIMPL_CATEGORYIMPL_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/RoseTypes/RationalRoseTlb.h"
#include "MDProcess/MDAModel/RoseModel/RoseModel.h"

namespace RoseModelImpl {

class CategoryImpl; // self forward Var
typedef ::Core::Var<CategoryImpl> CategoryImpl_var;
typedef ::Core::Var<const CategoryImpl> CategoryImpl_cvar;

class CategoryImpl_factory;

// реализация элемента-папка
class CategoryImpl:
	virtual public Category
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (CategoryImpl)
	friend class CategoryImpl_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	CategoryImpl (IRoseCategoryPtr cat);

	virtual ~CategoryImpl ();
//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	// Розовский элемент, над которым сделана обёртка
	IRoseCategoryPtr m_cat;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from Category
	// определяет можно ли папку вылить в отдельный кат
	virtual bool can_control () const;

	// implemented method from Category
	// возвращает список всех детей - папок (рекурсивно)
	virtual CategoryList* get_all_categories () const;

	// implemented method from Category
	// возвращает список папок - непосредственных детей элемента
	virtual CategoryList* get_categories () const;

	// implemented method from Category
	// возвращает полное имя элемента
	virtual const std::string get_full_name () const;

	// implemented method from Category
	// возвращает true, если хотя бы один ребенок (рекурсивно) "вылит" в собственный cat
	virtual bool has_controlled_child () const;

	// implemented method from Category
	// возвращает true, если есть дочерние элементы не доступные для редактирования, т.е их нужно
	// захватить для того, чтобы начать редактировать
	virtual bool has_ro_child () const;

	// implemented method from Category
	// возвращает true, если элемент "вылит" в собственный cat
	virtual bool is_controlled () const;

	// implemented method from Element
	// возвращает true, если элемент доступен для редактирования
	virtual bool can_modify () const;

	// implemented method from Element
	// возвращает список всех детей элемента (с учетом вложенности)
	virtual ElementList* get_all_childs () const;

	// implemented method from Element
	// возвращает список непосредственных детей элемента
	virtual ElementList* get_childs () const;
}; // class CategoryImpl

} // namespace RoseModelImpl


#endif //__MDPROCESS_MDAMODEL_ROSEMODELIMPL_CATEGORYIMPL_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
