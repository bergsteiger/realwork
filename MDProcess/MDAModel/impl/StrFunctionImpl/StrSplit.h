////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/StrFunctionImpl/StrSplit.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::StrFunctionImpl::StrSplit
// Заголовок реализации класса серванта для интерфеса 
//
// реализация встроенной функции генератора "_str_split".
// _str_split ("<строка>","<префикс>","<разделитель>") - разбивает строку на n-строк с заданным
// префиксом и разделителем (размер одной части пока что задан жестко в генераторе)
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_STRFUNCTIONIMPL_STRSPLIT_H__
#define __MDPROCESS_MDAMODEL_STRFUNCTIONIMPL_STRSPLIT_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/BaseFunctionImpl/InternalFunctionBase.h"

namespace StrFunctionImpl {

class StrSplit; // self forward Var
typedef ::Core::Var<StrSplit> StrSplit_var;
typedef ::Core::Var<const StrSplit> StrSplit_cvar;

class StrSplit_factory;

// реализация встроенной функции генератора "_str_split".
// _str_split ("<строка>","<префикс>","<разделитель>") - разбивает строку на n-строк с заданным
// префиксом и разделителем (размер одной части пока что задан жестко в генераторе)
class StrSplit:
	virtual public BaseFunctionImpl::InternalFunctionBase
{
	SET_OBJECT_COUNTER (StrSplit)
	friend class StrSplit_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	StrSplit ();

	virtual ~StrSplit ();

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
}; // class StrSplit

} // namespace StrFunctionImpl


#endif //__MDPROCESS_MDAMODEL_STRFUNCTIONIMPL_STRSPLIT_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
