////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/StereotypeFunctionsImpl/ClearList.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::StereotypeFunctionsImpl::ClearList
//
// %S%f_clear_list(LIST_ID) - очищает локальный список с идентификатором LIST_ID, если с %S не было
// связано переменной типа список с таким идентфиикатором, список создается и связывается
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/LibHome.h"
#include "MDProcess/MDAModel/impl/StereotypeFunctionsImpl/ClearList.h"

namespace StereotypeFunctionsImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

ClearList::ClearList ()
//#UC START# *4A2CBB5C0268_4A2CBBD20008_4B74E00202EF_BASE_INIT*
//#UC END# *4A2CBB5C0268_4A2CBBD20008_4B74E00202EF_BASE_INIT*
{
	//#UC START# *4A2CBB5C0268_4A2CBBD20008_4B74E00202EF_BODY*
	//#UC END# *4A2CBB5C0268_4A2CBBD20008_4B74E00202EF_BODY*
}

ClearList::~ClearList () {
	//#UC START# *4B74E00202EF_DESTR_BODY*
	//#UC END# *4B74E00202EF_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from BaseFunctionImpl::InternalStereotypeFunctionBase
// Собственно реализации встроенной функции. Каждый конкретный сервант реализует это метод
const std::string ClearList::execute_impl (
	const AbstractDumperBase* self
	, const TemplateFunctions::FunctionParams& params
	, TemplatePainter* painter
) const /*throw (
	TemplateFunctions::BadParams
)*/ {
	//#UC START# *4A2DFD7B0291_4B74E00202EF*
	if (params.size () < 1) {
		throw TemplateFunctions::BadParams (GDS_CURRENT_FUNCTION, 1, params.size ());
	}

	std::string var_id (TemplatePainter::resolve_exp(params[0], painter));
	const AbstractDumperBase* var = self->get_var_dumper (var_id);
	TemplatePainter::ContainerDumper* container = dynamic_cast<TemplatePainter::ContainerDumper*> (
		const_cast<AbstractDumperBase*> (var)
	);

	if (!container) {
		TemplatePainter::ContainerDumper_var newContainer = new TemplatePainter::ContainerDumper (var_id);
		container = newContainer.ptr ();

		self->set_var_dumper (var_id, container); //увеличивает счетчик ссылок на container
	} else {
		container->clear ();
	}
	
	return std::string ();
	//#UC END# *4A2DFD7B0291_4B74E00202EF*
}
} // namespace StereotypeFunctionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

