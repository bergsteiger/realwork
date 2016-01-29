////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/VarFunctionsImpl/SortList.cpp"
// генератор файлов реализации C++ (.cpp)
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
#include "MDProcess/MDAModel/LibHome.h"
#include "MDProcess/MDAModel/impl/VarFunctionsImpl/SortList.h"
// by <<uses>> dependencies
#include "shared/GCL/alg/sorting.h"
#include "MDProcess/MDAModel/AbstractDumpers/SyntaxDef.h"
#include "MDProcess/MDAModel/AbstractDumpers/TemplatePainter.h"
#include "boost/function.hpp"
#include "boost/bind.hpp"
#include "MDProcess/MDAModel/ContainerOperations/ContainerOperations.h"

namespace VarFunctionsImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

SortList::SortList ()
//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A2CDEDA0203_BASE_INIT*
//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A2CDEDA0203_BASE_INIT*
{
	//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A2CDEDA0203_BODY*
	//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A2CDEDA0203_BODY*
}

SortList::~SortList () {
	//#UC START# *4A2CDEDA0203_DESTR_BODY*
	//#UC END# *4A2CDEDA0203_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from BaseFunctionImpl::InternalFunctionBase
// Собственно реализации встроенной функции. Каждый конкретный сервант реализует это метод
const std::string SortList::execute_impl (
	const TemplateFunctions::FunctionParams& params
	, TemplatePainter* painter
) const /*throw (
	TemplateFunctions::BadParams
)*/ {
	//#UC START# *4A2CE18202C1_4A2CDEDA0203*
	

	if (params.size () < 2) {
		throw TemplateFunctions::BadParams (GDS_CURRENT_FUNCTION, 2, params.size ());
	}
	std::string var_id = TemplatePainter::resolve_exp(params[0], painter);

	TemplatePainter::ContainerDumper* cont = get_container_if_exists (var_id);
	if (cont) {
		if (cont->size () > 0) {
			TemplatePainter::ContainerDumper* key_list = 0;
			if (params.size() > 2) {
				std::string key_list_id = TemplatePainter::resolve_exp(params[2], painter);

				key_list = get_container_if_exists (key_list_id);
				if (!key_list) {
					std::string mess (GDS_CURRENT_FUNCTION);
					mess += " - can't find key list with id: ";
					mess += key_list_id;							
					throw Base::FatalError (mess);
				}
			}

			ContainerOperations::ContainerTemplateOperationsFactory::get ().sort (
				cont
				, params[1]
				, painter
				, key_list
			);			
		}
	}
	
	return std::string ();
	//#UC END# *4A2CE18202C1_4A2CDEDA0203*
}
} // namespace VarFunctionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

