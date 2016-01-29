////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/StrFunctionImpl/StringLength.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::StrFunctionImpl::StringLength
// Заголовок реализации класса серванта для интерфеса 
//
// реализация встроенной функции генератора _string_length
// _string_length(«строка») - длина переданной строки
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_STRFUNCTIONIMPL_STRINGLENGTH_H__
#define __MDPROCESS_MDAMODEL_STRFUNCTIONIMPL_STRINGLENGTH_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/BaseFunctionImpl/InternalFunctionBase.h"

namespace StrFunctionImpl {

class StringLength; // self forward Var
typedef ::Core::Var<StringLength> StringLength_var;
typedef ::Core::Var<const StringLength> StringLength_cvar;

class StringLength_factory;

// реализация встроенной функции генератора _string_length
// _string_length(«строка») - длина переданной строки
class StringLength:
	virtual public BaseFunctionImpl::InternalFunctionBase
{
	SET_OBJECT_COUNTER (StringLength)
	friend class StringLength_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	StringLength ();

	virtual ~StringLength ();

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
}; // class StringLength

} // namespace StrFunctionImpl


#endif //__MDPROCESS_MDAMODEL_STRFUNCTIONIMPL_STRINGLENGTH_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
