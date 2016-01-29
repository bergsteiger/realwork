////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/StrFunctionImpl/Suffix.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::StrFunctionImpl::Suffix
// Заголовок реализации класса серванта для интерфеса 
//
// Формат вызова:
// %f_suffix(строка,суффикс) - если строка заканчивается суффиксом - возвращает суффикс, иначе
// возвращает исходную строку
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_STRFUNCTIONIMPL_SUFFIX_H__
#define __MDPROCESS_MDAMODEL_STRFUNCTIONIMPL_SUFFIX_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/BaseFunctionImpl/InternalFunctionBase.h"

namespace StrFunctionImpl {

class Suffix; // self forward Var
typedef ::Core::Var<Suffix> Suffix_var;
typedef ::Core::Var<const Suffix> Suffix_cvar;

class Suffix_factory;

// Формат вызова:
// %f_suffix(строка,суффикс) - если строка заканчивается суффиксом - возвращает суффикс, иначе
// возвращает исходную строку
class Suffix:
	virtual public BaseFunctionImpl::InternalFunctionBase
{
	SET_OBJECT_COUNTER (Suffix)
	friend class Suffix_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	Suffix ();

	virtual ~Suffix ();

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
}; // class Suffix

} // namespace StrFunctionImpl


#endif //__MDPROCESS_MDAMODEL_STRFUNCTIONIMPL_SUFFIX_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
