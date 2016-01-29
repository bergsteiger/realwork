////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/StrFunctionImpl/SplitToList.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::StrFunctionImpl::SplitToList
// Заголовок реализации класса серванта для интерфеса 
//
// реализация встроенной функции генератора _split_to_list
// _split_to_list («идентификатор», «строка», «разделитель») - разбивает строку по разделителям,
// фрагменты помещаются в список c заданным идентификатором.  Например:
// %f_split_to_list(ROOT_RELATIVE_PATH,%Sd,/) - разбивает результат %Sd по разделителям /, помещая
// элементы в список ROOT_RELATIVE_PATH
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_STRFUNCTIONIMPL_SPLITTOLIST_H__
#define __MDPROCESS_MDAMODEL_STRFUNCTIONIMPL_SPLITTOLIST_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/BaseFunctionImpl/InternalFunctionBase.h"

namespace StrFunctionImpl {

class SplitToList; // self forward Var
typedef ::Core::Var<SplitToList> SplitToList_var;
typedef ::Core::Var<const SplitToList> SplitToList_cvar;

class SplitToList_factory;

// реализация встроенной функции генератора _split_to_list
// _split_to_list («идентификатор», «строка», «разделитель») - разбивает строку по разделителям,
// фрагменты помещаются в список c заданным идентификатором.  Например:
// %f_split_to_list(ROOT_RELATIVE_PATH,%Sd,/) - разбивает результат %Sd по разделителям /, помещая
// элементы в список ROOT_RELATIVE_PATH
class SplitToList:
	virtual public BaseFunctionImpl::InternalFunctionBase
{
	SET_OBJECT_COUNTER (SplitToList)
	friend class SplitToList_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	SplitToList ();

	virtual ~SplitToList ();

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
}; // class SplitToList

} // namespace StrFunctionImpl


#endif //__MDPROCESS_MDAMODEL_STRFUNCTIONIMPL_SPLITTOLIST_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
