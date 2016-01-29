////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/UCModificationBase.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VirtualElementsFuncionsImpl::UCModificationBase
//
// базовый сервант для операций по работе с юзер-секциями
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/LibHome.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/UCModificationBase.h"
// by <<uses>> dependencies
#include "MDProcess/MDAModel/AbstractDumpers/AbstractDumper.h"
#include "boost/bind.hpp"
#include "MDProcess/MDAModel/AbstractDumpers/AbstractDumper.h"
#include "MDProcess/MDAModel/AbstractDumpers/TemplatePainter.h"
// by <<friend>> dependencies
#include "MDProcess/MDAModel/AbstractDumpers/TemplatePainter.h"

namespace VirtualElementsFuncionsImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// static member methods

// базовая реализация функции модификации юзер-секции
void UCModificationBase::uc_function_impl_base (TemplatePainter::DelayedFunctionParams_box& params, const UCModificationFunctionImpl& impl) {
	//#UC START# *4B28B5810281*
	TemplatePainter::set_var_dumpers (params->get_var_dumpers ());
	//TemplatePainter::set_var_list_of_dumpers (params->get_var_list_of_dumpers ());

	if (params->get_params ().size () < 1) {
		throw TemplateFunctions::BadParams (GDS_CURRENT_FUNCTION, 1, params->get_params ().size ());
	}
	std::string gen_id = TemplatePainter::resolve_exp (params->get_params ()[0], params->get_painter ());
	
	if (AbstractDumperBase::s_gen_infos.find(gen_id) == AbstractDumperBase::s_gen_infos.end()) {
		throw Base::FatalError (
			std::string ("Использован неизвестный генератор: ")
			+ gen_id
		);
	}

	std::string saved_gen = AbstractDumperBase::s_current_map;
	AbstractDumperBase::s_current_map = gen_id;

	std::string uc_id ("*");
	uc_id += params->get_self ()->get_model_unique_id_str ();
	if (params->get_params ().size () > 1) {
		uc_id += TemplatePainter::resolve_exp (params->get_params ()[1], params->get_painter ());
	}
	uc_id += "*";

	std::string content;
	if (params->get_params ().size () > 2) {
		content = TemplatePainter::resolve_exp (params->get_params ()[2], params->get_painter ());
	}	
	
	std::string result = impl (gen_id, uc_id, content, params->get_self (), params->get_painter ());
	AbstractDumperBase::s_current_map = saved_gen;
	//#UC END# *4B28B5810281*
}


//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

UCModificationBase::UCModificationBase ()
//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A97B3BC005B_BASE_INIT*
//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A97B3BC005B_BASE_INIT*
{
	//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A97B3BC005B_BODY*
	//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A97B3BC005B_BODY*
}

UCModificationBase::~UCModificationBase () {
	//#UC START# *4A97B3BC005B_DESTR_BODY*
	//#UC END# *4A97B3BC005B_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from BaseFunctionImpl::InternalStereotypeFunctionBase
// Собственно реализации встроенной функции. Каждый конкретный сервант реализует это метод
const std::string UCModificationBase::execute_impl (
	const AbstractDumperBase* self
	, const TemplateFunctions::FunctionParams& params
	, TemplatePainter* painter
) const /*throw (
	TemplateFunctions::BadParams
)*/ {
	//#UC START# *4A2DFD7B0291_4A97B3BC005B*
	TemplatePainter::DelayedFunctionParams_box func_params (
		new TemplatePainter::DelayedFunctionParams (self, params, painter)
	);

	AbstractDumper::UCModificationfunction_var func (
		new AbstractDumper::UCModificationFunction (
			boost::bind (
				&UCModificationBase::uc_function_impl_base
				, func_params
				, this->get_uc_function_impl ()
			)
		)
	);

	AbstractDumper::add_uc_modification_function (func);

	return std::string ();
	//#UC END# *4A2DFD7B0291_4A97B3BC005B*
}
} // namespace VirtualElementsFuncionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

