////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/VarFunctionsImpl/IsEqualList.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VarFunctionsImpl::IsEqualList
//
// Функция сравнения списков
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/LibHome.h"
#include "MDProcess/MDAModel/impl/VarFunctionsImpl/IsEqualList.h"
// by <<uses>> dependencies
#include "MDProcess/MDAModel/AbstractDumpers/TemplatePainter.h"

namespace VarFunctionsImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

IsEqualList::IsEqualList ()
//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A2CDD9B015C_BASE_INIT*
//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A2CDD9B015C_BASE_INIT*
{
	//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A2CDD9B015C_BODY*
	//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A2CDD9B015C_BODY*
}

IsEqualList::~IsEqualList () {
	//#UC START# *4A2CDD9B015C_DESTR_BODY*
	//#UC END# *4A2CDD9B015C_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from BaseFunctionImpl::InternalFunctionBase
// Собственно реализации встроенной функции. Каждый конкретный сервант реализует это метод
const std::string IsEqualList::execute_impl (
	const TemplateFunctions::FunctionParams& params
	, TemplatePainter* painter
) const /*throw (
	TemplateFunctions::BadParams
)*/ {
	//#UC START# *4A2CE18202C1_4A2CDD9B015C*
	if (params.size () < 2) {
		throw TemplateFunctions::BadParams (GDS_CURRENT_FUNCTION, 2, params.size ());
	}
	std::string res ("false");
	std::string first_id = TemplatePainter::resolve_exp(params[0], painter);
	std::string second_id = TemplatePainter::resolve_exp(params[1], painter);
	
	const TemplatePainter::ContainerDumper* first_cont = get_container_if_exists (first_id);
	const TemplatePainter::ContainerDumper* second_cont = get_container_if_exists (second_id);
	
	if (
		first_cont
		&& second_cont
	) {
		if (first_cont->is_equal (second_cont)) {
			res = "true";
		}
	} else {
		std::string mess (GDS_CURRENT_FUNCTION);
		mess += ": Can't find list: ";		
		if (!first_cont) {
			mess += first_id;
			if (!second_cont) {
				mess += ", ";
				mess += second_id;
			}
		} else {
			mess += first_id;
		}
	}
	return res;
	//#UC END# *4A2CE18202C1_4A2CDD9B015C*
}
} // namespace VarFunctionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

