////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/VarFunctionsImpl/SortList_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VarFunctionsImpl::SortList
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
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/VarFunctionsImpl/SortList_factory.h"
#include "MDProcess/MDAModel/impl/VarFunctionsImpl/SortList.h"

namespace VarFunctionsImpl {

SortList_factory::SortList_factory () {
}

void SortList_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	TemplateFunctions::InternalFunctionFactoryManager::register_factory (this, priority);
}

const std::string SortList_factory::key () const {
	return "_sort_list";
}

TemplateFunctions::InternalFunction* SortList_factory::make () {
	SortList_var ret = new SortList ();
	return ret._retn ();
}

} // namespace VarFunctionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

