////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/VarFunctionsImpl/SizeList.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VarFunctionsImpl::SizeList
//
// реализация встроенной функции генератора _size_list
// _size_list(«идентификатор») - возвращаеьт количество элементов в списке
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/LibHome.h"
#include "MDProcess/MDAModel/impl/VarFunctionsImpl/SizeList.h"
// by <<uses>> dependencies
#include "boost/lexical_cast.hpp"
#include "MDProcess/MDAModel/AbstractDumpers/TemplatePainter.h"
#include "MDProcess/MDAModel/ContainerOperations/ContainerOperations.h"

namespace VarFunctionsImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

SizeList::SizeList ()
//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A2CDE9903E3_BASE_INIT*
//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A2CDE9903E3_BASE_INIT*
{
	//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A2CDE9903E3_BODY*
	//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A2CDE9903E3_BODY*
}

SizeList::~SizeList () {
	//#UC START# *4A2CDE9903E3_DESTR_BODY*
	//#UC END# *4A2CDE9903E3_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from BaseFunctionImpl::InternalFunctionBase
// Собственно реализации встроенной функции. Каждый конкретный сервант реализует это метод
const std::string SizeList::execute_impl (
	const TemplateFunctions::FunctionParams& params
	, TemplatePainter* painter
) const /*throw (
	TemplateFunctions::BadParams
)*/ {
	//#UC START# *4A2CE18202C1_4A2CDE9903E3*
	if (params.size () < 1) {
		throw TemplateFunctions::BadParams (GDS_CURRENT_FUNCTION, 1, params.size ());
	}
	std::string res;
	std::string list_id = TemplatePainter::resolve_exp(params[0], painter);

	TemplatePainter::ContainerDumper* cont = get_container_if_exists (list_id);
	if (cont) {
		res = boost::lexical_cast<std::string> (cont->size ());
	} else {
		std::string mess (GDS_CURRENT_FUNCTION);
		mess += " - can't find list with id: ";
		mess += list_id;
		throw Base::FatalError (mess);
	}

	return res;
	//#UC END# *4A2CE18202C1_4A2CDE9903E3*
}
} // namespace VarFunctionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

