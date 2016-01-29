////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/UCModificationBase.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VirtualElementsFuncionsImpl::UCModificationBase
// Заголовок реализации класса серванта для интерфеса 
//
// базовый сервант для операций по работе с юзер-секциями
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_UCMODIFICATIONBASE_H__
#define __MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_UCMODIFICATIONBASE_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "boost/function.hpp"
#include "MDProcess/MDAModel/AbstractDumpers/AbstractDumperBase.h"
#include "MDProcess/MDAModel/AbstractDumpers/TemplatePainter.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/VirtualElementsFunctionBase.h"

namespace VirtualElementsFuncionsImpl {

class UCModificationBase; // self forward Var
typedef ::Core::Var<UCModificationBase> UCModificationBase_var;
typedef ::Core::Var<const UCModificationBase> UCModificationBase_cvar;

// базовый сервант для операций по работе с юзер-секциями
class UCModificationBase:
	virtual public VirtualElementsFunctionBase
{
	SET_OBJECT_COUNTER (UCModificationBase)

//////////////////////////////////////////////////////////////////////////////////////////
// nested declorations
protected:
	// тип - функция - реализация метода модификации UC
	typedef boost::function<const std::string (const std::string&, const std::string&, const std::string&, const AbstractDumperBase*, TemplatePainter*)> UCModificationFunctionImpl;

//////////////////////////////////////////////////////////////////////////////////////////
// static member methods and data
private:
	// базовая реализация функции модификации юзер-секции
	static void uc_function_impl_base (TemplatePainter::DelayedFunctionParams_box& params, const UCModificationFunctionImpl& impl);

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	UCModificationBase ();

	virtual ~UCModificationBase ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
private:
	// возвращает реализацию конкретной функции
	virtual const UCModificationFunctionImpl get_uc_function_impl () const = 0;


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
}; // class UCModificationBase

} // namespace VirtualElementsFuncionsImpl


#endif //__MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_UCMODIFICATIONBASE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
