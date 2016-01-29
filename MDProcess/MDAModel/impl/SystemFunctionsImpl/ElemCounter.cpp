////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/SystemFunctionsImpl/ElemCounter.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::SystemFunctionsImpl::ElemCounter
//
// реализация встроенной функции генератора "_elem_counter".
// _elem_counter («counter id»,«value») - получает номер элемента в именованной последовательности.
// Порядок элементов в последовательности определяется порядком первого вызова данной функции на
// каждом из элементов. Например:<%f_elem_counter(NUM_IN_PARTENT,C)>
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/LibHome.h"
#include "MDProcess/MDAModel/impl/SystemFunctionsImpl/ElemCounter.h"

namespace SystemFunctionsImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

ElemCounter::ElemCounter ()
//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A2CE90803BA_BASE_INIT*
//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A2CE90803BA_BASE_INIT*
{
	//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A2CE90803BA_BODY*
	//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A2CE90803BA_BODY*
}

ElemCounter::~ElemCounter () {
	//#UC START# *4A2CE90803BA_DESTR_BODY*
	//#UC END# *4A2CE90803BA_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from BaseFunctionImpl::InternalFunctionBase
// Собственно реализации встроенной функции. Каждый конкретный сервант реализует это метод
const std::string ElemCounter::execute_impl (
	const TemplateFunctions::FunctionParams& params
	, TemplatePainter* painter
) const /*throw (
	TemplateFunctions::BadParams
)*/ {
	//#UC START# *4A2CE18202C1_4A2CE90803BA*
	if (params.size () < 2) {
		throw TemplateFunctions::BadParams (GDS_CURRENT_FUNCTION, 2, params.size ());
	}
	std::string counter_id = TemplatePainter::resolve_exp(params[0], painter);

	AbstractDumperBase::CodeTemplate::const_iterator it = params[1].begin ();
	AbstractDumperBase::CodeTemplate::const_iterator it_end = params[1].end ();

	const AbstractDumperBase* adb = painter->get_dumper_by_template (it, it_end);
	if (!adb) {
		throw Base::FatalError (
			std::string ("Не удалось найти элемент \"") 
			+ params[1]
			+ std::string ("\"")
		);
	}
	return adb->element_counter (counter_id);
	//#UC END# *4A2CE18202C1_4A2CE90803BA*
}
} // namespace SystemFunctionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

