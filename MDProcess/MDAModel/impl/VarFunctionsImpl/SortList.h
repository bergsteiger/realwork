////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/VarFunctionsImpl/SortList.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VarFunctionsImpl::SortList
// Заголовок реализации класса серванта для интерфеса 
//
// реализация встроенной функции генератора _sort_list
// _sort_list(«идентификатор», «тип сортировки») - сортирует список в соответствии с заданным типом
// сортировки. Допустимые типы:
// - n - по имени
// - g - по гуиду на модели
// - p - тоже что по имени, но предварительно по родителю
// - u - по использованию (сортировка осуществляется по положению элементов в графе зависимости)
// - k - указывает, что в качестве ключей сортировки нужно использовать внешний список
// (идентификатор списка указывается как 3-й параметр: %f_sort_list(LIST,k,KEY_LIST))
// - если второй параметр заключён в кавычки, то считается, что это команда сортировки на языке
// шаблона и, что сортировку списка нужно выполнять путём сравнения результатов выполнения этой
// команды шаблона на элементах списка.
// 
// Пример использования:
// %f_add_to_list(LIST,"B")\
// %f_add_to_list(LIST,"C")\
// %f_add_to_list(LIST,"A")\
// %f_add_to_list(LIST,"D")\
// %f_sort_list(LIST,n)\
// // в результате элементы в списке выстроятся в порядке: A, B, C, D
// 
// Аналогично, можно отсортировать список, используя команду шаблона:
// %f_sort_list(LIST,"%SN")
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_VARFUNCTIONSIMPL_SORTLIST_H__
#define __MDPROCESS_MDAMODEL_VARFUNCTIONSIMPL_SORTLIST_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/ContainerOperationsImpl/ListOperationBaseImpl.h"

namespace VarFunctionsImpl {

class SortList; // self forward Var
typedef ::Core::Var<SortList> SortList_var;
typedef ::Core::Var<const SortList> SortList_cvar;

class SortList_factory;

// реализация встроенной функции генератора _sort_list
// _sort_list(«идентификатор», «тип сортировки») - сортирует список в соответствии с заданным типом
// сортировки. Допустимые типы:
// - n - по имени
// - g - по гуиду на модели
// - p - тоже что по имени, но предварительно по родителю
// - u - по использованию (сортировка осуществляется по положению элементов в графе зависимости)
// - k - указывает, что в качестве ключей сортировки нужно использовать внешний список
// (идентификатор списка указывается как 3-й параметр: %f_sort_list(LIST,k,KEY_LIST))
// - если второй параметр заключён в кавычки, то считается, что это команда сортировки на языке
// шаблона и, что сортировку списка нужно выполнять путём сравнения результатов выполнения этой
// команды шаблона на элементах списка.
// 
// Пример использования:
// %f_add_to_list(LIST,"B")\
// %f_add_to_list(LIST,"C")\
// %f_add_to_list(LIST,"A")\
// %f_add_to_list(LIST,"D")\
// %f_sort_list(LIST,n)\
// // в результате элементы в списке выстроятся в порядке: A, B, C, D
// 
// Аналогично, можно отсортировать список, используя команду шаблона:
// %f_sort_list(LIST,"%SN")
class SortList:
	virtual public ContainerOperationsImpl::ListOperationBaseImpl
{
	SET_OBJECT_COUNTER (SortList)
	friend class SortList_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	SortList ();

	virtual ~SortList ();

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
}; // class SortList

} // namespace VarFunctionsImpl


#endif //__MDPROCESS_MDAMODEL_VARFUNCTIONSIMPL_SORTLIST_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
