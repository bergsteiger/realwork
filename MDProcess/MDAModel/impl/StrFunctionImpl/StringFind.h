////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/StrFunctionImpl/StringFind.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::StrFunctionImpl::StringFind
// Заголовок реализации класса серванта для интерфеса 
//
// реализация встроенной функции генератора _string_find
// _string_find(«строка»,«подстрока») - ищет подстроку в строке, возвращает найденную позицию, если
// подстрока не найдена - возвращает -1
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_STRFUNCTIONIMPL_STRINGFIND_H__
#define __MDPROCESS_MDAMODEL_STRFUNCTIONIMPL_STRINGFIND_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/BaseFunctionImpl/InternalFunctionBase.h"

namespace StrFunctionImpl {

class StringFind; // self forward Var
typedef ::Core::Var<StringFind> StringFind_var;
typedef ::Core::Var<const StringFind> StringFind_cvar;

class StringFind_factory;

// реализация встроенной функции генератора _string_find
// _string_find(«строка»,«подстрока») - ищет подстроку в строке, возвращает найденную позицию, если
// подстрока не найдена - возвращает -1
class StringFind:
	virtual public BaseFunctionImpl::InternalFunctionBase
{
	SET_OBJECT_COUNTER (StringFind)
	friend class StringFind_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	StringFind ();

	virtual ~StringFind ();

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
}; // class StringFind

} // namespace StrFunctionImpl


#endif //__MDPROCESS_MDAMODEL_STRFUNCTIONIMPL_STRINGFIND_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
