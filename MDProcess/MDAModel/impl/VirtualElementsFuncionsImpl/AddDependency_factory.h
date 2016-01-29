////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/AddDependency_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VirtualElementsFuncionsImpl::AddDependency
// Заголовк реализации фабрик интерфеса AddDependencyLocal для серванта AddDependency
//
// 1. %S%f_add_dependency(<UID нового элемента>,<цель связи>,<стереотип>,<имя связи>,<имя
// переменной>) - создает новую связь между текущим и элементом и целью связи, цель может быть
// задана УИДом реального элемента либо просто именем - данный формат используется для простановки
// связи между классами
// 2. %S%f_add_dependency(<цель связи>) - создает новую связь между текущим и элементом и целью
// связи, цель может быть задана УИДом реального элемента либо просто именем - данный формат
// используется для простановки связи между папками.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_ADDDEPENDENCY_FCTR_H__
#define __MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_ADDDEPENDENCY_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/VirtualElementsFuncionsImplFactories.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/VirtualElementsFuncionsImpl.h"

namespace VirtualElementsFuncionsImpl {

/// Interface-factory implementation for AddDependency
class AddDependency_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public AddDependencyLocalAbstractFactory
{
public:
	AddDependency_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const std::string key () const;

	AddDependencyLocal* get ();

	TemplateFunctions::InternalStereotypeFunction* make ();

};

typedef ::Core::Var<AddDependency_factory> AddDependency_factory_var;

} // namespace VirtualElementsFuncionsImpl


#endif //__MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_ADDDEPENDENCY_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

