////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/MakeAccessable.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VirtualElementsFuncionsImpl::MakeAccessable
// Заголовок реализации класса серванта для интерфеса 
//
// %S%f_make_accessable(идентификатор элемента) - делает видимым элемент - расставляет необходимые
// связи (виртуальные), при этом связи расставляются между родителями этих элементов, между самими
// элементами никаких новых связей не добавляется!. Пример:
// {code}
// %S%f_make_accessable(%TГ)
// {code}
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_MAKEACCESSABLE_H__
#define __MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_MAKEACCESSABLE_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/VirtualElementsFunctionBase.h"

namespace VirtualElementsFuncionsImpl {

class MakeAccessable; // self forward Var
typedef ::Core::Var<MakeAccessable> MakeAccessable_var;
typedef ::Core::Var<const MakeAccessable> MakeAccessable_cvar;

class MakeAccessable_factory;

// %S%f_make_accessable(идентификатор элемента) - делает видимым элемент - расставляет необходимые
// связи (виртуальные), при этом связи расставляются между родителями этих элементов, между самими
// элементами никаких новых связей не добавляется!. Пример:
// {code}
// %S%f_make_accessable(%TГ)
// {code}
class MakeAccessable:
	virtual public VirtualElementsFunctionBase
{
	SET_OBJECT_COUNTER (MakeAccessable)
	friend class MakeAccessable_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	MakeAccessable ();

	virtual ~MakeAccessable ();

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from BaseFunctionImpl::InternalStereotypeFunctionBase
	// Собственно реализации встроенной функции. Каждый конкретный сервант реализует это метод
	virtual const std::string execute_impl (
		const AbstractDumperBase* self
		, const TemplateFunctions::FunctionParams& params
		, TemplatePainter* painter
	) const /*throw (
		TemplateFunctions::BadParams
	)*/;
}; // class MakeAccessable

} // namespace VirtualElementsFuncionsImpl


#endif //__MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_MAKEACCESSABLE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
