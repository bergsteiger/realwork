////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/VarFunctionsImpl/CopyList.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VarFunctionsImpl::CopyList
//
// реализация встроенной функции генератора _copy_list
// _copy_list(«идентификатор списка1», «идентификатор списка2») - копирует список1 в список2.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/LibHome.h"
#include "MDProcess/MDAModel/impl/VarFunctionsImpl/CopyList.h"
// by <<uses>> dependencies
#include "MDProcess/MDAModel/AbstractDumpers/TemplatePainter.h"

namespace VarFunctionsImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

CopyList::CopyList ()
//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A2CDCF90061_BASE_INIT*
//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A2CDCF90061_BASE_INIT*
{
	//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A2CDCF90061_BODY*
	//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A2CDCF90061_BODY*
}

CopyList::~CopyList () {
	//#UC START# *4A2CDCF90061_DESTR_BODY*
	//#UC END# *4A2CDCF90061_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from BaseFunctionImpl::InternalFunctionBase
// Собственно реализации встроенной функции. Каждый конкретный сервант реализует это метод
const std::string CopyList::execute_impl (
	const TemplateFunctions::FunctionParams& params
	, TemplatePainter* painter
) const /*throw (
	TemplateFunctions::BadParams
)*/ {
	//#UC START# *4A2CE18202C1_4A2CDCF90061*
	if (params.size () < 2) {
		throw TemplateFunctions::BadParams (GDS_CURRENT_FUNCTION, 2, params.size ());
	}
	std::string source_list_id = TemplatePainter::resolve_exp(params[0], painter);
	std::string dest_list_id = TemplatePainter::resolve_exp(params[1], painter);
	
	if (source_list_id.empty () == false && dest_list_id.empty () == false) {
		TemplatePainter::ContainerDumper* dest_container = get_container (dest_list_id);
		dest_container->clear ();
		dest_container->add (get_container (source_list_id)->get_items ());
	}
	return std::string ();
	//#UC END# *4A2CE18202C1_4A2CDCF90061*
}
} // namespace VarFunctionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

