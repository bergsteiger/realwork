////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/StrFunctionImpl/StringHash.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::StrFunctionImpl::StringHash
// Заголовок реализации класса серванта для интерфеса 
//
// реализация встроенной функции генератора "_string_hash"
// _string_hash("<строка>") - хэш переданной строки
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_STRFUNCTIONIMPL_STRINGHASH_H__
#define __MDPROCESS_MDAMODEL_STRFUNCTIONIMPL_STRINGHASH_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/BaseFunctionImpl/InternalFunctionBase.h"

namespace StrFunctionImpl {

class StringHash; // self forward Var
typedef ::Core::Var<StringHash> StringHash_var;
typedef ::Core::Var<const StringHash> StringHash_cvar;

class StringHash_factory;

// реализация встроенной функции генератора "_string_hash"
// _string_hash("<строка>") - хэш переданной строки
class StringHash:
	virtual public BaseFunctionImpl::InternalFunctionBase
{
	SET_OBJECT_COUNTER (StringHash)
	friend class StringHash_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	StringHash ();

	virtual ~StringHash ();

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
}; // class StringHash

} // namespace StrFunctionImpl


#endif //__MDPROCESS_MDAMODEL_STRFUNCTIONIMPL_STRINGHASH_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
