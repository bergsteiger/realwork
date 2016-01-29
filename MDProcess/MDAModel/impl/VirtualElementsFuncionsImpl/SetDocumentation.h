////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/SetDocumentation.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VirtualElementsFuncionsImpl::SetDocumentation
// Заголовок реализации класса серванта для интерфеса 
//
// %S%f_set_documentation(<Документация>) - устанавливает документацию для элемента. Применима
// ТОЛЬКО к виртуальным элементам
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_SETDOCUMENTATION_H__
#define __MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_SETDOCUMENTATION_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/VirtualElementsFunctionBase.h"

namespace VirtualElementsFuncionsImpl {

class SetDocumentation; // self forward Var
typedef ::Core::Var<SetDocumentation> SetDocumentation_var;
typedef ::Core::Var<const SetDocumentation> SetDocumentation_cvar;

class SetDocumentation_factory;

// %S%f_set_documentation(<Документация>) - устанавливает документацию для элемента. Применима
// ТОЛЬКО к виртуальным элементам
class SetDocumentation:
	virtual public VirtualElementsFunctionBase
{
	SET_OBJECT_COUNTER (SetDocumentation)
	friend class SetDocumentation_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	SetDocumentation ();

	virtual ~SetDocumentation ();

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
}; // class SetDocumentation

} // namespace VirtualElementsFuncionsImpl


#endif //__MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_SETDOCUMENTATION_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
