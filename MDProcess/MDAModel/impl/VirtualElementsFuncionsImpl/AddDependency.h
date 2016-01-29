////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/AddDependency.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VirtualElementsFuncionsImpl::AddDependency
// Заголовок реализации класса серванта для интерфеса AddDependencyLocal
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
#ifndef __MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_ADDDEPENDENCY_H__
#define __MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_ADDDEPENDENCY_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/AbstractDumpers/AbstractDumperBase.h"
#include "MDProcess/MDAModel/RoseDumpers/RoseAbstractClassDumper.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/VirtualElementsFuncionsImpl.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/VirtualElementsFunctionBase.h"

namespace VirtualElementsFuncionsImpl {

class AddDependency; // self forward Var
typedef ::Core::Var<AddDependency> AddDependency_var;
typedef ::Core::Var<const AddDependency> AddDependency_cvar;

class AddDependency_factory;

// 1. %S%f_add_dependency(<UID нового элемента>,<цель связи>,<стереотип>,<имя связи>,<имя
// переменной>) - создает новую связь между текущим и элементом и целью связи, цель может быть
// задана УИДом реального элемента либо просто именем - данный формат используется для простановки
// связи между классами
// 2. %S%f_add_dependency(<цель связи>) - создает новую связь между текущим и элементом и целью
// связи, цель может быть задана УИДом реального элемента либо просто именем - данный формат
// используется для простановки связи между папками.
class AddDependency:
	virtual public AddDependencyLocal
	, virtual public VirtualElementsFunctionBase
{
	SET_OBJECT_COUNTER (AddDependency)
	friend class AddDependency_factory; // self factory
protected:
	// factories id
	struct FactoriesID {
		class Make {}; // TemplateFunctions::BaseFunction::make
		class Get {}; // VirtualElementsFuncionsImpl::AddDependencyLocal::get
	};
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	AddDependency (const FactoriesID::Get& factory_id);

	AddDependency (const FactoriesID::Make& factory_id);

	virtual ~AddDependency ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
private:
	// создает связь зависимости между классами
	virtual void create_dep_for_class (
		const RoseAbstractClassDumper* source
		, const RoseAbstractClassDumper* target
		, const std::string& guid_suffix
		, const std::string& name
		, const std::string& stereotype
		, const std::string& var_id
		, const AbstractDumperBase* context
	) const;


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from AddDependencyLocal
	// создает зависимость между элементами (НЕ классами)
	virtual void create_dep_for_others (const AbstractDumper* source, const AbstractDumper* target) const;

	// implemented method from BaseFunctionImpl::InternalStereotypeFunctionBase
	// Собственно реализации встроенной функции. Каждый конкретный сервант реализует это метод
	virtual const std::string execute_impl (
		const AbstractDumperBase* self
		, const TemplateFunctions::FunctionParams& params
		, TemplatePainter* painter
	) const /*throw (
		TemplateFunctions::BadParams
	)*/;
}; // class AddDependency

} // namespace VirtualElementsFuncionsImpl


#endif //__MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_ADDDEPENDENCY_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
