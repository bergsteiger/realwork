////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/VarFunctionsImpl/FindElement.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VarFunctionsImpl::FindElement
// Заголовок реализации класса серванта для интерфеса 
//
// реализация встроенной функции стереотипа _find_element.
// _find_element(«идентификатор|имя», «переменная») - находит элемент по имени или по
// идентификатору и записывает его в переменную. Первый параметр сначала интерпретируется как
// идентификатор элемента, если элемент с таким идентификатором не был найден, то параметр
// интерпретируется как имя элемента, причем имя может указываться с частью пути от рута да
// элемента (для уточнения поиска). Если в результате поиска по имени найдено более одного элемента
// - выбрасывается исключение. Например:
// {code}
// %S%f_find_element(%SU, SELF)  - переменная SELF удет указывать на текущий элемент (S)
// %S%f_set_var (A::B::attr, ATTR)  - переменная ATTR будет указывать на элемент, до которого
// полный путь от рута заканчивается на "A::B::attr"
// {code}
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_VARFUNCTIONSIMPL_FINDELEMENT_H__
#define __MDPROCESS_MDAMODEL_VARFUNCTIONSIMPL_FINDELEMENT_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/BaseFunctionImpl/InternalFunctionBase.h"

namespace VarFunctionsImpl {

class FindElement; // self forward Var
typedef ::Core::Var<FindElement> FindElement_var;
typedef ::Core::Var<const FindElement> FindElement_cvar;

class FindElement_factory;

// реализация встроенной функции стереотипа _find_element.
// _find_element(«идентификатор|имя», «переменная») - находит элемент по имени или по
// идентификатору и записывает его в переменную. Первый параметр сначала интерпретируется как
// идентификатор элемента, если элемент с таким идентификатором не был найден, то параметр
// интерпретируется как имя элемента, причем имя может указываться с частью пути от рута да
// элемента (для уточнения поиска). Если в результате поиска по имени найдено более одного элемента
// - выбрасывается исключение. Например:
// {code}
// %S%f_find_element(%SU, SELF)  - переменная SELF удет указывать на текущий элемент (S)
// %S%f_set_var (A::B::attr, ATTR)  - переменная ATTR будет указывать на элемент, до которого
// полный путь от рута заканчивается на "A::B::attr"
// {code}
class FindElement:
	virtual public BaseFunctionImpl::InternalFunctionBase
{
	SET_OBJECT_COUNTER (FindElement)
	friend class FindElement_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	FindElement ();

	virtual ~FindElement ();

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
}; // class FindElement

} // namespace VarFunctionsImpl


#endif //__MDPROCESS_MDAMODEL_VARFUNCTIONSIMPL_FINDELEMENT_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
