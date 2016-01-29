////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/SetImplementSelectType.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VirtualElementsFuncionsImpl::SetImplementSelectType
// Заголовок реализации класса серванта для интерфеса 
//
// %S%f_set_implement_select_type(all|include|exclude) - устанавливает тип включения для
// реализуемых операций класса
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_SETIMPLEMENTSELECTTYPE_H__
#define __MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_SETIMPLEMENTSELECTTYPE_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/VirtualElementsFunctionBase.h"

namespace VirtualElementsFuncionsImpl {

class SetImplementSelectType; // self forward Var
typedef ::Core::Var<SetImplementSelectType> SetImplementSelectType_var;
typedef ::Core::Var<const SetImplementSelectType> SetImplementSelectType_cvar;

class SetImplementSelectType_factory;

// %S%f_set_implement_select_type(all|include|exclude) - устанавливает тип включения для
// реализуемых операций класса
class SetImplementSelectType:
	virtual public VirtualElementsFunctionBase
{
	SET_OBJECT_COUNTER (SetImplementSelectType)
	friend class SetImplementSelectType_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	SetImplementSelectType ();

	virtual ~SetImplementSelectType ();

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
}; // class SetImplementSelectType

} // namespace VirtualElementsFuncionsImpl


#endif //__MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_SETIMPLEMENTSELECTTYPE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
