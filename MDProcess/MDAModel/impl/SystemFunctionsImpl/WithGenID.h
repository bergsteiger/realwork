////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/SystemFunctionsImpl/WithGenID.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::SystemFunctionsImpl::WithGenID
// Заголовок реализации класса серванта для интерфеса 
//
// реализация встроенной функции генератора "_with_gen_id".
// _with_gen_id(«gen id»,«параметр») - выводит параметр от «имени» генератора с заданным ID
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_SYSTEMFUNCTIONSIMPL_WITHGENID_H__
#define __MDPROCESS_MDAMODEL_SYSTEMFUNCTIONSIMPL_WITHGENID_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/BaseFunctionImpl/InternalFunctionBase.h"

namespace SystemFunctionsImpl {

class WithGenID; // self forward Var
typedef ::Core::Var<WithGenID> WithGenID_var;
typedef ::Core::Var<const WithGenID> WithGenID_cvar;

class WithGenID_factory;

// реализация встроенной функции генератора "_with_gen_id".
// _with_gen_id(«gen id»,«параметр») - выводит параметр от «имени» генератора с заданным ID
class WithGenID:
	virtual public BaseFunctionImpl::InternalFunctionBase
{
	SET_OBJECT_COUNTER (WithGenID)
	friend class WithGenID_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	WithGenID ();

	virtual ~WithGenID ();

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
}; // class WithGenID

} // namespace SystemFunctionsImpl


#endif //__MDPROCESS_MDAMODEL_SYSTEMFUNCTIONSIMPL_WITHGENID_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
