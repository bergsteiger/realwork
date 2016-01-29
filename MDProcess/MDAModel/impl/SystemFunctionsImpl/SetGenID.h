////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/SystemFunctionsImpl/SetGenID.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::SystemFunctionsImpl::SetGenID
// Заголовок реализации класса серванта для интерфеса 
//
// реализация встроенной функции генератора "_set_gen_id"
// _set_gen_id(«gen id») - устанавливает генератор.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_SYSTEMFUNCTIONSIMPL_SETGENID_H__
#define __MDPROCESS_MDAMODEL_SYSTEMFUNCTIONSIMPL_SETGENID_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/BaseFunctionImpl/InternalFunctionBase.h"

namespace SystemFunctionsImpl {

class SetGenID; // self forward Var
typedef ::Core::Var<SetGenID> SetGenID_var;
typedef ::Core::Var<const SetGenID> SetGenID_cvar;

class SetGenID_factory;

// реализация встроенной функции генератора "_set_gen_id"
// _set_gen_id(«gen id») - устанавливает генератор.
class SetGenID:
	virtual public BaseFunctionImpl::InternalFunctionBase
{
	SET_OBJECT_COUNTER (SetGenID)
	friend class SetGenID_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	SetGenID ();

	virtual ~SetGenID ();

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from BaseFunctionImpl::InternalFunctionBase
	// Собственно реализации встроенной функции. Каждый конкретный сервант реализует это метод
	virtual const std::string execute_impl (
		const TemplateFunctions::FunctionParams& params
		, TemplatePainter* painter
	) const /*throw (
		TemplateFunctions::BadParams
	)*/;
}; // class SetGenID

} // namespace SystemFunctionsImpl


#endif //__MDPROCESS_MDAMODEL_SYSTEMFUNCTIONSIMPL_SETGENID_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
