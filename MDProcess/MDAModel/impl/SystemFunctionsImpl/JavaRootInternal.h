////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/SystemFunctionsImpl/JavaRootInternal.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::SystemFunctionsImpl::JavaRootInternal
// Заголовок реализации класса серванта для интерфеса 
//
// Возвращает корневую директорию для java исходников
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_SYSTEMFUNCTIONSIMPL_JAVAROOTINTERNAL_H__
#define __MDPROCESS_MDAMODEL_SYSTEMFUNCTIONSIMPL_JAVAROOTINTERNAL_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/BaseFunctionImpl/InternalFunctionBase.h"

namespace SystemFunctionsImpl {

class JavaRootInternal; // self forward Var
typedef ::Core::Var<JavaRootInternal> JavaRootInternal_var;
typedef ::Core::Var<const JavaRootInternal> JavaRootInternal_cvar;

class JavaRootInternal_factory;

// Возвращает корневую директорию для java исходников
class JavaRootInternal:
	virtual public BaseFunctionImpl::InternalFunctionBase
{
	SET_OBJECT_COUNTER (JavaRootInternal)
	friend class JavaRootInternal_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	JavaRootInternal ();

	virtual ~JavaRootInternal ();

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
}; // class JavaRootInternal

} // namespace SystemFunctionsImpl


#endif //__MDPROCESS_MDAMODEL_SYSTEMFUNCTIONSIMPL_JAVAROOTINTERNAL_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
