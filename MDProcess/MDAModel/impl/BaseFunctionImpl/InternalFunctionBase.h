////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/BaseFunctionImpl/InternalFunctionBase.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::BaseFunctionImpl::InternalFunctionBase
// Заголовок реализации класса серванта для интерфеса InternalFunction
//
// базовая реализация встроенной функции шаблона
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_BASEFUNCTIONIMPL_INTERNALFUNCTIONBASE_H__
#define __MDPROCESS_MDAMODEL_BASEFUNCTIONIMPL_INTERNALFUNCTIONBASE_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/AbstractDumpers/TemplatePainter.h"
#include "MDProcess/MDAModel/TemplateFunctions/TemplateFunctions.h"
#include "MDProcess/MDAModel/impl/BaseFunctionImpl/ListOperationBase.h"

namespace BaseFunctionImpl {

class InternalFunctionBase; // self forward Var
typedef ::Core::Var<InternalFunctionBase> InternalFunctionBase_var;
typedef ::Core::Var<const InternalFunctionBase> InternalFunctionBase_cvar;

// базовая реализация встроенной функции шаблона
class InternalFunctionBase:
	virtual public TemplateFunctions::InternalFunction
	, virtual public ::Core::RefCountObjectBase
	, virtual public ListOperationBase
{
	SET_OBJECT_COUNTER (InternalFunctionBase)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	InternalFunctionBase ();

	virtual ~InternalFunctionBase ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	// Собственно реализации встроенной функции. Каждый конкретный сервант реализует это метод
	virtual const std::string execute_impl (
		const TemplateFunctions::FunctionParams& params
		, TemplatePainter* painter
	) const /*throw (
		TemplateFunctions::BadParams
	)*/ = 0;


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from TemplateFunctions::BaseFunction
	// выполнение функции шаблона
	virtual const std::string execute (
		const TemplateFunctions::FunctionParams& params
		, Base::AbstractTemplatePainter* painter
	) const /*throw (
		TemplateFunctions::BadParams
	)*/;
}; // class InternalFunctionBase

} // namespace BaseFunctionImpl


#endif //__MDPROCESS_MDAMODEL_BASEFUNCTIONIMPL_INTERNALFUNCTIONBASE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
