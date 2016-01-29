////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/StereotypeFunctionsImpl/AddToList.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::StereotypeFunctionsImpl::AddToList
//
// %S%f_add_to_list («значение») - добавляет в список c заданным идентификатором элемент (может
// быть ЭЛЕМЕНТ МОДЕЛИ или СТРОКА).
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/LibHome.h"
#include "MDProcess/MDAModel/impl/StereotypeFunctionsImpl/AddToList.h"
// by <<uses>> dependencies
#include "MDProcess/MDAModel/ContainerOperations/ContainerOperations.h"

namespace StereotypeFunctionsImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

AddToList::AddToList ()
//#UC START# *4A2CBB5C0268_4A2CBBD20008_4B752F4303C3_BASE_INIT*
//#UC END# *4A2CBB5C0268_4A2CBBD20008_4B752F4303C3_BASE_INIT*
{
	//#UC START# *4A2CBB5C0268_4A2CBBD20008_4B752F4303C3_BODY*
	//#UC END# *4A2CBB5C0268_4A2CBBD20008_4B752F4303C3_BODY*
}

AddToList::~AddToList () {
	//#UC START# *4B752F4303C3_DESTR_BODY*
	//#UC END# *4B752F4303C3_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from ContainerOperationsImpl::StereotypeListOperationBase
const std::string AddToList::execute_impl2 (
	TemplatePainter::ContainerDumper* self
	, const TemplateFunctions::FunctionParams& params
	, TemplatePainter* painter
) const /*throw (
	TemplateFunctions::BadParams
)*/ {
	//#UC START# *4B75414501B9_4B752F4303C3*
	if (params.size () < 1) {
		throw TemplateFunctions::BadParams (GDS_CURRENT_FUNCTION, 1, params.size ());
	}

	ContainerOperations::ContainerTemplateOperationsFactory::get ().add (
		self
		, params[0]
		, painter
	);
	
	return std::string ();
	//#UC END# *4B75414501B9_4B752F4303C3*
}
} // namespace StereotypeFunctionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

