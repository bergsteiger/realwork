////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/StereotypeFunctionsImpl/SortList.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::StereotypeFunctionsImpl::SortList
//
// %S%f_sort_list(«тип сортировки») - то же, что и глобальная функция сортировки _sort_lsit
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/LibHome.h"
#include "MDProcess/MDAModel/impl/StereotypeFunctionsImpl/SortList.h"
// by <<uses>> dependencies
#include "MDProcess/MDAModel/ContainerOperations/ContainerOperations.h"

namespace StereotypeFunctionsImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

SortList::SortList ()
//#UC START# *4A2CBB5C0268_4A2CBBD20008_4B7542AA00AA_BASE_INIT*
//#UC END# *4A2CBB5C0268_4A2CBBD20008_4B7542AA00AA_BASE_INIT*
{
	//#UC START# *4A2CBB5C0268_4A2CBBD20008_4B7542AA00AA_BODY*
	//#UC END# *4A2CBB5C0268_4A2CBBD20008_4B7542AA00AA_BODY*
}

SortList::~SortList () {
	//#UC START# *4B7542AA00AA_DESTR_BODY*
	//#UC END# *4B7542AA00AA_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from ContainerOperationsImpl::StereotypeListOperationBase
const std::string SortList::execute_impl2 (
	TemplatePainter::ContainerDumper* self
	, const TemplateFunctions::FunctionParams& params
	, TemplatePainter* painter
) const /*throw (
	TemplateFunctions::BadParams
)*/ {
	//#UC START# *4B75414501B9_4B7542AA00AA*
	if (self->size () > 0) {
		TemplatePainter::ContainerDumper* key_list = 0;
		if (params.size() > 1) {
			std::string key_list_id = TemplatePainter::resolve_exp(params[1], painter);

			key_list = get_container_if_exists (key_list_id);
			if (!key_list) {
				std::string mess (GDS_CURRENT_FUNCTION);
				mess += " - can't find key list with id: ";
				mess += key_list_id;							
				throw Base::FatalError (mess);
			}
		}

		ContainerOperations::ContainerTemplateOperationsFactory::get ().sort (
			self
			, params[0]
			, painter
			, key_list
		);			
	}

	return std::string ();
	//#UC END# *4B75414501B9_4B7542AA00AA*
}
} // namespace StereotypeFunctionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

