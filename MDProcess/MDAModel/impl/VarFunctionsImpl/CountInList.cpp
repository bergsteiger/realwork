////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/VarFunctionsImpl/CountInList.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VarFunctionsImpl::CountInList
//
// реализация встроенной функции генератора _count_in_list.
// _count_in_list(«идентификатор», «значение») - возвращает сколько раз встречается в списке
// элемент (может быть ЭЛЕМЕНТ МОДЕЛИ или СТРОКА).
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/LibHome.h"
#include "MDProcess/MDAModel/impl/VarFunctionsImpl/CountInList.h"
// by <<uses>> dependencies
#include "boost/lexical_cast.hpp"
#include "MDProcess/MDAModel/AbstractDumpers/TemplatePainter.h"
#include "MDProcess/MDAModel/ContainerOperations/ContainerOperations.h"

namespace VarFunctionsImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

CountInList::CountInList ()
//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A2CDCB00068_BASE_INIT*
//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A2CDCB00068_BASE_INIT*
{
	//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A2CDCB00068_BODY*
	//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A2CDCB00068_BODY*
}

CountInList::~CountInList () {
	//#UC START# *4A2CDCB00068_DESTR_BODY*
	//#UC END# *4A2CDCB00068_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from BaseFunctionImpl::InternalFunctionBase
// Собственно реализации встроенной функции. Каждый конкретный сервант реализует это метод
const std::string CountInList::execute_impl (
	const TemplateFunctions::FunctionParams& params
	, TemplatePainter* painter
) const /*throw (
	TemplateFunctions::BadParams
)*/ {
	//#UC START# *4A2CE18202C1_4A2CDCB00068*
	if (params.size () < 2) {
		throw TemplateFunctions::BadParams (GDS_CURRENT_FUNCTION, 2, params.size ());
	}

	std::string var_id (TemplatePainter::resolve_exp (params[0], painter));
	
	TemplatePainter::ContainerDumper* cont = this->get_container_if_exists (var_id);
	if (cont) {
		return ContainerOperations::ContainerTemplateOperationsFactory::get ().count (
			cont
			, params[1]
			, painter
		);
	}

	return std::string ("0");
	//#UC END# *4A2CE18202C1_4A2CDCB00068*
}
} // namespace VarFunctionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

