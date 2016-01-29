////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/BaseFunctionImpl/InternalStereotypeFunctionBase.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::BaseFunctionImpl::InternalStereotypeFunctionBase
// Заголовок реализации класса серванта для интерфеса InternalStereotypeFunction
//
// базовая реализация встроенной функции стереотипа
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_BASEFUNCTIONIMPL_INTERNALSTEREOTYPEFUNCTIONBASE_H__
#define __MDPROCESS_MDAMODEL_BASEFUNCTIONIMPL_INTERNALSTEREOTYPEFUNCTIONBASE_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/AbstractDumpers/AbstractDumperBase.h"
#include "MDProcess/MDAModel/AbstractDumpers/TemplatePainter.h"
#include "MDProcess/MDAModel/TemplateFunctions/TemplateFunctions.h"
#include "MDProcess/MDAModel/impl/BaseFunctionImpl/ListOperationBase.h"

namespace BaseFunctionImpl {

class InternalStereotypeFunctionBase; // self forward Var
typedef ::Core::Var<InternalStereotypeFunctionBase> InternalStereotypeFunctionBase_var;
typedef ::Core::Var<const InternalStereotypeFunctionBase> InternalStereotypeFunctionBase_cvar;

// базовая реализация встроенной функции стереотипа
class InternalStereotypeFunctionBase:
	virtual public TemplateFunctions::InternalStereotypeFunction
	, virtual public ::Core::RefCountObjectBase
	, virtual public ListOperationBase
{
	SET_OBJECT_COUNTER (InternalStereotypeFunctionBase)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	InternalStereotypeFunctionBase ();

	virtual ~InternalStereotypeFunctionBase ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	// Собственно реализации встроенной функции. Каждый конкретный сервант реализует это метод
	virtual const std::string execute_impl (
		const AbstractDumperBase* self
		, const TemplateFunctions::FunctionParams& params
		, TemplatePainter* painter
	) const /*throw (
		TemplateFunctions::BadParams
	)*/ = 0;

private:
	// метод вызываемый после вызовы реализации функции
	virtual void post_execute () const;

	// метод вызываемый перед вызовом реализации функции
	virtual void pre_execute () const;


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
}; // class InternalStereotypeFunctionBase

} // namespace BaseFunctionImpl


#endif //__MDPROCESS_MDAMODEL_BASEFUNCTIONIMPL_INTERNALSTEREOTYPEFUNCTIONBASE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
