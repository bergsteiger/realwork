////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/RoseModelImpl/InheritedItemHelperImpl.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::RoseModelImpl::InheritedItemHelperImpl
// Заголовок реализации класса серванта для интерфеса InheritedItemHelper
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_ROSEMODELIMPL_INHERITEDITEMHELPERIMPL_H__
#define __MDPROCESS_MDAMODEL_ROSEMODELIMPL_INHERITEDITEMHELPERIMPL_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/RoseTypes/RationalRoseTlb.h"
#include "MDProcess/MDAModel/RoseModel/RoseModel.h"
#include "MDProcess/MDAModel/Base/Base.h"
#include "boost/property_tree/ptree.hpp"

namespace RoseModelImpl {

class InheritedItemHelperImpl; // self forward Var
typedef ::Core::Var<InheritedItemHelperImpl> InheritedItemHelperImpl_var;
typedef ::Core::Var<const InheritedItemHelperImpl> InheritedItemHelperImpl_cvar;

class InheritedItemHelperImpl_factory;

class InheritedItemHelperImpl:
	virtual public InheritedItemHelper
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (InheritedItemHelperImpl)
	friend class InheritedItemHelperImpl_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	InheritedItemHelperImpl ();

	virtual ~InheritedItemHelperImpl ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
private:
	// сериализует элемент в дерево свойств
	virtual boost::property_tree::ptree* serialize_item (const InheritedItem* item) const;


//////////////////////////////////////////////////////////////////////////////////////////
// template methods implementation

private:
	// реализация функции сохранения
	template <class T>
	bool save_impl (IRoseElementPtr elem, const std::string& prop_name, const T& inherted_items) const;

	// реализация метода stored_value
	template <class T>
	const std::string stored_value_impl (const T& inherited_items) const;

	// реализация функции сохранения
	template <class T>
	bool save_impl (Base::Dumper* elem, const std::string& prop_name, const T& inherted_items) const;



private:
	// реализация метода получения списка переопределенных элементов заданного типа на основе
	// сохраненных ранее данных
	template <class InheritedTypeFactory, class Result>
	Result* get_stored_inherited_items_impl (IRoseElementPtr elem, const std::string& prop_name) const;

	// реализация метода получения списка переопределенных элементов заданного типа на основе
	// сохраненных ранее данных
	template <class InheritedTypeFactory, class Result>
	Result* get_stored_inherited_items_impl (const std::string& prop_value) const;



//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from InheritedItemHelper
	// возвращает список реализуемых элементов, для элемента elem на основе сохраненной ранее
	// информации
	virtual ImplementedItemSet* get_stored_implemented (IRoseElementPtr elem) const;

	// implemented method from InheritedItemHelper
	// возвращает список реализуемых элементов, для элемента elem на основе сохраненной ранее
	// информации
	// elem должен быть экземпляром RoseAbstractDumper (тут используется тип Dumper, чтобы не зависеть
	// от пакета RoseDumpers)
	virtual ImplementedItemSet* get_stored_implemented (const Base::Dumper* elem) const;

	// implemented method from InheritedItemHelper
	// возвращает список переопределяемых элементов сохраненных в свойствах по ключу prop_name
	virtual InheritedItemSet* get_stored_inherited_items (IRoseElementPtr elem, const std::string& prop_name) const;

	// implemented method from InheritedItemHelper
	// возвращает список переопределяемых элементов сохраненных в свойствах по ключу prop_name
	// 
	// elem должен быть экземпляром RoseAbstractDumper (тут используется тип Dumper, чтобы не зависеть
	// от пакета RoseDumpers)
	virtual InheritedItemSet* get_stored_inherited_items (const Base::Dumper* elem, const std::string& prop_name) const;

	// implemented method from InheritedItemHelper
	// возвращает список переопределяемых элементов, для элемента elem на основе сохраненной ранее
	// информации
	virtual OverloadedItemSet* get_stored_overloaded (IRoseElementPtr elem) const;

	// implemented method from InheritedItemHelper
	// возвращает список переопределяемых элементов, для элемента elem на основе сохраненной ранее
	// информации
	// elem должен быть экземпляром RoseAbstractDumper (тут используется тип Dumper, чтобы не зависеть
	// от пакета RoseDumpers)
	virtual OverloadedItemSet* get_stored_overloaded (const Base::Dumper* elem) const;

	// implemented method from InheritedItemHelper
	// создает элемент обертку для переопределяемого элемента
	virtual IRoseElementPtr make_wrapper (IRoseElementPtr elem, const InheritedItem* state) const;

	// implemented method from InheritedItemHelper
	// сохранить список реализуемых элементов
	virtual bool save (IRoseElementPtr elem, const ImplementedItemSet& items) const;

	// implemented method from InheritedItemHelper
	// сохранить список переопределямых элементов
	virtual bool save (IRoseElementPtr elem, const OverloadedItemSet& items) const;

	// implemented method from InheritedItemHelper
	// сохранить список реализуемых элементов
	virtual bool save (Base::Dumper* elem, const ImplementedItemSet& items) const;

	// implemented method from InheritedItemHelper
	// сохранить список переопределяемых элементов
	virtual bool save (Base::Dumper* elem, const OverloadedItemSet& items) const;

	// implemented method from InheritedItemHelper
	// возвращает сериализованное значение для множества переопределяемых элементов
	virtual const std::string stored_value (const InheritedItemSet& inherited_items) const;

	// implemented method from InheritedItemHelper
	// возвращает сериализованное значение для множества переопределяемых элементов
	virtual const std::string stored_value (const OverloadedItemSet& inherited_items) const;

	// implemented method from InheritedItemHelper
	// возвращает сериализованное значение для множества переопределяемых элементов
	virtual const std::string stored_value (const ImplementedItemSet& inherited_items) const;
}; // class InheritedItemHelperImpl

} // namespace RoseModelImpl

#include "MDProcess/MDAModel/impl/RoseModelImpl/InheritedItemHelperImpl.i.h"

#endif //__MDPROCESS_MDAMODEL_ROSEMODELIMPL_INHERITEDITEMHELPERIMPL_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
