////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/VarFunctionsImpl/RemoveFromList.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VarFunctionsImpl::RemoveFromList
//
// реализация встроенной функции генератора _remove_from_list.
// _remove_from_list (идентификатор», «значение») - удаляет из списка c заданным идентификатором
// элемент (может быть ЭЛЕМЕНТ МОДЕЛИ или СТРОКА).
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/LibHome.h"
#include "MDProcess/MDAModel/impl/VarFunctionsImpl/RemoveFromList.h"
// by <<uses>> dependencies
#include "MDProcess/MDAModel/AbstractDumpers/TemplatePainter.h"
#include "MDProcess/MDAModel/ContainerOperations/ContainerOperations.h"

namespace VarFunctionsImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

RemoveFromList::RemoveFromList ()
//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A2CDE3D00A2_BASE_INIT*
//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A2CDE3D00A2_BASE_INIT*
{
	//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A2CDE3D00A2_BODY*
	//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A2CDE3D00A2_BODY*
}

RemoveFromList::~RemoveFromList () {
	//#UC START# *4A2CDE3D00A2_DESTR_BODY*
	//#UC END# *4A2CDE3D00A2_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from BaseFunctionImpl::InternalFunctionBase
// Собственно реализации встроенной функции. Каждый конкретный сервант реализует это метод
const std::string RemoveFromList::execute_impl (
	const TemplateFunctions::FunctionParams& params
	, TemplatePainter* painter
) const /*throw (
	TemplateFunctions::BadParams
)*/ {
	//#UC START# *4A2CE18202C1_4A2CDE3D00A2*
	if (params.size () < 2) {
		throw TemplateFunctions::BadParams (GDS_CURRENT_FUNCTION, 2, params.size ());
	}

	std::string var_id = TemplatePainter::resolve_exp(params[0], painter);

	TemplatePainter::ContainerDumper* cont = get_container_if_exists (var_id);
	
	if (cont) {

		ContainerOperations::ContainerTemplateOperationsFactory::get ().remove (
			cont
			, params[1]
			, painter
		);
	}

	return std::string ();
	//#UC END# *4A2CE18202C1_4A2CDE3D00A2*
}
} // namespace VarFunctionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

