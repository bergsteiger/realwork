////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/OverrideImplementBase.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VirtualElementsFuncionsImpl::OverrideImplementBase
// Заголовок реализации класса серванта для интерфеса 
//
// базовая реализация метода добавления операции в список overload или implemented
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_OVERRIDEIMPLEMENTBASE_H__
#define __MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_OVERRIDEIMPLEMENTBASE_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/VirtualElementsFunctionBase.h"

namespace VirtualElementsFuncionsImpl {

class OverrideImplementBase; // self forward Var
typedef ::Core::Var<OverrideImplementBase> OverrideImplementBase_var;
typedef ::Core::Var<const OverrideImplementBase> OverrideImplementBase_cvar;

// базовая реализация метода добавления операции в список overload или implemented
class OverrideImplementBase:
	virtual public VirtualElementsFunctionBase
{
	SET_OBJECT_COUNTER (OverrideImplementBase)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	OverrideImplementBase ();


	// prop - имя свойства, в которое будет добавляться операция
	OverrideImplementBase (const std::string& prop, char list_tpl_command);

	virtual ~OverrideImplementBase ();
//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	// команда шаблона, соответствующая изменяемому списку
	char m_list_tpl_command;

	// имя свойства, в котром хранится список overload или implemented
	std::string m_property_name;

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
}; // class OverrideImplementBase

} // namespace VirtualElementsFuncionsImpl


#endif //__MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_OVERRIDEIMPLEMENTBASE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
