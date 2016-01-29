////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/VarFunctionsImpl/SortList_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VarFunctionsImpl::SortList
// Заголовк реализации фабрик интерфеса  для серванта SortList
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
#ifndef __MDPROCESS_MDAMODEL_VARFUNCTIONSIMPL_SORTLIST_FCTR_H__
#define __MDPROCESS_MDAMODEL_VARFUNCTIONSIMPL_SORTLIST_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/TemplateFunctions/TemplateFunctionsFactories.h"

namespace VarFunctionsImpl {

/// Interface-factory implementation for SortList
class SortList_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public TemplateFunctions::InternalFunctionAbstractFactory
{
public:
	SortList_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const std::string key () const;

	TemplateFunctions::InternalFunction* make ();

};

typedef ::Core::Var<SortList_factory> SortList_factory_var;

} // namespace VarFunctionsImpl


#endif //__MDPROCESS_MDAMODEL_VARFUNCTIONSIMPL_SORTLIST_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

