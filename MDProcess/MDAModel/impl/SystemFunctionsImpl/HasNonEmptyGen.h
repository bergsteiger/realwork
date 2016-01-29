////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/SystemFunctionsImpl/HasNonEmptyGen.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::SystemFunctionsImpl::HasNonEmptyGen
// Заголовок реализации класса серванта для интерфеса 
//
// реализация встроенной функции генератора _has_non_empty_gen
// _has_non_empty_gen(«дампер»,«генератор») - возвращает true, если дампер имеет не пустой
// генератор, иначе возвращает false
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_SYSTEMFUNCTIONSIMPL_HASNONEMPTYGEN_H__
#define __MDPROCESS_MDAMODEL_SYSTEMFUNCTIONSIMPL_HASNONEMPTYGEN_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/BaseFunctionImpl/InternalFunctionBase.h"

namespace SystemFunctionsImpl {

class HasNonEmptyGen; // self forward Var
typedef ::Core::Var<HasNonEmptyGen> HasNonEmptyGen_var;
typedef ::Core::Var<const HasNonEmptyGen> HasNonEmptyGen_cvar;

class HasNonEmptyGen_factory;

// реализация встроенной функции генератора _has_non_empty_gen
// _has_non_empty_gen(«дампер»,«генератор») - возвращает true, если дампер имеет не пустой
// генератор, иначе возвращает false
class HasNonEmptyGen:
	virtual public BaseFunctionImpl::InternalFunctionBase
{
	SET_OBJECT_COUNTER (HasNonEmptyGen)
	friend class HasNonEmptyGen_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	HasNonEmptyGen ();

	virtual ~HasNonEmptyGen ();

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
}; // class HasNonEmptyGen

} // namespace SystemFunctionsImpl


#endif //__MDPROCESS_MDAMODEL_SYSTEMFUNCTIONSIMPL_HASNONEMPTYGEN_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
